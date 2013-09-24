From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 24 Sep 2013 12:36:10 -0700
Message-ID: <20130924193610.GO9464@google.com>
References: <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
 <20130923213729.GE9464@google.com>
 <20130924055419.GA11208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 21:36:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOYPD-0005sw-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 21:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808Ab3IXTgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 15:36:16 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:58117 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab3IXTgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 15:36:15 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5056937pdj.15
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sN1I/XtCDALGVzkY1cmpJXpvul1euiFZ46TaWco4fGQ=;
        b=rxZJbx7Wn+GONtMI79Sp4NHwJCL2nkyO7dFIjAHDsiNaly3cOWePFPrgVNEiSQuPik
         3VpUa6jZABX6EyYeh1g0Jk4TOlJ9NYS6TOHAB74be5DSqQbxzTcDhBGSFZ4U+5jdRUQY
         jl5kCU3/eAZ982+HP6FYFNDua8ZcVZWykJQDwxZZmPmDvEJv7bwAMsvcGpj2m+EBldP4
         AD+cJhwskIFVrwgS5n4qbpibZqjVGmjc+hLBbLybUdmRDHOvzD6OFc1f0gVVQfhBGGdn
         FqDnM5nYZUdoFQQ4F+FEmn7QhAV3yY4mk0U3DZLcbmCI+6fCMRFmuoeT1nZVtcBtwrmk
         fwIg==
X-Received: by 10.68.189.229 with SMTP id gl5mr6109887pbc.195.1380051375244;
        Tue, 24 Sep 2013 12:36:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 7sm47658364paf.22.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 12:36:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130924055419.GA11208@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235313>

Michael S. Tsirkin wrote:
> On Mon, Sep 23, 2013 at 02:37:29PM -0700, Jonathan Nieder wrote:

>>  a) When asked to compute the patch-id of a seekable file, use the
>>     current streaming implementation until you notice a filename that
>>     is out of order.  Then start over with sorted hunks (for example
>>     building a table of offsets within the patch for each hunk to
>>     support this).
>>
>>     When asked to compute the patch-id of an unseekable file, stream
>>     to a temporary file under $GIT_DIR to get a seekable file.
>
> This can be computed in one pass: just keep two checksums around.
>
> But the result won't be stable: if you get same patch from two
> people one is ordered, the other isn't, you get two different checksums.

Sorry for the lack of clarity.  In this case (a), I meant "sort the
diff hunks and use the *old* patch-id definition with sorted hunks,
which produces a stable result but requires random access.

However:

[...]
>>  b) Unconditionally use the new patch-id definition that is stable
>>     under permutation of hunks.  If and when someone complains that
>>     this invalidates their old patch-ids, they can work on adding a
>>     nice interface for getting the old-style patch-ids.  I suspect it
>>     just wouldn't come up.
>
> That's certainly easy to implement.

Yes, (b) seems like the best option to me, for what it's worth.

Thanks again,
Jonathan

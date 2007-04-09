From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes 'limit' arg
Date: Mon, 9 Apr 2007 12:20:26 -0700
Message-ID: <56b7f5510704091220w69529e72n2f982c097c4e26a0@mail.gmail.com>
References: <46197994.70009@gmail.com>
	 <alpine.LFD.0.98.0704082034060.28181@xanadu.home>
	 <56b7f5510704091151l70cc74b1la82e0c5a67d6885f@mail.gmail.com>
	 <alpine.LFD.0.98.0704091455100.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HazQ3-0004jo-SF
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbXDITU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbXDITU2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:20:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:41044 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965153AbXDITU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:20:27 -0400
Received: by wr-out-0506.google.com with SMTP id 71so960333wri
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 12:20:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C/6UgilCK0Op4CLfinooZrVckeiiw9BSplOdJVDWGbME7h8rqeqWimJp+ABmOqP0v4c/VUTRIbA/jarqCM5tomfOaaDByNY5g0yqmxf8u3ppLCTEGup3KN7BavABGfezwa1V/pV4rAgTu04BXxj0PAmzbJs5ckSL5MtqA7EhetM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TAhylY+hiLRVBDPM9yjgm7rDZITtFMgu/tUvNlIildx8shJ5C6nTiKlqt+A9DRaA5xWVtuOi2fKazdkkAx8li4qBF1cMvxb/0taTIOzIxGfuwrLNfZbxWmNCOJDNxVEIghon1KdpuYmOkM/X3ryGYapn2eK3z+T2pfWIdf8Yi60=
Received: by 10.115.76.1 with SMTP id d1mr2433303wal.1176146426057;
        Mon, 09 Apr 2007 12:20:26 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Mon, 9 Apr 2007 12:20:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704091455100.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44073>

On 4/9/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 9 Apr 2007, Dana How wrote:
> > On 4/8/07, Nicolas Pitre <nico@cam.org> wrote:
> > > > +                     sha1write(f, header, hdrlen);
> > > >                       sha1write(f, header + pos, sizeof(header) - pos);
> > >
> > > The above looks rather buggy to me.
> >
> > OK, can you be more specific?
>
> You're writing the content of the array 'header' twice in a row.  Sure
> the second time it is header + pos but it is still the result of an
> operation that used to put data into 'header' after the first content
> was already written out.  Right now it looks like the first write might
> contain clobbered data.
Thanks,  I'll take care of that.

For testing, I've been using git-fsck/git-verify-pack/git-unpack-objects .
The only bugs they ever caught were (1) offset wraparound in .idx
before I started this patchset (with a very bad error message) and
(2) I failed to flush out the buffer before changing packs.
Everything else has been detected manually (not always by me).  Hmm.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

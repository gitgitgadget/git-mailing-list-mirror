From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Thu, 9 Feb 2012 11:51:58 -0600
Message-ID: <20120209175158.GA7384@burratino>
References: <4F3120D4.1050604@warmcat.com>
 <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>
 <CAHkRjk6dr=5wxm+iSC2_CSB-q3k2WG_Um+X7dwsy-H8tL508EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Andy Green =?utf-8?B?KOael+WuieW7uCk=?= <andy@warmcat.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 18:52:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvYAH-0005eC-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957Ab2BIRwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 12:52:08 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46586 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab2BIRwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 12:52:07 -0500
Received: by iacb35 with SMTP id b35so2845484iac.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wQXeS3t4UsD5QgpT5ANX6MoSLax2xb90CWi8boVZP3E=;
        b=KKpPpDDseo0J5cSFnxwgg7ZT960YcneRDtBjJtTy//DWi65bvOrJofQdIDWZRRKrhb
         bwzS3uRVhIjOXMSDs5jvNWlAQInrSb/HIq/bt0EEUSIkVoSh4QCsmkyTVk22V2/WBJt9
         LIfyX+UcZw3eGXXxO8On9UwEfAKGThS/UP0tU=
Received: by 10.42.136.69 with SMTP id s5mr4038912ict.20.1328809927335;
        Thu, 09 Feb 2012 09:52:07 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ch2sm5076675igb.4.2012.02.09.09.52.05
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 09:52:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHkRjk6dr=5wxm+iSC2_CSB-q3k2WG_Um+X7dwsy-H8tL508EA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190299>

Hi Catalin,

Catalin Marinas wrote:

> Thanks for looking into this. Is this the same as an email header? If
> yes, we could just use the python's email.Header.decode_header()
> function (I haven't tried yet).

They look like this:

	encoding ISO8859-1

> BTW, does Git allow custom headers to be inserted by tools like StGit?

No.  There is one list of supported headers, and this list is the
standards body that maintains it[*].  So if you end up needing an
extension to the commit object format, that can be done, but it needs
to be accepted here (and ideally checked by "git fsck", though it's
lagging a bit in that respect lately).

By the way, headers have a standard order to avoid spurious changes in
commit names from reordering.  Additions so far have always happened
at the end, which is what makes checks by "git fsck" possible --- it
can't rule out an unrecognized header line being a standard field from
a future version of git, but it would be allowed to complain about
unrecognized fields before 'encoding', for example.

Thanks,
Jonathan

[*] http://thread.gmane.org/gmane.comp.version-control.git/138848/focus=138892

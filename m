From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Some git performance measurements..
Date: Fri, 7 Dec 2007 13:35:18 +0000
Message-ID: <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
	 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
	 <finmvm$da8$1@ger.gmane.org>
	 <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711292131350.9605@xanadu.home>
	 <B161871F-E812-44B4-A699-44341B5783D3@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 14:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0dMl-000533-BY
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 14:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbXLGNfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 08:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXLGNfV
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 08:35:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:32249 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbXLGNfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 08:35:20 -0500
Received: by wr-out-0506.google.com with SMTP id c49so523015wra
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ytv9NsdRVx6FObnZc4vo/ardh4cpM8/sceP2Cr+Om0U=;
        b=wRLoJ/sStdxfaKvKMvWf7kJOAEfF83mlNniDFfh8QDzChhZiLPvOVn880ZX0pDzboGDxubVI4Z03MX9auE5qDOI/A6EjzJY46HXzZzCDzzb+q/NGpMivYoWCF3/l9PfULfOAl+oMv0esb5TFfBn4Kkuq6qKzLJpKboHFulqTXtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LI2iWn3mT+at3tgMdCObSIfctKGVtWUTjyYmotIK1QehOk4FzmBjIycB378TlDYbDIeiX9GYZKUYS6wv1A2YuJ0kdWHsUS0MR361Y0HGW9b7WWb88B2wE+dUYspICkUZXlXGiQuphNKrwyxIfSgdIrmTo5esyuxQ6HNKwsR+U6c=
Received: by 10.70.115.17 with SMTP id n17mr85640wxc.1197034518907;
        Fri, 07 Dec 2007 05:35:18 -0800 (PST)
Received: by 10.70.59.11 with HTTP; Fri, 7 Dec 2007 05:35:18 -0800 (PST)
In-Reply-To: <B161871F-E812-44B4-A699-44341B5783D3@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67424>

On Nov 30, 2007 6:11 AM, Steffen Prohaska <prohaska@zib.de> wrote:
> Brian Downing measured horrid performance of qsort on Windows
> 2000 [1].  qsort seems to show worst case behaviour.
>
> This resulted in a patch replacing Window's qsort implementation
> for the mingw port [2].
>
> [1] http://thread.gmane.org/gmane.comp.version-control.msysgit/1084
> [2] http://thread.gmane.org/gmane.comp.version-control.msysgit/1086
>
>
> Avoiding qsort would even be better.  I'm not sure, though,
> if the particular qsort call that triggered the current
> discussion, is the very same qsort call that Brian was hit by.
> I'm only claiming that in general avoiding qsort on Windows
> is a good idea.

This is a vote for pulling this into mainline git. AIX (at least 5.3) also
has the horrible worst-case performance of the libc qsort on sorted or
near-sorted lists (such as those provided by some filesystems, or a
directory which has been rsynced).

Some versions of Solaris have the same problem [1]

I benchmarked 3 alternative qsorts, qsortG [2] was the fastest on my system
but has funky licensing, the NetBSD qsort was middle-range and the glibc one
the slowest of the three (but that could be due to it being tuned for a "Sun
4/260"). All of them show over 100x speed improvements on a git-status of my
main repo (104s -> ~0.7s)

I like the idea of a BROKEN_QSORT make variable. I was trying to come up
with a patch which would discover the problem in a performance/regression
test and suggest the setting, but have had insufficient free time so far.

Cheers, Mike

[1] http://bugs.opensolaris.org/view_bug.do?bug_id=1258570

[2] http://www.mccaughan.org.uk/g/software.html#qsort

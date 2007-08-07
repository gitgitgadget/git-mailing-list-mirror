From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Mon, 6 Aug 2007 21:22:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
 <20070803053717.GA16379@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 06:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIGc2-0006Wo-Bi
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 06:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbXHGEXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 00:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXHGEXv
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 00:23:51 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34955 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750829AbXHGEXu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 00:23:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l774MZR2029403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Aug 2007 21:22:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l774MQRe030194;
	Mon, 6 Aug 2007 21:22:29 -0700
In-Reply-To: <20070803053717.GA16379@midwinter.com>
X-Spam-Status: No, hits=-4.719 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55215>



On Thu, 2 Aug 2007, Steven Grimm wrote:
>
> The default is now to not show the diff --git header line if the file's
> timestamp has changed but the contents and/or file mode haven't.

I don't mind this per se, but I'd *really* want some kind of warning that 
the index is not up-to-date.

Otherwise, git usage can be horrendously slow, and you're never even told 
why. The diffs just take lots of time (because it reads each file), but 
the output is empty.

> 	Personally I'm in favor of doing away with the option altogether
> 	and having the code always work the way it works by default with
> 	this patch, but if some people find the old behavior useful they
> 	can still get at it with the new option.

It's not that the old output is "useful" in itself, but it's important for 
people to know that the index is clean. So I'd suggest just setting a flag 
when the header isn't printed, and then printing out a single line at the 
end about "git index not up-to-date" or something.

Doing a "git diff" cannot actually update the index (since it very much 
has to work on a read-only setup too), which is why the index _stays_ 
stale unless something is done (eg "git status") to refresh it. And it's 
that stale index that continues to make for bad performance without any 
indication of why that is a problem.

			Linus

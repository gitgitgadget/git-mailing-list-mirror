From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 18:29:41 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
References: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site>
 <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
 <20071130005852.GA12224@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxveF-0005bz-61
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761025AbXK3CaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763941AbXK3CaL
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:30:11 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41810 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759661AbXK3CaJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 21:30:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU2TgWK026408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 18:29:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU2Tfgp019324;
	Thu, 29 Nov 2007 18:29:42 -0800
In-Reply-To: <20071130005852.GA12224@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.727 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66607>



On Thu, 29 Nov 2007, Jeff King wrote:
> 
> I thought Linus' point was that moving the subcommands was sufficient
> for dealing with the consistency issue (i.e., all scripts would move to
> "git foo" and only those people who really wanted to would put the
> dashed forms in their path). 

Yes. I meant that we might as well keep all the git-xyz forms around, but 
_only_ in the libexec directory (and make sure that the libexec directory 
by default is *not* a binary directory), so that they'd normally not be 
visible.

So then, people who want to use the old-fashioned git-xyz forms, because 
they just really hate white-space or whatever, could choose to do one of 
two things:
 - either just change the default libexec directory to be the same as the 
   binary install directory, and have all the git-xyz things in the same 
   place they've always been.
 - or just add $(gitlibexec) into their path.

but the default (which is what 99% of all people use) would be to not 
show them. I also think that it makes sense to avoid wasting diskspace 
with duplicate files, so in situations where you don't have hardlinks, 
just don't install the git-xyz files at all by default (and again, maybe 
we can have a option to the installer to do it for people who really are 
very attached to the git-xyz format, and prefer to waste even a lot of 
disk on it)

So I just think that the whole idiotic complaint that some people have 
(that whole "git-<tab><tab>" shows "Display all 144 possibilities?" and 
people are somehow using that as an argument that git is "complex") should 
be something we strive to undo. I think the complaint is insane (because 
the answer is "well, nobody forces you to _use_ all the power and scripts 
we give you!"), but still, it's a complaint, so let's just assume the user 
is right, and try to fix it.

So when you do "git-<tab><tab>" it should just beep at you and not show 
anything at all by default. And when you do "git <tab><tab>", we should 
make sure that the bash expansion (or zsh or whatever) shows a nice 
collection of common plumbing, not soemthing really scary.

			Linus

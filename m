From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 13:56:26 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711151349560.4260@woody.linux-foundation.org>
References: <804pfobgkp.fsf@tiny.isode.net> <20071114230258.GG3973@steel.home> <807ikj3fge.fsf@tiny.isode.net> <20071115192654.GA3552@steel.home> <80ejerdzjd.fsf@tiny.isode.net> <20071115211727.GC3552@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsmiF-0006Ad-Ku
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763370AbXKOV5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765268AbXKOV5H
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:57:07 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56378 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757732AbXKOV5G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 16:57:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFLuQv4001173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2007 13:56:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFLuQQQ017702;
	Thu, 15 Nov 2007 13:56:26 -0800
In-Reply-To: <20071115211727.GC3552@steel.home>
X-Spam-Status: No, hits=-1.806 required=5 tests=AWL,BAYES_00,SUBJECT_FUZZY_TION
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65166>



On Thu, 15 Nov 2007, Alex Riesen wrote:
> 
> No, I honestly believed that Git-known files can be ignored. According
> to Linus I must be wrong, but I have an excuse:

I do think we're not necessarily entirely consistent wrt ignore files.

In particular, git-ls-files itself actually is pretty special, because it 
has two totally different modes:

 - you can ask for "other" files (and this is where you'd be expected to 
   use .gitignore)

 - you can just list the files git knows about (and this is where you'd 
   generally be expected to *not* use .gitignore)

..and to make matters more interesting, "git add" used to do the former 
(it was just a thin script around "git-ls-files -o") but then was later 
enhanced to also take already-known files into account, so I am not at all 
surprised if we actually get confused because we used to have a fairly 
clear separation of the two cases but then we started mixing them up.

So while I think that ".gitignore" *should* only affect files that we 
don't already know about (ie effectively only file lists that come from 
"readdir()", not from internal git data structures), I would not be at all 
surprised if there are bugs.

		Linus

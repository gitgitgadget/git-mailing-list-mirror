From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: resolve (merge) problems
Date: Thu, 1 Dec 2005 16:07:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512011556480.3099@g5.osdl.org>
References: <20051201231844.59450.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:09:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhySm-00044N-6s
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 01:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVLBAHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 19:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVLBAHl
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 19:07:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932571AbVLBAHk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 19:07:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB207Ye0016147
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Dec 2005 16:07:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB207Ynj015684;
	Thu, 1 Dec 2005 16:07:34 -0800
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20051201231844.59450.qmail@web31801.mail.mud.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13090>



On Thu, 1 Dec 2005, Luben Tuikov wrote:
> 
> $git resolve HEAD master "merge linus' tree"
> Trying to merge 5666c0947ede0432ba5148570aa66ffb9febff5b into
> 32df3299405fb7054b76346899f3db2fa29150fb using 458af5439fe7ae7d95ca14106844e61f0795166c.
> Simple merge failed, trying Automatic merge
> Removing arch/arm/configs/poodle_defconfig
> Removing drivers/atm/atmdev_init.c
> fatal: merge program failed
> Automatic merge failed, fix up by hand
> 
> How do I proceed from here?

Well, first off, you would probably have been better off with the smarter 
recursive merge instead of the old "git resolve":

	git merge -s recursive "merge linus' tree" HEAD master

(the "-s recursive" isn't really needed, it _should_ be the default).

You can re-try that by doing a "git reset --hard" (to get rid of the 
partial merge) and just starting over.

> The output from git-diff-index is:

Don't. You'll see all the changes relative to HEAD, which _includes_ all 
the stuff that got cleanly merged.

Instead, do just a

	git diff

or perhaps

	git-diff-files --name-status

which will show much better what is going on. In this case, I suspect that 
the problem is that my branch removed "poodle_defconfig", and you had 
changes in it, no? Or maybe there were conflicts in atmdev_init.c, so they 
got left in an unmerged state..

Regardless, the git-diff-files interface should show you which files are 
unmerged and need to be fixed up.

Just fix them up: either remove them, or edit them to taste, and then do 
"git-update-index <filename>" (add the "--remove" option if you deleted 
the file), and then finish it off when you're happy with a "git commit".

That _should_ fix it all up.

		Linus

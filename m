From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 5 Feb 2008 13:49:18 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>
References: <ve53xwob.fsf@blue.sea.net> <alpine.LSU.1.00.0802051524580.8543@racer.site> <prvbxfhl.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 22:50:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMVgg-0005PR-Df
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 22:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759603AbYBEVuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 16:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759513AbYBEVuM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 16:50:12 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37794 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759644AbYBEVuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2008 16:50:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m15LnIwi026243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Feb 2008 13:49:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m15LnICA010063;
	Tue, 5 Feb 2008 13:49:18 -0800
In-Reply-To: <prvbxfhl.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.714 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72703>



On Tue, 5 Feb 2008, Jari Aalto wrote:
> 
> The current situation is plain ugly and git shouldn't stomp on any other
> dir than .git

I do agree.

The whole (and _only_) reason for the directory being called ".dotest" is 
literally totally silly and historical:

 - I long since wrote my own stupid scripts around BK (and called 
   my set of scripts around BK "bktools")

 - that script set included a script to extract the patch and description 
   from a mailbox.

 - that script was called "dotest", because it started out as a testing 
   script, and I never re-named it. And while my bktools set had other 
   scripts in it, that was the one I used _every_single_day_, so "dotest" 
   is not only always in my shell history, it's also hardcoded in my 
   brainstem.

 - BitMover eventually merged an improved version of my mbox applicator 
   scripts into bitkeeper, making much of it pointless, but I kept the 
   name around as a shell macro, because it was what I was used to (I 
   think it basically expanded into something like "bk import -temail" or 
   something)

 - when I started git, I *rewrote* those old bktools for git, and created 
   a new "git-tools" directory. And yes, the script that actually tied all 
   the mail splitting and application together was *still* called 
   "dotest", because it was still what I used.

 - again, time passes, and again, my helper scripts end up migrating into 
   the actual SCM, now called "git applymbox" (and then later "git am"), 
   but yet *again*, I cannot teach myself to call it anything sane, so my 
   .bashrc file still contains

	alias dotest='git-am --utf8'

   and I still write "dotest" when I apply emails. Even though it hasn't 
   been about "testing" for the last five years or so, and it's how I do 
   all my work.

So the temporary directory that contains all the temp-files for my 
"dotest" script (which was external to git) - it's called ".dotest". Of 
course.

It all makes perfect sense. Or rather, it made sense way back when. I 
agree that it's just totally insane these days, and ".dotest/" should be 
renamed to something like ".git/split/" or something.

		Linus

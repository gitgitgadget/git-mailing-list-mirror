From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: seperate commits for objects already updated in index?
Date: Tue, 14 Mar 2006 09:00:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603140856120.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 14 18:06:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJCsy-0002Qd-8v
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 18:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbWCNRAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 12:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbWCNRAf
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 12:00:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752245AbWCNRAf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Mar 2006 12:00:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2EH0VDZ020779
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Mar 2006 09:00:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2EH0Urv000407;
	Tue, 14 Mar 2006 09:00:30 -0800
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17589>



On Tue, 14 Mar 2006, Paul Jakma wrote:

> Hi,
> 
> Dumb question, imagine you made changes to a few files, and ran update-index
> at various stages in between:
> 
> $ git status
> #
> # Updated but not checked in:
> #   (will commit)
> #
> #       modified: foo/ChangeLog
> #       modified: foo/whatever
> #       modified: bar/ChangeLog
> #       modified: bar/other
> 
> The changes in bar/ are unrelated to the changes in foo/ - how do you commit
> each seperately? Git doesn't seem to want to let me:
> 
>   $ git commit -o bar
>   Different in index and the last commit:
>   M       bar/ChangeLog
>   M       bar/other
>   You might have meant to say 'git commit -i paths...', perhaps?
> 
> git commit on its own wants to commit all the above files.
> 
> what's the silly thing I've missed?

You've already marked them all modified in the index (using 
git-update-index), so git commit thinks you are confused by naming them 
again and saying "only".

The simplest thing to do is to do

	git reset

to reset your index back to your HEAD (but obviously DON'T use the "-f" 
flag, which will also force the working tree!). That will make your index 
clean, and undo the fact that you've already marked things to be committed 
with "git-update-index".

Then you can just do

	git commit -o bar

and everything should be fine, because then git doesn't think you're doing 
something insane.

		Linus

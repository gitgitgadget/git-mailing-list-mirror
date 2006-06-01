From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git reset --hard not removing some files
Date: Thu, 1 Jun 2006 09:21:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
References: <20060601160052.GK14325@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 18:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Flpvp-0007wo-23
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 18:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWFAQVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 12:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWFAQVy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 12:21:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030220AbWFAQVx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 12:21:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k51GLd2g020967
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Jun 2006 09:21:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k51GLcnX006984;
	Thu, 1 Jun 2006 09:21:38 -0700
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060601160052.GK14325@admingilde.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21119>



On Thu, 1 Jun 2006, Martin Waitz wrote:
> 
> I have the following problem:

It's not a problem, it's a feature.

> nbg1l001:~/src/git > git branch
> * master
>   next
>   origin
> nbg1l001:~/src/git > git checkout -b test
> nbg1l001:~/src/git > git status
> # On branch refs/heads/test
> nothing to commit
> zsh: exit 1     git status
> nbg1l001:~/src/git > git reset --hard v1.3.3
> nbg1l001:~/src/git > git status
> # On branch refs/heads/test
> #
> # Untracked files:
> #   (use "git add" to add to commit)
> #
> #       git-quiltimport
> #       git-upload-tar

Those files were _never_ tracked.

What happened is that when you switched to an earlier version, you _also_ 
switched the ".gitignore" file to the earlier version, and that older 
.gitignore file doesn't have those two (newer) binaries listed as being 
ignored.

And "git reset" won't be deleting files it doesn't track (it had _better_ 
not touch them), even more so when it has been told to ignore them, so it 
makes total sense to _not_ delete them when doing that reset.

			Linus

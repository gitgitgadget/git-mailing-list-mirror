From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Tue, 14 Mar 2006 13:58:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
References: <20060314211022.GA12498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 14 22:59:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJHX5-000380-Ty
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 22:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWCNV6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 16:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWCNV6U
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 16:58:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932534AbWCNV6T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Mar 2006 16:58:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2ELwCDZ005119
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Mar 2006 13:58:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2ELw9dx012892;
	Tue, 14 Mar 2006 13:58:11 -0800
To: Qingning Huo <qhuo@mayhq.co.uk>
In-Reply-To: <20060314211022.GA12498@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17600>



On Tue, 14 Mar 2006, Qingning Huo wrote:
>
> The system have GNU git installed at /usr/bin/git.  I installed git-core
> to ~/opt/bin.  ~/opt/bin is in my PATH, but is after /usr/bin.  I have
> set alias git="$HOME/opt/bin/git".

This should not be a problem with the modern "git.c" wrapper. It 
_should_, if you call it with the full path, automatically prepend that 
path to the PATH when executing sub-commands. 

So if you run git as "$HOME/opt/bin/git", the PATH _should_ be 
 - first the "PREFIX/bin" path as defined by the build
 - second the "$HOME/opt/bin/" path as defined by the fact that you ran 
   git from that path
 - finally the normal $PATH.

To check this out, do this:

	ln -s /usr/bin/printenv ~/opt/bin/git-printenv
	git printenv

and you should see the proper PATH that git ends up using internally that 
way.

So your problem seems to be that you do "git-pull", when you really should 
do "git pull" (where that wrapper will set up PATH for you). Since you 
don't use the wrapper, the scripts end up doing the wrong thing.

		Linus

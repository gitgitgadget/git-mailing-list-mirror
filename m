From: Steven Cole <elenstev@mesatop.com>
Subject: Re: Add lsremote command.
Date: Sun, 17 Apr 2005 16:42:56 -0600
Message-ID: <200504171642.56686.elenstev@mesatop.com>
References: <200504162336.51937.elenstev@mesatop.com> <20050417140309.GF1487@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:43:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNITo-0002s8-MV
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVDQWqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVDQWqy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:46:54 -0400
Received: from nacho.zianet.com ([216.234.192.105]:45834 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261535AbVDQWqu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 18:46:50 -0400
Received: (qmail 23901 invoked from network); 17 Apr 2005 22:46:48 -0000
Received: from 216-31-65-214.zianet.com (216.31.65.214)
  by 0 with SMTP; 17 Apr 2005 22:46:48 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
In-Reply-To: <20050417140309.GF1487@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 17 April 2005 08:03 am, Petr Baudis wrote:
> Dear diary, on Sun, Apr 17, 2005 at 07:36:51AM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...
> > This is a fairly trivial addition, but if users are adding remote repositories
> > with git addremote, then those users should be able to list out the remote
> > list without having to know the details of where the remotes file is kept.
> 
> Could you please send your patches inline? (Either in the body or with
> correct content-disposition header.)
> 
> You got the return values other way around and you are missing a
> copyright notice at the top; you should also mention that you take no
> parameters.
> 
> Please use -s instead of -e, since it is more appropriate in this case.
> Also, you should report the "no remotes" message to stderr. And always
> exit when you found that .git/remotes exists, not only if cat succeeds.
> 
> Kind regards,
> 
Thanks for the fixes.  Here's a better version.
Steven

 This is a fairly trivial addition, but if users are adding remote repositories
 with git addremote, then those users should be able to list out the remote
 list without having to know the details of where the remotes file is kept.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

diff -urN git-pasky.orig/git git-pasky/git
--- git-pasky.orig/git	2005-04-17 15:02:37.000000000 -0600
+++ git-pasky/git	2005-04-17 15:04:23.000000000 -0600
@@ -41,6 +41,7 @@
 	log
 	ls		[TREE_ID]
 	lsobj		[OBJTYPE]
+	lsremote
 	merge		-b BASE_ID FROM_ID
 	pull		[RNAME]
 	rm		FILE...
@@ -105,6 +106,7 @@
 "log")        gitlog.sh "$@";;
 "ls")         gitls.sh "$@";;
 "lsobj")      gitlsobj.sh "$@";;
+"lsremote")   gitlsremote.sh "$@";;
 "merge")      gitmerge.sh "$@";;
 "pull")       gitpull.sh "$@";;
 "rm")         gitrm.sh "$@";;
diff -urN git-pasky.orig/gitlsremote.sh git-pasky/gitlsremote.sh
--- git-pasky.orig/gitlsremote.sh	1969-12-31 17:00:00.000000000 -0700
+++ git-pasky/gitlsremote.sh	2005-04-17 16:20:48.000000000 -0600
@@ -0,0 +1,11 @@
+#!/bin/sh
+#
+# Lists remote GIT repositories
+# Copyright (c) Steven Cole 2005
+#
+# Takes no parameters
+#
+[ -s .git/remotes ] && cat .git/remotes
+[ -s .git/remotes ] && exit
+
+echo "List of remotes is empty. See git addremote." >&2


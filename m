From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] rsh.c environment variable
Date: Mon, 6 Jun 2005 16:35:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506061631330.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:36:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfOIa-0002Ec-3r
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 22:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVFFUhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVFFUhQ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 16:37:16 -0400
Received: from iabervon.org ([66.92.72.58]:63236 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261679AbVFFUgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 16:36:16 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfOJK-0006Yi-00; Mon, 6 Jun 2005 16:35:02 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.21.0506061616590.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

rsh.c used to set the environment variable for the object database when
invoking the remote command. Now that there is a GIT_DIR variable, use
that instead.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Index: rsh.c
===================================================================
--- 5d261be8a54c55542223536a72c53fab564cc28a/rsh.c  (mode:100644 sha1:5d1cb9d578a8e679fc190a9d7d2c842ad811223f)
+++ 2dde8ae2d3300fb95e35facac622b9b54990624e/rsh.c  (mode:100644 sha1:3eb9d9160531de91cbccfc1fdea2e9007a9cbfec)
@@ -36,8 +36,8 @@
 	*(path++) = '\0';
 	/* ssh <host> 'cd /<path>; stdio-pull <arg...> <commit-id>' */
 	snprintf(command, COMMAND_SIZE, 
-		 "cd /%s; %s=objects %s",
-		 path, DB_ENVIRONMENT, remote_prog);
+		 "%s='/%s' %s",
+		 GIT_DIR_ENVIRONMENT, path, remote_prog);
 	posn = command + strlen(command);
 	for (i = 0; i < rmt_argc; i++) {
 		*(posn++) = ' ';


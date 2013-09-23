From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 05/15] contrib/git-credential-gnome-keyring.c: set Gnome application name
Date: Sun, 22 Sep 2013 22:08:01 -0700
Message-ID: <1379912891-12277-6-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyP6-0002D3-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab3IWFJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39631 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab3IWFJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2744597pbb.33
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PcD9nJXbDobOgDCMtw73vjqC5akd/QZTPXxhFdwaPVY=;
        b=ce+BzFgY8s1aRFG3VqmmQlpBE7kb35Vvl3zOxJBnsWS2dRJ1n8zM3QEXq1GgN4FxuY
         R29WhiJ+wWEARYsWqyeH0qL1a45dBFl0WVOXdzBGv7KZEsB2A1OSWqVWl1wJ2mrvwCSE
         Y4uarycxXS1sIQLtQyn5xxmf2k5n3reLvZmyjeKHAAcYjKag7oI5zrTV9pqP2fOvANDT
         RS/JofS15VjBdfWSNLwSbhsmVZFmdhVBebNU9+3DHxjQ6sVlb7YnOV9+8hNSoJlM5G+f
         CMDpsQ7t4WQ0bQxXHp051tgpm3Vj6upTVQP3EPV/DsA1TvSSgV82HXemLH8/fJ/Ua//A
         dA7Q==
X-Received: by 10.66.230.138 with SMTP id sy10mr23135818pac.103.1379912947803;
        Sun, 22 Sep 2013 22:09:07 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235198>

Since this is a Gnome application, let's set the application name to
something reasonable.  This will be displayed in Gnome dialog boxes
e.g. the one that prompts for the user's keyring password.

We add an include statement for glib.h and add the glib-2.0 cflags and
libs to the compilation arguments, but both of these are really noops
since glib is already a dependency of gnome-keyring.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/credential/gnome-keyring/Makefile                       | 4 ++--
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/gnome-keyring/Makefile b/contrib/credential/gnome-keyring/Makefile
index e6561d8..c3c7c98 100644
--- a/contrib/credential/gnome-keyring/Makefile
+++ b/contrib/credential/gnome-keyring/Makefile
@@ -8,8 +8,8 @@ CFLAGS = -g -O2 -Wall
 -include ../../../config.mak.autogen
 -include ../../../config.mak
 
-INCS:=$(shell pkg-config --cflags gnome-keyring-1)
-LIBS:=$(shell pkg-config --libs gnome-keyring-1)
+INCS:=$(shell pkg-config --cflags gnome-keyring-1 glib-2.0)
+LIBS:=$(shell pkg-config --libs gnome-keyring-1 glib-2.0)
 
 SRCS:=$(MAIN).c
 OBJS:=$(SRCS:.c=.o)
diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 5459ba7..5779770 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -28,6 +28,7 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <glib.h>
 #include <gnome-keyring.h>
 
 /*
@@ -399,6 +400,8 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
+	g_set_application_name("Git Credential Helper");
+
 	/* lookup operation callback */
 	while(try_op->name && strcmp(argv[1], try_op->name))
 		try_op++;
-- 
1.8.4.489.g545bc72

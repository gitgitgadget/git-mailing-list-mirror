From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 08/16] contrib/git-credential-gnome-keyring.c: set Gnome application name
Date: Mon, 23 Sep 2013 11:49:09 -0700
Message-ID: <1379962157-1338-9-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:50:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBDA-0007xz-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab3IWSuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:50:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9061 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab3IWSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B52408d200002>; Mon, 23 Sep 2013 11:49:05 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:49:25 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 23 Sep 2013 11:49:25 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:25 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235231>

From: Brandon Casey <drafnel@gmail.com>

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
index 0d2c55e..43b19dd 100644
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
 	while (try_op->name && strcmp(argv[1], try_op->name))
 		try_op++;
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

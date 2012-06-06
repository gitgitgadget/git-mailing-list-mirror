From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCHv2] Add the possibility to specify a default help format
Date: Wed,  6 Jun 2012 20:28:16 +0000
Message-ID: <1339014496-6736-1-git-send-email-vfr@lyx.org>
References: <1338987397-7376-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 22:28:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScMqa-0008UJ-Hf
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 22:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325Ab2FFU2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 16:28:45 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35621 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758313Ab2FFU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 16:28:43 -0400
Received: by weyu7 with SMTP id u7so4597487wey.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 13:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=7YKcvY9Nlb3GhzKl90Hh2V11EVm9RzRObdNSbwkXYXM=;
        b=bQirnSI+Gw3CDYXGCvugKvWhddlOe4J7ldl//pOh+k418N1xjjsCr98LCVwI6jkp1l
         q9nRBPFSY2WXXKZpFpUttGhZQQEgsIoLcJE/vRb4refeVNEgE6qWK980sRLrOxz95QS6
         VMtlf1jQ0n5fNHU073N5bItWUTN+Sewmqp7GF5DkTxJ8ElQEsMDU9GrrhS/35laPgeRj
         45Zk0/T420SLgG0wrvM0JUnR32OJtrCr/D/TRGHLOByFNqX0FqHygOZjrv+b1xz844sj
         QPomYJlwHo59JfiNhbIBjtbdf5yid0ciPfUsO29UbyQKoipvJIV5jVPEtlfRrYn5s0DP
         35Kg==
Received: by 10.216.199.95 with SMTP id w73mr18949268wen.196.1339014521708;
        Wed, 06 Jun 2012 13:28:41 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id gb9sm4504142wib.8.2012.06.06.13.28.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 13:28:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
In-Reply-To: <1338987397-7376-1-git-send-email-vfr@lyx.org>
X-Gm-Message-State: ALoCoQmHogGNPA/YX7OOJFRskFp3DBAXCai+hx/qkMLRmfo+pKD1cpzY8IbQ0OPSqkZztL/7qtP8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199352>

At the moment, the default help format (i.e. the format that is chosen if
'git help xxx' is called without a help format parameter) is defined by
the switch to be 'man'. However, on different platforms the preferred
format might differ. For example, on Windows there is no man viewer, so we
would prefer html.

This patch adds the possibility to choose a default help format on
compilation by defining DEFAULT_HELP_FORMAT. If it is not specified the
default is still 'man'.

Example:
  make DEFAULT_HELP_FORMAT=info

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Makefile       |    9 +++++++++
 builtin/help.c |    8 +++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4592f1f..9df6213 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,10 @@ all::
 # the diff algorithm.  It gives a nice speedup if your processor has
 # fast unaligned word loads.  Does NOT work on big-endian systems!
 # Enabled by default on x86_64.
+#
+# Define DEFAULT_HELP_FORMAT to "man", "info" or "html" 
+# (defaults to "man") if you want to have a different default when
+# "git help" is called without a parameter specifying the format.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1236,6 +1240,7 @@ ifeq ($(uname_S),Windows)
 	BLK_SHA1 = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
+	DEFAULT_HELP_FORMAT = html
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -1915,6 +1920,10 @@ SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
 BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
 endif
 
+ifdef DEFAULT_HELP_FORMAT
+BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
+endif
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
diff --git a/builtin/help.c b/builtin/help.c
index 43d3c84..536d4fd 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -12,6 +12,10 @@
 #include "column.h"
 #include "help.h"
 
+#ifndef DEFAULT_HELP_FORMAT
+#define DEFAULT_HELP_FORMAT "man"
+#endif
+
 static struct man_viewer_list {
 	struct man_viewer_list *next;
 	char name[FLEX_ARRAY];
@@ -445,7 +449,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
 
-	if (parsed_help_format != HELP_FORMAT_NONE)
+	if (parsed_help_format == HELP_FORMAT_NONE)
+		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
+	else
 		help_format = parsed_help_format;
 
 	alias = alias_lookup(argv[0]);
-- 
1.7.9.msysgit.0

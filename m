From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 14/20] watchman: add a config option to enable the extension
Date: Thu, 12 May 2016 16:20:09 -0400
Message-ID: <1463084415-19826-15-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6W-0005AB-EB
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbcELUUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:20:49 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33654 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcELUUr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:47 -0400
Received: by mail-io0-f172.google.com with SMTP id f89so108986399ioi.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ov/yt9gnq4V51eTcUk32tP4yGdO0RK0E91nFtjvxh08=;
        b=iRhDA2G2tTLGUjxYR0+RYNymw7mGcatUvbm+yCSlLpKTl3/P06KtODmEw9lxXPQ20p
         P11oDR/624fpWxdpF/sx/S7J6PlesHw0An2T/kYYJ1md1QrKhGCkZ7duO3W0unuMCmql
         xIA5vyVUfsKpxpbJocmSqN3SQZVbKasnDu1CQQxY1VGsRfAN64lTsmumWZEhIJYOtw3y
         3oPMb1IFRAokSdHTBQ2bsnI1lju7xhFPPNl+olfrrLjNVEMti0xqfQXzRloQPrgL69Or
         pH6IxKUqeDBWlCezidEjWDY77OVgBRE3XPUe5GOplqFICyTMi5vnvM6GOolJO9PPUogJ
         WFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ov/yt9gnq4V51eTcUk32tP4yGdO0RK0E91nFtjvxh08=;
        b=ZQ+pWRbL3ijuy7SdyCYxdkk7vPePHPXXrrRBzGb2BXXqFbxq7iI5nTM9GX4RJv7GVM
         Sxl2tWgnW7YoGLs4HnxBHln3V+jd8DCFdbKGS4YG+I+WnMUCKt4ssGPl4vG/yt07WO7m
         yDz94X2keoH+KKGkFrOoisIHQyvFDvpeVlwbi8+WQHLtyFE91Da+6jcJUez/zTvH0gR1
         JDFvLGRes0FGrd4drfjHeFJDhxxVqLRbs4aBfbN3eqqGkhCdpdOo7SLii7Z4YGXPupPI
         ICY7k5jJAARviqlG7eX55Zpx3p8Vmyc99qMzmbL2rsNhwksLFwH8KL/L6KQZ2faBvc0h
         PVaw==
X-Gm-Message-State: AOPr4FV/7Ue8rfwynXhTrr7PIoxgV62RyO3PiTUCfhgQvKPejaWP0H6+mvp/iRQJWrmHLA==
X-Received: by 10.107.130.71 with SMTP id e68mr10200008iod.175.1463084446120;
        Thu, 12 May 2016 13:20:46 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:45 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294460>

For installations that have centrally-managed configuration, it's
easier to set a config once than to run update-index on every
repository.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 .gitignore                    |  1 +
 Documentation/config.txt      |  4 ++++
 Makefile                      |  1 +
 read-cache.c                  |  6 ++++++
 t/t1701-watchman-extension.sh | 37 +++++++++++++++++++++++++++++++++++++
 test-dump-watchman.c          | 16 ++++++++++++++++
 6 files changed, 65 insertions(+)
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100644 test-dump-watchman.c

diff --git a/.gitignore b/.gitignore
index b92f122..e6a5b2c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -188,6 +188,7 @@
 /test-dump-cache-tree
 /test-dump-split-index
 /test-dump-untracked-cache
+/test-dump-watchman
 /test-fake-ssh
 /test-scrap-cache-tree
 /test-genrandom
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..15001ce 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1848,6 +1848,10 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+index.addwatchmanextension::
+	Automatically add the watchman extension to the index whenever
+	it is written.
+
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
diff --git a/Makefile b/Makefile
index 65ab0f4..5f0a954 100644
--- a/Makefile
+++ b/Makefile
@@ -599,6 +599,7 @@ TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
+TEST_PROGRAMS_NEED_X += test-dump-watchman
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
diff --git a/read-cache.c b/read-cache.c
index 75a1b05..a2107f0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2430,6 +2430,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int watchman = 0;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2453,6 +2454,11 @@ static int do_write_index(struct index_state *istate, int newfd,
 	if (istate->version == 3 || istate->version == 2)
 		istate->version = extended ? 3 : 2;
 
+	if (!git_config_get_bool("index.addwatchmanextension", &watchman) &&
+	    watchman &&
+	    !the_index.last_update)
+		the_index.last_update = xstrdup("");
+
 	hdr_version = istate->version;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
diff --git a/t/t1701-watchman-extension.sh b/t/t1701-watchman-extension.sh
new file mode 100755
index 0000000..71f1d46
--- /dev/null
+++ b/t/t1701-watchman-extension.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='watchman extension smoke tests'
+
+# These don't actually test watchman interaction -- just the
+# index extension
+
+. ./test-lib.sh
+
+test_expect_success 'enable watchman' '
+	test_commit a &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: (null)" >expect &&
+	test_cmp expect actual &&
+	git update-index --watchman &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: " >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable watchman' '
+	git update-index --no-watchman &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: (null)" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'auto-enable watchman' '
+	test_config index.addwatchmanextension true &&
+	test_commit c &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: " >expect &&
+	test_cmp expect actual
+'
+
+
+test_done
diff --git a/test-dump-watchman.c b/test-dump-watchman.c
new file mode 100644
index 0000000..0314fa5
--- /dev/null
+++ b/test-dump-watchman.c
@@ -0,0 +1,16 @@
+#include "cache.h"
+#include "ewah/ewok.h"
+
+int main(int argc, char **argv)
+{
+	do_read_index(&the_index, argv[1], 1);
+	printf("last_update: %s\n", the_index.last_update ?
+	       the_index.last_update : "(null)");
+
+	/*
+	 * For now, we just dump last_update, since it is not reasonable
+	 * to populate the extension itself in tests.
+	 */
+
+	return 0;
+}
-- 
2.4.2.767.g62658d5-twtrsrc

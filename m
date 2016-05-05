From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 13/19] watchman: add a config option to enable the extension
Date: Thu,  5 May 2016 17:47:05 -0400
Message-ID: <1462484831-13643-14-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR82-0008DU-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757901AbcEEVsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:48:12 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36402 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946AbcEEVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:49 -0400
Received: by mail-qg0-f49.google.com with SMTP id w36so47406588qge.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQ+XFp4DqtbEKsooVBsHK3Z/sc/J5Svjpm5kXbZP4+A=;
        b=QjywdXG9AbneWI36FRmz5HSE/GbdKIBK1nNMj3NHApuX0md6uF7fF9oCspch65lK3S
         0AG5PcAqs3sD+QkFbsyLXy7cHr2DzPHs6wiO9iu5UFyCo9vmh4KOocj4MNNs+mgbEoXe
         WzhMXRQrQmgGBN7DGutS7EbiqQzWw7XnBU6OyyBbPoaKD/9ZhDHgJgToTleamDo1qwJb
         fhGQ4VqFQLWGtlbv/15PgDXwoyQTS0MQ+ggS9LLkLeocNZAqsOxGWd0nrppzV+VGylUB
         8u8zG3Ea22c45GIW25wUxyc3G/r+YKKfeoLFAzpDj4r7Deh6Mp6PptZ3YahBkfIG3g7c
         xWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQ+XFp4DqtbEKsooVBsHK3Z/sc/J5Svjpm5kXbZP4+A=;
        b=G/rJsZ9O1984N0MaXWt5lpZ7fmzJGyvuORjVsu3H9Hp1jMn3WC7srd+fmCKLJ7AY2n
         LZ2USQ9kSkm4PpSW4mZZIlozsxl34crtBg8/1zsYekc4XPizLg4Clgk3+S8SvG2J03gJ
         UEDDLnbvLUaKayPQhjmSMMozi2uQ3cilm0pj5X2JYPGPgaoZmFlPDxePA7BfyoK6g9oQ
         lCDjzt1DJrXFXeMFDoFS6EfkepY/7bnYqtNZPDOnS3qgPDQbaG9I5OI6rzcHAvW15n8Q
         4mV9sFzWWSDsXr9RkUeAnJQY+N5npZ960ZEGrcK52yj7r3a/avpXiSElNTi96b5s1H8o
         3eJQ==
X-Gm-Message-State: AOPr4FVWepWLsvtxNLGEEC9WPTTOS5XOQGQS5B18uE0GKJ1aaWs73RDie8wanCPPNrwo2Q==
X-Received: by 10.140.40.99 with SMTP id w90mr16181397qgw.42.1462484862199;
        Thu, 05 May 2016 14:47:42 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293700>

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
index 4ad2c19..b00919a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2429,6 +2429,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int watchman = 0;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2452,6 +2453,11 @@ static int do_write_index(struct index_state *istate, int newfd,
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

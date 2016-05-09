From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 13/19] watchman: add a config option to enable the extension
Date: Mon,  9 May 2016 16:48:43 -0400
Message-ID: <1462826929-7567-14-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:50:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7l-0004LM-Us
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbcEIUtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:36 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36121 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcEIUt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:27 -0400
Received: by mail-qk0-f176.google.com with SMTP id x7so101937376qkd.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2eRmQLrNqMLgl5rjKW7y4wi31W9qXAFldpNk9WJIu8=;
        b=rwlZkqAHkvnRf94P1fHZb4p36Ksxhg/ebb48KBxEXSTe5XpulJyAH/brAQ8CxCvWMe
         Pl024U4BDL8OILQumMo4ilB6AU7uZI3bgnTwex6/j4VsADWDF318w435bfExpnbKa0sZ
         5mcDh5+nbAOgbtjhCy4gd0Kn8ZnmSLV4Bua1e4JgDPuK1EfNWByxDDoClsGviFC5ysIY
         3np9x5v+mqB1oQZnezVHUlJPr0y48krRSMMwg8Bg9w7W9B5juZpPUjaBry0r6MqxCIsu
         09WTFvxLMKv2fH6wlnkZRmMAGR2T/anK60HkyMoSIn3rbCb4JCXmyrkkvskAXtOdjOmc
         vVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2eRmQLrNqMLgl5rjKW7y4wi31W9qXAFldpNk9WJIu8=;
        b=RQZIXoq1VKhLCPN0ZELikz/g/5XVvI2afDfwcutD36pBNc4BpBnfJyexN2TjkZwmcx
         +ShkxDyJVvDoXCI5vH+U6RqX5ht3+1JT9hlWQ8+S0NrFdLc3goc9Ric8lVrOS1cPBc7O
         +c5aDOjH305gG6KvL073QeSo8V7yb7eL5HVvJmY5cLyAZHbIH7DLznSTSuQHyz/EICiQ
         Lu6aC4I73Ol520B+R8O/AJqTsSkSniV495wN5FvAkcaAqQAdPg6/+D8e1Dd1dWWnbOew
         PdHfJkK3WB25NS2fzbDyXFtEjQkeGOOKRAPzvryEyphE/UxYaDCl7tp2lg+INUPgOrhL
         EhZg==
X-Gm-Message-State: AOPr4FUXes/+LocfLT8Z0SmPj8hdQt88nS3e42zlnui6t8gARojDE2rI3F7DWIXxKiConw==
X-Received: by 10.55.77.202 with SMTP id a193mr40295830qkb.48.1462826961114;
        Mon, 09 May 2016 13:49:21 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294052>

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
index 76b65c2..7b7cb39 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2428,6 +2428,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int watchman = 0;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2451,6 +2452,11 @@ static int do_write_index(struct index_state *istate, int newfd,
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

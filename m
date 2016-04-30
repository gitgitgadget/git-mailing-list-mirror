From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 13/19] watchman: add a config option to enable the extension
Date: Fri, 29 Apr 2016 21:02:07 -0400
Message-ID: <1461978133-13966-14-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:03:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJO-00089Y-F3
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbcD3BDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:03:05 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35474 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbcD3BCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:39 -0400
Received: by mail-qg0-f50.google.com with SMTP id f74so49689681qge.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UkJIyhQDqCUHt5XZFQGBs5w6rH7BvFSOD9t+UkRTCUc=;
        b=Uua/5XuOJYGH+JGvYUVRJzsm5e5s/0yp0aNOksNKNVL0+8twF5J+uGi1yRxQyLaHsq
         82Ek+kkdIMOKGtpJLEr1vYmxSZNWyifX39sD1qyZIhgL+8hQMzyqXHrrDdYUCuXGN76c
         OH2KuNLqfTTzKrcWxLEMNXWj7iHnJ4pZEoSKvxZo7NHpwSXGaYUKeAnvG8GICXcKgtyD
         3cneMFuTcnXY6tpw/9n6ECo06EvT+65tha7G9D5tlavCGY95ob+kTk/xnwJAfXoZnUlD
         F67OJQW2MhMC7DX5gNp1GzNCHGHcESF/TNnkn6BVRAcJpSJHw+S9dTiVJNBMZzxtkqSS
         YxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UkJIyhQDqCUHt5XZFQGBs5w6rH7BvFSOD9t+UkRTCUc=;
        b=B7sU2fyTFCDYTRKjcRO2dKfE3besMSqB4iCExZ8rWpsgcfvFsQIO2u/ehsqile8YbI
         WhgvTKRquORb/6zj1u9RRolgj7hy+1KCP6Ef4apNG1DVzEzchPItwR5my24oUblFVaeM
         dAZCQeFSAdFr/FkJlYMwQvE+wLk5NWE9UKwRa2yt9je1/KEXy00GiZ7ZGy0cBY3b1J4H
         sEtFEkBx2eI+7mO/vBdciTvPr+IfEqQYCG0KcjQoezlgCnw0T0iyPR+eY9c7cqOmdE93
         S05XAPa9mXbUXY0uyHP0w605ZKHq77C2v+Nkk4JSlMl6/6XT+ygvh8oktXuYSFFb1NTC
         OoCQ==
X-Gm-Message-State: AOPr4FX/AuM2il/RUTM1scmtBHRIwc8NqAJFlbZ193Id6doA/CKWpTC/SfRDTOaH7Oa+dQ==
X-Received: by 10.140.43.244 with SMTP id e107mr21174269qga.13.1461978158290;
        Fri, 29 Apr 2016 18:02:38 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293114>

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
index 1779fa2..5f5e933 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2426,6 +2426,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int watchman = 0;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2449,6 +2450,11 @@ static int do_write_index(struct index_state *istate, int newfd,
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

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6276F2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 09:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbdCCJw0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 04:52:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32887 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdCCJwY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 04:52:24 -0500
Received: by mail-pg0-f67.google.com with SMTP id 16so3736016pga.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ttRM+dxDcPmsq+uG8KLdFkIt0ZFtFMRScMmGYJ7SkoI=;
        b=HTpovmukptlRDBzMBtG6fCmQWiF1E/C311PIUV5ZN1ZRj4QyhoBn/eX3Kmhcj5kayG
         bGobEwIwttdatIp7tryQHMzeasFp8CEo8KhnIsYlgPhWe2HB/7fjtfFf26BCiXZmCBMu
         Imbwl11TQV9PuN0mz7RLKVnVWV79oVMCS/+XVQBFvG6MjMngRFnfY0f9ZCg9cjcbtti4
         34SupNbPn6SE33VSLVEWrCxkDeAmMKEDpxhZvzAVMt/dcaCypmlZ/mq6tTpjq5QxIRMY
         9W4dk6Caqgc990zizk4CUHo/maQ+bDc4w5u4nVH+iFxnwoWN9oYqwzDJAUvWi5l0SVrM
         PG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ttRM+dxDcPmsq+uG8KLdFkIt0ZFtFMRScMmGYJ7SkoI=;
        b=adA04IxS+Pusib416iBwAzgl/Da82lOehVNW1bnKHfsavj1WLdaQN5wxFlaWw0jzm0
         +gFlJSZC+LyBvrmhOSCKZiLzfx/ODx3r4pqi0xkuvl4ykHT5FK5A7MN9VpwWbz28CxzJ
         LTFrIIHlVB/FNDM9C83/Ibgnji2A9PhEZsgM/4oasnH5ry0QctWWZlTGzeORilWZp9Vq
         vUwbkETmyHu3nPEpw23nlqfPWBSwURy0uO5/Cg1rGMeZ+hgFh7kFRw1sHhyRv+90QEEu
         Ymna6YPRRZe1b0b+s+X1NaFbOrOBWxMRolWX0tcIJwrN1TEbmWA9G8auLi9jWQhPdgTn
         WT6w==
X-Gm-Message-State: AMke39lkj9i3lVUi4sJaKYNqaHgO5nTLlsBmZaAixR743otrMSv00PIoILZdV0kEH2EfDw==
X-Received: by 10.84.134.228 with SMTP id 91mr2959745plh.116.1488534202125;
        Fri, 03 Mar 2017 01:43:22 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id w29sm22113209pfi.131.2017.03.03.01.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 01:43:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Mar 2017 16:43:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] config: check if config path is a file before parsing it
Date:   Fri,  3 Mar 2017 16:42:51 +0700
Message-Id: <20170303094252.11706-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170303094252.11706-1-pclouds@gmail.com>
References: <20170303094252.11706-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a directory is given as a config file by accident, we keep open it
as a file. The behavior of fopen() in this case seems to be
undefined.

On Linux, we open a directory as a file ok, then get error (which we
consider eof) on the first read. So the config parser sees this "file"
as empty (i.e. valid config). All is well and we don't complain
anything (but we should).

The situation is slighly different on Windows. I think fopen() returns
NULL. And we get a very unhelpful message:

    $ cat >abc <<EOF
    [include]
        path = /tmp/foo
    EOF
    $ mkdir /tmp/foo
    $ git config --includes --file=abc core.bare
    fatal: bad config line 3 in file abc

Opening a directory is wrong in the first place. Avoid it. If caught,
print something better. With this patch, we have

    $ git config --includes --file=abc core.bare
    error: '/tmp/foo' is not a file
    fatal: bad config line 3 in file abc

It's not perfect (line should be 2 instead of 3). But it's definitely
improving.

The new test is only relevant on linux where we blindly open the
directory and consider it an empty file. On Windows, the test should
pass even without this patch.
---
 abspath.c              | 7 +++++++
 cache.h                | 1 +
 config.c               | 9 +++++++++
 t/t1300-repo-config.sh | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/abspath.c b/abspath.c
index 2f0c26e0e2..373cc3abb2 100644
--- a/abspath.c
+++ b/abspath.c
@@ -11,6 +11,13 @@ int is_directory(const char *path)
 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
 }
 
+int is_not_file(const char *path)
+{
+	struct stat st;
+
+	return !stat(path, &st) && !S_ISREG(st.st_mode);
+}
+
 /* removes the last path component from 'path' except if 'path' is root */
 static void strip_last_component(struct strbuf *path)
 {
diff --git a/cache.h b/cache.h
index 80b6372cf7..bdd1402ab9 100644
--- a/cache.h
+++ b/cache.h
@@ -1149,6 +1149,7 @@ static inline int is_absolute_path(const char *path)
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
 int is_directory(const char *);
+int is_not_file(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
diff --git a/config.c b/config.c
index c6b874a7bf..c21c0ce433 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "dir.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1212,6 +1213,9 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	int ret = -1;
 	FILE *f;
 
+	if (is_not_file(filename))
+		return error(_("'%s' is not a file"), filename);
+
 	f = fopen(filename, "r");
 	if (f) {
 		flockfile(f);
@@ -2451,6 +2455,11 @@ int git_config_rename_section_in_file(const char *config_filename,
 		goto out;
 	}
 
+	if (!S_ISREG(st.st_mode)) {
+		ret = error(_("'%s' is not a file"), config_filename);
+		goto out;
+	}
+
 	if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
 		ret = error_errno("chmod on %s failed",
 				  get_lock_file_path(lock));
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 052f120216..3683fbb84e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1477,4 +1477,9 @@ test_expect_success !MINGW '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_success 'a directory is given as a config file' '
+	mkdir config-dir &&
+	test_must_fail git config --file=config-dir --list
+'
+
 test_done
-- 
2.11.0.157.gd943d85


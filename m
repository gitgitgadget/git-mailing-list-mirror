Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9680C209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946831AbdEZDfa (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33082 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946778AbdEZDfU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so43066926pfe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HODGcXDydCZNwWvp/XSw5poNO07nSUBUbD72+lXcGFY=;
        b=ZHDi5DV5eQ3+M3RSa5NSzH5t9wiQN2pbUvlclvzEb9/r5PHWm/6JTaJ7LW2QutgqHR
         RlE1ytHeL7dtApUnEq9xxEnDOIKOmVOkHidOAObth7+JhLh8vUKXNarqy6TzkQC71b+5
         2Ipi41QkLRIaSXA5Ce5ZrHgzAzNqLexvK5yjJ+RIdT1kdAEJHt8QbdnZGFdPRLtntAUh
         /6Aam9p5LPyAg5J0t7BtMRGedcA1J68aedkpMg+rrUyfud20vuj31J8bfKj/NvjpZRpX
         ZCrEie9TTZ+xiYWeBy9TbRbp3S2PltUPP0ydnzx26dcWeexDVBJV8u1Ag817s5t27/KT
         dLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HODGcXDydCZNwWvp/XSw5poNO07nSUBUbD72+lXcGFY=;
        b=KvhWhV6+zuqbc6VBj5Fp7cE/ZkRb2PXv9D5xxTKMJG0/VIqzQ1XscxfUcJYaGlUzM4
         hTeCYJ3Cg627+Ew7pmpAMfXVpvzm9J3+JIT0UMZHBr5A5KDwDsUkTOnzc+HVlDZbS5rJ
         HGyNH74r70VrBXZhwnoLGkuy/xVJRYZTlQ+kGW2W7Uac0f8jN9k3SEK1nFZB1hI+8zGC
         vY6+kOyOvxTTsw9SSnJt6msq12qDsASknS6bph+eKouyihi61F64E7FYzru7/wwhUAhn
         ejD0sJxkQBImA0JY6oZzj2Ifdovdj6nPXhQzOjvNa4td6r8cQXkma7jy77fPA23hmKjT
         BRLQ==
X-Gm-Message-State: AODbwcBZCBG7nLKGg+DzDJhWhZEZR2MI6NcNk9HRy9uuvyTg2/wN1E/w
        /0o3FqFj5Rq8rQ==
X-Received: by 10.98.206.201 with SMTP id y192mr47570830pfg.60.1495769719867;
        Thu, 25 May 2017 20:35:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id c196sm16327678pga.23.2017.05.25.20.35.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 06/13] wrapper.c: add and use warn_on_fopen_errors()
Date:   Fri, 26 May 2017 12:35:03 +0900
Message-Id: <20170526033510.1793-7-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

In many places, Git warns about an inaccessible file after a fopen()
failed. To discern these cases from other cases where we want to warn
about inaccessible files, introduce a new helper specifically to test
whether fopen() failed because the current user lacks the permission to
open file in question.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c              |  3 +++
 dir.c                 |  6 +++---
 git-compat-util.h     |  2 ++
 t/t1308-config-set.sh |  3 ++-
 wrapper.c             | 10 ++++++++++
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index b4a3205da3..2894fbb6d0 100644
--- a/config.c
+++ b/config.c
@@ -2640,6 +2640,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 	}
 
 	if (!(config_file = fopen(config_filename, "rb"))) {
+		ret = warn_on_fopen_errors(config_filename);
+		if (ret)
+			goto out;
 		/* no config file means nothing to rename, no error */
 		goto commit_and_out;
 	}
diff --git a/dir.c b/dir.c
index f451bfa48c..be616e884e 100644
--- a/dir.c
+++ b/dir.c
@@ -745,9 +745,9 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 
 	fd = open(fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0) {
-		if (errno != ENOENT)
-			warn_on_inaccessible(fname);
-		if (0 <= fd)
+		if (fd < 0)
+			warn_on_fopen_errors(fname);
+		else
 			close(fd);
 		if (!check_index ||
 		    (buf = read_skip_worktree_file_from_index(fname, &size, sha1_stat)) == NULL)
diff --git a/git-compat-util.h b/git-compat-util.h
index 6be55cf8b3..eb5c18c7fd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1101,6 +1101,8 @@ int access_or_die(const char *path, int mode, unsigned flag);
 
 /* Warn on an inaccessible file that ought to be accessible */
 void warn_on_inaccessible(const char *path);
+/* Warn on an inaccessible file if errno indicates this is an error */
+int warn_on_fopen_errors(const char *path);
 
 #ifdef GMTIME_UNRELIABLE_ERRORS
 struct tm *git_gmtime(const time_t *);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 72d5f1f931..df92fdcd40 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -195,7 +195,8 @@ test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
 	chmod -r .git/config &&
 	test_when_finished "chmod +r .git/config" &&
 	echo "Error (-1) reading configuration file .git/config." >expect &&
-	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
+	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>output &&
+	grep "^Error" output >actual &&
 	test_cmp expect actual
 '
 
diff --git a/wrapper.c b/wrapper.c
index d837417709..20c25e7e65 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -418,6 +418,16 @@ FILE *fopen_for_writing(const char *path)
 	return ret;
 }
 
+int warn_on_fopen_errors(const char *path)
+{
+	if (errno != ENOENT && errno != ENOTDIR) {
+		warn_on_inaccessible(path);
+		return -1;
+	}
+
+	return 0;
+}
+
 int xmkstemp(char *template)
 {
 	int fd;
-- 
2.13.0-491-g71cfeddc25


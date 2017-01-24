Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9BF1F6DC
	for <e@80x24.org>; Tue, 24 Jan 2017 23:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdAXX5F (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 18:57:05 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34082 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdAXX5D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 18:57:03 -0500
Received: by mail-pf0-f181.google.com with SMTP id e4so53227244pfg.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fVHc8kG3yGeW2pA+Jw5LKAs5jIUKlR3kkO2Hh5c96to=;
        b=TTsxY1OXBithDT/8GntpePQT+DPw0Fo4uqkCZ8O6S1z5C1ixnVd6MmwtAJ8HbldVwf
         /WYBLhObv++mfOa/qqJGT8O3JdGA7GpyF1177G/AyqNFEqRu1obs4iQ8JQI6yPl8UKE3
         sjdLZI6vZ+nGYmlidewIoAt/36OSWasF3O3AGlGsID24HSVeXznijIUf4jGK4AbDcTaQ
         qu+VS48wRiJeoNSKbLIXYkwlr46dJvWGmyZB9wkuJEVLtfGqbE+4rTxanTQBHIm8Eh8H
         VsXUyOdrR9wIUJoHz0hu1o4Bpi2GYnDDOKs7JWGrPkAaim/5sKwW7o4Y7plxWo8AmmDL
         17GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fVHc8kG3yGeW2pA+Jw5LKAs5jIUKlR3kkO2Hh5c96to=;
        b=XiKpXUil5MGdTz4gU5UiojpL+X+Nv1j1wAUzQVZeLqR1KqZAsxk5w/HqqyGftgdyqn
         sOW0JgQFTzhWc5+WfjMlT9xK2hSJUraeeQ1FXb7CqOh2wpftyNWrP2fAXKph2MFokWim
         UvB9aW+dp7mrDA1yIhGX7hiQpbUW17F90fnyXTK3Xf2crq1oV1a8058tqNvdTwCkaJGh
         JiYxCXVzx3xeT6iV+rxRax3RwGok/hgtF2Lg8LbwiNmEjLXXkrTsGCzbdgsZ4ooTr7kK
         +67UIQCjZaaMkk+g3cc3fcl+TjmBSEyTvjSFZCWokkxgYsSeN1b6yNW7ESgKizTPLjV8
         J+GQ==
X-Gm-Message-State: AIkVDXIoycn6q3VPt+qVGvROlAfyTAGkNL12r5YSx79TbRgv7+420KlH/X514CgW4NQz0DzM
X-Received: by 10.98.192.216 with SMTP id g85mr42399561pfk.117.1485302222759;
        Tue, 24 Jan 2017 15:57:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6936:a216:cb1:3482])
        by smtp.gmail.com with ESMTPSA id o24sm47202691pfj.78.2017.01.24.15.57.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 15:57:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/3] cache.h: expose the dying procedure for reading gitlinks
Date:   Tue, 24 Jan 2017 15:56:50 -0800
Message-Id: <20170124235651.18749-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <20170124235651.18749-1-sbeller@google.com>
References: <20170124221948.GB58021@google.com>
 <20170124235651.18749-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to react to only a subset of errors, defaulting
the rest to die as usual. Separate the block that takes care of dying
into its own function so we have easy access to it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h |  1 +
 setup.c | 48 ++++++++++++++++++++++++++----------------------
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index cafa3d10ae..d55f5dccb1 100644
--- a/cache.h
+++ b/cache.h
@@ -507,6 +507,7 @@ extern int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
+extern void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 extern const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 extern const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
diff --git a/setup.c b/setup.c
index 4605fd3c3c..967f289f1e 100644
--- a/setup.c
+++ b/setup.c
@@ -486,6 +486,30 @@ int verify_repository_format(const struct repository_format *format,
 	return 0;
 }
 
+void read_gitfile_error_die(int error_code, const char *path, const char *dir)
+{
+	switch (error_code) {
+	case READ_GITFILE_ERR_STAT_FAILED:
+	case READ_GITFILE_ERR_NOT_A_FILE:
+		/* non-fatal; follow return path */
+		break;
+	case READ_GITFILE_ERR_OPEN_FAILED:
+		die_errno("Error opening '%s'", path);
+	case READ_GITFILE_ERR_TOO_LARGE:
+		die("Too large to be a .git file: '%s'", path);
+	case READ_GITFILE_ERR_READ_FAILED:
+		die("Error reading %s", path);
+	case READ_GITFILE_ERR_INVALID_FORMAT:
+		die("Invalid gitfile format: %s", path);
+	case READ_GITFILE_ERR_NO_PATH:
+		die("No path in gitfile: %s", path);
+	case READ_GITFILE_ERR_NOT_A_REPO:
+		die("Not a git repository: %s", dir);
+	default:
+		die("BUG: unknown error code");
+	}
+}
+
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
@@ -559,28 +583,8 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 cleanup_return:
 	if (return_error_code)
 		*return_error_code = error_code;
-	else if (error_code) {
-		switch (error_code) {
-		case READ_GITFILE_ERR_STAT_FAILED:
-		case READ_GITFILE_ERR_NOT_A_FILE:
-			/* non-fatal; follow return path */
-			break;
-		case READ_GITFILE_ERR_OPEN_FAILED:
-			die_errno("Error opening '%s'", path);
-		case READ_GITFILE_ERR_TOO_LARGE:
-			die("Too large to be a .git file: '%s'", path);
-		case READ_GITFILE_ERR_READ_FAILED:
-			die("Error reading %s", path);
-		case READ_GITFILE_ERR_INVALID_FORMAT:
-			die("Invalid gitfile format: %s", path);
-		case READ_GITFILE_ERR_NO_PATH:
-			die("No path in gitfile: %s", path);
-		case READ_GITFILE_ERR_NOT_A_REPO:
-			die("Not a git repository: %s", dir);
-		default:
-			assert(0);
-		}
-	}
+	else if (error_code)
+		read_gitfile_error_die(error_code, path, dir);
 
 	free(buf);
 	return error_code ? NULL : path;
-- 
2.11.0.495.g04f60290a0.dirty


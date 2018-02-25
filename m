Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06C71F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeBYLS5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:18:57 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46728 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeBYLS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:18:56 -0500
Received: by mail-pf0-f193.google.com with SMTP id z10so1046231pfh.13
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YS83EE6u6f2ry0pCITC0ZqASXHTfzxM1ckbmLF4doI4=;
        b=XD5L8yhU2tf3oxWmeoCbvqgPT850+J7jF4t9zPE8sWeJ7DDj4gyBc89Uj2/zNrog9K
         wLxzza2jQElctGpaKCTwusmf1ZfbQSuKb2U4uT9B2asNF5ZaplwKiwp+H4sy0Xe8wxso
         3wfuJIlUedn6A3b4/7a8wPBtFv4LIQ4E4E935zRn7V4MmQO37S0DaM1MLBsBiwv3MwNs
         29bZMg1QVMFtg/adfIBOM0YrULVss3U+Nokgw+zNbWlNFOAO3uxCVP9p1ZMk5MEjzNC7
         SupeH9PeWgc8Zi9TMhdGPnNhdpOHgCYGmZeMh3Z6c4UObggMA4UXi1iFERxkR+rjHapp
         muJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YS83EE6u6f2ry0pCITC0ZqASXHTfzxM1ckbmLF4doI4=;
        b=KYRAzIupQRp0iPnrmSuwDeQeO1TAco5GC9n+Ql2Tm+qJ3j3IURXnhW0+kI4wgWRG5C
         KBLkyAO8cpaEv1V5r7kyafHwcJQTvLKSe6CgSAICU3LUUrU/7uoLcoJMJ2LIiEZ0DqdN
         EiuMrgeVkbb/9YuZSF4KulLcrzXAt1M4tT1N71jWpcRnPCTlogk9Jpb5DwTx8ikg0HyL
         fI0Ltsat0nkuitZJA7X+yc/qz+gONsqmA/Nf6FZSE0H4uq7+2sQEquRF41zQ28qOC9pX
         g7rk4OJkM2o3U2BMGh9DnKvjyNy8RhB842t30HdIvHlaqHe2BiHWoK6y6YGYru58HrbT
         z+HQ==
X-Gm-Message-State: APf1xPDV7fF15dw+g/tIxV71K3AYgmeqnPdWBPooF/dh4JS/i/V5Fki2
        pXNNtJQE5/LK0rsJbQ0n92u+0g==
X-Google-Smtp-Source: AH8x2269+lncW+6PbWwjry+gaoAhIgbxgKOTe3y92gMQ4oBYtW2aR7rJKnJSpoyY7G7HxNLHjv4jJw==
X-Received: by 10.101.75.70 with SMTP id k6mr6010617pgt.335.1519557535876;
        Sun, 25 Feb 2018 03:18:55 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id g67sm11037327pgc.60.2018.02.25.03.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 03:18:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Feb 2018 18:18:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH v3 1/6] setup.c: initialize the_repository correctly in all cases
Date:   Sun, 25 Feb 2018 18:18:35 +0700
Message-Id: <20180225111840.16421-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180225111840.16421-1-pclouds@gmail.com>
References: <20180224033429.9656-1-pclouds@gmail.com>
 <20180225111840.16421-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many ways for any command to access a git repository:

- most of them will try to discover the .git dir via
  setup_git_directory() and friends

- the server side programs already know where the repo is and prepare
  with enter_repo()

- special commands that deal with repo creation (init/clone) use
  init_db() once the new repo is ready for access.

- somebody accesses $GIT_DIR before any of above functions are called
  and accidentally sets up a git repository by set_git_dir() alone

"the_repository" is partially set up via set_git_dir() at some point
in all four cases. The hash algorithm though is configured later after
.git/config is read.

So far proper repo initialization is done only for the first case [1].
The second case is not covered (but that's fine [3]). The third case
was found and worked around in [2]. The fourth case is a buggy one,
which should be fixed already by jk/no-looking-at-dotgit-outside-repo
and never happens again.

This patch makes sure all cases initialize the hash algorithm in
the_repository correctly. Both second and third cases must run
check_repo_format() before "entering" it. Eventually we probably just
rename this function to init_repo() or something.

[1] 78a6766802 (Integrate hash algorithm support with repo setup -
    2017-11-12)

[2] e26f7f19b6 (repository: pre-initialize hash algo pointer -
    2018-01-19)

[3] the reason server side is still running ok with no hash algo before
    [2] is because the programs that use enter_repo() do very
    little (and unlikely to hash anything) then spawn a new
    program (like pack-objects or upload-archive) to do the heavy
    lifting. These programs already use setup_git_directory() or the
    gently version

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 3 ++-
 cache.h           | 3 ++-
 path.c            | 2 +-
 setup.c           | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index c9b7946bad..d119d9906b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "repository.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -369,7 +370,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format();
+	check_repository_format(the_repository);
 
 	reinit = create_default_files(template_dir, original_git_dir);
 
diff --git a/cache.h b/cache.h
index 21fbcc2414..6b97138264 100644
--- a/cache.h
+++ b/cache.h
@@ -894,6 +894,7 @@ extern int repository_format_precious_objects;
 extern char *repository_format_partial_clone;
 extern const char *core_partial_clone_filter_default;
 
+struct repository;
 struct repository_format {
 	int version;
 	int precious_objects;
@@ -926,7 +927,7 @@ int verify_repository_format(const struct repository_format *format,
  * set_git_dir() before calling this, and use it only for "are we in a valid
  * repo?".
  */
-extern void check_repository_format(void);
+extern void check_repository_format(struct repository *);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
diff --git a/path.c b/path.c
index da8b655730..a544252198 100644
--- a/path.c
+++ b/path.c
@@ -827,7 +827,7 @@ const char *enter_repo(const char *path, int strict)
 
 	if (is_git_directory(".")) {
 		set_git_dir(".");
-		check_repository_format();
+		check_repository_format(the_repository);
 		return path;
 	}
 
diff --git a/setup.c b/setup.c
index c5d55dcee4..a82103832e 100644
--- a/setup.c
+++ b/setup.c
@@ -1180,11 +1180,14 @@ int git_config_perm(const char *var, const char *value)
 	return -(i & 0666);
 }
 
-void check_repository_format(void)
+/* optionally configure "repo" to the correct format */
+void check_repository_format(struct repository *repo)
 {
 	struct repository_format repo_fmt;
 	check_repository_format_gently(get_git_dir(), &repo_fmt, NULL);
 	startup_info->have_repository = 1;
+	if (repo)
+		repo_set_hash_algo(repo, repo_fmt.hash_algo);
 }
 
 /*
-- 
2.16.1.435.g8f24da2e1a


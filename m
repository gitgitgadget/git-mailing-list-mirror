Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6019D2027B
	for <e@80x24.org>; Thu, 18 May 2017 08:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbdERIWT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 04:22:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33978 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754107AbdERIWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 04:22:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id l39so4797483qtb.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MDd3tIN/OEShXaSeDMQCyirKN9laWec3SCNoN3yLLAA=;
        b=SzAwlVlzcjzAKJS9hbDTtJYjPogVfujOfKePGyApdF8tSzG/MQDFHej3m/85vz4uqm
         iKFdJIBT4xIHyzfWwk1RTpLbhbbqAXcmVAGmi8vI3Bav+mC3wcY/chSMfRPpp+Jc3JXD
         DQKSt8CYGDf9jD9N2n9Gdv31TMAd54ndSLl61ohYS1KBVVl6kwGSbs9U5VX7qIOL1mkK
         6oR2GCPYVTBTZNkOwjw4Bg0SY9oslKMLX39y55b76x4nbSfGEXYLLa+jlFJs9Vo69e+J
         f3ZbUXfRpKKhO1rr2fWvmgJsIzMDnnd5rh3bZUV9ZRrKnxqy7zyqOxEYMPtcaT22Iiuc
         0LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MDd3tIN/OEShXaSeDMQCyirKN9laWec3SCNoN3yLLAA=;
        b=Bm9xYt3+bcKzVpFmCjWy+vNjcpkJY8/5IcuMLq5UtXYO6Yy1E5LN1c5HxPPc3AwiGR
         oEumrXY/UZJeh4/nT9qKSz2jzkdt02zrUwkAJyb5MJTMMe4IS2A4hbDcHYk7CSR+b+ox
         04g9VcnukMk0uy+6IWccAENukHHKvV7RQv4dY+/eulS5i8hcHOxI4sUgm+R9eJM4Ma+T
         ggoVxH7UCnrwW9ktLx4ZnjkAJ83hHBIL1l40aD/0G0Py2MLlE8Gko4pS4aC5GyKiQlUd
         SAwwXysOOlzvzWQ7+ROr2yaPiiq6DeQAUNF5OOJCDDsTfNiUuLZUtBOBAEWHlTGGlflH
         cAiw==
X-Gm-Message-State: AODbwcAw0paijuHhHFssNW8kzJEPwDApmWLMbybYzXSfVXc6ozzjVIZr
        r5PQxQmtABlD9g==
X-Received: by 10.200.56.46 with SMTP id q43mr2879551qtb.83.1495095733540;
        Thu, 18 May 2017 01:22:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id k36sm2999604qte.65.2017.05.18.01.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 01:22:12 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 6/6] clean: teach clean -d to skip dirs containing ignored files
Date:   Thu, 18 May 2017 04:21:54 -0400
Message-Id: <20170518082154.28643-7-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an implicit assumption that a directory containing only
untracked and ignored files should itself be considered untracked. This
makes sense in use cases where we're asking if a directory should be
added to the git database, but not when we're asking if a directory can
be safely removed from the working tree; as a result, clean -d would
assume that an "untracked" directory containing ignored files could be
deleted.

To get around this, we teach clean -d to collect ignored files and skip
over so-called "untracked" directories if they contain any ignored
files (while still removing the untracked contents of such dirs).

This also fixes the known breakage in t7300 since clean -d now skips
untracked directories containing ignored files.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 builtin/clean.c  | 38 +++++++++++++++++++++++++++++++++++++-
 t/t7300-clean.sh |  2 +-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..0d490d76e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -859,7 +859,7 @@ static void interactive_main_loop(void)
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, res;
+	int i, j, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
@@ -911,6 +911,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				  " refusing to clean"));
 	}
 
+	if (remove_directories)
+		dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
+
 	if (force > 1)
 		rm_flags = 0;
 
@@ -932,12 +935,39 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	fill_directory(&dir, &pathspec);
 
+	for (j = i = 0; i < dir.nr;) {
+		for (;
+		     j < dir.ignored_nr &&
+		       0 <= cmp_dir_entry(&dir.entries[i], &dir.ignored[j]);
+		     j++);
+
+		if ((j < dir.ignored_nr) &&
+				check_dir_entry_contains(dir.entries[i], dir.ignored[j])) {
+			/* skip any dir.entries which contains a dir.ignored */
+			free(dir.entries[i]);
+			dir.entries[i++] = NULL;
+		} else {
+			/* prune the contents of a dir.entries which will be removed */
+			struct dir_entry *ent = dir.entries[i++];
+			for (;
+			     i < dir.nr &&
+			       check_dir_entry_contains(ent, dir.entries[i]);
+			     i++) {
+				free(dir.entries[i]);
+				dir.entries[i] = NULL;
+			}
+		}
+	}
+
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		int matches = 0;
 		struct stat st;
 		const char *rel;
 
+		if (!ent)
+			continue;
+
 		if (!cache_name_is_other(ent->name, ent->len))
 			continue;
 
@@ -958,6 +988,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		string_list_append(&del_list, rel);
 	}
 
+	for (i = 0; i < dir.nr; i++)
+		free(dir.entries[i]);
+
+	for (i = 0; i < dir.ignored_nr; i++)
+		free(dir.ignored[i]);
+
 	if (interactive && del_list.nr > 0)
 		interactive_main_loop();
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 3a2d709c2..7b36954d6 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,7 +653,7 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
-test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
 	echo /foo/bar >.gitignore &&
 	echo ignoreme >>.gitignore &&
 	rm -rf foo &&
-- 
2.13.0


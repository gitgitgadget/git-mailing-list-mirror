Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E13820248
	for <e@80x24.org>; Tue,  9 Apr 2019 10:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDIK07 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 06:26:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45674 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfDIK07 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 06:26:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so9426349pfi.12
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FswKOFtOenwY4aqC6Aijl6L+BojcTYlpMZcgtvGEHQM=;
        b=V5sorJ0wXu/6E+ojtm/Ngy5j3B3W6ogaO4M51npYfigG6TXsJz0+rWP0wBiV4d7HBP
         wzcEE4dMfhRvz2XqAN3CrAYQ/5PqPnbI+DwxNzuPvI8NGBwwG7tbyUU0UTInWFCORR9x
         LpszVZ8reiZNcrIYb0DcEAAgW68bG9lvS8gd3ZxmFajOdP4/nKJiXJd/ouLXoumSBwWe
         KEKAoRG9q3BUYqu9GawwQi+T/2GTIA+EQaqMNxgimECFUHC1CPJbvNQYqCVgPfAyhg7y
         HoQ9SjmR56cKfQklE8gMqtwVfT2IeLmqOjIfrpG5v8W/ifaxIrkgFqkw2IgcaQaRTUH+
         79YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FswKOFtOenwY4aqC6Aijl6L+BojcTYlpMZcgtvGEHQM=;
        b=GWFiK/+KTq2KnsKfaCk6ijN0k/kwkob2OF8JENuMKovp2mbwxuE1OZpaZVsb326itX
         EuoTWPlBXS0k7BPqDD/qvD5ndNNzq40VFR99niGmFeR8pHagLSJP+a7zRCc6bW+mXgcb
         XoLvbrsHSlhNGAqhKPa/pUB0p4vxO2eKfdZp5Nkeauy18YFOqEDPgiKfXw0wWqum7PPI
         U2ZfA5xGbVL8UIGy+euSv1HEiMvyBbIhXBYb9CTRoQdInHRgi5gCl4+XOjah7eRltRNh
         LXQKmMCTDVkpylq40pmycNIb9XtzYc4NTkpevnL2YckvH6/77q0ewswln93XbysxdPXW
         Rdow==
X-Gm-Message-State: APjAAAX+NQCh2uG5n/+9GcPm/YUuvE41lo7K3a0PKSPnoJDD7a0JhOs5
        VxD949yLOnZ53KDi+qRM0mU=
X-Google-Smtp-Source: APXvYqw0ymD67ypzPXadMvbsiKDrh0lRzf+uqpURigecugMBVBjwv6oOOjZ8vLKdvzcKYDmv+6PYWA==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr34036370pgt.391.1554805618155;
        Tue, 09 Apr 2019 03:26:58 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id o67sm75339223pga.55.2019.04.09.03.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:26:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 09 Apr 2019 17:26:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, git@vger.kernel.org, pclouds@gmail.com
Subject: [PATCH] Introduce "precious" file concept
Date:   Tue,  9 Apr 2019 17:26:49 +0700
Message-Id: <20190409102649.22115-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com>
References: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new attribute "precious" is added to indicate that certain files
have valuable content and should not be easily discarded even if they
are ignored or untracked.

So far there are one part of Git that are made aware of precious files:
"git clean" will leave precious files alone if --keep-precious is
specified.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Here's the replacement patch that keeps "git clean" behavior the same
 as before and only checks 'precious' attribute when --keep-precous is
 specified.

 Documentation/git-clean.txt     |  6 ++++-
 Documentation/gitattributes.txt | 11 +++++++++
 attr.c                          | 12 ++++++++++
 attr.h                          |  2 ++
 builtin/clean.c                 | 30 +++++++++++++++++++++----
 t/t7300-clean.sh                | 40 +++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0d..7f8c157c90 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [<options>] [-d] [-f] [-i] [-n] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -71,6 +71,10 @@ OPTIONS
 	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+--keep-precious::
+	Do not remove untracked or ignored files if they have
+	`precious` attribute.
+
 Interactive mode
 ----------------
 When the command enters the interactive mode, it shows the
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index bdd11a2ddd..ea3c07db79 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1192,6 +1192,17 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
+Precious files
+~~~~~~~~~~~~~~
+
+`precious`
+^^^^^^^^^^
+
+This attribute is set on files to indicate that their content is
+valuable. Some commands will behave slightly different on precious
+files. linkgit:git-clean[1] may leave precious files alone.
+
+
 USING MACRO ATTRIBUTES
 ----------------------
 
diff --git a/attr.c b/attr.c
index 93dc16b59c..dc6490510c 100644
--- a/attr.c
+++ b/attr.c
@@ -1157,3 +1157,15 @@ void attr_start(void)
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
 	pthread_mutex_init(&check_vector.mutex, NULL);
 }
+
+int is_precious_file(struct index_state *istate, const char *path)
+{
+	static struct attr_check *check;
+	if (!check)
+		check = attr_check_initl("precious", NULL);
+	if (!check)
+		return 0;
+
+	git_check_attr(istate, path, check);
+	return ATTR_TRUE(check->items[0].value);
+}
diff --git a/attr.h b/attr.h
index b0378bfe5f..b9a9751a66 100644
--- a/attr.h
+++ b/attr.h
@@ -82,4 +82,6 @@ void git_attr_set_direction(enum git_attr_direction new_direction);
 
 void attr_start(void);
 
+int is_precious_file(struct index_state *istate, const char *path);
+
 #endif /* ATTR_H */
diff --git a/builtin/clean.c b/builtin/clean.c
index aaba4af3c2..d2836393c5 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -18,19 +18,23 @@
 #include "color.h"
 #include "pathspec.h"
 #include "help.h"
+#include "attr.h"
 
 static int force = -1; /* unset */
 static int interactive;
+static int keep_precious;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
+	N_("git clean [<options>] [-d] [-f] [-i] [-n] [-x | -X] [--] <paths>..."),
 	NULL
 };
 
 static const char *msg_remove = N_("Removing %s\n");
 static const char *msg_would_remove = N_("Would remove %s\n");
+static const char *msg_skip_precious = N_("Skipping precious file %s\n");
+static const char *msg_would_skip_precious = N_("Would skip precious file %s\n");
 static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
@@ -146,6 +150,11 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int skip_precious_file(struct index_state *istate, const char *path)
+{
+	return keep_precious && is_precious_file(istate, path);
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -154,6 +163,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
+	const char *rel_path;
 
 	*dir_gone = 1;
 
@@ -193,9 +203,16 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
-		if (lstat(path->buf, &st))
+		if (lstat(path->buf, &st)) {
 			; /* fall thru */
-		else if (S_ISDIR(st.st_mode)) {
+		} else if ((!prefix && skip_precious_file(&the_index, path->buf)) ||
+			   (prefix && skip_prefix(path->buf, prefix, &rel_path) &&
+			    skip_precious_file(&the_index, rel_path))) {
+			quote_path_relative(path->buf, prefix, &quoted);
+			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), quoted.buf);
+			*dir_gone = 0;
+			continue;
+		} else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
 			if (gone) {
@@ -915,6 +932,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
 		OPT_BOOL('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
+		OPT_BOOL(0, "keep-precious", &keep_precious,
+			 N_("do not remove files with 'precious' attribute")),
 		OPT_END()
 	};
 
@@ -1019,7 +1038,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (lstat(abs_path.buf, &st))
 			continue;
 
-		if (S_ISDIR(st.st_mode)) {
+		if (skip_precious_file(&the_index, item->string)) {
+			qname = quote_path_relative(item->string, NULL, &buf);
+			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), qname);
+		} else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
 				errors++;
 			if (gone && !quiet) {
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954d63..ae600dafb5 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,4 +669,44 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
+test_expect_success 'git clean -xd --keep-precious leaves precious files alone' '
+	git init precious &&
+	(
+		cd precious &&
+		test_commit one &&
+		cat >.gitignore <<-\EOF &&
+		*.o
+		*.mak
+		EOF
+		cat >.gitattributes <<-\EOF &&
+		*.mak precious
+		.gitattributes precious
+		*.precious precious
+		EOF
+		mkdir sub &&
+		touch one.o sub/two.o one.mak sub/two.mak &&
+		touch one.untracked two.precious sub/also.precious &&
+		git clean -fdx --keep-precious &&
+		test_path_is_missing one.o &&
+		test_path_is_missing sub/two.o &&
+		test_path_is_missing one.untracked &&
+		test_path_is_file .gitattributes &&
+		test_path_is_file one.mak &&
+		test_path_is_file sub/two.mak &&
+		test_path_is_file two.precious &&
+		test_path_is_file sub/also.precious
+	)
+'
+
+test_expect_success 'git clean -xd still deletes them all' '
+	test_path_is_file precious/one.mak &&
+	test_path_is_file precious/sub/two.mak &&
+	test_path_is_file precious/two.precious &&
+	test_path_is_file precious/sub/also.precious &&
+	git -C precious clean -fdx &&
+	test_path_is_missing precious/one.mak &&
+	test_path_is_missing precious/sub/two.mak &&
+	test_path_is_missing precious/two.precious &&
+	test_path_is_missing precious/sub/also.precious
+'
 test_done
-- 
2.21.0.479.g47ac719cd3


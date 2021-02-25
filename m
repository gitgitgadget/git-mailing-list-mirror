Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D457EC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8021864EFA
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 16:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBYQSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 11:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhBYQQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 11:16:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4073C061786
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 08:15:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f12so2011516wrx.8
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DN49Mv/tFlf7TTPAkvmpN1B56wgBJjIu0MVoDHa0YYI=;
        b=DL/RysohMvdTJVyP9bjpNvFl+8JeVemyXazt+PFRI61S6zo4NhEul6eLh3N7rJfWoW
         XhWN16bdjSH+0NpBigCad/w2IArehaHw19f/UuJGUMftj7ZgYGZZX1+bqxPw/dW/v/+4
         018PPK9R5kVWxiTshfD6WMPsp6O3TIfImKhsOWf4OoowmU2hf7XnefAzJULbObv01wUa
         9kf8X6s3mcuQ8zrEFa8ysfxvh2Pq/e/nzk0AhUiRlGXALlYjZCV3t3HHGLbPsCCZkjZa
         CXv/xoEb/AnFndRyBYkHUjGkgsVFTPUS4HiNb50UBQ5cWAxRDwuhC49XLoKYpCNrWO/u
         X2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DN49Mv/tFlf7TTPAkvmpN1B56wgBJjIu0MVoDHa0YYI=;
        b=OxRMxN63m2680g+oHfdp9OolRyGfd3atxrh5Y7YuqnaEfywRZ02CGKun6Nyjy+JU+E
         l/OGMAgCC7x4B0e8GxlykKBcYlIcXXR/5sWa7ROzWK3wTF0cZz8++JdU6iOSAfF+nZZs
         mJdlTC+9Q9B7hoMFYFG8XZOO9IpuzId+8hxuTonuB64cgJMbcijFJ8kl8q99ptySU+55
         oDcmiODx3SghXKk4WH29Oj+oD+xLHGhkA+XGqnATJ24xrvI/bQr2P4p/hWeTcpCbYXP1
         BIVn8t+HuD2NfasRtMFWrR3hPSrEIGjc8+1UVZQlYz2bj3NFeaRRdEuWwdLl1nUY7Pd3
         g9ew==
X-Gm-Message-State: AOAM533OWo4Wrvqqzk0MZHjeCyK16I2ABvS84PPG+abBeKnrXcUIyvUZ
        4OrAdiVEF7cwXM/J6N/LOPa2j3+TtVc=
X-Google-Smtp-Source: ABdhPJzl2d03RiEZspSWOcBBKVSVbykoV+kgIG87hJbMGZkc0iSKgLec5L7BiOMf9syXhKcsGgrZHg==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr4294795wrs.225.1614269754540;
        Thu, 25 Feb 2021 08:15:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm7829525wmc.35.2021.02.25.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 08:15:54 -0800 (PST)
Message-Id: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 16:15:52 +0000
Subject: [PATCH] format-patch: allow a non-integral version numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Usually we can only use `format-patch -v<n>` to generate integral
version numbers patches, but if we can provide `format-patch` with
non-integer versions numbers of patches, this may help us to send patches
such as "v1.1" versions sometimes.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] format-patch: allow a non-integral version numbers
    
     * format-patch previously only integer version number -v<n>, now trying
       to provide a non-integer version.
    
    this want to fix #882 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/885

 Documentation/git-format-patch.txt |  6 +++---
 builtin/log.c                      | 20 ++++++++++----------
 log-tree.c                         |  4 ++--
 revision.h                         |  2 +-
 t/t4014-format-patch.sh            |  8 ++++----
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..0cc39dbf573c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -215,12 +215,12 @@ populated with placeholder text.
 
 -v <n>::
 --reroll-count=<n>::
-	Mark the series as the <n>-th iteration of the topic. The
+	Mark the series as the specified version of the topic. The
 	output filenames have `v<n>` prepended to them, and the
 	subject prefix ("PATCH" by default, but configurable via the
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
-	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
-	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
+	`--reroll-count 4.4` may produce `v4.4-0001-add-makefile.patch`
+	file that has "Subject: [PATCH v4.4 1/20] Add makefile" in it.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed1..72af140b812e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1662,13 +1662,13 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 	oidclr(&bases->base_commit);
 }
 
-static const char *diff_title(struct strbuf *sb, int reroll_count,
+static const char *diff_title(struct strbuf *sb, const char *reroll_count,
 		       const char *generic, const char *rerolled)
 {
-	if (reroll_count <= 0)
+	if (!reroll_count)
 		strbuf_addstr(sb, generic);
 	else /* RFC may be v0, so allow -v1 to diff against v0 */
-		strbuf_addf(sb, rerolled, reroll_count - 1);
+		strbuf_addf(sb, rerolled, "last version");
 	return sb->buf;
 }
 
@@ -1717,7 +1717,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int use_patch_format = 0;
 	int quiet = 0;
-	int reroll_count = -1;
+	const char *reroll_count = NULL;
 	char *cover_from_description_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
@@ -1751,8 +1751,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
 			    N_("start numbering patches at <n> instead of 1")),
-		OPT_INTEGER('v', "reroll-count", &reroll_count,
-			    N_("mark the series as Nth re-roll")),
+		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
+			    N_("mark the series as specified version re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
@@ -1862,9 +1862,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (0 < reroll_count) {
+	if (reroll_count) {
 		struct strbuf sprefix = STRBUF_INIT;
-		strbuf_addf(&sprefix, "%s v%d",
+		strbuf_addf(&sprefix, "%s v%s",
 			    rev.subject_prefix, reroll_count);
 		rev.reroll_count = reroll_count;
 		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
@@ -2080,7 +2080,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
 		rev.idiff_title = diff_title(&idiff_title, reroll_count,
 					     _("Interdiff:"),
-					     _("Interdiff against v%d:"));
+					     _("Interdiff against %s:"));
 	}
 
 	if (creation_factor < 0)
@@ -2099,7 +2099,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.creation_factor = creation_factor;
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
-					     _("Range-diff against v%d:"));
+					     _("Range-diff against %s:"));
 	}
 
 	if (!signature) {
diff --git a/log-tree.c b/log-tree.c
index 4531cebfab38..5f2e08ebcaab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -369,8 +369,8 @@ void fmt_output_subject(struct strbuf *filename,
 	int start_len = filename->len;
 	int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
 
-	if (0 < info->reroll_count)
-		strbuf_addf(filename, "v%d-", info->reroll_count);
+	if (info->reroll_count)
+		strbuf_addf(filename, "v%s-", info->reroll_count);
 	strbuf_addf(filename, "%04d-%s", nr, subject);
 
 	if (max_len < filename->len)
diff --git a/revision.h b/revision.h
index e6be3c845e66..097d08354c61 100644
--- a/revision.h
+++ b/revision.h
@@ -235,7 +235,7 @@ struct rev_info {
 	const char	*mime_boundary;
 	const char	*patch_suffix;
 	int		numbered_files;
-	int		reroll_count;
+	const char	*reroll_count;
 	char		*message_id;
 	struct ident_split from_ident;
 	struct string_list *ref_message_ids;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 66630c8413d5..b911e08f0810 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -372,10 +372,10 @@ test_expect_success 'filename limit applies only to basename' '
 
 test_expect_success 'reroll count' '
 	rm -fr patches &&
-	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
-	! grep -v "^patches/v4-000[0-3]-" list &&
+	git format-patch -o patches --cover-letter --reroll-count 4.4 main..side >list &&
+	! grep -v "^patches/v4.4-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
-	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
+	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
 '
 
 test_expect_success 'reroll count (-v)' '
@@ -2252,7 +2252,7 @@ test_expect_success 'interdiff: cover-letter' '
 
 test_expect_success 'interdiff: reroll-count' '
 	git format-patch --cover-letter --interdiff=boop~2 -v2 -1 boop &&
-	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
+	test_i18ngrep "^Interdiff ..* last version:$" v2-0000-cover-letter.patch
 '
 
 test_expect_success 'interdiff: solo-patch' '

base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
-- 
gitgitgadget

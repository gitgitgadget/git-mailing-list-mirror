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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D8C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7CD64FF5
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhCPIZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhCPIZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 04:25:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F289C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:25:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d191so9561565wmd.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FpXLAPOjeyJVAgbf5Ja3maz09jCHxB1RdeMvJy7WH2s=;
        b=OxZ2l7xWLZEZS5HROHuAbQyRXJiOCgJlqw09gFz3uDav53NHLSRvg3ECHuSnodbq2Q
         WtkxkourbaRexaWLVAenAqazFe1MJJzlDRk5Sg0lcddCohs49zkUSjxhCYQA03mPdfNP
         1uO0IsYZeegBSk3Q/EC9hpdDAa/AfsMRGO82cq1+TqnmRQGZFyczYQ1I/euTTiKUUZh/
         YTozQMzlhw7jILSGzkB7hm9dV0zkHMMebBDpuMkbonqXgZEkaLH8o1ykUPPilb/6moxR
         bWfwZOhviC8QCWdvqPYVLgCem7ESCw74VmM5wt2HnmGPZlwGNRA+A0WmXAYOxrW2XF1W
         TwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FpXLAPOjeyJVAgbf5Ja3maz09jCHxB1RdeMvJy7WH2s=;
        b=QiJtAi3T7IdGx9pAlcSh86j0ZVTKv4Zy1e/OJDh9z28YqIFIzW1iwxZwILNUzoOi1M
         L5G7pLlXIG8xdAk+kfhzU3Vd3pypOoIBF+6xqTtnVHYUDGWubZyyLw0QPdYyiAB2QV0Z
         cLVGuamIiGZnK0V5B8FMMsQg6lzx2gixRfD+CfR5XJQDMXsIWJwPBOyFRMrsCFHOSdCz
         /lSI7NlzOfJ2P+Qw5rQsgFkB7R8GUWqaI/tyS5LoBorGHOY9CmEluv1NvlsTeOin+A8S
         sy5wUFB9nUiQEi8pBNkMfhNMNc7cP3/ISdOcXAeRu6xOMv72kjjAVBD9+dOdC04euYjH
         u17Q==
X-Gm-Message-State: AOAM531wO6TzMp29VbvEFa+8/D67X74FdGXoBsfauxEkUrlSySVePuLx
        YPUfiFTIXul9OsxpAICL+Lt/WSz0ACY=
X-Google-Smtp-Source: ABdhPJxyVj+TGMbnFE+6SwaSbK6NT9R+ZufAuwSsrUS3BWDd98ryr4Sqn+OUSVXmg+Xy5+xFXkfqOA==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr3553913wmq.168.1615883138211;
        Tue, 16 Mar 2021 01:25:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm2357491wmf.13.2021.03.16.01.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 01:25:37 -0700 (PDT)
Message-Id: <pull.885.v5.git.1615883137212.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com>
References: <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 08:25:36 +0000
Subject: [PATCH v5] format-patch: allow a non-integral version numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Usually we can only use `format-patch -v<n>` to generate integral
version numbers patches, but sometimes a same fixup should be
labeled as a non-integral version like `v1.1`, so teach `format-patch`
to allow a non-integral version which may be helpful to send those
patches.

`<n>` can be any string, such as `-v1.1`.  In the case where it
is a non-integral value, the "Range-diff" and "Interdiff"
headers will not include the previous version.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] format-patch: allow a non-integral version numbers
    
    There is a small question: in the case of --reroll-count=<n>, "n" is an
    integer, we output "n-1" in the patch instead of "m" specified by
    --previous-count=<m>,Should we switch the priority of these two: let "m"
    output?
    
    this want to fix #882 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/885

Range-diff vs v4:

 1:  cb1c0267e16b ! 1:  3c4e828dbf3f format-patch: allow a non-integral version numbers
     @@ Documentation/git-format-patch.txt: populated with placeholder text.
       	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
       	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
       	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
     -+	now can support non-integrated version number like `-v1.1`.
     ++	 `<n>` may be a fractional number.
       
       --to=<email>::
       	Add a `To:` header to the email headers. This is in addition
      
       ## builtin/log.c ##
     +@@ builtin/log.c: static void print_bases(struct base_tree_info *bases, FILE *file)
     + 	oidclr(&bases->base_commit);
     + }
     + 
     +-static const char *diff_title(struct strbuf *sb, int reroll_count,
     +-		       const char *generic, const char *rerolled)
     ++static const char *diff_title(struct strbuf *sb,
     ++			      const char *reroll_count,
     ++			      const char *generic,
     ++			      const char *rerolled)
     + {
     +-	if (reroll_count <= 0)
     ++	int reroll_count_int = -1;
     ++
     ++	if (reroll_count)
     ++		strtol_i(reroll_count, 10, &reroll_count_int);
     ++	if (reroll_count_int <= 0)
     + 		strbuf_addstr(sb, generic);
     + 	else /* RFC may be v0, so allow -v1 to diff against v0 */
     +-		strbuf_addf(sb, rerolled, reroll_count - 1);
     ++		strbuf_addf(sb, rerolled, reroll_count_int - 1);
     + 	return sb->buf;
     + }
     + 
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 	struct strbuf buf = STRBUF_INIT;
       	int use_patch_format = 0;
       	int quiet = 0;
     - 	int reroll_count = -1;
     -+	const char *reroll_count_string = NULL;
     +-	int reroll_count = -1;
     ++	const char *reroll_count = NULL;
       	char *cover_from_description_arg = NULL;
       	char *branch_name = NULL;
       	char *base_commit = NULL;
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       		OPT_INTEGER(0, "start-number", &start_number,
       			    N_("start numbering patches at <n> instead of 1")),
      -		OPT_INTEGER('v', "reroll-count", &reroll_count,
     -+		OPT_STRING('v', "reroll-count", &reroll_count_string, N_("reroll-count"),
     ++		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
       			    N_("mark the series as Nth re-roll")),
       		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
       			    N_("max length of output filename")),
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
       
      -	if (0 < reroll_count) {
     -+	if (reroll_count_string) {
     ++	if (reroll_count) {
       		struct strbuf sprefix = STRBUF_INIT;
      -		strbuf_addf(&sprefix, "%s v%d",
     --			    rev.subject_prefix, reroll_count);
     --		rev.reroll_count = reroll_count;
      +
     -+		strtol_i(reroll_count_string, 10, &reroll_count);
      +		strbuf_addf(&sprefix, "%s v%s",
     -+			    rev.subject_prefix, reroll_count_string);
     -+		rev.reroll_count = reroll_count_string;
     + 			    rev.subject_prefix, reroll_count);
     + 		rev.reroll_count = reroll_count;
       		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
     - 	}
     - 
      
       ## log-tree.c ##
      @@ log-tree.c: void fmt_output_subject(struct strbuf *filename,


 Documentation/git-format-patch.txt |  1 +
 builtin/log.c                      | 23 +++++++++++++++--------
 log-tree.c                         |  4 ++--
 revision.h                         |  2 +-
 t/t3206-range-diff.sh              | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 26 ++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..82abef1a6d92 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -221,6 +221,7 @@ populated with placeholder text.
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
+	 `<n>` may be a fractional number.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed1..6fe0ec8327ec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1662,13 +1662,19 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 	oidclr(&bases->base_commit);
 }
 
-static const char *diff_title(struct strbuf *sb, int reroll_count,
-		       const char *generic, const char *rerolled)
+static const char *diff_title(struct strbuf *sb,
+			      const char *reroll_count,
+			      const char *generic,
+			      const char *rerolled)
 {
-	if (reroll_count <= 0)
+	int reroll_count_int = -1;
+
+	if (reroll_count)
+		strtol_i(reroll_count, 10, &reroll_count_int);
+	if (reroll_count_int <= 0)
 		strbuf_addstr(sb, generic);
 	else /* RFC may be v0, so allow -v1 to diff against v0 */
-		strbuf_addf(sb, rerolled, reroll_count - 1);
+		strbuf_addf(sb, rerolled, reroll_count_int - 1);
 	return sb->buf;
 }
 
@@ -1717,7 +1723,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int use_patch_format = 0;
 	int quiet = 0;
-	int reroll_count = -1;
+	const char *reroll_count = NULL;
 	char *cover_from_description_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
@@ -1751,7 +1757,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
 			    N_("start numbering patches at <n> instead of 1")),
-		OPT_INTEGER('v', "reroll-count", &reroll_count,
+		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
 			    N_("mark the series as Nth re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
@@ -1862,9 +1868,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (0 < reroll_count) {
+	if (reroll_count) {
 		struct strbuf sprefix = STRBUF_INIT;
-		strbuf_addf(&sprefix, "%s v%d",
+
+		strbuf_addf(&sprefix, "%s v%s",
 			    rev.subject_prefix, reroll_count);
 		rev.reroll_count = reroll_count;
 		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
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
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 1b26c4c2ef91..dc419c087e07 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -521,6 +521,22 @@ test_expect_success 'format-patch --range-diff as commentary' '
 	grep "> 1: .* new message" 0001-*
 '
 
+test_expect_success 'format-patch --range-diff reroll-count with a non-integer' '
+	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
+	test_when_finished "rm v2.9-0001-*" &&
+	test_line_count = 1 actual &&
+	test_i18ngrep "^Range-diff:$" v2.9-0001-* &&
+	grep "> 1: .* new message" v2.9-0001-*
+'
+
+test_expect_success 'format-patch --range-diff reroll-count with a integer' '
+	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
+	test_when_finished "rm v2-0001-*" &&
+	test_line_count = 1 actual &&
+	test_i18ngrep "^Range-diff ..* v1:$" v2-0001-* &&
+	grep "> 1: .* new message" v2-0001-*
+'
+
 test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 66630c8413d5..59dff38065ab 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -378,6 +378,14 @@ test_expect_success 'reroll count' '
 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
 '
 
+test_expect_success 'reroll count with a non-integer' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter --reroll-count 4.4 main..side >list &&
+	! grep -v "^patches/v4.4-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
+'
+
 test_expect_success 'reroll count (-v)' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter -v4 main..side >list &&
@@ -386,6 +394,14 @@ test_expect_success 'reroll count (-v)' '
 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
 '
 
+test_expect_success 'reroll count (-v) with a non-integer' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter -v4.4 main..side >list &&
+	! grep -v "^patches/v4.4-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
@@ -2255,6 +2271,16 @@ test_expect_success 'interdiff: reroll-count' '
 	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
 '
 
+test_expect_success 'interdiff: reroll-count with a non-integer' '
+	git format-patch --cover-letter --interdiff=boop~2 -v2.2 -1 boop &&
+	test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
+'
+
+test_expect_success 'interdiff: reroll-count with a integer' '
+	git format-patch --cover-letter --interdiff=boop~2 -v2 -1 boop &&
+	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
+'
+
 test_expect_success 'interdiff: solo-patch' '
 	cat >expect <<-\EOF &&
 	  +fleep

base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
-- 
gitgitgadget

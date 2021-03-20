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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1157C433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54A06192D
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 14:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTO4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCTO4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 10:56:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A1C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 07:56:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 12so6978779wmf.5
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rCwtMtGnaxoCXLmNVCi8enoCtmWKkn13gH9jfiwzS7s=;
        b=dxGArrHD+waLl0rbmhpjDfS9YkO3CT9VdWs2g5XSPKPHOrCVH4oH2xczl1eGK6RM8x
         ZnTgUcTHEPYcxGif/Yrr6dGbcp5H5B0dNGmQ6BlMCJNAIuD/hHll/sDTFRxqcz1Ng5rp
         yM+LZ2/sfXiFjMsE8rgZnJewJpIBOyMeG++8CYkKqd9qqo+cbiJ/Qah3llXlrftgIdPU
         M+d0qQ+8VnvvsO+vnccpKjnMDsLoQQtWMlaJbNUTJ/RWhBEotDPewM+Hdyn/wEwQOVWm
         CBMCJlH+PUNDlgL/bLT1MdLWHUzIKWE9HbSDxfTzw4uVKx6dPJWO9a1GDH3Jtjui/TJp
         YCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rCwtMtGnaxoCXLmNVCi8enoCtmWKkn13gH9jfiwzS7s=;
        b=VxtnVNSNGZgKXX9yls5hbbwKv6CBGUK0iKo58Rv3oU6vR4GN+Qmw+M/O/qHjoK4M6L
         tzXF8VXHBTsrS9tFAB8gYahA7LPc1F7ud7rko10VhXgCCMwYLGYDzod1p3nLP9/64Ugw
         w4aWZhpxJC+gpaIhMidjKC3eWhFZiz4acOOIVuKlbW4Ccch9JjJHXGWir0SSaNGH22uN
         HIlOYe+8fEmuhJKHqZb+ICdqHOsnsQOoqb0x5iaD1iq8Gh1ehYxKwGKdR+WFOAgjGhrT
         rKvD4qjax/JG9LMlwGCajZ34ckkJkguf7O81PkgwkvHs6bzNrqt7+u9koVkj1OWKw4My
         oKBw==
X-Gm-Message-State: AOAM533YMKC7oJkXt6UyGcdeVJumyjSbQ6aWnTqtQ42gsg5VN15sxtFS
        /JLx4jHlO8k0S2schPGDAWD0Oa9Y3mE=
X-Google-Smtp-Source: ABdhPJz1pQq7jd8Rqtg4s3eunQxZw/qYXdEQ0OORV1cKdNcucZam1SFcNHbqB2K24H96Lphhpi5ZAA==
X-Received: by 2002:a05:600c:6d4:: with SMTP id b20mr8192018wmn.142.1616252179448;
        Sat, 20 Mar 2021 07:56:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm15544665wro.18.2021.03.20.07.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 07:56:18 -0700 (PDT)
Message-Id: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 14:56:17 +0000
Subject: [PATCH v8] format-patch: allow a non-integral version numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Usually we can only use `format-patch -v<n>` to generate integral
version numbers patches, but sometimes a small fixup should be
labeled as a non-integral version like `v1.1`, so teach `format-patch`
to allow a non-integral version which may be helpful to send those
patches.

`<n>` can be any string, such as '3.1' or '4rev2'. In the case
where it is a non-integral value, the "Range-diff" and "Interdiff"
headers will not include the previous version.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] format-patch: allow a non-integral version numbers
    
    There is a small question: in the case of --reroll-count=<n>, "n" is an
    integer, we output "n-1" in the patch instead of "m" specified by
    --previous-count=<m>,Should we switch the priority of these two: let "m"
    output?
    
    this want to fix #882 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/885

Range-diff vs v7:

 1:  95cfe75ee7da ! 1:  89458d384fd0 format-patch: allow a non-integral version numbers
     @@ Commit message
          format-patch: allow a non-integral version numbers
      
          Usually we can only use `format-patch -v<n>` to generate integral
     -    version numbers patches, but sometimes a same fixup should be
     +    version numbers patches, but sometimes a small fixup should be
          labeled as a non-integral version like `v1.1`, so teach `format-patch`
          to allow a non-integral version which may be helpful to send those
          patches.
      
     -    `<n>` can be any string, such as `-v1.1`.  In the case where it
     -    is a non-integral value, the "Range-diff" and "Interdiff"
     +    `<n>` can be any string, such as '3.1' or '4rev2'. In the case
     +    where it is a non-integral value, the "Range-diff" and "Interdiff"
          headers will not include the previous version.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ Documentation/git-format-patch.txt: populated with placeholder text.
       	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
       	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
       	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
     -+	 `<n>` may be a fractional number.
     ++	 `<n>` may be a non-integer number.  E.g. `--reroll-count=4.4`
     ++	may produce `v4.4-0001-add-makefile.patch` file that has
     ++	"Subject: [PATCH v4.4 1/20] Add makefile" in it.
     ++	`--reroll-count=4rev2` may produce `v4rev2-0001-add-makefile.patch`
     ++	file that has "Subject: [PATCH v4rev2 1/20] Add makefile" in it.
       
       --to=<email>::
       	Add a `To:` header to the email headers. This is in addition
     @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff as comment
      +	grep "> 1: .* new message" v2-0001-*
      +'
      +
     ++test_expect_success 'format-patch --range-diff with v0' '
     ++	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
     ++	test_when_finished "rm v0-0001-*" &&
     ++	test_line_count = 1 actual &&
     ++	test_i18ngrep "^Range-diff:$" v0-0001-* &&
     ++	grep "> 1: .* new message" v0-0001-*
     ++'
       test_expect_success 'range-diff overrides diff.noprefix internally' '
       	git -c diff.noprefix=true range-diff HEAD^...
       '
     @@ t/t4014-format-patch.sh: test_expect_success 'reroll count' '
       	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
       '
       
     -+test_expect_success 'reroll count with a non-integer' '
     ++test_expect_success 'reroll count with a fractional number' '
      +	rm -fr patches &&
      +	git format-patch -o patches --cover-letter --reroll-count 4.4 main..side >list &&
      +	! grep -v "^patches/v4.4-000[0-3]-" list &&
      +	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
      +	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
      +'
     ++
     ++test_expect_success 'reroll count with a non number' '
     ++	rm -fr patches &&
     ++	git format-patch -o patches --cover-letter --reroll-count 4rev2 main..side >list &&
     ++	! grep -v "^patches/v4rev2-000[0-3]-" list &&
     ++	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     ++	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
     ++'
      +
       test_expect_success 'reroll count (-v)' '
       	rm -fr patches &&
     @@ t/t4014-format-patch.sh: test_expect_success 'reroll count (-v)' '
       	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
       '
       
     -+test_expect_success 'reroll count (-v) with a non-integer' '
     ++test_expect_success 'reroll count (-v) with a fractional number' '
      +	rm -fr patches &&
      +	git format-patch -o patches --cover-letter -v4.4 main..side >list &&
      +	! grep -v "^patches/v4.4-000[0-3]-" list &&
      +	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
      +	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
      +'
     ++
     ++test_expect_success 'reroll (-v) count with a non number' '
     ++	rm -fr patches &&
     ++	git format-patch -o patches --cover-letter --reroll-count 4rev2 main..side >list &&
     ++	! grep -v "^patches/v4rev2-000[0-3]-" list &&
     ++	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     ++	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
     ++'
      +
       check_threading () {
       	expect="$1" &&


 Documentation/git-format-patch.txt |  5 ++++
 builtin/log.c                      | 25 +++++++++++-------
 log-tree.c                         |  4 +--
 revision.h                         |  2 +-
 t/t3206-range-diff.sh              | 23 ++++++++++++++++
 t/t4014-format-patch.sh            | 42 ++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..e2c29a856451 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -221,6 +221,11 @@ populated with placeholder text.
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
+	 `<n>` may be a non-integer number.  E.g. `--reroll-count=4.4`
+	may produce `v4.4-0001-add-makefile.patch` file that has
+	"Subject: [PATCH v4.4 1/20] Add makefile" in it.
+	`--reroll-count=4rev2` may produce `v4rev2-0001-add-makefile.patch`
+	file that has "Subject: [PATCH v4rev2 1/20] Add makefile" in it.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed1..af853f111464 100644
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
+	int v;
+
+	/* RFC may be v0, so allow -v1 to diff against v0 */
+	if (reroll_count && !strtol_i(reroll_count, 10, &v) &&
+	    v >= 1)
+		strbuf_addf(sb, rerolled, v - 1);
+	else
 		strbuf_addstr(sb, generic);
-	else /* RFC may be v0, so allow -v1 to diff against v0 */
-		strbuf_addf(sb, rerolled, reroll_count - 1);
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
index 1b26c4c2ef91..a501949575fa 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -521,6 +521,29 @@ test_expect_success 'format-patch --range-diff as commentary' '
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
+test_expect_success 'format-patch --range-diff with v0' '
+	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
+	test_when_finished "rm v0-0001-*" &&
+	test_line_count = 1 actual &&
+	test_i18ngrep "^Range-diff:$" v0-0001-* &&
+	grep "> 1: .* new message" v0-0001-*
+'
 test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 66630c8413d5..457312793d7e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -378,6 +378,22 @@ test_expect_success 'reroll count' '
 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
 '
 
+test_expect_success 'reroll count with a fractional number' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter --reroll-count 4.4 main..side >list &&
+	! grep -v "^patches/v4.4-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
+'
+
+test_expect_success 'reroll count with a non number' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter --reroll-count 4rev2 main..side >list &&
+	! grep -v "^patches/v4rev2-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
+'
+
 test_expect_success 'reroll count (-v)' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter -v4 main..side >list &&
@@ -386,6 +402,22 @@ test_expect_success 'reroll count (-v)' '
 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
 '
 
+test_expect_success 'reroll count (-v) with a fractional number' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter -v4.4 main..side >list &&
+	! grep -v "^patches/v4.4-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
+'
+
+test_expect_success 'reroll (-v) count with a non number' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter --reroll-count 4rev2 main..side >list &&
+	! grep -v "^patches/v4rev2-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
@@ -2255,6 +2287,16 @@ test_expect_success 'interdiff: reroll-count' '
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

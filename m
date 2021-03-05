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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6483CC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 07:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A8A64DEC
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 07:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEHKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEHKO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 02:10:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375DC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 23:10:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5522427wma.0
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 23:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D/BH/01zbp1C/oc0j+vt2dM2AvEoiMGMJ5Ewnn+oFu0=;
        b=pgVCsQjTGj1NqIbyFCko8wpeJtEFqXIpZ08fUMqPBucIzVvYVrtN174J8VxJ4xRE8S
         OxN9IeQuXQo9w+V4ixYT8vJaYBHPdUvhHcIU3qM4BnsRcpr7LhNS/rPmmkMVFAGHGfrm
         fkZWwOocjV81K03/RCHYcb7VE/DdV5ejXiVjNMjVnijgFC6ELFfuGVmriHQCpladyRw5
         p8SnMBO0XjZEUs8RmJJ+GSfrj1eKwcF4rWDkhCqmRQ2Sn05C4qhTbEDlHSNRMmR5r8Mi
         C4AoChI8YZpIfRUqX9av6bFKcqBKF3ApSh9L2ESs4lBLtQtF4CCqylGTFjlLxZkJgOE0
         scFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D/BH/01zbp1C/oc0j+vt2dM2AvEoiMGMJ5Ewnn+oFu0=;
        b=fVTX5pnwpMllI72r+L+veir5cXP838poeyKZUCwlwY5vC1hVTZkY537s1mhaUug5zC
         0RPacSjs/IlcYK2d8iNNRydhJiW6paWkfUg7sQE4lqDuWBXoMa7hgnqqxZo3nkOk+ZhM
         7AKNlwu9T0hluxw4tR0ODrI5f21B8Lcd9iuqpyYoD0oJNSIlyiGouAHNsabbSLOr4hwt
         GnAAg9+k1GDQz1NnPoDa9Bbk0qbK9s04V48lDaxp77wvgUVuR5YMJA83IDatfjuLCw4y
         D0dHVucAZL5lgj3spo25S92g4uAQDf0aC/h2qWFtFAS4GLT2K4iPqCXN7gjhH4SKpsb9
         Uv6Q==
X-Gm-Message-State: AOAM531HRF/Z5Wo3QFdZU9D1jlWgHw2FClzxa8T0Z22sMm3KT2E3TRJK
        NjsKcJ6viWkx9hZsfXdqqd/z0Pz1be8=
X-Google-Smtp-Source: ABdhPJyAQ0dbkU1X8i91d68i+ptdaOuj2sUDijjhljvDXerNlkgCRYHWGuncFv8yADLIaTjIpU7SIA==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr7529935wmf.47.1614928212659;
        Thu, 04 Mar 2021 23:10:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm2869476wmc.48.2021.03.04.23.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 23:10:12 -0800 (PST)
Message-Id: <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com>
References: <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 07:10:11 +0000
Subject: [PATCH v4] format-patch: allow a non-integral version numbers
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/885

Range-diff vs v3:

 1:  d4f38b78c464 ! 1:  cb1c0267e16b format-patch: allow a non-integral version numbers
     @@ Commit message
      
          Usually we can only use `format-patch -v<n>` to generate integral
          version numbers patches, but sometimes a same fixup should be
     -    labeled as a non-integral versions like `v1.1`, so teach `format-patch`
     -    to allow a non-integral versions may be helpful to send those patches.
     +    labeled as a non-integral version like `v1.1`, so teach `format-patch`
     +    to allow a non-integral version which may be helpful to send those
     +    patches.
      
     -    Since the original `format-patch` logic, if we specify a version `-v<n>`
     -    and commbine with `--interdiff` or `--rangediff`, the patch will output
     -    "Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but this does
     -    not meet the requirements of our fractional version numbers, so if the
     -    user use a integral version number `-v<n>`, ensure that the output in
     -    the patch is still `v<n-1>`; otherwise, only output "Interdiff" or
     -    "Range-diff".
     +    `<n>` can be any string, such as `-v1.1`.  In the case where it
     +    is a non-integral value, the "Range-diff" and "Interdiff"
     +    headers will not include the previous version.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-format-patch.txt: populated with placeholder text.
       	Add a `To:` header to the email headers. This is in addition
      
       ## builtin/log.c ##
     -@@ builtin/log.c: static void print_bases(struct base_tree_info *bases, FILE *file)
     - 	oidclr(&bases->base_commit);
     - }
     - 
     --static const char *diff_title(struct strbuf *sb, int reroll_count,
     --		       const char *generic, const char *rerolled)
     -+static const char *diff_title(struct strbuf *sb,
     -+			const char *reroll_count_string,
     -+			const char*previous_count_string,
     -+			const char *generic, const char *rerolled)
     - {
     --	if (reroll_count <= 0)
     -+	if (!reroll_count_string || !previous_count_string)
     - 		strbuf_addstr(sb, generic);
     --	else /* RFC may be v0, so allow -v1 to diff against v0 */
     --		strbuf_addf(sb, rerolled, reroll_count - 1);
     -+	else if (previous_count_string)
     -+		strbuf_addf(sb, rerolled, previous_count_string);
     - 	return sb->buf;
     - }
     - 
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
       	int use_patch_format = 0;
       	int quiet = 0;
       	int reroll_count = -1;
      +	const char *reroll_count_string = NULL;
     -+	const char *previous_count_string = NULL;
       	char *cover_from_description_arg = NULL;
       	char *branch_name = NULL;
       	char *base_commit = NULL;
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       		OPT_INTEGER(0, "start-number", &start_number,
       			    N_("start numbering patches at <n> instead of 1")),
      -		OPT_INTEGER('v', "reroll-count", &reroll_count,
     --			    N_("mark the series as Nth re-roll")),
      +		OPT_STRING('v', "reroll-count", &reroll_count_string, N_("reroll-count"),
     -+			    N_("mark the series as specified version re-roll")),
     + 			    N_("mark the series as Nth re-roll")),
       		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
       			    N_("max length of output filename")),
     - 		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
       	if (cover_from_description_arg)
       		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      -		strbuf_addf(&sprefix, "%s v%d",
      -			    rev.subject_prefix, reroll_count);
      -		rev.reroll_count = reroll_count;
     -+		char *endp;
      +
     -+		reroll_count = strtoul(reroll_count_string, &endp, 10);
     -+		if (!*endp && 0 < reroll_count) {
     -+			previous_count_string = xstrfmt("%d", reroll_count - 1);
     -+		}
     ++		strtol_i(reroll_count_string, 10, &reroll_count);
      +		strbuf_addf(&sprefix, "%s v%s",
      +			    rev.subject_prefix, reroll_count_string);
      +		rev.reroll_count = reroll_count_string;
       		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
       	}
       
     -@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     - 			die(_("--interdiff requires --cover-letter or single patch"));
     - 		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
     - 		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
     --		rev.idiff_title = diff_title(&idiff_title, reroll_count,
     --					     _("Interdiff:"),
     --					     _("Interdiff against v%d:"));
     -+		rev.idiff_title = diff_title(&idiff_title, reroll_count_string,
     -+					previous_count_string,
     -+					_("Interdiff:"),
     -+					_("Interdiff against v%s:"));
     - 	}
     - 
     - 	if (creation_factor < 0)
     -@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     - 		rev.rdiff1 = rdiff1.buf;
     - 		rev.rdiff2 = rdiff2.buf;
     - 		rev.creation_factor = creation_factor;
     --		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
     --					     _("Range-diff:"),
     --					     _("Range-diff against v%d:"));
     -+		rev.rdiff_title = diff_title(&rdiff_title, reroll_count_string,
     -+					previous_count_string,
     -+					_("Range-diff:"),
     -+					_("Range-diff against v%s:"));
     - 	}
     - 
     - 	if (!signature) {
      
       ## log-tree.c ##
      @@ log-tree.c: void fmt_output_subject(struct strbuf *filename,


 Documentation/git-format-patch.txt |  1 +
 builtin/log.c                      | 13 ++++++++-----
 log-tree.c                         |  4 ++--
 revision.h                         |  2 +-
 t/t3206-range-diff.sh              | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 26 ++++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..8af0d2923118 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -221,6 +221,7 @@ populated with placeholder text.
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
+	now can support non-integrated version number like `-v1.1`.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed1..03be9675fc5e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1718,6 +1718,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int use_patch_format = 0;
 	int quiet = 0;
 	int reroll_count = -1;
+	const char *reroll_count_string = NULL;
 	char *cover_from_description_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
@@ -1751,7 +1752,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
 			    N_("start numbering patches at <n> instead of 1")),
-		OPT_INTEGER('v', "reroll-count", &reroll_count,
+		OPT_STRING('v', "reroll-count", &reroll_count_string, N_("reroll-count"),
 			    N_("mark the series as Nth re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
@@ -1862,11 +1863,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (0 < reroll_count) {
+	if (reroll_count_string) {
 		struct strbuf sprefix = STRBUF_INIT;
-		strbuf_addf(&sprefix, "%s v%d",
-			    rev.subject_prefix, reroll_count);
-		rev.reroll_count = reroll_count;
+
+		strtol_i(reroll_count_string, 10, &reroll_count);
+		strbuf_addf(&sprefix, "%s v%s",
+			    rev.subject_prefix, reroll_count_string);
+		rev.reroll_count = reroll_count_string;
 		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
 	}
 
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

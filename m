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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B8FC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 12:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AE6601FB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhCDMNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 07:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbhCDMMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 07:12:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA9C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 04:12:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u125so9416119wmg.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 04:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2bqE/ogUpxrx3pIx0hk92DTTMwqgGRffF/K9JLeuAyg=;
        b=nwKmkgbnOaiuDsutSQ9H4ZzasqqZ5W93tky/HxUCVqArhRW0OGrTFKiKPSIU1uYnj5
         bIbQ0InaBOS7BEiChJRjOwSBOqIPoionmg0Fj9xJ5lV7+I+IKZnGK9ZN2kEttv7l3ueU
         KM/lXblzUQD8zRDuAbFP5Cg3mAb4q0sG8h8bpMFhJSSzw8hAzHQRS3TWcWvsv7+F2Z5H
         KuhVXQy0Cvnle+8KNO+mp5PgO+2WipmpLhEl/WzAGB/1aGJOh46tmHZz+b9dPOQKizFK
         3XjYrOuhb2V33npTguk0GXCOTtKvycdeGPzRaxViPa5b8bV2AyaU3kKDcgGMOpA9Dqzo
         LrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2bqE/ogUpxrx3pIx0hk92DTTMwqgGRffF/K9JLeuAyg=;
        b=jjQW5kIhCAvFLZdvTLW/m2FeuNesKaTdelfZgp+HjDqNnezonUWv1Aoghnror+EnHE
         BISLbbmGzVpJoQEiR34xJfqCKtCyWMUNtClSkbgobeopYnazneHfnFXrr1QQw99v4/dk
         lsKhm2EJEP/IVNj6rlMTSrnJtjWSwNiBjPKBDEQSFrcgUTPcIcSSsKTVuQXPak2AdhS7
         AiMH6nMi+G3kBRnhfmC25jy5t9T6o/dQTTpzAp1jFKl/Cm2+VUB8Gb50EWixyEEUZ/C5
         jbF86SmA5I5pp3s1Rb9qJSzG48n027az0vy45mopL+tgZFQotyK57XYiYJAgGpsRVY+k
         9Njg==
X-Gm-Message-State: AOAM533k9S+W9FxidwqbD1TjnuvCmV5sX/20XqNLIKrZCYwSC6Ca2Yap
        JeYQNcFou7G6mcLS3Hg9XgXlXXmPmjY=
X-Google-Smtp-Source: ABdhPJwHo+n2G+Ha+dahucG90rUUsDOn3GutPoOD9vHgNJnAMgrLuoqjGG56P1xS/foUbSK++0a7XQ==
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr3771681wmm.42.1614859928542;
        Thu, 04 Mar 2021 04:12:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm4161027wrn.97.2021.03.04.04.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 04:12:08 -0800 (PST)
Message-Id: <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
References: <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 12:12:06 +0000
Subject: [PATCH v3] format-patch: allow a non-integral version numbers
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
labeled as a non-integral versions like `v1.1`, so teach `format-patch`
to allow a non-integral versions may be helpful to send those patches.

Since the original `format-patch` logic, if we specify a version `-v<n>`
and commbine with `--interdiff` or `--rangediff`, the patch will output
"Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but this does
not meet the requirements of our fractional version numbers, so if the
user use a integral version number `-v<n>`, ensure that the output in
the patch is still `v<n-1>`; otherwise, only output "Interdiff" or
"Range-diff".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] format-patch: allow a non-integral version numbers
    
    There is a small question: in the case of --reroll-count=<n>, "n" is an
    integer, we output "n-1" in the patch instead of "m" specified by
    --previous-count=<m>,Should we switch the priority of these two: let "m"
    output?
    
    this want to fix #882 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/885

Range-diff vs v2:

 1:  800094cbf53b ! 1:  d4f38b78c464 format-patch: allow a non-integral version numbers
     @@ Commit message
      
          Usually we can only use `format-patch -v<n>` to generate integral
          version numbers patches, but sometimes a same fixup should be
     -    laveled as a non-integral versions like `v1.1`,so teach format-patch
     -    allow a non-integral versions may be helpful to send those patches.
     +    labeled as a non-integral versions like `v1.1`, so teach `format-patch`
     +    to allow a non-integral versions may be helpful to send those patches.
      
          Since the original `format-patch` logic, if we specify a version `-v<n>`
          and commbine with `--interdiff` or `--rangediff`, the patch will output
          "Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but this does
     -    not meet the requirements of our fractional version numbers, so provide
     -    `format patch` a new option `--previous-count=<n>`, the patch can output
     -    user-specified previous version number. If the user use a integral version
     -    number `-v<n>`, ensure that the output in the patch is still `v<n-1>`.
     -    (let `--previous-count` become invalid.)
     +    not meet the requirements of our fractional version numbers, so if the
     +    user use a integral version number `-v<n>`, ensure that the output in
     +    the patch is still `v<n-1>`; otherwise, only output "Interdiff" or
     +    "Range-diff".
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-format-patch.txt ##
     -@@ Documentation/git-format-patch.txt: SYNOPSIS
     - 		   [--cover-from-description=<mode>]
     - 		   [--rfc] [--subject-prefix=<subject prefix>]
     - 		   [(--reroll-count|-v) <n>]
     -+		   [--previous-count=<n>]
     - 		   [--to=<email>] [--cc=<email>]
     - 		   [--[no-]cover-letter] [--quiet]
     - 		   [--[no-]encode-email-headers]
      @@ Documentation/git-format-patch.txt: populated with placeholder text.
       	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
       	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
       	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
      +	now can support non-integrated version number like `-v1.1`.
     -+
     -+--previous-count=<n>::
     -+	Under the premise that we have used `--reroll-count=<n>`,
     -+	we can use `--previous-count=<n>` to specify the previous
     -+	version number. E.g. When we use the `--range-diff` or
     -+	`--interdiff` option and combine with `-v2.3 --previous-count=2.2`,
     -+	"Interdiff against v2.2:" or "Range-diff against v2.2:"
     -+	will be output in the patch.
       
       --to=<email>::
       	Add a `To:` header to the email headers. This is in addition
     @@ builtin/log.c: static void print_bases(struct base_tree_info *bases, FILE *file)
       
      -static const char *diff_title(struct strbuf *sb, int reroll_count,
      -		       const char *generic, const char *rerolled)
     -+static const char *diff_title(struct strbuf *sb, const char *reroll_count, int reroll_count_is_integer,
     -+			const char*previous_count, const char *generic, const char *rerolled)
     ++static const char *diff_title(struct strbuf *sb,
     ++			const char *reroll_count_string,
     ++			const char*previous_count_string,
     ++			const char *generic, const char *rerolled)
       {
      -	if (reroll_count <= 0)
     -+	if (!reroll_count || (!reroll_count_is_integer && !previous_count))
     ++	if (!reroll_count_string || !previous_count_string)
       		strbuf_addstr(sb, generic);
      -	else /* RFC may be v0, so allow -v1 to diff against v0 */
      -		strbuf_addf(sb, rerolled, reroll_count - 1);
     -+	else if (reroll_count_is_integer)/* RFC may be v0, so allow -v1 to diff against v0 */
     -+		strbuf_addf(sb, rerolled, atoi(reroll_count) - 1);
     -+	else if (previous_count)
     -+		strbuf_addf(sb, rerolled, previous_count);
     ++	else if (previous_count_string)
     ++		strbuf_addf(sb, rerolled, previous_count_string);
       	return sb->buf;
       }
       
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     - 	struct strbuf buf = STRBUF_INIT;
       	int use_patch_format = 0;
       	int quiet = 0;
     --	int reroll_count = -1;
     -+	int reroll_count_is_integer = 0;
     -+	const char *reroll_count = NULL;
     -+	const char *previous_count = NULL;
     + 	int reroll_count = -1;
     ++	const char *reroll_count_string = NULL;
     ++	const char *previous_count_string = NULL;
       	char *cover_from_description_arg = NULL;
       	char *branch_name = NULL;
       	char *base_commit = NULL;
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       			    N_("start numbering patches at <n> instead of 1")),
      -		OPT_INTEGER('v', "reroll-count", &reroll_count,
      -			    N_("mark the series as Nth re-roll")),
     -+		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
     ++		OPT_STRING('v', "reroll-count", &reroll_count_string, N_("reroll-count"),
      +			    N_("mark the series as specified version re-roll")),
     -+		OPT_STRING(0, "previous-count", &previous_count, N_("previous-count"),
     -+			    N_("specified as the last version while we use --reroll-count")),
       		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
       			    N_("max length of output filename")),
       		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     - 
       	if (cover_from_description_arg)
       		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
     --
     + 
      -	if (0 < reroll_count) {
     -+	if (previous_count && !reroll_count)
     -+		usage(_("previous-count can only used when reroll-count is used"));
     -+	if (reroll_count) {
     ++	if (reroll_count_string) {
       		struct strbuf sprefix = STRBUF_INIT;
      -		strbuf_addf(&sprefix, "%s v%d",
     -+		char ch;
     -+		size_t i = 0 , reroll_count_len = strlen(reroll_count);
     +-			    rev.subject_prefix, reroll_count);
     +-		rev.reroll_count = reroll_count;
     ++		char *endp;
      +
     -+		for (; i != reroll_count_len; i++) {
     -+			ch = reroll_count[i];
     -+			if(!isdigit(ch))
     -+				break;
     ++		reroll_count = strtoul(reroll_count_string, &endp, 10);
     ++		if (!*endp && 0 < reroll_count) {
     ++			previous_count_string = xstrfmt("%d", reroll_count - 1);
      +		}
     -+		reroll_count_is_integer = i == reroll_count_len ? 1 : 0;
      +		strbuf_addf(&sprefix, "%s v%s",
     - 			    rev.subject_prefix, reroll_count);
     - 		rev.reroll_count = reroll_count;
     ++			    rev.subject_prefix, reroll_count_string);
     ++		rev.reroll_count = reroll_count_string;
       		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
     + 	}
     + 
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 			die(_("--interdiff requires --cover-letter or single patch"));
       		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
       		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
     - 		rev.idiff_title = diff_title(&idiff_title, reroll_count,
     +-		rev.idiff_title = diff_title(&idiff_title, reroll_count,
      -					     _("Interdiff:"),
      -					     _("Interdiff against v%d:"));
     -+			reroll_count_is_integer, previous_count, _("Interdiff:"),
     -+				reroll_count_is_integer ? _("Interdiff against v%d:") :
     ++		rev.idiff_title = diff_title(&idiff_title, reroll_count_string,
     ++					previous_count_string,
     ++					_("Interdiff:"),
      +					_("Interdiff against v%s:"));
       	}
       
       	if (creation_factor < 0)
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 		rev.rdiff1 = rdiff1.buf;
       		rev.rdiff2 = rdiff2.buf;
       		rev.creation_factor = creation_factor;
     - 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
     +-		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
      -					     _("Range-diff:"),
      -					     _("Range-diff against v%d:"));
     -+			reroll_count_is_integer, previous_count, _("Range-diff:"),
     -+				reroll_count_is_integer ? _("Range-diff against v%d:") :
     ++		rev.rdiff_title = diff_title(&rdiff_title, reroll_count_string,
     ++					previous_count_string,
     ++					_("Range-diff:"),
      +					_("Range-diff against v%s:"));
       	}
       
     @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff as comment
       	grep "> 1: .* new message" 0001-*
       '
       
     -+test_expect_success 'format-patch --range-diff reroll-count with a non-integer and previous-count ' '
     -+	git format-patch --range-diff=HEAD~1 -v2.9 --previous-count=2.8 HEAD~1 >actual &&
     ++test_expect_success 'format-patch --range-diff reroll-count with a non-integer' '
     ++	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
      +	test_when_finished "rm v2.9-0001-*" &&
      +	test_line_count = 1 actual &&
     -+	test_i18ngrep "^Range-diff ..* v2.8:$" v2.9-0001-* &&
     ++	test_i18ngrep "^Range-diff:$" v2.9-0001-* &&
      +	grep "> 1: .* new message" v2.9-0001-*
      +'
      +
     -+test_expect_success 'format-patch --range-diff reroll-count with a integer previous-count' '
     -+	git format-patch --range-diff=HEAD~1 -v2 --previous-count=1.8 HEAD~1 >actual &&
     ++test_expect_success 'format-patch --range-diff reroll-count with a integer' '
     ++	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
      +	test_when_finished "rm v2-0001-*" &&
      +	test_line_count = 1 actual &&
      +	test_i18ngrep "^Range-diff ..* v1:$" v2-0001-* &&
     @@ t/t4014-format-patch.sh: test_expect_success 'interdiff: reroll-count' '
      +	test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
      +'
      +
     -+test_expect_success 'interdiff: reroll-count with a non-integer and previous-count ' '
     -+	git format-patch --cover-letter --interdiff=boop~2 -v2.2 --previous-count=2.1 -1 boop &&
     -+	test_i18ngrep "^Interdiff ..* v2.1:$" v2.2-0000-cover-letter.patch
     -+'
     -+
     -+test_expect_success 'interdiff: reroll-count with a integer and previous-count ' '
     -+	git format-patch --cover-letter --interdiff=boop~2 -v2 --previous-count=1.5 -1 boop &&
     ++test_expect_success 'interdiff: reroll-count with a integer' '
     ++	git format-patch --cover-letter --interdiff=boop~2 -v2 -1 boop &&
      +	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
      +'
     -+test_expect_success 'interdiff: previous-count without reroll-count ' '
     -+	test_must_fail git format-patch --cover-letter --interdiff=boop~2 --previous-count=1.5 -1 boop
     -+'
     ++
       test_expect_success 'interdiff: solo-patch' '
       	cat >expect <<-\EOF &&
       	  +fleep


 Documentation/git-format-patch.txt |  1 +
 builtin/log.c                      | 46 +++++++++++++++++++-----------
 log-tree.c                         |  4 +--
 revision.h                         |  2 +-
 t/t3206-range-diff.sh              | 16 +++++++++++
 t/t4014-format-patch.sh            | 26 +++++++++++++++++
 6 files changed, 75 insertions(+), 20 deletions(-)

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
index f67b67d80ed1..d135c30620b6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1662,13 +1662,15 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 	oidclr(&bases->base_commit);
 }
 
-static const char *diff_title(struct strbuf *sb, int reroll_count,
-		       const char *generic, const char *rerolled)
+static const char *diff_title(struct strbuf *sb,
+			const char *reroll_count_string,
+			const char*previous_count_string,
+			const char *generic, const char *rerolled)
 {
-	if (reroll_count <= 0)
+	if (!reroll_count_string || !previous_count_string)
 		strbuf_addstr(sb, generic);
-	else /* RFC may be v0, so allow -v1 to diff against v0 */
-		strbuf_addf(sb, rerolled, reroll_count - 1);
+	else if (previous_count_string)
+		strbuf_addf(sb, rerolled, previous_count_string);
 	return sb->buf;
 }
 
@@ -1718,6 +1720,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int use_patch_format = 0;
 	int quiet = 0;
 	int reroll_count = -1;
+	const char *reroll_count_string = NULL;
+	const char *previous_count_string = NULL;
 	char *cover_from_description_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
@@ -1751,8 +1755,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
 			    N_("start numbering patches at <n> instead of 1")),
-		OPT_INTEGER('v', "reroll-count", &reroll_count,
-			    N_("mark the series as Nth re-roll")),
+		OPT_STRING('v', "reroll-count", &reroll_count_string, N_("reroll-count"),
+			    N_("mark the series as specified version re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
@@ -1862,11 +1866,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
-	if (0 < reroll_count) {
+	if (reroll_count_string) {
 		struct strbuf sprefix = STRBUF_INIT;
-		strbuf_addf(&sprefix, "%s v%d",
-			    rev.subject_prefix, reroll_count);
-		rev.reroll_count = reroll_count;
+		char *endp;
+
+		reroll_count = strtoul(reroll_count_string, &endp, 10);
+		if (!*endp && 0 < reroll_count) {
+			previous_count_string = xstrfmt("%d", reroll_count - 1);
+		}
+		strbuf_addf(&sprefix, "%s v%s",
+			    rev.subject_prefix, reroll_count_string);
+		rev.reroll_count = reroll_count_string;
 		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
 	}
 
@@ -2078,9 +2088,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			die(_("--interdiff requires --cover-letter or single patch"));
 		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
 		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
-		rev.idiff_title = diff_title(&idiff_title, reroll_count,
-					     _("Interdiff:"),
-					     _("Interdiff against v%d:"));
+		rev.idiff_title = diff_title(&idiff_title, reroll_count_string,
+					previous_count_string,
+					_("Interdiff:"),
+					_("Interdiff against v%s:"));
 	}
 
 	if (creation_factor < 0)
@@ -2097,9 +2108,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.rdiff1 = rdiff1.buf;
 		rev.rdiff2 = rdiff2.buf;
 		rev.creation_factor = creation_factor;
-		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
-					     _("Range-diff:"),
-					     _("Range-diff against v%d:"));
+		rev.rdiff_title = diff_title(&rdiff_title, reroll_count_string,
+					previous_count_string,
+					_("Range-diff:"),
+					_("Range-diff against v%s:"));
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

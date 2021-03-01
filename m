Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD53C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A25364DEF
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhCAIlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhCAIlN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:41:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB571C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:40:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o16so13581549wmh.0
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pvelsq1xw6exDnivMtdSASK76MwGw8p3yUUn+yZBFgo=;
        b=WXgsMXl7kAGYkyjPDrjIhcfF5lb0ruspQ+n5Z2RctSr7QPJnwAb17PzSYtMUQVyOtm
         EnA6wQBz3jrA9nxm7x2Fie4KviHcdJ8Daz57DgnyjzhIz0n3gXV9KXJwubGEzNtdAphl
         J5tcnhquMYW25SdjkGOadvegVY6Z1kCJ0VRlZPcd+Er8oSuGLr91cKV5oHzwl83pbdKL
         cDD/tRjRBsKO5kry2Sg52HWjlX/LRN63CigqkF9FZyzOc2/nBkJFw5Q8mrirCCLn2vMz
         tNoEeBj7fc87FTK1foL3M4+TXFMBa+gEBwK59WrlVNR1bVdm3NteS9C0OfxK3OXkNlzK
         ciIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pvelsq1xw6exDnivMtdSASK76MwGw8p3yUUn+yZBFgo=;
        b=JiG/wkpxkHSSrSUEZGu0vW21INZ5fklTMqtsESagMK9LGx2o9jXd2qFQ7O9FfyQZ4d
         IuEm5kstgRmF89Xa0jexI/nq2UWx16+g33fNatINbHo6cLUF0FBp1cW4q5OB9aFGz8ut
         vd5qWTrw6ZUmBBTBgSBMBya3+Rnyu3mdMUZcwXx8RXKh35cw0pR3Oq9NFx5ugS/hcTPK
         uRjfpYD0UWbx++gmgsEmWO/B+G/LVifRMveGqOuyrMBJlUAhBj1CHFXXa6yd3Lv0Y/pz
         pnGBN2XCede9dHh2A8eJrkFCvDG4PIwVTCwmLHKBg7kIMxASFTAEBnJIZvyTO0tzMQTY
         iC2Q==
X-Gm-Message-State: AOAM53122Tf/NWyBZZyPdHCQR/BAOYjnnjGwUEmIa/EnLvkn8kz58vLd
        In5rqKECWt7fuqPxWQnbQ99KRw5uYlU=
X-Google-Smtp-Source: ABdhPJxlS5mhZSrX/miPBnZgAyMqUoFehu3kV0L/88ctguv5xE11cYMqtErkSHhwCdVRRBVpRxxI4Q==
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr8769309wmc.31.1614588031546;
        Mon, 01 Mar 2021 00:40:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm6326432wrj.62.2021.03.01.00.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:40:30 -0800 (PST)
Message-Id: <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Mar 2021 08:40:29 +0000
Subject: [PATCH v2] format-patch: allow a non-integral version numbers
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
laveled as a non-integral versions like `v1.1`,so teach format-patch
allow a non-integral versions may be helpful to send those patches.

Since the original `format-patch` logic, if we specify a version `-v<n>`
and commbine with `--interdiff` or `--rangediff`, the patch will output
"Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but this does
not meet the requirements of our fractional version numbers, so provide
`format patch` a new option `--previous-count=<n>`, the patch can output
user-specified previous version number. If the user use a integral version
number `-v<n>`, ensure that the output in the patch is still `v<n-1>`.
(let `--previous-count` become invalid.)

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] format-patch: allow a non-integral version numbers
    
    There is a small question: in the case of --reroll-count=<n>, "n" is an
    integer, we output "n-1" in the patch instead of "m" specified by
    --previous-count=<m>,Should we switch the priority of these two: let "m"
    output?
    
    this want to fix #882 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/885

Range-diff vs v1:

 1:  285e085cd546 ! 1:  800094cbf53b format-patch: allow a non-integral version numbers
     @@ Commit message
          format-patch: allow a non-integral version numbers
      
          Usually we can only use `format-patch -v<n>` to generate integral
     -    version numbers patches, but if we can provide `format-patch` with
     -    non-integer versions numbers of patches, this may help us to send patches
     -    such as "v1.1" versions sometimes.
     +    version numbers patches, but sometimes a same fixup should be
     +    laveled as a non-integral versions like `v1.1`,so teach format-patch
     +    allow a non-integral versions may be helpful to send those patches.
     +
     +    Since the original `format-patch` logic, if we specify a version `-v<n>`
     +    and commbine with `--interdiff` or `--rangediff`, the patch will output
     +    "Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but this does
     +    not meet the requirements of our fractional version numbers, so provide
     +    `format patch` a new option `--previous-count=<n>`, the patch can output
     +    user-specified previous version number. If the user use a integral version
     +    number `-v<n>`, ensure that the output in the patch is still `v<n-1>`.
     +    (let `--previous-count` become invalid.)
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-format-patch.txt ##
     +@@ Documentation/git-format-patch.txt: SYNOPSIS
     + 		   [--cover-from-description=<mode>]
     + 		   [--rfc] [--subject-prefix=<subject prefix>]
     + 		   [(--reroll-count|-v) <n>]
     ++		   [--previous-count=<n>]
     + 		   [--to=<email>] [--cc=<email>]
     + 		   [--[no-]cover-letter] [--quiet]
     + 		   [--[no-]encode-email-headers]
      @@ Documentation/git-format-patch.txt: populated with placeholder text.
     - 
     - -v <n>::
     - --reroll-count=<n>::
     --	Mark the series as the <n>-th iteration of the topic. The
     -+	Mark the series as the specified version of the topic. The
     - 	output filenames have `v<n>` prepended to them, and the
     - 	subject prefix ("PATCH" by default, but configurable via the
       	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
     --	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
     --	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
     -+	`--reroll-count 4.4` may produce `v4.4-0001-add-makefile.patch`
     -+	file that has "Subject: [PATCH v4.4 1/20] Add makefile" in it.
     + 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
     + 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
     ++	now can support non-integrated version number like `-v1.1`.
     ++
     ++--previous-count=<n>::
     ++	Under the premise that we have used `--reroll-count=<n>`,
     ++	we can use `--previous-count=<n>` to specify the previous
     ++	version number. E.g. When we use the `--range-diff` or
     ++	`--interdiff` option and combine with `-v2.3 --previous-count=2.2`,
     ++	"Interdiff against v2.2:" or "Range-diff against v2.2:"
     ++	will be output in the patch.
       
       --to=<email>::
       	Add a `To:` header to the email headers. This is in addition
     @@ builtin/log.c: static void print_bases(struct base_tree_info *bases, FILE *file)
       }
       
      -static const char *diff_title(struct strbuf *sb, int reroll_count,
     -+static const char *diff_title(struct strbuf *sb, const char *reroll_count,
     - 		       const char *generic, const char *rerolled)
     +-		       const char *generic, const char *rerolled)
     ++static const char *diff_title(struct strbuf *sb, const char *reroll_count, int reroll_count_is_integer,
     ++			const char*previous_count, const char *generic, const char *rerolled)
       {
      -	if (reroll_count <= 0)
     -+	if (!reroll_count)
     ++	if (!reroll_count || (!reroll_count_is_integer && !previous_count))
       		strbuf_addstr(sb, generic);
     - 	else /* RFC may be v0, so allow -v1 to diff against v0 */
     +-	else /* RFC may be v0, so allow -v1 to diff against v0 */
      -		strbuf_addf(sb, rerolled, reroll_count - 1);
     -+		strbuf_addf(sb, rerolled, "last version");
     ++	else if (reroll_count_is_integer)/* RFC may be v0, so allow -v1 to diff against v0 */
     ++		strbuf_addf(sb, rerolled, atoi(reroll_count) - 1);
     ++	else if (previous_count)
     ++		strbuf_addf(sb, rerolled, previous_count);
       	return sb->buf;
       }
       
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       	int use_patch_format = 0;
       	int quiet = 0;
      -	int reroll_count = -1;
     ++	int reroll_count_is_integer = 0;
      +	const char *reroll_count = NULL;
     ++	const char *previous_count = NULL;
       	char *cover_from_description_arg = NULL;
       	char *branch_name = NULL;
       	char *base_commit = NULL;
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      -			    N_("mark the series as Nth re-roll")),
      +		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
      +			    N_("mark the series as specified version re-roll")),
     ++		OPT_STRING(0, "previous-count", &previous_count, N_("previous-count"),
     ++			    N_("specified as the last version while we use --reroll-count")),
       		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
       			    N_("max length of output filename")),
       		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 
       	if (cover_from_description_arg)
       		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
     - 
     +-
      -	if (0 < reroll_count) {
     ++	if (previous_count && !reroll_count)
     ++		usage(_("previous-count can only used when reroll-count is used"));
      +	if (reroll_count) {
       		struct strbuf sprefix = STRBUF_INIT;
      -		strbuf_addf(&sprefix, "%s v%d",
     ++		char ch;
     ++		size_t i = 0 , reroll_count_len = strlen(reroll_count);
     ++
     ++		for (; i != reroll_count_len; i++) {
     ++			ch = reroll_count[i];
     ++			if(!isdigit(ch))
     ++				break;
     ++		}
     ++		reroll_count_is_integer = i == reroll_count_len ? 1 : 0;
      +		strbuf_addf(&sprefix, "%s v%s",
       			    rev.subject_prefix, reroll_count);
       		rev.reroll_count = reroll_count;
       		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
       		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
       		rev.idiff_title = diff_title(&idiff_title, reroll_count,
     - 					     _("Interdiff:"),
     +-					     _("Interdiff:"),
      -					     _("Interdiff against v%d:"));
     -+					     _("Interdiff against %s:"));
     ++			reroll_count_is_integer, previous_count, _("Interdiff:"),
     ++				reroll_count_is_integer ? _("Interdiff against v%d:") :
     ++					_("Interdiff against v%s:"));
       	}
       
       	if (creation_factor < 0)
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 		rev.rdiff2 = rdiff2.buf;
       		rev.creation_factor = creation_factor;
       		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
     - 					     _("Range-diff:"),
     +-					     _("Range-diff:"),
      -					     _("Range-diff against v%d:"));
     -+					     _("Range-diff against %s:"));
     ++			reroll_count_is_integer, previous_count, _("Range-diff:"),
     ++				reroll_count_is_integer ? _("Range-diff against v%d:") :
     ++					_("Range-diff against v%s:"));
       	}
       
       	if (!signature) {
     @@ revision.h: struct rev_info {
       	struct ident_split from_ident;
       	struct string_list *ref_message_ids;
      
     + ## t/t3206-range-diff.sh ##
     +@@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff as commentary' '
     + 	grep "> 1: .* new message" 0001-*
     + '
     + 
     ++test_expect_success 'format-patch --range-diff reroll-count with a non-integer and previous-count ' '
     ++	git format-patch --range-diff=HEAD~1 -v2.9 --previous-count=2.8 HEAD~1 >actual &&
     ++	test_when_finished "rm v2.9-0001-*" &&
     ++	test_line_count = 1 actual &&
     ++	test_i18ngrep "^Range-diff ..* v2.8:$" v2.9-0001-* &&
     ++	grep "> 1: .* new message" v2.9-0001-*
     ++'
     ++
     ++test_expect_success 'format-patch --range-diff reroll-count with a integer previous-count' '
     ++	git format-patch --range-diff=HEAD~1 -v2 --previous-count=1.8 HEAD~1 >actual &&
     ++	test_when_finished "rm v2-0001-*" &&
     ++	test_line_count = 1 actual &&
     ++	test_i18ngrep "^Range-diff ..* v1:$" v2-0001-* &&
     ++	grep "> 1: .* new message" v2-0001-*
     ++'
     ++
     + test_expect_success 'range-diff overrides diff.noprefix internally' '
     + 	git -c diff.noprefix=true range-diff HEAD^...
     + '
     +
       ## t/t4014-format-patch.sh ##
     -@@ t/t4014-format-patch.sh: test_expect_success 'filename limit applies only to basename' '
     +@@ t/t4014-format-patch.sh: test_expect_success 'reroll count' '
     + 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
     + '
       
     - test_expect_success 'reroll count' '
     - 	rm -fr patches &&
     --	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
     --	! grep -v "^patches/v4-000[0-3]-" list &&
     ++test_expect_success 'reroll count with a non-integer' '
     ++	rm -fr patches &&
      +	git format-patch -o patches --cover-letter --reroll-count 4.4 main..side >list &&
      +	! grep -v "^patches/v4.4-000[0-3]-" list &&
     - 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     --	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
     ++	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
      +	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
     - '
     - 
     ++'
     ++
       test_expect_success 'reroll count (-v)' '
     -@@ t/t4014-format-patch.sh: test_expect_success 'interdiff: cover-letter' '
     + 	rm -fr patches &&
     + 	git format-patch -o patches --cover-letter -v4 main..side >list &&
     +@@ t/t4014-format-patch.sh: test_expect_success 'reroll count (-v)' '
     + 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
     + '
       
     - test_expect_success 'interdiff: reroll-count' '
     - 	git format-patch --cover-letter --interdiff=boop~2 -v2 -1 boop &&
     --	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
     -+	test_i18ngrep "^Interdiff ..* last version:$" v2-0000-cover-letter.patch
     ++test_expect_success 'reroll count (-v) with a non-integer' '
     ++	rm -fr patches &&
     ++	git format-patch -o patches --cover-letter -v4.4 main..side >list &&
     ++	! grep -v "^patches/v4.4-000[0-3]-" list &&
     ++	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     ++	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
     ++'
     ++
     + check_threading () {
     + 	expect="$1" &&
     + 	shift &&
     +@@ t/t4014-format-patch.sh: test_expect_success 'interdiff: reroll-count' '
     + 	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
       '
       
     ++test_expect_success 'interdiff: reroll-count with a non-integer' '
     ++	git format-patch --cover-letter --interdiff=boop~2 -v2.2 -1 boop &&
     ++	test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
     ++'
     ++
     ++test_expect_success 'interdiff: reroll-count with a non-integer and previous-count ' '
     ++	git format-patch --cover-letter --interdiff=boop~2 -v2.2 --previous-count=2.1 -1 boop &&
     ++	test_i18ngrep "^Interdiff ..* v2.1:$" v2.2-0000-cover-letter.patch
     ++'
     ++
     ++test_expect_success 'interdiff: reroll-count with a integer and previous-count ' '
     ++	git format-patch --cover-letter --interdiff=boop~2 -v2 --previous-count=1.5 -1 boop &&
     ++	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
     ++'
     ++test_expect_success 'interdiff: previous-count without reroll-count ' '
     ++	test_must_fail git format-patch --cover-letter --interdiff=boop~2 --previous-count=1.5 -1 boop
     ++'
       test_expect_success 'interdiff: solo-patch' '
     + 	cat >expect <<-\EOF &&
     + 	  +fleep


 Documentation/git-format-patch.txt | 10 +++++++
 builtin/log.c                      | 48 ++++++++++++++++++++----------
 log-tree.c                         |  4 +--
 revision.h                         |  2 +-
 t/t3206-range-diff.sh              | 16 ++++++++++
 t/t4014-format-patch.sh            | 33 ++++++++++++++++++++
 6 files changed, 95 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..f10fa6527f5f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
+		   [--previous-count=<n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
 		   [--[no-]encode-email-headers]
@@ -221,6 +222,15 @@ populated with placeholder text.
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
+	now can support non-integrated version number like `-v1.1`.
+
+--previous-count=<n>::
+	Under the premise that we have used `--reroll-count=<n>`,
+	we can use `--previous-count=<n>` to specify the previous
+	version number. E.g. When we use the `--range-diff` or
+	`--interdiff` option and combine with `-v2.3 --previous-count=2.2`,
+	"Interdiff against v2.2:" or "Range-diff against v2.2:"
+	will be output in the patch.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed1..95c95eab5393 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1662,13 +1662,15 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 	oidclr(&bases->base_commit);
 }
 
-static const char *diff_title(struct strbuf *sb, int reroll_count,
-		       const char *generic, const char *rerolled)
+static const char *diff_title(struct strbuf *sb, const char *reroll_count, int reroll_count_is_integer,
+			const char*previous_count, const char *generic, const char *rerolled)
 {
-	if (reroll_count <= 0)
+	if (!reroll_count || (!reroll_count_is_integer && !previous_count))
 		strbuf_addstr(sb, generic);
-	else /* RFC may be v0, so allow -v1 to diff against v0 */
-		strbuf_addf(sb, rerolled, reroll_count - 1);
+	else if (reroll_count_is_integer)/* RFC may be v0, so allow -v1 to diff against v0 */
+		strbuf_addf(sb, rerolled, atoi(reroll_count) - 1);
+	else if (previous_count)
+		strbuf_addf(sb, rerolled, previous_count);
 	return sb->buf;
 }
 
@@ -1717,7 +1719,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int use_patch_format = 0;
 	int quiet = 0;
-	int reroll_count = -1;
+	int reroll_count_is_integer = 0;
+	const char *reroll_count = NULL;
+	const char *previous_count = NULL;
 	char *cover_from_description_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
@@ -1751,8 +1755,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
 			    N_("start numbering patches at <n> instead of 1")),
-		OPT_INTEGER('v', "reroll-count", &reroll_count,
-			    N_("mark the series as Nth re-roll")),
+		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
+			    N_("mark the series as specified version re-roll")),
+		OPT_STRING(0, "previous-count", &previous_count, N_("previous-count"),
+			    N_("specified as the last version while we use --reroll-count")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
@@ -1861,10 +1867,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
-
-	if (0 < reroll_count) {
+	if (previous_count && !reroll_count)
+		usage(_("previous-count can only used when reroll-count is used"));
+	if (reroll_count) {
 		struct strbuf sprefix = STRBUF_INIT;
-		strbuf_addf(&sprefix, "%s v%d",
+		char ch;
+		size_t i = 0 , reroll_count_len = strlen(reroll_count);
+
+		for (; i != reroll_count_len; i++) {
+			ch = reroll_count[i];
+			if(!isdigit(ch))
+				break;
+		}
+		reroll_count_is_integer = i == reroll_count_len ? 1 : 0;
+		strbuf_addf(&sprefix, "%s v%s",
 			    rev.subject_prefix, reroll_count);
 		rev.reroll_count = reroll_count;
 		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
@@ -2079,8 +2095,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
 		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
 		rev.idiff_title = diff_title(&idiff_title, reroll_count,
-					     _("Interdiff:"),
-					     _("Interdiff against v%d:"));
+			reroll_count_is_integer, previous_count, _("Interdiff:"),
+				reroll_count_is_integer ? _("Interdiff against v%d:") :
+					_("Interdiff against v%s:"));
 	}
 
 	if (creation_factor < 0)
@@ -2098,8 +2115,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.rdiff2 = rdiff2.buf;
 		rev.creation_factor = creation_factor;
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
-					     _("Range-diff:"),
-					     _("Range-diff against v%d:"));
+			reroll_count_is_integer, previous_count, _("Range-diff:"),
+				reroll_count_is_integer ? _("Range-diff against v%d:") :
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
index 1b26c4c2ef91..ffb91f27f75f 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -521,6 +521,22 @@ test_expect_success 'format-patch --range-diff as commentary' '
 	grep "> 1: .* new message" 0001-*
 '
 
+test_expect_success 'format-patch --range-diff reroll-count with a non-integer and previous-count ' '
+	git format-patch --range-diff=HEAD~1 -v2.9 --previous-count=2.8 HEAD~1 >actual &&
+	test_when_finished "rm v2.9-0001-*" &&
+	test_line_count = 1 actual &&
+	test_i18ngrep "^Range-diff ..* v2.8:$" v2.9-0001-* &&
+	grep "> 1: .* new message" v2.9-0001-*
+'
+
+test_expect_success 'format-patch --range-diff reroll-count with a integer previous-count' '
+	git format-patch --range-diff=HEAD~1 -v2 --previous-count=1.8 HEAD~1 >actual &&
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
index 66630c8413d5..1b3c1dc273aa 100755
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
@@ -2255,6 +2271,23 @@ test_expect_success 'interdiff: reroll-count' '
 	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
 '
 
+test_expect_success 'interdiff: reroll-count with a non-integer' '
+	git format-patch --cover-letter --interdiff=boop~2 -v2.2 -1 boop &&
+	test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
+'
+
+test_expect_success 'interdiff: reroll-count with a non-integer and previous-count ' '
+	git format-patch --cover-letter --interdiff=boop~2 -v2.2 --previous-count=2.1 -1 boop &&
+	test_i18ngrep "^Interdiff ..* v2.1:$" v2.2-0000-cover-letter.patch
+'
+
+test_expect_success 'interdiff: reroll-count with a integer and previous-count ' '
+	git format-patch --cover-letter --interdiff=boop~2 -v2 --previous-count=1.5 -1 boop &&
+	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
+'
+test_expect_success 'interdiff: previous-count without reroll-count ' '
+	test_must_fail git format-patch --cover-letter --interdiff=boop~2 --previous-count=1.5 -1 boop
+'
 test_expect_success 'interdiff: solo-patch' '
 	cat >expect <<-\EOF &&
 	  +fleep

base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
-- 
gitgitgadget

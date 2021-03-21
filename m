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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2456DC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01DF61930
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 09:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCUJAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCUJA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 05:00:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0880C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 02:00:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so13478126wra.2
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QLQHArKfX7GNzZqhR3Q8xmdUMW2dTgfpzd4Hoh4uhBU=;
        b=YdIjMhzCezavzFExpRiTIPhkxHQWM5yz2vI4EiyDtS5H0iOL8ZCHP4zE112EEC2C6S
         KRjUE3cNinfwjYWs5+arnr2PFeK8BWgBW68diS4tZkL17J492O3rAiCUc7ZoOibooQ7G
         j2n1q/w+QOLqFOHl8oB9uCFe3FmCcu68X2US37veqmVPcuJ4O8HtVCUtR2RzP9FB3fTe
         fi6ml8+Srf/3ZlFgc3zy0QJrzYjCvtkpA0rs+l9zmgAPNCTmU6shcV32o82/aq1E0ky6
         3chynyYsI6uXAy3ICEJ3qrHKhAQ+2HbfCEtW4lZPa664wMbXUkYRrx1dIbqQYBD6q+Na
         +Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QLQHArKfX7GNzZqhR3Q8xmdUMW2dTgfpzd4Hoh4uhBU=;
        b=MDS8twD+XKhCvhgPqPgmQacP1RaZ22U3KQAOObVCr6xeJnMRppjY1oEyUAoYZhUE4M
         qFVriJyIAlPiteApOcgB82QbfmhCNnqPFBezXKUqx7pbX8QjdpBsrglez6u/gUqTvj2Z
         nPcEc/CapEdbuB+Ym2rVsrs4KKudUoxPM+bS5fg7//gXY7zxDLT5UnwdrS7Kh05MO7qo
         RrpaW66lrvfQ+fNnS2VyEaZC+VEvKKE/osUeMLJNbFzsewyDVRqav6bZwjhZyFKUvqvS
         wfTbBE/srFigEBtDPSssc+N/LhVjVoAGMSClBV1202NqYxamloKRTg+epi+S90Vs8yMz
         7XsQ==
X-Gm-Message-State: AOAM532nvqrhVeTU2p0ELyyivBki3T9hhYJXd6Ao86Q8d+Bc/tBesL6u
        VeYPDuJ4qBC25pnXsDVMTI1X48vPVeU=
X-Google-Smtp-Source: ABdhPJwxWj9NM3P25Eek+aoNccTrNZ0ouCSqEWT0w35toln3vXraJvLXyMZhPBV6rL3A5IzIM6I77g==
X-Received: by 2002:a5d:468e:: with SMTP id u14mr12931850wrq.359.1616317226642;
        Sun, 21 Mar 2021 02:00:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm15479248wrv.47.2021.03.21.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 02:00:26 -0700 (PDT)
Message-Id: <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
References: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 09:00:25 +0000
Subject: [PATCH v9] format-patch: allow a non-integral version numbers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

The `-v<n>` option of `format-patch` can give nothing but an
integral iteration number to patches in a series.  Some people,
however, prefer to mark a new iteration with only a small fixup
with a non integral iteration number (e.g. an "oops, that was
wrong" fix-up patch for v4 iteration may be labeled as "v4.1").

Allow `format-patch` to take such a non-integral iteration
number.

`<n>` can be any string, such as '3.1' or '4rev2'. In the case
where it is a non-integral value, the "Range-diff" and "Interdiff"
headers will not include the previous version.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] format-patch: allow a non-integral version numbers
    
    this want to fix #882 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/885

Range-diff vs v8:

 1:  89458d384fd0 ! 1:  97eaae4a8d9e format-patch: allow a non-integral version numbers
     @@ Metadata
       ## Commit message ##
          format-patch: allow a non-integral version numbers
      
     -    Usually we can only use `format-patch -v<n>` to generate integral
     -    version numbers patches, but sometimes a small fixup should be
     -    labeled as a non-integral version like `v1.1`, so teach `format-patch`
     -    to allow a non-integral version which may be helpful to send those
     -    patches.
     +    The `-v<n>` option of `format-patch` can give nothing but an
     +    integral iteration number to patches in a series.  Some people,
     +    however, prefer to mark a new iteration with only a small fixup
     +    with a non integral iteration number (e.g. an "oops, that was
     +    wrong" fix-up patch for v4 iteration may be labeled as "v4.1").
     +
     +    Allow `format-patch` to take such a non-integral iteration
     +    number.
      
          `<n>` can be any string, such as '3.1' or '4rev2'. In the case
          where it is a non-integral value, the "Range-diff" and "Interdiff"
     @@ Documentation/git-format-patch.txt: populated with placeholder text.
       	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
       	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
       	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
     -+	 `<n>` may be a non-integer number.  E.g. `--reroll-count=4.4`
     -+	may produce `v4.4-0001-add-makefile.patch` file that has
     -+	"Subject: [PATCH v4.4 1/20] Add makefile" in it.
     -+	`--reroll-count=4rev2` may produce `v4rev2-0001-add-makefile.patch`
     -+	file that has "Subject: [PATCH v4rev2 1/20] Add makefile" in it.
     ++	`<n>` does not have to be an integer (e.g. "--reroll-count=4.4",
     ++	or "--reroll-count=4rev2" are allowed), but the downside of
     ++	using such a reroll-count is that the range-diff/interdiff
     ++	with the previous version does not state exactly which
     ++	version the new interation is compared against.
       
       --to=<email>::
       	Add a `To:` header to the email headers. This is in addition
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      
       ## log-tree.c ##
      @@ log-tree.c: void fmt_output_subject(struct strbuf *filename,
     + 	int nr = info->nr;
       	int start_len = filename->len;
       	int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
     ++	struct strbuf temp = STRBUF_INIT;
       
      -	if (0 < info->reroll_count)
      -		strbuf_addf(filename, "v%d-", info->reroll_count);
     -+	if (info->reroll_count)
     -+		strbuf_addf(filename, "v%s-", info->reroll_count);
     ++	if (info->reroll_count) {
     ++		strbuf_addf(&temp, "v%s", info->reroll_count);
     ++		format_sanitized_subject(filename, temp.buf, temp.len);
     ++		strbuf_addstr(filename, "-");
     ++		strbuf_release(&temp);
     ++	}
       	strbuf_addf(filename, "%04d-%s", nr, subject);
       
       	if (max_len < filename->len)
     @@ t/t4014-format-patch.sh: test_expect_success 'reroll count (-v)' '
      +
      +test_expect_success 'reroll (-v) count with a non number' '
      +	rm -fr patches &&
     -+	git format-patch -o patches --cover-letter --reroll-count 4rev2 main..side >list &&
     ++	git format-patch -o patches --cover-letter -v4rev2 main..side >list &&
      +	! grep -v "^patches/v4rev2-000[0-3]-" list &&
      +	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
      +	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
      +'
     ++
     ++test_expect_success 'reroll (-v) count with a "injection (1)"' '
     ++	rm -fr patches &&
     ++	git format-patch -o patches --cover-letter -v4..././../1/.2//  main..side >list &&
     ++	! grep -v "^patches/v4.-.-.-1-.2-000[0-3]-" list &&
     ++	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     ++	! grep -v "^Subject: \[PATCH v4..././../1/.2// [0-3]/3\] " subjects
     ++'
     ++
     ++test_expect_success 'reroll (-v) count with a "injection (2)"' '
     ++	rm -fr patches &&
     ++	git format-patch -o patches --cover-letter -v4-----//1//--.--  main..side >list &&
     ++	! grep -v "^patches/v4-1-000[0-3]-" list &&
     ++	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     ++	! grep -v "^Subject: \[PATCH v4-----//1//--.-- [0-3]/3\] " subjects
     ++'
      +
       check_threading () {
       	expect="$1" &&


 Documentation/git-format-patch.txt |  5 +++
 builtin/log.c                      | 25 ++++++++-----
 log-tree.c                         |  9 +++--
 revision.h                         |  2 +-
 t/t3206-range-diff.sh              | 23 ++++++++++++
 t/t4014-format-patch.sh            | 58 ++++++++++++++++++++++++++++++
 6 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..741c9f8b2b88 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -221,6 +221,11 @@ populated with placeholder text.
 	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
 	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
 	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
+	`<n>` does not have to be an integer (e.g. "--reroll-count=4.4",
+	or "--reroll-count=4rev2" are allowed), but the downside of
+	using such a reroll-count is that the range-diff/interdiff
+	with the previous version does not state exactly which
+	version the new interation is compared against.
 
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
index 4531cebfab38..ebdeb29f92a2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -368,9 +368,14 @@ void fmt_output_subject(struct strbuf *filename,
 	int nr = info->nr;
 	int start_len = filename->len;
 	int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
+	struct strbuf temp = STRBUF_INIT;
 
-	if (0 < info->reroll_count)
-		strbuf_addf(filename, "v%d-", info->reroll_count);
+	if (info->reroll_count) {
+		strbuf_addf(&temp, "v%s", info->reroll_count);
+		format_sanitized_subject(filename, temp.buf, temp.len);
+		strbuf_addstr(filename, "-");
+		strbuf_release(&temp);
+	}
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
index 66630c8413d5..d59a06248dbd 100755
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
@@ -386,6 +402,38 @@ test_expect_success 'reroll count (-v)' '
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
+	git format-patch -o patches --cover-letter -v4rev2 main..side >list &&
+	! grep -v "^patches/v4rev2-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
+'
+
+test_expect_success 'reroll (-v) count with a "injection (1)"' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter -v4..././../1/.2//  main..side >list &&
+	! grep -v "^patches/v4.-.-.-1-.2-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4..././../1/.2// [0-3]/3\] " subjects
+'
+
+test_expect_success 'reroll (-v) count with a "injection (2)"' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter -v4-----//1//--.--  main..side >list &&
+	! grep -v "^patches/v4-1-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4-----//1//--.-- [0-3]/3\] " subjects
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
@@ -2255,6 +2303,16 @@ test_expect_success 'interdiff: reroll-count' '
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

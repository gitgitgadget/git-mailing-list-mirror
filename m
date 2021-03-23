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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B938C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 11:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C62619B9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 11:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCWLMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCWLMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 07:12:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B096C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 04:12:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b9so20337267wrt.8
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 04:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=L+9R7am+XzCq70BGmztFbSMxEqR8OHL5qeGbW/88Nco=;
        b=mMxmwbADmQIYT2Tx5irxI+R+DpGrXxeWmtnq88XlLXov3pn4ws6w1/EKI6eNKRHGGu
         uZlG6TkIregtd9foDAxT5ErYxhAjUZytoprmaRL5ppmYVLIT4euaDWg4FTLviw+uGpsg
         9BsyYlbRUhVl2qM072HTXH//5PzCAaW8LT46Oz3lt2fC3JLt8Hb0I1oM/yemc2WS1fhF
         hiYRMWpv4jetgqzTlKYVkCxH+hBJ8XxzSjtkpDR1Kdvt/a3UVtXbf783XcPrwxP4LgRr
         j7nyJDSEZVKco1X/HJTHiZROmBFKYr/t8QiyLe95UMi1zamrv0vidKbGeUHIMf51ij0Y
         MUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=L+9R7am+XzCq70BGmztFbSMxEqR8OHL5qeGbW/88Nco=;
        b=XzpQitt8z60WYYU4boWi5DGE6b69P/NLkAYP7maJwYRKURi8u/oTsXJayrlpR38CMA
         rF1cCTpae9i+m3mwYQD82acZIFqeZlMXQ/h3MmK3iKw2WsmAncqxi09Dq/g2IvwxCnKf
         zZvHXOD0CrDCpC+LzM68//PX1TaznqKhbmIVDhcKupjGbbmV6l0ICpK6ETaU+FV/v4eV
         dfu5xcsS4BxgNsQD0SAx31desAhVtbE0yIxvJeggom2AeVgeIeo7ZL4cfeVlGohMKVxD
         HC30hwllA/+Efv2c8iwdIUfZsFL2GWgS5meHdukzfguPD5FvDqqLoigd79HPwRR6H9uh
         kuRQ==
X-Gm-Message-State: AOAM530mAHiqyyWYGh8a9Bv3jpeM3Ut3VuMfkDNfm+8KyUoV/Y1HoSe5
        MSdAch+vG3Yi0e4+E0Gl2nxsuHK/zH0=
X-Google-Smtp-Source: ABdhPJzN7S+jTT9v5LywoHjbNEMv3VXvu09Y77cdkbmV1OrqdUqVciNNk7SiB1rRZLnI+8Fqvm+0xQ==
X-Received: by 2002:a5d:6cd2:: with SMTP id c18mr3420865wrc.330.1616497947855;
        Tue, 23 Mar 2021 04:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm24352311wrf.41.2021.03.23.04.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:12:27 -0700 (PDT)
Message-Id: <pull.885.v10.git.1616497946427.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com>
References: <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 11:12:25 +0000
Subject: [PATCH v10] format-patch: allow a non-integral version numbers
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
    
    A rollback was performed again under Eric's suggestion.
    
    this want to fix #882 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-885%2Fadlternative%2Fformat_patch_non_intergral-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-885/adlternative/format_patch_non_intergral-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/885

Range-diff vs v9:

 1:  97eaae4a8d9e ! 1:  53c359f364fa format-patch: allow a non-integral version numbers
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      
       ## log-tree.c ##
      @@ log-tree.c: void fmt_output_subject(struct strbuf *filename,
     - 	int nr = info->nr;
       	int start_len = filename->len;
       	int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
     -+	struct strbuf temp = STRBUF_INIT;
       
      -	if (0 < info->reroll_count)
      -		strbuf_addf(filename, "v%d-", info->reroll_count);
      +	if (info->reroll_count) {
     ++		struct strbuf temp = STRBUF_INIT;
     ++
      +		strbuf_addf(&temp, "v%s", info->reroll_count);
      +		format_sanitized_subject(filename, temp.buf, temp.len);
      +		strbuf_addstr(filename, "-");
     @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff as comment
      +	test_i18ngrep "^Range-diff:$" v0-0001-* &&
      +	grep "> 1: .* new message" v0-0001-*
      +'
     ++
       test_expect_success 'range-diff overrides diff.noprefix internally' '
       	git -c diff.noprefix=true range-diff HEAD^...
       '
      
       ## t/t4014-format-patch.sh ##
     -@@ t/t4014-format-patch.sh: test_expect_success 'reroll count' '
     - 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
     - '
     - 
     -+test_expect_success 'reroll count with a fractional number' '
     -+	rm -fr patches &&
     -+	git format-patch -o patches --cover-letter --reroll-count 4.4 main..side >list &&
     -+	! grep -v "^patches/v4.4-000[0-3]-" list &&
     -+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     -+	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
     -+'
     -+
     -+test_expect_success 'reroll count with a non number' '
     -+	rm -fr patches &&
     -+	git format-patch -o patches --cover-letter --reroll-count 4rev2 main..side >list &&
     -+	! grep -v "^patches/v4rev2-000[0-3]-" list &&
     -+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     -+	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
     -+'
     -+
     - test_expect_success 'reroll count (-v)' '
     - 	rm -fr patches &&
     - 	git format-patch -o patches --cover-letter -v4 main..side >list &&
      @@ t/t4014-format-patch.sh: test_expect_success 'reroll count (-v)' '
       	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
       '
     @@ t/t4014-format-patch.sh: test_expect_success 'reroll count (-v)' '
      +	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
      +'
      +
     -+test_expect_success 'reroll (-v) count with a "injection (1)"' '
     -+	rm -fr patches &&
     -+	git format-patch -o patches --cover-letter -v4..././../1/.2//  main..side >list &&
     -+	! grep -v "^patches/v4.-.-.-1-.2-000[0-3]-" list &&
     -+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     -+	! grep -v "^Subject: \[PATCH v4..././../1/.2// [0-3]/3\] " subjects
     -+'
     -+
     -+test_expect_success 'reroll (-v) count with a "injection (2)"' '
     ++test_expect_success 'reroll (-v) count with a non-pathname character' '
      +	rm -fr patches &&
     -+	git format-patch -o patches --cover-letter -v4-----//1//--.--  main..side >list &&
     -+	! grep -v "^patches/v4-1-000[0-3]-" list &&
     ++	git format-patch -o patches --cover-letter -v4---..././../--1/.2//  main..side >list &&
     ++	! grep -v "patches/v4-\.-\.-\.-1-\.2-000[0-3]-" list &&
      +	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
     -+	! grep -v "^Subject: \[PATCH v4-----//1//--.-- [0-3]/3\] " subjects
     ++	! grep -v "^Subject: \[PATCH v4---\.\.\./\./\.\./--1/\.2// [0-3]/3\] " subjects
      +'
      +
       check_threading () {


 Documentation/git-format-patch.txt |  5 +++++
 builtin/log.c                      | 25 ++++++++++++++--------
 log-tree.c                         | 10 +++++++--
 revision.h                         |  2 +-
 t/t3206-range-diff.sh              | 24 +++++++++++++++++++++
 t/t4014-format-patch.sh            | 34 ++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 12 deletions(-)

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
index 4531cebfab38..f3178a66a95b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -369,8 +369,14 @@ void fmt_output_subject(struct strbuf *filename,
 	int start_len = filename->len;
 	int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
 
-	if (0 < info->reroll_count)
-		strbuf_addf(filename, "v%d-", info->reroll_count);
+	if (info->reroll_count) {
+		struct strbuf temp = STRBUF_INIT;
+
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
index 1b26c4c2ef91..e30bc48a2901 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -521,6 +521,30 @@ test_expect_success 'format-patch --range-diff as commentary' '
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
+
 test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 66630c8413d5..ed0cc8b5e177 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -386,6 +386,30 @@ test_expect_success 'reroll count (-v)' '
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
+test_expect_success 'reroll (-v) count with a non-pathname character' '
+	rm -fr patches &&
+	git format-patch -o patches --cover-letter -v4---..././../--1/.2//  main..side >list &&
+	! grep -v "patches/v4-\.-\.-\.-1-\.2-000[0-3]-" list &&
+	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
+	! grep -v "^Subject: \[PATCH v4---\.\.\./\./\.\./--1/\.2// [0-3]/3\] " subjects
+'
+
 check_threading () {
 	expect="$1" &&
 	shift &&
@@ -2255,6 +2279,16 @@ test_expect_success 'interdiff: reroll-count' '
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

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C1C4743E
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7660613E9
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFEJPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFEJPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 05:15:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC69C061789
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 02:13:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h3so6711877wmq.3
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WYTZLDiP0RR+f08dtmyAR+1YUnTfqjOJL7C/bTBv5zI=;
        b=m2aH1ywBFXtQWi96SbAYvo4prZc8dDPuVLVfB8uRVnih7UTLjZh6P/q6AetAW/elPv
         kxTWByUoBw8TBT7s9Y0LYibjBgXdD5+Br3t8ml38drprXUcs/vKbT6UP7Yk0MVlYkad9
         DVQNlz5rDTfuv7fQsOyibGFRsWTjoZhzYQKlytOKVqlr4kT1/ycXwEgev0A9r/7Qhe5M
         65to1XOWBmkYfaQO02LEdUfkc+ZwTJcspZZq1EFCF9gPg/gMKW5Y8/sYw5/vbt6VmHo7
         SwUv79Yxry8QMM/hgqLI69NsUrp7nHC4GWjTwA/6uOLp+yCu7vYTCljKy3hGbJJtPo1g
         JsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WYTZLDiP0RR+f08dtmyAR+1YUnTfqjOJL7C/bTBv5zI=;
        b=Y829ONb1bJB2q2rhzwAVRHdFCw9KQRTmMe7L8NzOovgWKneDLOSEoiIiyMElWf/P5F
         HBSZWIPkpB2Ey2w09cRQRDOvtU00Q8qrc+A3WQ1mqeyCr2ZbVHtjS7u4KQ5tk3a+UvHi
         8oE8QZdl1l7c6pxvKWGcmk8fP+Q8ejG5pXWY3UDQVgRH+jNICTkPz/tRhe8TDr8ubaKZ
         M6V+bUhA54Oq4re+ptsm0TuznJeCwt5xc/pXAh3+jYys+29vf9iklC+qx7vxL00ww6RJ
         kiqE9zabRg3bFRdnqoYF4GoVMAfgmePSXuuPcYMf/g1qAuVBOEEqcuydv5+NqmvRIsCN
         sVwQ==
X-Gm-Message-State: AOAM533yvsBQZGprQiovvwAHg5ZWkVFaNfcHkyhRRhSyan+qrUxhUMS7
        NGWezqhLQin3r68P//lbEZpTWt6PgIQ=
X-Google-Smtp-Source: ABdhPJzPbBO1grSzAwMOnXgdmK8i0BSA9TKgJ7GWgo+f9tbG7rUuSz04wYRqJgHkKB5sOxAyhcTtFA==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr7437022wml.29.1622884418939;
        Sat, 05 Jun 2021 02:13:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm301043wms.18.2021.06.05.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 02:13:38 -0700 (PDT)
Message-Id: <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.972.git.1622884415.gitgitgadget@gmail.com>
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 09:13:32 +0000
Subject: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to let "cat-file --batch=%(rest)" use the ref-filter
interface, add %(rest) atom for ref-filter and --rest option
for "git for-each-ref", "git branch", "git tag" and "git verify-tag".
`--rest` specify a string to replace %(rest) placeholders of
the --format option.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-branch.txt       |  6 +++++-
 Documentation/git-for-each-ref.txt | 10 +++++++++-
 Documentation/git-tag.txt          |  4 ++++
 Documentation/git-verify-tag.txt   |  6 +++++-
 builtin/branch.c                   |  5 +++++
 builtin/for-each-ref.c             |  6 ++++++
 builtin/tag.c                      |  6 ++++++
 builtin/verify-tag.c               |  1 +
 ref-filter.c                       | 21 +++++++++++++++++++++
 ref-filter.h                       |  5 ++++-
 t/t3203-branch-output.sh           | 14 ++++++++++++++
 t/t6300-for-each-ref.sh            | 24 ++++++++++++++++++++++++
 t/t7004-tag.sh                     | 10 ++++++++++
 t/t7030-verify-tag.sh              |  8 ++++++++
 14 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2d7..29fa579e3d8a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	[--contains [<commit>]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
-	[--list] [<pattern>...]
+	[--list] [<pattern>...] [--rest=<rest>]
 'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
@@ -298,6 +298,10 @@ start-point is either a local or remote-tracking branch.
 	and the object it points at.  The format is the same as
 	that of linkgit:git-for-each-ref[1].
 
+--rest=<rest>::
+	If given, the `%(rest)` placeholders in the `--format` option
+	will be replaced.
+
 CONFIGURATION
 -------------
 `pager.branch` is only respected when listing branches, i.e., when
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 8f8d8cd1e04f..e85b7b19a530 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at=<object>]
+		   [--points-at=<object>] [--rest=<rest>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 
@@ -74,6 +74,10 @@ OPTIONS
 --points-at=<object>::
 	Only list refs which points at the given object.
 
+--rest=<rest>::
+	If given, the `%(rest)` placeholders in the `--format` option
+	will be replaced by its contents.
+
 --merged[=<object>]::
 	Only list refs whose tips are reachable from the
 	specified commit (HEAD if not specified).
@@ -235,6 +239,10 @@ and `date` to extract the named component.  For email fields (`authoremail`,
 without angle brackets, and `:localpart` to get the part before the `@` symbol
 out of the trimmed email.
 
+rest::
+	The placeholder for `--rest` specified string. If no `--rest`, nothing
+	is printed.
+
 The raw data in a object is `raw`.
 
 raw:size::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31a97a1b6c5b..3bf6ae7216de 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -200,6 +200,10 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
+--rest=<rest>::
+	If given, the `%(rest)` placeholders in the `--format` option
+	will be replaced.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0b8075dad965..7ba4a6941ab1 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -8,7 +8,7 @@ git-verify-tag - Check the GPG signature of tags
 SYNOPSIS
 --------
 [verse]
-'git verify-tag' [--format=<format>] <tag>...
+'git verify-tag' [--format=<format>] [--rest=<rest>] <tag>...
 
 DESCRIPTION
 -----------
@@ -27,6 +27,10 @@ OPTIONS
 <tag>...::
 	SHA-1 identifiers of Git tag objects.
 
+--rest=<rest>::
+	If given, the `%(rest)` placeholders in the `--format` option
+	will be replaced.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752af..b03a4c49c1d9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -439,6 +439,10 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 
+	if (format->use_rest)
+		for (i = 0; i < array.nr; i++)
+			array.items[i]->rest = format->rest;
+
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
@@ -670,6 +674,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(0, "rest", &format.rest, N_("rest"), N_("specify %(rest) contents")),
 		OPT_END(),
 	};
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89cb6307d46f..fac7777fd2c0 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -37,6 +37,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
+		OPT_STRING(  0 , "rest", &format.rest, N_("rest"), N_("specify %(rest) contents")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_SORT(sorting_tail),
@@ -78,6 +79,11 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
+
+	if (format.use_rest)
+		for (i = 0; i < array.nr; i++)
+			array.items[i]->rest = format.rest;
+
 	ref_array_sort(sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
diff --git a/builtin/tag.c b/builtin/tag.c
index 452558ec9575..9e52b3eacb16 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -63,6 +63,11 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
+
+	if (format->use_rest)
+		for (i = 0; i < array.nr; i++)
+			array.items[i]->rest = format->rest;
+
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
@@ -481,6 +486,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_STRING(  0 , "format", &format.format, N_("format"),
 			   N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
+		OPT_STRING(0, "rest", &format.rest, N_("rest"), N_("specify %(rest) contents")),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END()
 	};
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f45136a06ba7..00be4899678d 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -36,6 +36,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
 		OPT_STRING(0, "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(0, "rest", &format.rest, N_("rest"), N_("specify %(rest) contents")),
 		OPT_END()
 	};
 
diff --git a/ref-filter.c b/ref-filter.c
index 608e38aa4160..695f6f55e3e3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -157,6 +157,7 @@ enum atom_type {
 	ATOM_IF,
 	ATOM_THEN,
 	ATOM_ELSE,
+	ATOM_REST,
 };
 
 /*
@@ -559,6 +560,15 @@ static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
+static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
+			    const char *arg, struct strbuf *err)
+{
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
+	format->use_rest = 1;
+	return 0;
+}
+
 static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *unused_err)
 {
@@ -615,6 +625,7 @@ static struct {
 	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
 	[ATOM_THEN] = { "then", SOURCE_NONE },
 	[ATOM_ELSE] = { "else", SOURCE_NONE },
+	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -1919,6 +1930,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			v->handler = else_atom_handler;
 			v->s = xstrdup("");
 			continue;
+		} else if (atom_type == ATOM_REST) {
+			if (ref->rest)
+				v->s = xstrdup(ref->rest);
+			else
+				v->s = xstrdup("");
+			continue;
 		} else
 			continue;
 
@@ -2136,6 +2153,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
+	ref->rest = NULL;
 
 	return ref;
 }
@@ -2600,6 +2618,9 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 
 	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
+	if (format->use_rest)
+		ref_item->rest = format->rest;
+
 	if (format_ref_array_item(ref_item, format, &output, &err))
 		die("%s", err.buf);
 	fwrite(output.buf, 1, output.len, stdout);
diff --git a/ref-filter.h b/ref-filter.h
index 74fb423fc89f..9dc07476a584 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -38,6 +38,7 @@ struct ref_sorting {
 
 struct ref_array_item {
 	struct object_id objectname;
+	const char *rest;
 	int flag;
 	unsigned int kind;
 	const char *symref;
@@ -76,14 +77,16 @@ struct ref_format {
 	 * verify_ref_format() afterwards to finalize.
 	 */
 	const char *format;
+	const char *rest;
 	int quote_style;
+	int use_rest;
 	int use_color;
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { NULL, 0, -1 }
+#define REF_FORMAT_INIT { NULL, NULL, 0, 0, -1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 5325b9f67a00..dc6bf2557088 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -340,6 +340,20 @@ test_expect_success 'git branch --format option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch with --format and --rest option' '
+	cat >expect <<-\EOF &&
+	@Refname is (HEAD detached from fromtag)
+	@Refname is refs/heads/ambiguous
+	@Refname is refs/heads/branch-one
+	@Refname is refs/heads/branch-two
+	@Refname is refs/heads/main
+	@Refname is refs/heads/ref-to-branch
+	@Refname is refs/heads/ref-to-remote
+	EOF
+	git branch --rest="@" --format="%(rest)Refname is %(refname)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'worktree colors correct' '
 	cat >expect <<-EOF &&
 	* <GREEN>(HEAD detached from fromtag)<RESET>
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5f66d933ace0..e908b2ca0522 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1187,6 +1187,30 @@ test_expect_success 'basic atom: head contents:trailers' '
 	test_cmp expect actual.clean
 '
 
+test_expect_success 'bacic atom: rest with --rest' '
+	git for-each-ref --format="###refname=%(refname)
+###oid=%(objectname)
+###type=%(objecttype)
+###size=%(objectsize)" refs/heads/main refs/tags/subject-body >expect &&
+	git for-each-ref --rest="###" --format="%(rest)refname=%(refname)
+%(rest)oid=%(objectname)
+%(rest)type=%(objecttype)
+%(rest)size=%(objectsize)" refs/heads/main refs/tags/subject-body >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bacic atom: *rest with --rest' '
+	git for-each-ref --format="###refname=%(refname)
+###oid=%(objectname)
+###type=%(objecttype)
+###size=%(objectsize)" refs/heads/main refs/tags/subject-body >expect &&
+	git for-each-ref --rest="###" --format="%(*rest)refname=%(refname)
+%(rest)oid=%(objectname)
+%(rest)type=%(objecttype)
+%(rest)size=%(objectsize)" refs/heads/main refs/tags/subject-body >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2f72c5c6883e..93c4366ff52d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1998,6 +1998,16 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_expect_success 'tag -l with --format and --rest' '
+	cat >expect <<-\EOF &&
+	#refname : refs/tags/v1.0
+	#refname : refs/tags/v1.0.1
+	#refname : refs/tags/v1.1.3
+	EOF
+	git tag -l --rest="#" --format="%(rest)refname : %(refname)" "v1*" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>v1.0<RESET>" >expect.color &&
 	echo "v1.0" >expect.bare &&
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 3cefde9602bf..008df00c32d6 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -194,6 +194,14 @@ test_expect_success GPG 'verifying tag with --format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'verifying tag with --format and --rest' '
+	cat >expect <<-\EOF &&
+	#tagname : fourth-signed
+	EOF
+	git verify-tag --rest="#" --format="%(rest)tagname : %(tag)" "fourth-signed" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'verifying a forged tag with --format should fail silently' '
 	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
 	test_must_be_empty actual-forged
-- 
gitgitgadget


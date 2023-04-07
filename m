Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7FFC6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 17:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDGRxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDGRxh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 13:53:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228961BA
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 10:53:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h11so48365710lfu.8
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680890013; x=1683482013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WKLGXhGn7S7+fmpf9jOR55IPT4m4hljnUsXwXpbbvw=;
        b=Jk1sxmwXn14cJmUYc7da+H9N7iefju5N6CFeed3N7zyT5U+1rS3GaibXtx/4JqY6AY
         M6jzliC0LcXzO2TmUk6mQ4DY4U3SpU1aLZ82ZFw12oEuvqzhuZshgbZxqrPKOnWe/kOz
         IWvQ7nf4Ymh5uhXGnwJBpPzcuYu2+v7rjSGbnIFboNXlrLG5gBoWKCj1HyMnI5o8Fe6M
         3SdUjZ/c3nLPISEHv8aNXQcLxQhRKTW0Jr3fcLUqF7lneZAZNrIjmRGxuBXdYkGYBUhY
         JH1pjCNrGA1UkxP6Wj71gIaoZkmNznZASnsVmjV5xIcnAOkQ03xshePmxaL9stalq3x0
         oWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890013; x=1683482013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WKLGXhGn7S7+fmpf9jOR55IPT4m4hljnUsXwXpbbvw=;
        b=oe92d2hnpL8cRSxNS3jkY72ZExgyGGq6OPXeO3QupxN3ggRUzBnIhed/6EPhZ3HN2w
         2vrhVrLS8eeSTyMJD0sXERvvyUbJhe62GcxDSMRMB0Bjbs2CNEs9sKdeBefnTKTuHi8x
         vCrjDr4OjlKvV+vs9bWoGPZ8ru/nGZ6KGa7eBfFkEMB60dMewvADwdJ8LJQOao3/tBvC
         IrdIG+uKzOhWPAttjid36w7Du3NdueobMXIxY38+7kzzZgkLPQ2hGayv2VnFO+39uvPI
         /9rnv4pSpz4cXoOa7aSrrYaZ+MbMYKfIAaT4Ggd1YDZBaWgJrTy1cQMUwnZbwmqgtXEG
         Tz2w==
X-Gm-Message-State: AAQBX9eL4XbcTDwxmlSZ5ZL+zcf63d+zTta+GrrZ+sp9uNSPfrb96zTb
        tPvwU9V/qhPoDkMPTBtKEkw=
X-Google-Smtp-Source: AKy350aUy5USvbVgoAEB0ec7ZXtej7k/zduXR4MEdfABU89+QMp+yKfYszPnUj5S6wXvB3B2JjhwsA==
X-Received: by 2002:a05:6512:21ac:b0:4e8:4bc3:fe8a with SMTP id c12-20020a05651221ac00b004e84bc3fe8amr832362lft.25.1680890013154;
        Fri, 07 Apr 2023 10:53:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9c74:f016:4c88:53bb])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b004e90dee5469sm804595lfc.157.2023.04.07.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:53:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, oystwa@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com
Subject: [PATCH v3] branch, for-each-ref, tag: add option to omit empty lines
Date:   Fri,  7 Apr 2023 19:53:16 +0200
Message-Id: <20230407175316.6404-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqjzyoq35x.fsf@gitster.g>
References: <xmqqjzyoq35x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the given format string expands to the empty string a newline is
still printed it. This makes using the output linewise more tedious. For
example, git update-ref --stdin does not accept empty lines.

Add options to branch and for-each-ref to not print these empty lines.
The default behavior remains the same.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
Dang, you're right. But yes, it was a near-identical patch to
builtin/tag.c. Along with a test, of course.

I see you already applied the first of these patches so in this
iteration there's only one. 

 Documentation/git-branch.txt       |  4 ++++
 Documentation/git-for-each-ref.txt |  4 ++++
 Documentation/git-tag.txt          |  4 ++++
 builtin/branch.c                   |  6 +++++-
 builtin/for-each-ref.c             |  7 +++++--
 builtin/tag.c                      |  6 +++++-
 t/t3203-branch-output.sh           | 24 ++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  8 ++++++++
 t/t7004-tag.sh                     | 16 ++++++++++++++++
 9 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d382ac69f7..d207da9101 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -156,6 +156,10 @@ in another worktree linked to the same repository.
 --ignore-case::
 	Sorting and filtering branches are case insensitive.
 
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
 --column[=<options>]::
 --no-column::
 	Display branch listing in columns. See configuration variable
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 0713e49b49..1e215d4e73 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -98,6 +98,10 @@ OPTIONS
 --ignore-case::
 	Sorting and filtering refs are case insensitive.
 
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
 FIELD NAMES
 -----------
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index fdc72b5875..7f61c1edb3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -131,6 +131,10 @@ options for details.
 --ignore-case::
 	Sorting and filtering tags are case insensitive.
 
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
 --column[=<options>]::
 --no-column::
 	Display tag listing in columns. See configuration variable
diff --git a/builtin/branch.c b/builtin/branch.c
index 6413a016c5..98d5fa2c8e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -44,6 +44,7 @@ static const char *head;
 static struct object_id head_oid;
 static int recurse_submodules = 0;
 static int submodule_propagate_branches = 0;
+static int omit_empty = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -466,7 +467,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			string_list_append(output, out.buf);
 		} else {
 			fwrite(out.buf, 1, out.len, stdout);
-			putchar('\n');
+			if (out.len || !omit_empty)
+				putchar('\n');
 		}
 	}
 
@@ -675,6 +677,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
+		OPT_BOOL(0, "omit-empty",  &omit_empty,
+			N_("do not output a newline after empty formatted refs")),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL('l', "list", &list, N_("list branch names")),
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 0bdc49a6e1..695fc8f4a5 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -22,7 +22,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int i;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
-	int maxcount = 0, icase = 0;
+	int maxcount = 0, icase = 0, omit_empty = 0;
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -40,6 +40,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
 		OPT_BIT(0 , "tcl",  &format.quote_style,
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
+		OPT_BOOL(0, "omit-empty",  &omit_empty,
+			N_("do not output a newline after empty formatted refs")),
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
@@ -112,7 +114,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		if (format_ref_array_item(array.items[i], &format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
-		putchar('\n');
+		if (output.len || !omit_empty)
+			putchar('\n');
 	}
 
 	strbuf_release(&err);
diff --git a/builtin/tag.c b/builtin/tag.c
index 782bb3aa2f..ab5f5c74f4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -41,6 +41,7 @@ static const char * const git_tag_usage[] = {
 static unsigned int colopts;
 static int force_sign_annotate;
 static int config_sign_tag = -1; /* unspecified */
+static int omit_empty = 0;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
@@ -79,7 +80,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		if (format_ref_array_item(array.items[i], format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
-		putchar('\n');
+		if (output.len || !omit_empty)
+			putchar('\n');
 	}
 
 	strbuf_release(&err);
@@ -474,6 +476,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
+		OPT_BOOL(0, "omit-empty",  &omit_empty,
+			N_("do not output a newline after empty formatted refs")),
 		OPT_REF_SORT(&sorting_options),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 1c0f7ea24e..93f8295339 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -355,6 +355,30 @@ test_expect_success 'git branch with --format=%(rest) must fail' '
 	test_must_fail git branch --format="%(rest)" >actual
 '
 
+test_expect_success 'git branch --format --omit-empty' '
+	cat >expect <<-\EOF &&
+	Refname is (HEAD detached from fromtag)
+	Refname is refs/heads/ambiguous
+	Refname is refs/heads/branch-one
+	Refname is refs/heads/branch-two
+
+	Refname is refs/heads/ref-to-branch
+	Refname is refs/heads/ref-to-remote
+	EOF
+	git branch --format="%(if:notequals=refs/heads/main)%(refname)%(then)Refname is %(refname)%(end)" >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	Refname is (HEAD detached from fromtag)
+	Refname is refs/heads/ambiguous
+	Refname is refs/heads/branch-one
+	Refname is refs/heads/branch-two
+	Refname is refs/heads/ref-to-branch
+	Refname is refs/heads/ref-to-remote
+	EOF
+	git branch --omit-empty --format="%(if:notequals=refs/heads/main)%(refname)%(then)Refname is %(refname)%(end)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'worktree colors correct' '
 	cat >expect <<-EOF &&
 	* <GREEN>(HEAD detached from fromtag)<RESET>
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 6614469d2d..5c00607608 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1374,6 +1374,14 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
 	test_cmp expect actual
 '
 
+test_expect_success 'for-each-ref --omit-empty works' '
+	git for-each-ref --format="%(refname)" >actual &&
+	test_line_count -gt 1 actual &&
+	git for-each-ref --format="%(if:equals=refs/heads/main)%(refname)%(then)%(refname)%(end)" --omit-empty >actual &&
+	echo refs/heads/main >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
 	# name refs numerically to avoid case-insensitive filesystem conflicts
 	nr=0 &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 32b312fa80..0fe6ba93a2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2046,6 +2046,22 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_expect_success '--format --omit-empty works' '
+	cat >expect <<-\EOF &&
+	refname : refs/tags/v1.0
+
+	refname : refs/tags/v1.1.3
+	EOF
+	git tag -l --format="%(if:notequals=refs/tags/v1.0.1)%(refname)%(then)refname : %(refname)%(end)" "v1*" >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	refname : refs/tags/v1.0
+	refname : refs/tags/v1.1.3
+	EOF
+	git tag -l --omit-empty --format="%(if:notequals=refs/tags/v1.0.1)%(refname)%(then)refname : %(refname)%(end)" "v1*" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git tag -l with --format="%(rest)" must fail' '
 	test_must_fail git tag -l --format="%(rest)" "v1*"
 '
-- 
2.20.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC7DC77B60
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 11:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjC3LVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjC3LVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 07:21:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C77AB9
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:21:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k37so24108548lfv.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGcTfxbfZ/fuJarXcIAzRFEaJwFftTj5Lei8fMydIEE=;
        b=o6OomgqFXu95aOyFdV864KnyTXS2hgPs+/h9N6cH7lv0WRR+y0fze9tgZvEjuMIfU8
         CD0D3J0/APmop4yicmEukQcgJUDFNVnhP0jOvorAqLkC+iFynmiru1+l4G5TYFafpAaX
         D9kcXiYuexStLC2YkrEQ6LLJq3b31LOfELGUBdGMcMuFP+fyYJpW1HegnjvgvPEAeLGj
         cCfHDEZRLPUyiKs/8UEOFLjYjo2L0Uj/xpKFGcmIXAOY76WCAB+x4EE+/0QueLt2asIF
         kc8/oLwNM2Sb6ymv5D/iImN+4znZnnREtE2RaG6kmuR58dHKjbc52e/R4zpr/f52Pbsl
         h6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGcTfxbfZ/fuJarXcIAzRFEaJwFftTj5Lei8fMydIEE=;
        b=m68N226a6Cj6YfKEHI+wBEheTiBzS4/NjUrIAnfIRC0YFt7ryDh1SC29mxegQPdOtc
         tGkmBYHWm4ONQmLqZPaK40sxCFjxR7WZ10cmlMav3uYcJxSNl6Qgs8G+FtVWamfCyJfH
         2G+ktMxvxMKihtgN9sawXh/5m2XkDOAjl16T4rmqYyc4ZFdw6AHox2SgkH0HmPpyjbnW
         aLlzexzHyvk14bx7KsFe5xb/yt2zF234Jph+KuBpuBWqMlpUz8UCK5dcwAZyEL9dr3hp
         d1dnDm72U6cQMcs9EPcmehFoOQQeaKiS2LvGwArA5ZNqFdG1F3U2/qoU0Ar2bD+l+s4z
         yPBw==
X-Gm-Message-State: AAQBX9dhTkvshp0pOy8q6GFcxkG9q1QRjh0pSaG/pCHQHlzO2mJTEKfH
        Zs+X5HKNca6gc2UE7bBbQN/Nfujcuj9XrQ==
X-Google-Smtp-Source: AKy350Y8A0f05Xno+4jV+8DdsogpxkiRyiqIVr1VN7ksevarho32R7iAIRoJlYQfCvLNW2GLuSHHGg==
X-Received: by 2002:a19:f60e:0:b0:4e9:8cae:c626 with SMTP id x14-20020a19f60e000000b004e98caec626mr7310946lfe.53.1680175305769;
        Thu, 30 Mar 2023 04:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9575:60ad:3b58:51c5])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004cc82b7080bsm5869024lfl.200.2023.03.30.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:21:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
Date:   Thu, 30 Mar 2023 13:21:33 +0200
Message-Id: <20230330112133.4437-3-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330112133.4437-1-oystwa@gmail.com>
References: <20230330112133.4437-1-oystwa@gmail.com>
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

The logic is more or less duplicated in branch.c and for-each-ref.c
which I don't like. However I couldn't really find a "central" place to
put it. Imo. it's definitely not a property of the format or the filter,
so struct ref_format and struct ref_filter are no good.

I also started working on a patch to make update-ref --stdin accept
empty lines. But that seems to be a much more deliberate decision, with
tests to verify it and all. So I stopped pursuing that.

 Documentation/git-branch.txt       |  5 +++++
 Documentation/git-for-each-ref.txt |  5 +++++
 builtin/branch.c                   | 12 +++++++++++-
 builtin/for-each-ref.c             | 15 +++++++++++----
 t/t3203-branch-output.sh           | 26 ++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  8 ++++++++
 6 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d382ac69f7..4d53133ce3 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -156,6 +156,11 @@ in another worktree linked to the same repository.
 --ignore-case::
 	Sorting and filtering branches are case insensitive.
 
+-n::
+--omit-empty-lines::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
 --column[=<options>]::
 --no-column::
 	Display branch listing in columns. See configuration variable
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6da899c629..0f4fa98b18 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -93,6 +93,11 @@ OPTIONS
 --ignore-case::
 	Sorting and filtering refs are case insensitive.
 
+-n::
+--omit-empty-lines::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..1bbb36b442 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -41,6 +41,7 @@ static const char *head;
 static struct object_id head_oid;
 static int recurse_submodules = 0;
 static int submodule_propagate_branches = 0;
+static int omit_empty_lines = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -461,7 +462,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			string_list_append(output, out.buf);
 		} else {
 			fwrite(out.buf, 1, out.len, stdout);
-			putchar('\n');
+			if (!omit_empty_lines || out.len > 0)
+				putchar('\n');
 		}
 	}
 
@@ -670,6 +672,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
+		OPT_BOOL('n' , "omit-empty-lines",  &omit_empty_lines,
+			N_("do not output a newline after empty formatted refs")),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL('l', "list", &list, N_("list branch names")),
@@ -757,7 +761,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (list)
+	{
+		if (omit_empty_lines && !format.format) {
+			error("--omit-empty-lines without --format does not make sense");
+			usage_with_options(builtin_branch_usage, options);
+		}
 		setup_auto_pager("branch", 1);
+	}
 
 	if (delete) {
 		if (!argc)
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6f62f40d12..349c4d4ef8 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -19,7 +19,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int i;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
-	int maxcount = 0, icase = 0;
+	int maxcount = 0, icase = 0, omit_empty_lines = 0;
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -35,6 +35,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
 		OPT_BIT(0 , "tcl",  &format.quote_style,
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
+		OPT_BOOL('n' , "omit-empty-lines",  &omit_empty_lines,
+			N_("do not output a newline after empty formatted refs")),
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
@@ -55,8 +57,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	memset(&array, 0, sizeof(array));
 	memset(&filter, 0, sizeof(filter));
 
-	format.format = "%(objectname) %(objecttype)\t%(refname)";
-
 	git_config(git_default_config, NULL);
 
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
@@ -68,6 +68,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
+	if (omit_empty_lines && !format.format) {
+		error("--omit-empty-lines without --format does not make sense");
+		usage_with_options(for_each_ref_usage, opts);
+	}
+	if (!format.format)
+		format.format = "%(objectname) %(objecttype)\t%(refname)";
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
@@ -88,7 +94,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		if (format_ref_array_item(array.items[i], &format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
-		putchar('\n');
+		if (!omit_empty_lines || output.len > 0)
+			putchar('\n');
 	}
 
 	strbuf_release(&err);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d34d77f893..26bf0819ea 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -341,6 +341,32 @@ test_expect_success 'git branch with --format=%(rest) must fail' '
 	test_must_fail git branch --format="%(rest)" >actual
 '
 
+test_expect_success 'git branch --format --omit-empty-lines' '
+	cat >expect <<-\EOF &&
+	Refname is (HEAD detached from fromtag)
+	Refname is refs/heads/ambiguous
+	Refname is refs/heads/branch-one
+	Refname is refs/heads/branch-two
+	EOF
+	echo >>expect &&
+	cat >>expect <<-\EOF &&
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
+	git branch --omit-empty-lines --format="%(if:notequals=refs/heads/main)%(refname)%(then)Refname is %(refname)%(end)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'worktree colors correct' '
 	cat >expect <<-EOF &&
 	* <GREEN>(HEAD detached from fromtag)<RESET>
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c466fd989f..eec9d45513 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1374,6 +1374,14 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
 	test_cmp expect actual
 '
 
+test_expect_success 'for-each-ref --omit-empty-lines works' '
+	git for-each-ref --format="%(refname)" > actual &&
+	test_line_count -gt 1 actual &&
+	git for-each-ref --format="%(if:equals=refs/heads/main)%(refname)%(then)%(refname)%(end)" --omit-empty-lines > actual &&
+	echo refs/heads/main > expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
 	# name refs numerically to avoid case-insensitive filesystem conflicts
 	nr=0 &&
-- 
2.34.1


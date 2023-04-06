Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B85C761A6
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 17:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbjDFRJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbjDFRI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 13:08:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6DC9EEB
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 10:08:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j11so51658627lfg.13
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680800933; x=1683392933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+ARfr5wkjuuedbwdWqo2luenHZ1ch8ULkdUqmwecFc=;
        b=R8XBOFpteRxjeYlymqokvJj5B5mKb8S6MSofTnt6sj74PdVQnB5KPdW5kqh3uIw/QN
         yC6Q61X2jKYtVuXtv8TKLLnQOccULP9fPUospdDLij/lcvF2j7vNOmEHzuvg7RWCNqr3
         zqqiH5CJLIHEuYGnffMqXIHdwvwdeuYB+L28yO5+mBoOIMXk/F0Xn9OkZQkH37+RYuSY
         Qsdj+9teUXjsE/itRcUJpOfHo8GXk3zz4qNWJFVkSHO2njVk4eKdVab4vLvkZFA3C2ED
         uahKuDzNKE5ymw20pyg6vS4FzFpFReZ+XWsh+HXf50Yc/dR8w9TyRRkKBWJC5FJGpplJ
         cryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800933; x=1683392933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+ARfr5wkjuuedbwdWqo2luenHZ1ch8ULkdUqmwecFc=;
        b=faWaf8fffIV9E0SmJCv6jg4VUPci/to/RZMP2IEyJ5MckLQix/1dOly2IUz3M0WCl0
         kjzOgOjC2MSFR5unkl8A6D0eYSbltVte8UbeEm+auUTTMu5TU9i81mDMBf0q3O0PIZ1I
         ZIEYLJRnTOX2s+bFs61AEysvqn+UCKThZILSNVhaWIQVOT8tH5iaCTywEq5S++af2wV5
         1a3qYq8OOwZSEwMpAxxbCfuC5ncb5RHfkStV7rEmC5cOXteIm43+6guQ3Uu4v0tw/4hr
         EDrTMY9WRCVmt0fzqbBhD85ugCm+pckrR2GUK14VrEWbIm1idScftFlmBQW0ZjhPWCQn
         relA==
X-Gm-Message-State: AAQBX9f6gdH+ccmTjKk41VczF404diRoyvIGzR5vZ+RMiapILSp58int
        PY2m2mVwwhLMqGrX9THUACzphTqoMSktjw==
X-Google-Smtp-Source: AKy350ZTgFQvfIf7stniM/7ip40sWIW6xKuovSehzExSveTqMkSE1PaxSzBvbp3v864bUss9xM1SSw==
X-Received: by 2002:ac2:5d24:0:b0:4eb:341c:ecc1 with SMTP id i4-20020ac25d24000000b004eb341cecc1mr3714lfb.5.1680800933403;
        Thu, 06 Apr 2023 10:08:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9c74:f016:4c88:53bb])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24850000000b004e817c666eesm338412lfy.193.2023.04.06.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 10:08:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com, peff@peff.net,
        oystwa@gmail.com
Subject: [PATCH v2 2/2] branch, for-each-ref: add option to omit empty lines
Date:   Thu,  6 Apr 2023 19:08:37 +0200
Message-Id: <20230406170837.10060-3-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230406170837.10060-1-oystwa@gmail.com>
References: <xmqq4jq0hp1i.fsf@gitster.g>
 <20230406170837.10060-1-oystwa@gmail.com>
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
 Documentation/git-branch.txt       |  4 ++++
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/branch.c                   |  6 +++++-
 builtin/for-each-ref.c             |  7 +++++--
 t/t3203-branch-output.sh           | 24 ++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  8 ++++++++
 6 files changed, 50 insertions(+), 3 deletions(-)

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
index 6da899c629..af790bfa4e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -93,6 +93,10 @@ OPTIONS
 --ignore-case::
 	Sorting and filtering refs are case insensitive.
 
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..b47fef51fb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -41,6 +41,7 @@ static const char *head;
 static struct object_id head_oid;
 static int recurse_submodules = 0;
 static int submodule_propagate_branches = 0;
+static int omit_empty = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -461,7 +462,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			string_list_append(output, out.buf);
 		} else {
 			fwrite(out.buf, 1, out.len, stdout);
-			putchar('\n');
+			if (out.len || !omit_empty)
+				putchar('\n');
 		}
 	}
 
@@ -670,6 +672,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
+		OPT_BOOL(0, "omit-empty",  &omit_empty,
+			N_("do not output a newline after empty formatted refs")),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL('l', "list", &list, N_("list branch names")),
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6f62f40d12..1fc5130481 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -19,7 +19,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int i;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
-	int maxcount = 0, icase = 0;
+	int maxcount = 0, icase = 0, omit_empty = 0;
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -35,6 +35,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
 		OPT_BIT(0 , "tcl",  &format.quote_style,
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
+		OPT_BOOL(0, "omit-empty",  &omit_empty,
+			N_("do not output a newline after empty formatted refs")),
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
@@ -88,7 +90,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		if (format_ref_array_item(array.items[i], &format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
-		putchar('\n');
+		if (output.len || !omit_empty)
+			putchar('\n');
 	}
 
 	strbuf_release(&err);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d34d77f893..c06906d83e 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -341,6 +341,30 @@ test_expect_success 'git branch with --format=%(rest) must fail' '
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
index c466fd989f..d4ccc22d99 100755
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
-- 
2.20.1


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75435C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiCDKoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiCDKof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC21AC2BF
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bx5so7020304pjb.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUTDDOVeBFl29d4A6IroFS8RhiM/GAeygpocBZmMUpI=;
        b=UINoaW1jje5YTxQtuLgvP3tCg4kH4WBZbUSqvkV8IgbyTSfmbKui1dDqbWvd88AXaS
         0LXwyF4LI0cpJMeA8XE5J/tWuYcP8fDo0AeYlzfN1s1V4xXGGBP3IOj6Qfdee+IW3A50
         QVF6jP7TtgsFJmgKVS0otcR2xIRyDFkc3IKednP+JfcRySVlUKQAEz7RV82RkhSuunIy
         Kjw4a5KIZsh1+m9tQ+hQgJovKd/+R4FCrmLlKd7+jGv7xCF21BNFIY3JcXwl5MGyojmS
         hmpe7DfWmslXVJoUCOrdpYbLC9WJrc7jc33PPaiPhfM8a0yuMiTzj4O0R2r2vlQmszJD
         EVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUTDDOVeBFl29d4A6IroFS8RhiM/GAeygpocBZmMUpI=;
        b=oSbdHKjkQD3mOyD14pGQ6SYPZArfXxgJv0ouXywPCPMAZBpV0gICZoPya6XVwSerRU
         Ac31+crCXvwQsbqgDrkYmomhJY1M90/r366piniindwF2Bo2+4j1myeZvF2cE6tJERvk
         19zCTofWBwjS8BDip6sGMLeB2cqnyuIzQBtDiqJzSWcLBZMkXI9fKB8S36VeALBe/260
         Z3fhmHUP+UVWLhJiJ7WJo9lqazVRQzMKLUh84Hk7VIMvnrlf3TS/769a6KrTGznqbh3t
         OJMBlqiDkaiF/Ox9QgBpMOkv9JyBGFJm68xOPNynHuO1L771F+zFKpxiXyKY0TX8hqaE
         K+sA==
X-Gm-Message-State: AOAM530gGL+G+UaR2oo/3ytMhS8i+/v9auOPMgV1PtWJ9NUhfO/wl3nj
        HCE6oUKeZQCN9TyNkc98hvI=
X-Google-Smtp-Source: ABdhPJws8DIGOjmMMxeqftouYYA9cDIUA/mbeYSBuM0HUBaAUPwriZkSmsmVA1z7+hSDSd+v1GJFmg==
X-Received: by 2002:a17:90b:17c2:b0:1bf:2d51:4e6f with SMTP id me2-20020a17090b17c200b001bf2d514e6fmr1170596pjb.172.1646390626720;
        Fri, 04 Mar 2022 02:43:46 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:46 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 12/12] ls-tree: support --object-only option for "git-ls-tree"
Date:   Fri,  4 Mar 2022 18:42:38 +0800
Message-Id: <55b1c4379d51c8254ac71a7b897d81bddd863143.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'--object-only' is an alias for '--format=%(objectname)'. It cannot
be used together other format-altering options like '--name-only',
'--long' or '--format', they are mutually exclusive.

The "--name-only" option outputs <filepath> only. Likewise, <objectName>
is another high frequency used field, so implement '--object-only' option
will bring intuitive and clear semantics for this scenario. Using
'--format=%(objectname)' we can achieve a similar effect, but the former
is with a lower learning cost(without knowing the format requirement
of '--format' option).

Even so, if a user is prefer to use "--format=%(objectname)", this is entirely
welcome because they are not only equivalent in function, but also have almost
identical performance. The reason is this commit also add the specific of
"--format=%(objectname)" to the current fast-pathes (builtin formats) to
avoid running unnecessary parsing mechanisms.

The following performance benchmarks are based on torvalds/linux.git:

  When hit the fast-path:

      Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --object-only HEAD
        Time (mean ± σ):      83.6 ms ±   2.0 ms    [User: 59.4 ms, System: 24.1 ms]
        Range (min … max):    80.4 ms …  87.2 ms    35 runs

      Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(objectname)' HEAD
        Time (mean ± σ):      84.1 ms ±   1.8 ms    [User: 61.7 ms, System: 22.3 ms]
        Range (min … max):    80.9 ms …  87.5 ms    35 runs

  But for a customized format, it will be slower:

       Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='oid: %(objectname)' HEAD
         Time (mean ± σ):      96.5 ms ±   2.5 ms    [User: 72.9 ms, System: 23.5 ms]
  	 Range (min … max):    93.1 ms … 104.1 ms    31 runs

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt | 11 ++++++++++-
 builtin/ls-tree.c             | 18 +++++++++++++++++-
 t/t3103-ls-tree-misc.sh       |  7 +++++--
 t/t3104-ls-tree-format.sh     | 19 +++++++++++++++++++
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db29a9efb5..1aea998e72 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
+	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -59,6 +59,15 @@ OPTIONS
 --name-only::
 --name-status::
 	List only filenames (instead of the "long" output), one per line.
+	Cannot be combined with `--object-only`.
+
+--object-only::
+	List only names of the objects, one per line. Cannot be combined
+	with `--name-only` or `--name-status`.
+	This is equivalent to specifying `--format='%(objectname)'`, but
+	for both this option and that exact format the command takes a
+	hand-optimized codepath instead of going through the generic
+	formatting mechanism.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index a46fa73bb3..7da21d9963 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -20,6 +20,7 @@ static int line_termination = '\n';
 #define LS_SHOW_TREES (1 << 2)
 #define LS_NAME_ONLY (1 << 3)
 #define LS_SHOW_SIZE (1 << 4)
+#define LS_OBJECT_ONLY (1 << 5)
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
@@ -36,6 +37,7 @@ static const char *format;
 static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
 static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
 static const char *name_only_format = "%(path)";
+static const char *object_only_format = "%(objectname)";
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -53,6 +55,7 @@ static const  char * const ls_tree_usage[] = {
 static enum mutx_option {
 	MODE_UNSPECIFIED = 0,
 	MODE_NAME_ONLY,
+	MODE_OBJECT_ONLY,
 	MODE_LONG,
 } cmdmode;
 
@@ -128,7 +131,10 @@ static int parse_shown_fields(unsigned int *shown_fields)
 		*shown_fields = FIELD_PATH_NAME;
 		return 0;
 	}
-
+	if (cmdmode == MODE_OBJECT_ONLY) {
+		*shown_fields = FIELD_OBJECT_NAME;
+		return 0;
+	}
 	if (!ls_options || (ls_options & LS_RECURSIVE)
 	    || (ls_options & LS_SHOW_TREES)
 	    || (ls_options & LS_TREE_ONLY))
@@ -257,6 +263,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			return recurse;
 	}
 
+	if (shown_fields == FIELD_OBJECT_NAME) {
+		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+		return recurse;
+	}
+
 	if (shown_fields == FIELD_PATH_NAME) {
 		baselen = base->len;
 		strbuf_addstr(base, pathname);
@@ -295,6 +306,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    MODE_NAME_ONLY),
 		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
 			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
+			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -363,6 +376,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	} else if (format && (!strcmp(format, name_only_format))) {
 		shown_fields = FIELD_PATH_NAME;
 		fn = show_tree;
+	} else if (format && (!strcmp(format, object_only_format))) {
+		shown_fields = FIELD_OBJECT_NAME;
+		fn = show_tree;
 	} else if (format)
 		fn = show_tree_fmt;
 
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index d9d7fa932f..d979c0df5d 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -25,11 +25,14 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 
 for opts in \
 	"--name-only --long" \
-	"--name-status --long"
+	"--name-status --long" \
+	"--name-only --object-only" \
+	"--name-status --object-only" \
+	"--object-only --long" \
+	"--object-only --format"
 do
 	test_expect_success "usage: incompatible options: $opts" '
 		test_expect_code 129 git ls-tree $opts $tree
     '
 done
-
 test_done
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index e08c83dc47..b86941c202 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -46,6 +46,19 @@ test_expect_success 'ls-tree --format=<name-only-like>' '
 		"--name-only"
 '
 
+test_expect_success 'ls-tree --format=<object-only-like>' '
+	test_ls_tree_format \
+		"%(objectname)" \
+		"--object-only"
+'
+
+test_expect_success 'ls-tree --format=<object-only-like> --abbrev' '
+	test_ls_tree_format \
+		"%(objectname)" \
+		"--object-only --abbrev" \
+		"--abbrev"
+'
+
 test_expect_success 'ls-tree combine --format=<default-like> and -t' '
 	test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
@@ -78,4 +91,10 @@ test_expect_success 'ls-tree hit fast-path with --format=<name-only-like>' '
 	git ls-tree --format="%(path)" -r HEAD >actual &&
 	test_cmp expect actual
 '
+
+test_expect_success 'ls-tree hit fast-path with --format=<object-only-like>' '
+	git ls-tree -r --object-only HEAD >expect &&
+	git ls-tree --format="%(objectname)" -r HEAD >actual &&
+	test_cmp expect actual
+'
 test_done
-- 
2.34.1.402.gef0f5bd184


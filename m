Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C416C433FE
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377036AbiBHNO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350320AbiBHMPU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D0C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:15:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so1878277pjv.5
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36p6/x068UVwb2pNta2ncpwZbX9rD54FEVAELqChjt8=;
        b=BN5hriAn1o0MnUnZLDWoTBiwY3wPTFLdEPulwN+JkbNy8K9Bb74wS9X7PCl/gqyTSk
         YWiXXN+5kGfvdrjNetTtVjE+m0ePpE+NA/Zah3/wt2uKzsbF4DPQyNyTwhsP2iBAvYzG
         iMmY3eYScb0iJX26RYmNlq2YtVqXTFBOjSyvkiHimFB8ACzmECmOQhWegvXkAuZPuYfx
         FM4GEa7mR6bS2aDhloGKBJ2S2ZWUHRAqbky6zIdprU61jEDO2GRruBd3YSeaId3lfmFu
         UPIITKOtZiIqEsyPsXnXV0Qv+Aqz3MkAD8eX+j/jVqvjFduJOXVUlCgzd3XaWnS5ZAxy
         WnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36p6/x068UVwb2pNta2ncpwZbX9rD54FEVAELqChjt8=;
        b=s3qi/TOoZD4nMrA8zxYkk429Hkw48Vkhq74ZLHIiKL9U6gKGDDlEqetvmEtjT1hjwo
         II4usOsmMPR5oUCVD/kqxRMZLI1P6Q8nQvG4Oh67k0czDyfWtHlGbg4xKr+BOH7ZFwVf
         3DKStVVx2XRJTVnwS90hvF5TbJAfTGFWnJgVPH1oU0eNTv+dpT3bB38DgAB6bQWgQHpg
         OWt5IeOt2m67XlizuyUT2iEoXCutikqlg9cbkI9m5Hr4yms13OjHHg7iUUshlrK+26IW
         zzCiL5+ZeuYPbCzaK6myI7N5av//kTsImB34UVnUrDr1pv82jmBY+I0kca6Zho7fycaY
         oIYw==
X-Gm-Message-State: AOAM531ie6Iy/d62Kqkx2YrF+1ZvE3GXNwaq6mWr+PHrReZGfU5h0aI7
        nvIVXIpEiTdNk4qPcHbK2q4=
X-Google-Smtp-Source: ABdhPJwzP+Ou4KkjzSt/Ju3NJwsHKc1onAphWsOfWyIUICU2pOYsqZPmbzRaAz7ee2Lr6mWb4N2G6A==
X-Received: by 2002:a17:902:b414:: with SMTP id x20mr4289323plr.14.1644322519377;
        Tue, 08 Feb 2022 04:15:19 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:15:19 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 13/13] ls-tree.c: support --object-only option for "git-ls-tree"
Date:   Tue,  8 Feb 2022 20:14:38 +0800
Message-Id: <e6d98f2560281e46e4ef2121692a54f796919b59.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We usually pipe the output from `git ls-trees` to tools like
`sed` or `cut` when we only want to extract some fields.

When we want only the pathname component, we can pass
`--name-only` option to omit such a pipeline, but there are no
options for extracting other fields.

Teach the "--object-only" option to the command to only show the
object name. This option cannot be used together with
"--name-only" or "--long" , they are mutually exclusive (actually
"--name-only" and "--long" can be combined together before, this
commit by the way fix this bug).

In terms of performance, there is no loss comparing to the
"master" (2ae0a9c), here are the
results of the performance tests in my environment based on linux
repository:

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    Time (mean ± σ):     105.8 ms ±   2.7 ms    [User: 85.7 ms, System: 20.0 ms]
    Range (min … max):   101.5 ms … 111.3 ms    28 runs

    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD
    Time (mean ± σ):     105.0 ms ±   3.0 ms    [User: 83.7 ms, System: 21.2 ms]
    Range (min … max):    99.3 ms … 109.5 ms    27 runs

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    Time (mean ± σ):     337.4 ms ±  10.9 ms    [User: 308.3 ms, System: 29.0 ms]
    Range (min … max):   323.0 ms … 355.0 ms    10 runs

    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD
    Time (mean ± σ):     337.6 ms ±   6.2 ms    [User: 309.4 ms, System: 28.1 ms]
    Range (min … max):   330.4 ms … 349.9 ms    10 runs

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |  7 ++++-
 builtin/ls-tree.c             | 16 ++++++++++-
 t/t3104-ls-tree-format.sh     | 12 +++++++++
 t/t3105-ls-tree-oid.sh        | 51 +++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100755 t/t3105-ls-tree-oid.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db29a9efb5..21045dd163 100644
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
@@ -59,6 +59,11 @@ OPTIONS
 --name-only::
 --name-status::
 	List only filenames (instead of the "long" output), one per line.
+	Cannot be combined with `--object-only`.
+
+--object-only::
+	List only names of the objects, one per line. Cannot be combined
+	with `--name-only` or `--name-status`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ba96bcf602..9819a24186 100644
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
@@ -37,6 +38,7 @@ static const char *format;
 static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
 static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
 static const char *name_only_format = "%(path)";
+static const char *object_only_format = "%(objectname)";
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -53,6 +55,7 @@ static const  char * const ls_tree_usage[] = {
 enum {
 	MODE_UNSPECIFIED = 0,
 	MODE_NAME_ONLY,
+	MODE_OBJECT_ONLY,
 	MODE_LONG,
 };
 
@@ -67,6 +70,8 @@ static int fast_path(void){
 	} else if (!strcmp(format, name_only_format)) {
 		shown_fields = FIELD_PATH_NAME;
 		return 1;
+	} else if (!strcmp(format, object_only_format)) {
+		shown_fields = FIELD_OBJECT_NAME;
 	}
 	return 0;
 }
@@ -143,7 +148,10 @@ static int parse_shown_fields(void)
 		shown_fields = FIELD_PATH_NAME;
 		return 0;
 	}
-
+	if (cmdmode == MODE_OBJECT_ONLY) {
+		shown_fields = FIELD_OBJECT_NAME;
+		return 0;
+	}
 	if (!ls_options || (ls_options & LS_RECURSIVE)
 	    || (ls_options & LS_SHOW_TREES)
 	    || (ls_options & LS_TREE_ONLY))
@@ -267,6 +275,10 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
 		return 0;
 
+	if (shown_fields == FIELD_OBJECT_NAME) {
+		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+		return recurse;
+	}
 	if (shown_fields == FIELD_PATH_NAME) {
 		baselen = base->len;
 		strbuf_addstr(base, pathname);
@@ -304,6 +316,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    MODE_NAME_ONLY),
 		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
 			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
+			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index e08c83dc47..c0ffc8e1c3 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -46,6 +46,12 @@ test_expect_success 'ls-tree --format=<name-only-like>' '
 		"--name-only"
 '
 
+test_expect_success 'ls-tree --format=<object-only-like>' '
+	test_ls_tree_format \
+		"%(objectname)" \
+		"--object-only"
+'
+
 test_expect_success 'ls-tree combine --format=<default-like> and -t' '
 	test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
@@ -78,4 +84,10 @@ test_expect_success 'ls-tree hit fast-path with --format=<name-only-like>' '
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
diff --git a/t/t3105-ls-tree-oid.sh b/t/t3105-ls-tree-oid.sh
new file mode 100755
index 0000000000..992bb26bfa
--- /dev/null
+++ b/t/t3105-ls-tree-oid.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='git ls-tree objects handling.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+test_commit A &&
+test_commit B &&
+mkdir -p C &&
+test_commit C/D.txt &&
+find *.txt path* \( -type f -o -type l \) -print |
+xargs git update-index --add &&
+tree=$(git write-tree) &&
+echo $tree
+'
+
+test_expect_success 'usage: --object-only' '
+git ls-tree --object-only $tree >current &&
+git ls-tree $tree >result &&
+cut -f1 result | cut -d " " -f3 >expected &&
+test_cmp current expected
+'
+
+test_expect_success 'usage: --object-only with -r' '
+git ls-tree --object-only -r $tree >current &&
+git ls-tree -r $tree >result &&
+cut -f1 result | cut -d " " -f3 >expected &&
+test_cmp current expected
+'
+
+test_expect_success 'usage: --object-only with --abbrev' '
+git ls-tree --object-only --abbrev=6 $tree >current &&
+git ls-tree --abbrev=6 $tree >result &&
+cut -f1 result | cut -d " " -f3 >expected &&
+test_cmp current expected
+'
+
+test_expect_success 'usage: incompatible options: --name-only with --object-only' '
+test_expect_code 129 git ls-tree --object-only --name-only $tree
+'
+
+test_expect_success 'usage: incompatible options: --name-status with --object-only' '
+test_expect_code 129 git ls-tree --object-only --name-status $tree
+'
+
+test_expect_success 'usage: incompatible options: --long with --object-only' '
+test_expect_code 129 git ls-tree --object-only --long $tree
+'
+
+test_done
-- 
2.34.1.403.gb35f2687cf.dirty


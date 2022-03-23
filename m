Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEECC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiCWJPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbiCWJP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A975C1A
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b15so1032598pfm.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ev7CrIs9nVSw5cdnSNV5+12ng7Edw3fNhGpobXgbAdQ=;
        b=mucBN08nJlTro9FyWCClMwQMxVc9maNcrCshWhvm1RbNYV1/daRS4cukQ5X9K/cfRy
         MJ/wEPdbmYGbahrjGt0h/NyI9PiknwA8oe5cQHMwRf3VzV3ak+asIaESGyZ11C1YwHnq
         +xf6UcHYAEIqziSdLs3Z0EgC3OVlBpf8j9Rg+5HRQmoe+utDTapnyO9ehV/SadxZpe6H
         bVg92J5auLi08R3iaz2NC2Bp2QfQzo0XMqtLHoeLQaI+hNeo+S2PDd01MrNf5BmxGJrQ
         FoqktNnmnC6SSstJJA5RlAUyJ8zpBh+qbbqDzrVq1M70doCc94b62Bz8/pSbzN9X5Q0w
         I7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ev7CrIs9nVSw5cdnSNV5+12ng7Edw3fNhGpobXgbAdQ=;
        b=nGnczyhgDVtC3fKZ2nsrr6eA66lonsmuffUpE+vF6+/VzINsvQjy0mvF2CqertDdEo
         rpjdF9pJLYteMn0KAjXH6uPBclesBI4fkLUJXypXYL4lOpe48OiTrzHz7TAYhTcWnYKk
         7YPCu451Iu65kYUbpaW3yAhZJnYsQxbdnPKuwTW1tE5IugbOpegVCEI9vtgejQtL1SHC
         QY0lXyZAZ4LgX9u5VWCip6abM31URuBE6ZuFpjklJkxz4EjiFj922H4qX6w2Mlj+Hywb
         9jjTAhDBthGigbW8xSBl7c8SmGpxwpARKa5QcUipATqbFgWnH8IpMOj1XN7oKujWofFw
         9o/Q==
X-Gm-Message-State: AOAM533NfP4MnavLs2NqLGBZ+HQZK7tnzfyiAKixrMUdpzCowKSmSspC
        ljhkxDHNd1ibrRNJx9Sqf7g=
X-Google-Smtp-Source: ABdhPJzq0XqIQqmznbsGEbxEYS7RMqs3bAULiwtOCvPrbvItzbHyXJVQjWC1g1NYyaKv96YSkSkczQ==
X-Received: by 2002:a63:3688:0:b0:382:8bf0:aad7 with SMTP id d130-20020a633688000000b003828bf0aad7mr10314974pga.602.1648026836957;
        Wed, 23 Mar 2022 02:13:56 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:56 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 13/15] ls-tree: support --object-only option for "git-ls-tree"
Date:   Wed, 23 Mar 2022 17:13:13 +0800
Message-Id: <27fd1d9e2c2fad8159b4a38709929e0b66d5f93f.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt | 11 ++++++++++-
 builtin/ls-tree.c             | 13 ++++++++++++-
 t/t3103-ls-tree-misc.sh       |  7 +++++--
 t/t3104-ls-tree-format.sh     |  9 +++++++++
 4 files changed, 36 insertions(+), 4 deletions(-)

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
index 8a1bf2fa4d..3474f8c3d6 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,7 +24,6 @@ static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
 static const char *format;
-
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -42,6 +41,7 @@ static enum ls_tree_cmdmode {
 	MODE_DEFAULT = 0,
 	MODE_LONG,
 	MODE_NAME_ONLY,
+	MODE_OBJECT_ONLY,
 } cmdmode;
 
 static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
@@ -227,6 +227,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			return recurse;
 	}
 
+	if (cmdmode == MODE_OBJECT_ONLY) {
+		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+		return recurse;
+	}
+
 	if (cmdmode == MODE_NAME_ONLY) {
 		baselen = base->len;
 		strbuf_addstr(base, pathname);
@@ -264,6 +269,10 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
 		.mode = MODE_NAME_ONLY, /* And MODE_NAME_STATUS */
 		.fmt = "%(path)",
 	},
+	{
+		.mode = MODE_OBJECT_ONLY,
+		.fmt = "%(objectname)",
+	},
 	{ 0 },
 };
 
@@ -288,6 +297,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    MODE_NAME_ONLY),
 		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
 			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
+			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
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
index 7f1eb699d3..0769a933d6 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -49,6 +49,15 @@ test_ls_tree_format \
 	"%(path)" \
 	"--name-only"
 
+test_ls_tree_format \
+	"%(objectname)" \
+	"--object-only"
+
+test_ls_tree_format \
+	"%(objectname)" \
+	"--object-only --abbrev" \
+	"--abbrev"
+
 test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	"-t" \
-- 
2.34.1.404.g92931a4a2c.dirty


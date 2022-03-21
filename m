Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4C1C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344960AbiCUHfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbiCUHfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B715FD7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n15so11986982plh.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozDbs5sUwie0NM1zyriGBx2cZxocADZ+d/+QmMBj+NM=;
        b=FxsAgUuxLbmOdsRNbAn5qZjO72Hi7C78xZ7OvXywaauSFgQqvnVZy7fzoOryLEOFqn
         lbhOcs2f38IvbWURx+nvozUbsyqmLtVU9eh1Kl6/6syRajGnXz18au5G0rm8thKafKe6
         jOyTOqjrVguoWsx+qOdM/aNMPwMIjiTcRpWB2DnJlU8Y/jvj/2tY5reemJ3e/1DeqCiV
         1HtNjAYP15e13naKKtsR6CZaNJwMtHokgI8/Xws6bzovdYGPvCjafuEsUeq1GZO2lJzl
         /hN403xiGFnY1Gw/jL6GmT4OBs1nJzYdhkv6VCRnQ/uOq2j2xkP6CNVZlN/5Pap+ZXQD
         809g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozDbs5sUwie0NM1zyriGBx2cZxocADZ+d/+QmMBj+NM=;
        b=LbND5mJTjCTHYlzRVUfD7+0xLYoc4Z9+9TF1ZMBg/3ApJAVCHBVJUUsJShzHYOwCCR
         KZqr295BIaDokBzM/hK7gxGAk/yY4ud4z0eUylSVDWJHU1zXoSOW7bfkEUzVLWSUxiR9
         bw7Re4cEZTF+GDRFSCqbhYuJTAHSvJaww8+CYJOa34pVSFx3jRtVJ/8E3UMQwndTIzVB
         qhZazQhkcv5xktU44kLhhVzbZuKp2xJYdlsJ+N8gpJ83H6dJPh0NA2x+yOAySDy0A+FQ
         NDu9Vr2faYmZQveuXgWt+iy0H6Dx/SKHfM48cIq9b5dXJb8zrvXYkkcOw7oIE9QGwmjX
         iBAw==
X-Gm-Message-State: AOAM532bfGXi6eUheC6/C/uOZKoL6MimuRWl6zwcHXnfU2swLtsIBFnN
        VQjALS7P6PzPGmyA8+YLXXg=
X-Google-Smtp-Source: ABdhPJzCkNlPyU6UpyEPD8lg02Z6FfVl5JaCg2IbnOhDGpAv31BLqsTbMBFkpCmy9x9h2ONb2j/grw==
X-Received: by 2002:a17:902:e846:b0:154:3d19:c5ae with SMTP id t6-20020a170902e84600b001543d19c5aemr8097338plg.87.1647848053758;
        Mon, 21 Mar 2022 00:34:13 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.34.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:13 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 12/16] ls-tree: support --object-only option for "git-ls-tree"
Date:   Mon, 21 Mar 2022 15:33:26 +0800
Message-Id: <2bcd08ebd0a0126f50be677884a02603b9a96a2d.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
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
 builtin/ls-tree.c             | 17 ++++++++++++++++-
 t/t3103-ls-tree-misc.sh       |  7 +++++--
 t/t3104-ls-tree-format.sh     |  9 +++++++++
 4 files changed, 40 insertions(+), 4 deletions(-)

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
index 182705e894..1aa65cc87f 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -34,6 +34,7 @@ static const char *format;
 static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
 static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
 static const char *name_only_format = "%(path)";
+static const char *object_only_format = "%(objectname)";
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -51,6 +52,7 @@ static const  char * const ls_tree_usage[] = {
 static enum ls_tree_cmdmode {
 	MODE_LONG = 1,
 	MODE_NAME_ONLY,
+	MODE_OBJECT_ONLY,
 } cmdmode;
 
 static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
@@ -125,7 +127,10 @@ static int parse_shown_fields(unsigned int *shown_fields)
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
@@ -254,6 +259,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
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
@@ -292,6 +302,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    MODE_NAME_ONLY),
 		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
 			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
+			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -360,6 +372,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
2.34.1.406.g2e0e55130e


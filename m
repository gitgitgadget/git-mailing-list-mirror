Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D01C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbiCUHfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbiCUHfD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E891E54BEE
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so9857803pjm.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Thd6oQWldGZ1o1gKTmTRRrooh9mm0sX4ZqFIIee8vQ=;
        b=OIKMAAwZxWxkMt8Vl1dBY9YWsFgDIYxdzNA5M5sAt7m1Yf58dHtQPjNsYDef8ma6Pq
         co2CF6qJD+NbhLb2tUzvHlclZ2AxbwSuu1ytRQ9u/b1egCilgLwuhGFb3c6P1ZIhI5D/
         B0mss4VHW6xLiWQjwCGK6POtwAQ3YcRyv5G8nYNOKeuYcgBY9yVgiEm61bgoiPumdZwY
         t4Cjhh0VG/Q5nxlVv5/QuPA0tiFLqw3M8WoaRAwMEXHbeu5CtgfCP7KaJkOQD0rOXxhQ
         igllBNCM6GveBxhcTCOV4X5K5sAbn/W/d9vd1MxHgg372Jd2v9sRTfr/yKu807pBLe0Q
         PXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Thd6oQWldGZ1o1gKTmTRRrooh9mm0sX4ZqFIIee8vQ=;
        b=yppvP/JxRmMn1/jCJZ/ap87vM8UGfqsDxedx2A0h3POcZkL/mg0aDJuYFMMNL/Kcfe
         CzUY0K0Ry6gyMKurWE+Mbh59boIPYe5JHtvlEqnHsGjJbsMUPEIawy8qWzAoxwYhk80o
         aJp6wW16jRjVGGxu8QK+keojbx2JLCHKyHblHYQ+Vazfjlx+Pvn799N08rUEQAcZAvYo
         vb2JLDssTo+Hvnvlwfn/ojPBw1kBXdiZw8o/llV2UIxPHPz6cnk5W1j6O8TYzo1/LQkU
         GluFeShYo1cyHd1xtxWoVIPpB5IYnHSLRkhhCTxgresXgOsJDr2QPZr4CCKr+fdXjMSE
         v33A==
X-Gm-Message-State: AOAM533VU1EuSMYaCbl5aiZKd7jFujrsixUEQ5xu3EqEC5Osy7ju8Ugq
        8s03qDMIgmhmyxi9bg9oIXjbKto0mjDr8Q==
X-Google-Smtp-Source: ABdhPJybHYHuriKlrgfEBPLU+Quj0U9GkXNyKLIPAl960rAHGbqA1/HuRBquOui9u4lvSjYNjg3MMA==
X-Received: by 2002:a17:90b:3503:b0:1bf:27c6:3b33 with SMTP id ls3-20020a17090b350300b001bf27c63b33mr35397538pjb.225.1647848017280;
        Mon, 21 Mar 2022 00:33:37 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:36 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 00/16] ls-tree: "--object-only" and "--format" opts
Date:   Mon, 21 Mar 2022 15:33:14 +0800
Message-Id: <cover.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff from v12:

Current patch is based by the review patch of Ævar Arnfjörð Bjarmason in [1].

In terms of the review commits, I replied Ævar Arnfjörð Bjarmason [2] and listed the
actions, therefore this v13 patch was implemented by these actions.  

Links:

1. https://public-inbox.org/git/cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com/
2. https://public-inbox.org/git/20220317095129.86790-1-dyroneteng@gmail.com/

Thanks.

Johannes Schindelin (1):
  cocci: allow padding with `strbuf_addf()`

Teng Long (5):
  ls-tree: rename "retval" to "recurse" in "show_tree()"
  ls-tree: simplify nesting if/else logic in "show_tree()"
  ls-tree: fix "--name-only" and "--long" combined use bug
  ls-tree: slightly refactor `show_tree()`
  ls-tree: support --object-only option for "git-ls-tree"

Ævar Arnfjörð Bjarmason (10):
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
  ls-tree: introduce struct "show_tree_data"
  ls-tree: introduce "--format" option
  ls-tree tests: add tests for --name-status
  ls-tree: detect and error on --name-only --name-status
  ls-tree: remove FIELD_*, just use MODE_*
  ls-tree: split up "fast path" callbacks

 Documentation/git-ls-tree.txt   |  68 +++++-
 builtin/ls-tree.c               | 367 ++++++++++++++++++++++++++------
 contrib/coccinelle/strbuf.cocci |   6 +-
 t/t3101-ls-tree-dirname.sh      |  55 ++---
 t/t3103-ls-tree-misc.sh         |  15 ++
 t/t3104-ls-tree-format.sh       |  76 +++++++
 6 files changed, 493 insertions(+), 94 deletions(-)
 create mode 100755 t/t3104-ls-tree-format.sh

Range-diff against v12:
 -:  ---------- >  1:  2fcff7e0d4 ls-tree: remove commented-out code
 -:  ---------- >  2:  6fd1dd9383 ls-tree: add missing braces to "else" arms
 -:  ---------- >  3:  208654b5e2 ls-tree: use "enum object_type", not {blob,tree,commit}_type
 -:  ---------- >  4:  2637464fd8 ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
 -:  ---------- >  5:  99e6d47108 ls-tree: rename "retval" to "recurse" in "show_tree()"
 -:  ---------- >  6:  a8d9b78dea ls-tree: simplify nesting if/else logic in "show_tree()"
 -:  ---------- >  7:  25a07e048f ls-tree: fix "--name-only" and "--long" combined use bug
 1:  f449146b4d !  8:  55f1e10d7e ls-tree: slightly refactor `show_tree()`
    @@ builtin/ls-tree.c
     -#define LS_SHOW_SIZE 16
     +#define LS_TREE_ONLY (1 << 1)
     +#define LS_SHOW_TREES (1 << 2)
    -+#define LS_NAME_ONLY (1 << 3)
    -+#define LS_SHOW_SIZE (1 << 4)
      static int abbrev;
      static int ls_options;
      static struct pathspec pathspec;
    @@ builtin/ls-tree.c
      	NULL
      };
      
    -+static enum mutx_option {
    -+	MODE_UNSPECIFIED = 0,
    ++static enum ls_tree_cmdmode {
    ++	MODE_LONG = 1,
     +	MODE_NAME_ONLY,
    -+	MODE_LONG,
     +} cmdmode;
     +
     +static int parse_shown_fields(void)
 2:  80311adc7c !  9:  85d0b0da1d ls-tree: introduce struct "show_tree_data"
    @@ builtin/ls-tree.c: static unsigned int shown_fields;
      static const  char * const ls_tree_usage[] = {
      	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
      	NULL
    -@@ builtin/ls-tree.c: static enum mutx_option {
    - 	MODE_LONG,
    +@@ builtin/ls-tree.c: static enum ls_tree_cmdmode {
    + 	MODE_NAME_ONLY,
      } cmdmode;
      
     -static int parse_shown_fields(void)
 3:  459080f549 = 10:  eddcf903ad cocci: allow padding with `strbuf_addf()`
 4:  cb717d08be ! 11:  7451242daa ls-tree: introduce "--format" option
    @@ Commit message
         idea and suggestion, this commit makes modifications in terms of the
         original discussion on community [1].
     
    +    In [1] there was a "GIT_TEST_LS_TREE_FORMAT_BACKEND" variable to
    +    ensure that we had test coverage for passing tests that would
    +    otherwise use show_tree() through show_tree_fmt(), and thus that the
    +    formatting mechanism could handle all the same cases as the
    +    non-formatting options.
    +
    +    Somewhere in subsequent re-rolls of that we seem to have drifted away
    +    from what the goal of these tests should be. We're trying to ensure
    +    correctness of show_tree_fmt(). We can't tell if we "hit [the]
    +    fast-path" here, and instead of having an explicit test for that, we
    +    can just add it to something our "test_ls_tree_format" tests for.
    +
         Here is the statistics about performance tests:
     
         1. Default format (hitten the builtin formats):
    @@ Commit message
     
         Links:
                 [1] https://public-inbox.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/
    +            [2] https://lore.kernel.org/git/cb717d08be87e3239117c6c667cb32caabaad33d.1646390152.git.dyroneteng@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
    @@ builtin/ls-tree.c: static const char *ls_tree_prefix;
      struct show_tree_data {
      	unsigned mode;
      	enum object_type type;
    -@@ builtin/ls-tree.c: static enum mutx_option {
    - 	MODE_LONG,
    +@@ builtin/ls-tree.c: static enum ls_tree_cmdmode {
    + 	MODE_NAME_ONLY,
      } cmdmode;
      
     +static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
    @@ t/t3104-ls-tree-format.sh (new)
     +	opts=$2 &&
     +	fmtopts=$3 &&
     +	shift 2 &&
    -+	git ls-tree $opts -r HEAD >expect.raw &&
    -+	sed "s/^/> /" >expect <expect.raw &&
    -+	git ls-tree --format="> $format" -r $fmtopts HEAD >actual &&
    -+	test_cmp expect actual
    ++
    ++	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
    ++		git ls-tree $opts -r HEAD >expect &&
    ++		git ls-tree --format="$format" -r $fmtopts HEAD >actual &&
    ++		test_cmp expect actual
    ++	'
    ++
    ++	test_expect_success "ls-tree '--format=<$format>' on optimized v.s. non-optimized path" '
    ++		git ls-tree --format="$format" -r $fmtopts HEAD >expect &&
    ++		git ls-tree --format="> $format" -r $fmtopts HEAD >actual.raw &&
    ++		sed "s/^> //" >actual <actual.raw &&
    ++		test_cmp expect actual
    ++	'
     +}
     +
    -+test_expect_success 'ls-tree --format=<default-like>' '
    -+	test_ls_tree_format \
    -+		"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    -+		""
    -+'
    ++test_ls_tree_format \
    ++	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    ++	""
     +
    -+test_expect_success 'ls-tree --format=<long-like>' '
    -+	test_ls_tree_format \
    -+		"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
    -+		"--long"
    -+'
    ++test_ls_tree_format \
    ++	"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
    ++	"--long"
     +
    -+test_expect_success 'ls-tree --format=<name-only-like>' '
    -+	test_ls_tree_format \
    -+		"%(path)" \
    -+		"--name-only"
    -+'
    ++test_ls_tree_format \
    ++	"%(path)" \
    ++	"--name-only"
     +
    -+test_expect_success 'ls-tree combine --format=<default-like> and -t' '
    -+	test_ls_tree_format \
    ++test_ls_tree_format \
     +	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
     +	"-t" \
     +	"-t"
    -+'
     +
    -+test_expect_success 'ls-tree combine --format=<default-like> and --full-name' '
    -+	test_ls_tree_format \
    ++test_ls_tree_format \
     +	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
     +	"--full-name" \
     +	"--full-name"
    -+'
     +
    -+test_expect_success 'ls-tree combine --format=<default-like> and --full-tree' '
    -+	test_ls_tree_format \
    ++test_ls_tree_format \
     +	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
     +	"--full-tree" \
     +	"--full-tree"
    -+'
     +
    -+test_expect_success 'ls-tree hit fast-path with --format=<default-like>' '
    -+	git ls-tree -r HEAD >expect &&
    -+	git ls-tree --format="%(objectmode) %(objecttype) %(objectname)%x09%(path)" -r HEAD >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'ls-tree hit fast-path with --format=<name-only-like>' '
    -+	git ls-tree -r --name-only HEAD >expect &&
    -+	git ls-tree --format="%(path)" -r HEAD >actual &&
    -+	test_cmp expect actual
    -+'
     +test_done
 5:  55b1c4379d ! 12:  2bcd08ebd0 ls-tree: support --object-only option for "git-ls-tree"
    @@ Documentation/git-ls-tree.txt: OPTIONS
      	Instead of showing the full 40-byte hexadecimal object
     
      ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static int line_termination = '\n';
    - #define LS_SHOW_TREES (1 << 2)
    - #define LS_NAME_ONLY (1 << 3)
    - #define LS_SHOW_SIZE (1 << 4)
    -+#define LS_OBJECT_ONLY (1 << 5)
    - static int abbrev;
    - static int ls_options;
    - static struct pathspec pathspec;
     @@ builtin/ls-tree.c: static const char *format;
      static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
      static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
    @@ builtin/ls-tree.c: static const char *format;
      	unsigned mode;
      	enum object_type type;
     @@ builtin/ls-tree.c: static const  char * const ls_tree_usage[] = {
    - static enum mutx_option {
    - 	MODE_UNSPECIFIED = 0,
    + static enum ls_tree_cmdmode {
    + 	MODE_LONG = 1,
      	MODE_NAME_ONLY,
     +	MODE_OBJECT_ONLY,
    - 	MODE_LONG,
      } cmdmode;
      
    + static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
     @@ builtin/ls-tree.c: static int parse_shown_fields(unsigned int *shown_fields)
      		*shown_fields = FIELD_PATH_NAME;
      		return 0;
    @@ t/t3103-ls-tree-misc.sh: test_expect_success 'ls-tree fails with non-zero exit c
      test_done
     
      ## t/t3104-ls-tree-format.sh ##
    -@@ t/t3104-ls-tree-format.sh: test_expect_success 'ls-tree --format=<name-only-like>' '
    - 		"--name-only"
    - '
    +@@ t/t3104-ls-tree-format.sh: test_ls_tree_format \
    + 	"%(path)" \
    + 	"--name-only"
      
    -+test_expect_success 'ls-tree --format=<object-only-like>' '
    -+	test_ls_tree_format \
    -+		"%(objectname)" \
    -+		"--object-only"
    -+'
    ++test_ls_tree_format \
    ++	"%(objectname)" \
    ++	"--object-only"
     +
    -+test_expect_success 'ls-tree --format=<object-only-like> --abbrev' '
    -+	test_ls_tree_format \
    -+		"%(objectname)" \
    -+		"--object-only --abbrev" \
    -+		"--abbrev"
    -+'
    ++test_ls_tree_format \
    ++	"%(objectname)" \
    ++	"--object-only --abbrev" \
    ++	"--abbrev"
     +
    - test_expect_success 'ls-tree combine --format=<default-like> and -t' '
    - 	test_ls_tree_format \
    + test_ls_tree_format \
      	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    -@@ t/t3104-ls-tree-format.sh: test_expect_success 'ls-tree hit fast-path with --format=<name-only-like>' '
    - 	git ls-tree --format="%(path)" -r HEAD >actual &&
    - 	test_cmp expect actual
    - '
    -+
    -+test_expect_success 'ls-tree hit fast-path with --format=<object-only-like>' '
    -+	git ls-tree -r --object-only HEAD >expect &&
    -+	git ls-tree --format="%(objectname)" -r HEAD >actual &&
    -+	test_cmp expect actual
    -+'
    - test_done
    + 	"-t" \
 -:  ---------- > 13:  a5c73de057 ls-tree tests: add tests for --name-status
 -:  ---------- > 14:  89402a8518 ls-tree: detect and error on --name-only --name-status
 -:  ---------- > 15:  b8afca193a ls-tree: remove FIELD_*, just use MODE_*
 -:  ---------- > 16:  010e3c0ece ls-tree: split up "fast path" callbacks
-- 
2.34.1.406.g2e0e55130e


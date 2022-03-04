Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6EC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiCDKnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiCDKno (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:43:44 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C81AAFD7
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:42:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id bc27so7191890pgb.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNl2arskMciB78pVcEsNCn9GtgyggCAgVdHUYafIS9c=;
        b=coD2DrvZnJee/9naI7ukd1x+v/Vx/mhrrI+tD1uusD0F3NORP11z8k35eQvgXUyv/5
         Zkec6LBXxIHan53tMVtI0PKI+PUCSjDABjdjVV0Zx8H81aORXrcLzrabXz2+VBaJm9yu
         wzXisjf+5xoUCIjXLqWwCq69XXS08Mv1boaZKN4M5ed1Vo2SLQ94BdgsvPsirKx2LMON
         imXR3FnyUnjsjbf8owWu8+y0MW2WvsoPWbMBY5XIA+QRXWQ2gsD4YmTTH0+2PU7ZDfBK
         7Aqi6ul6Gl91zdq7pg6CoZ7QZbU3dB5TvR+8m4cS6row+JAwWvTbvcfU5xysHuaRbBA6
         zJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNl2arskMciB78pVcEsNCn9GtgyggCAgVdHUYafIS9c=;
        b=nw4xzX6fkCMUVII2xB+9n15zBPLW8ZsnCROrzUg9D2MpjsZOjf9CjnRosPEPYVSUk7
         xY7WWOyyvThi9tuh23yYR/M32/Zz7Rm/Dbh9rY6BnSCNaRczLPlLTV5cpPmP2rM5pnIm
         VALqdxQ1bL/mGelEr77X4KXWbzjTQEXs3TCquMv3Y8fi0OqNY3t/BOkullgDtx9zgeJY
         trCOVdq5fZaIi5CSCBStrXhch+fP+KSdjWryHKywPG+N8PgWmvnaM6PFcsK9/HTkRsif
         up2M7mVjd3Dj/mbQn2mQgZSVcXzS7GlUpgWmCKMdfGTdDy686lV9NpyOpZ+ERT6jDNeZ
         5q8A==
X-Gm-Message-State: AOAM533QhEKWxF36gQ05BJduDGEYuOcLgX7ZIMgmsVfetqCFmjyyDW/+
        Wxy9DguK+HEAyuKlP7f6Sz8=
X-Google-Smtp-Source: ABdhPJz1+8tBKlFGjgmGoSFFT5tkUUYY0r8MxuRkO5/ug1mn2K15ZgK8oWH9kiIb8wdlRiLh8zk9gA==
X-Received: by 2002:a05:6a00:148b:b0:4e0:1001:1063 with SMTP id v11-20020a056a00148b00b004e010011063mr42294454pfu.15.1646390574866;
        Fri, 04 Mar 2022 02:42:54 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.42.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:42:54 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 00/12] ls-tree: "--object-only" and "--format" opts
Date:   Fri,  4 Mar 2022 18:42:26 +0800
Message-Id: <cover.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late reply.

Main diff from V11:

1. [v12][06/12] simplify nesting if/else logic in "show_tree()"

  * Unrolling this from a logical if/if/if/ to if/else

  It's from Ævar Arnfjörð Bjarmason's suggestion at:

  https://public-inbox.org/git/220219.86ee3ze5kz.gmgdl@evledraar.gmail.com/#t

  By the way, Ævar also think to doing a minimal change first for use
  "object_type", the reason I didn't is because after the unroll, the related
  codes here is almost the same. So, I think this situation here is ok now.


2. [v12][07/12] ls-tree: fix "--name-only" and "--long" combined use bug

  * Add 2 tests for the bugfix

  It's from Ævar Arnfjörð Bjarmason's suggestion at:

  https://public-inbox.org/git/220219.86iltbe6i2.gmgdl@evledraar.gmail.com/

3. [v12][08/12] ls-tree: slightly refactor `show_tree()

   * Name the cmdmode enum

   It's from Ævar Arnfjörð Bjarmason's suggestion at:

   https://public-inbox.org/git/220219.86mtine6jb.gmgdl@evledraar.gmail.com/

4. [v12][09/12] ls-tree: introduce struct "show_tree_data"

   * Move global "show_fields into struct "show_data", avoid to use both global
     value and local value to save the related data for showing.

   It's from Ævar Arnfjörð Bjarmason's suggestion at:

   https://public-inbox.org/git/220219.86mtine6jb.gmgdl@evledraar.gmail.com/       

5. [v12][11/12] ls-tree.c: introduce "--format" option

   * Replace "die(_("bad ls-tree format: as '%s'"), start);" with
     "die(_("bad ls-tree format: element '%s' does not start with '('"), start)"

   It's from Ævar Arnfjörð Bjarmason's suggestion at:

   https://public-inbox.org/git/220219.86r17ze72s.gmgdl@evledraar.gmail.com/

6. ls-tree: introduce function "fast_path()"

   * This commit is removed now.

7. [v12][12/12] ls-tree.c: support --object-only option for "git-ls-tree"

   * Optimize the commit message

   * Add some extra contents under "--object-only:" in "git-ls-tree.txt"

   * Tidy the tests. I remove t3105-ls-tree-oid.sh, move the format-checking
     tests to t3104-ls-tree-format.sh and move the option-compatiblilty-checking
     test to t3103-ls-tree-misc.sh.

Thanks.

Johannes Schindelin (1):
  cocci: allow padding with `strbuf_addf()`

Teng Long (5):
  ls-tree: rename "retval" to "recurse" in "show_tree()"
  ls-tree: simplify nesting if/else logic in "show_tree()"
  ls-tree: fix "--name-only" and "--long" combined use bug
  ls-tree: slightly refactor `show_tree()`
  ls-tree: support --object-only option for "git-ls-tree"

Ævar Arnfjörð Bjarmason (6):
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
  ls-tree: introduce struct "show_tree_data"
  ls-tree: introduce "--format" option

 Documentation/git-ls-tree.txt   |  68 ++++++-
 builtin/ls-tree.c               | 324 +++++++++++++++++++++++++-------
 contrib/coccinelle/strbuf.cocci |   6 +-
 t/t3103-ls-tree-misc.sh         |  12 ++
 t/t3104-ls-tree-format.sh       | 100 ++++++++++
 5 files changed, 439 insertions(+), 71 deletions(-)
 create mode 100755 t/t3104-ls-tree-format.sh

Range-diff against v11:
 -:  ---------- >  1:  2fcff7e0d4 ls-tree: remove commented-out code
 -:  ---------- >  2:  6fd1dd9383 ls-tree: add missing braces to "else" arms
 -:  ---------- >  3:  208654b5e2 ls-tree: use "enum object_type", not {blob,tree,commit}_type
 -:  ---------- >  4:  2637464fd8 ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
 -:  ---------- >  5:  99e6d47108 ls-tree: rename "retval" to "recurse" in "show_tree()"
 1:  3816a65fe6 !  6:  a8d9b78dea ls-tree: simplify nesting if/else logic in "show_tree()"
    @@ Metadata
      ## Commit message ##
         ls-tree: simplify nesting if/else logic in "show_tree()"
     
    -    This commit use "object_type()" to get the type, then remove
    -    some of the nested if to let the codes here become more cleaner.
    +    Use the object_type() function to determine the object type from the
    +    "mode" passed to us by read_tree(), instead of doing so with the S_*()
    +    macros.
     
         Signed-off-by: Teng Long <dyronetengb@gmail.com>
     
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -				return recurse;
     -		}
     -		type = OBJ_TREE;
    --	}
    --	else if (ls_options & LS_TREE_ONLY)
    -+	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
    ++	if (type == OBJ_BLOB) {
    ++		if (ls_options & LS_TREE_ONLY)
    ++			return 0;
    ++	} else if (type == OBJ_TREE &&
    ++		   show_recursive(base->buf, base->len, pathname)) {
     +		recurse = READ_TREE_RECURSIVE;
    -+	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
    -+		return recurse;
    -+	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    - 		return 0;
    ++		if (!(ls_options & LS_SHOW_TREES))
    ++			return recurse;
    + 	}
    +-	else if (ls_options & LS_TREE_ONLY)
    +-		return 0;
      
      	if (!(ls_options & LS_NAME_ONLY)) {
    + 		if (ls_options & LS_SHOW_SIZE) {
 2:  b22c2dc49e !  7:  25a07e048f ls-tree: fix "--name-only" and "--long" combined use bug
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		OPT_SET_INT(0, "full-name", &chomp_prefix,
      			    N_("use full path names"), 0),
      		OPT_BOOL(0, "full-tree", &full_tree,
    +
    + ## t/t3103-ls-tree-misc.sh ##
    +@@ t/t3103-ls-tree-misc.sh: test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
    + 	test_must_fail git ls-tree -r HEAD
    + '
    + 
    ++for opts in \
    ++	"--name-only --long" \
    ++	"--name-status --long"
    ++do
    ++	test_expect_success "usage: incompatible options: $opts" '
    ++		test_expect_code 129 git ls-tree $opts $tree
    ++    '
    ++done
    ++
    + test_done
 3:  41e8ed5047 !  8:  f449146b4d ls-tree: slightly refactor `show_tree()`
    @@ builtin/ls-tree.c
      	NULL
      };
      
    -+enum {
    ++static enum mutx_option {
     +	MODE_UNSPECIFIED = 0,
     +	MODE_NAME_ONLY,
     +	MODE_LONG,
    -+};
    -+
    -+static int cmdmode = MODE_UNSPECIFIED;
    ++} cmdmode;
     +
     +static int parse_shown_fields(void)
     +{
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
      		const char *pathname, unsigned mode, void *context)
      {
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    - 		return 0;
    + 			return recurse;
    + 	}
      
     -	if (!(ls_options & LS_NAME_ONLY)) {
     -		if (ls_options & LS_SHOW_SIZE) {
 4:  46e10a5392 !  9:  80311adc7c ls-tree: introduce struct "show_tree_data"
    @@ Commit message
         "show_tree()". This commit is a pre-prepared commit for supporting
         "--format" option and it does not affect any existing functionality.
     
    +    At the same time, we also move global "shown_fields" into "show_tree_data"
    +    , the purpose of this is to avoid use both global variable and pass-around
    +    struct.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## builtin/ls-tree.c ##
    +@@ builtin/ls-tree.c: static int ls_options;
    + static struct pathspec pathspec;
    + static int chomp_prefix;
    + static const char *ls_tree_prefix;
    +-static unsigned int shown_fields;
    + #define FIELD_PATH_NAME 1
    + #define FIELD_SIZE (1 << 1)
    + #define FIELD_OBJECT_NAME (1 << 2)
     @@ builtin/ls-tree.c: static unsigned int shown_fields;
      #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
      #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
    @@ builtin/ls-tree.c: static unsigned int shown_fields;
     +	const struct object_id *oid;
     +	const char *pathname;
     +	struct strbuf *base;
    ++	unsigned int shown_fields;
     +};
     +
      static const  char * const ls_tree_usage[] = {
      	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
      	NULL
    +@@ builtin/ls-tree.c: static enum mutx_option {
    + 	MODE_LONG,
    + } cmdmode;
    + 
    +-static int parse_shown_fields(void)
    ++static int parse_shown_fields(unsigned int *shown_fields)
    + {
    + 	if (cmdmode == MODE_NAME_ONLY) {
    +-		shown_fields = FIELD_PATH_NAME;
    ++		*shown_fields = FIELD_PATH_NAME;
    + 		return 0;
    + 	}
    + 
    + 	if (!ls_options || (ls_options & LS_RECURSIVE)
    + 	    || (ls_options & LS_SHOW_TREES)
    + 	    || (ls_options & LS_TREE_ONLY))
    +-		shown_fields = FIELD_DEFAULT;
    ++		*shown_fields = FIELD_DEFAULT;
    + 	if (cmdmode == MODE_LONG)
    +-		shown_fields = FIELD_LONG_DEFAULT;
    ++		*shown_fields = FIELD_LONG_DEFAULT;
    + 	return 1;
    + }
    + 
     @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
      	return 0;
      }
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
     -	size_t baselen = base->len;
     +	size_t baselen = data->base->len;
      
    - 	if (shown_fields & FIELD_SIZE) {
    +-	if (shown_fields & FIELD_SIZE) {
    ++	if (data->shown_fields & FIELD_SIZE) {
      		char size_text[24];
     -		if (type == OBJ_BLOB) {
     +		if (data->type == OBJ_BLOB) {
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
      	int recurse = 0;
      	size_t baselen;
      	enum object_type type = object_type(mode);
    ++	unsigned int shown_fields = *(unsigned int *)context;
     +	struct show_tree_data data = {
     +		.mode = mode,
     +		.type = type,
     +		.oid = oid,
     +		.pathname = pathname,
     +		.base = base,
    ++		.shown_fields = shown_fields,
     +	};
      
    - 	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
    - 		recurse = READ_TREE_RECURSIVE;
    + 	if (type == OBJ_BLOB) {
    + 		if (ls_options & LS_TREE_ONLY)
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    + 		return recurse;
      	}
      
    - 	if (shown_fields >= FIELD_DEFAULT)
    +-	if (shown_fields >= FIELD_DEFAULT)
     -		show_default(oid, type, pathname, mode, base);
    ++	if (shown_fields>= FIELD_DEFAULT)
     +		show_default(&data);
      
      	return recurse;
      }
    +@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    + 	struct object_id oid;
    + 	struct tree *tree;
    + 	int i, full_tree = 0;
    ++	unsigned int shown_fields = 0;
    + 	const struct option ls_tree_options[] = {
    + 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
    + 			LS_TREE_ONLY),
    +@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    + 	if (get_oid(argv[0], &oid))
    + 		die("Not a valid object name %s", argv[0]);
    + 
    +-	parse_shown_fields();
    +-
    + 	/*
    + 	 * show_recursive() rolls its own matching code and is
    + 	 * generally ignorant of 'struct pathspec'. The magic mask
    +@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    + 	tree = parse_tree_indirect(&oid);
    + 	if (!tree)
    + 		die("not a tree object");
    +-	return !!read_tree(the_repository, tree,
    +-			   &pathspec, show_tree, NULL);
    ++
    ++	parse_shown_fields(&shown_fields);
    ++
    ++	return !!read_tree(the_repository, tree, &pathspec, show_tree,
    ++			   &shown_fields);
    + }
 5:  c04320b801 = 10:  459080f549 cocci: allow padding with `strbuf_addf()`
 6:  5936004f13 ! 11:  cb717d08be ls-tree.c: introduce "--format" option
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    ls-tree.c: introduce "--format" option
    +    ls-tree: introduce "--format" option
     
         Add a --format option to ls-tree. It has an existing default output,
         and then --long and --name-only options to emit the default output
    @@ Documentation/git-ls-tree.txt: quoted as explained for the configuration variabl
      Part of the linkgit:git[1] suite
     
      ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static unsigned int shown_fields;
    +@@ builtin/ls-tree.c: static const char *ls_tree_prefix;
      #define FIELD_MODE (1 << 4)
      #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
      #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
    @@ builtin/ls-tree.c: static unsigned int shown_fields;
      struct show_tree_data {
      	unsigned mode;
      	enum object_type type;
    -@@ builtin/ls-tree.c: enum {
    - 
    - static int cmdmode = MODE_UNSPECIFIED;
    +@@ builtin/ls-tree.c: static enum mutx_option {
    + 	MODE_LONG,
    + } cmdmode;
      
     +static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
     +			      const enum object_type type, unsigned int padded)
    @@ builtin/ls-tree.c: enum {
     +	if (len)
     +		return len;
     +	if (*start != '(')
    -+		die(_("bad ls-tree format: as '%s'"), start);
    ++		die(_("bad ls-tree format: element '%s' does not start with '('"), start);
     +
     +	end = strchr(start + 1, ')');
     +	if (!end)
    @@ builtin/ls-tree.c: enum {
     +	return len;
     +}
     +
    - static int parse_shown_fields(void)
    + static int parse_shown_fields(unsigned int *shown_fields)
      {
      	if (cmdmode == MODE_NAME_ONLY) {
     @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
      {
      	size_t baselen = data->base->len;
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	struct object_id oid;
      	struct tree *tree;
      	int i, full_tree = 0;
    + 	unsigned int shown_fields = 0;
     +	read_tree_fn_t fn = show_tree;
      	const struct option ls_tree_options[] = {
      		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		usage_with_options(ls_tree_usage, ls_tree_options);
      	if (get_oid(argv[0], &oid))
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	tree = parse_tree_indirect(&oid);
    - 	if (!tree)
    - 		die("not a tree object");
    --	return !!read_tree(the_repository, tree,
    --			   &pathspec, show_tree, NULL);
    + 
    + 	parse_shown_fields(&shown_fields);
    + 
    +-	return !!read_tree(the_repository, tree, &pathspec, show_tree,
    +-			   &shown_fields);
     +	/*
     +	 * The generic show_tree_fmt() is slower than show_tree(), so
     +	 * take the fast path if possible.
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
     +	} else if (format)
     +		fn = show_tree_fmt;
     +
    -+	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
    ++	return !!read_tree(the_repository, tree, &pathspec, fn, &shown_fields);
      }
     
      ## t/t3104-ls-tree-format.sh (new) ##
 7:  6d26497749 <  -:  ---------- ls-tree: introduce function "fast_path()"
 8:  e6d98f2560 ! 12:  55b1c4379d ls-tree.c: support --object-only option for "git-ls-tree"
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    ls-tree.c: support --object-only option for "git-ls-tree"
    +    ls-tree: support --object-only option for "git-ls-tree"
     
    -    We usually pipe the output from `git ls-trees` to tools like
    -    `sed` or `cut` when we only want to extract some fields.
    +    '--object-only' is an alias for '--format=%(objectname)'. It cannot
    +    be used together other format-altering options like '--name-only',
    +    '--long' or '--format', they are mutually exclusive.
     
    -    When we want only the pathname component, we can pass
    -    `--name-only` option to omit such a pipeline, but there are no
    -    options for extracting other fields.
    +    The "--name-only" option outputs <filepath> only. Likewise, <objectName>
    +    is another high frequency used field, so implement '--object-only' option
    +    will bring intuitive and clear semantics for this scenario. Using
    +    '--format=%(objectname)' we can achieve a similar effect, but the former
    +    is with a lower learning cost(without knowing the format requirement
    +    of '--format' option).
     
    -    Teach the "--object-only" option to the command to only show the
    -    object name. This option cannot be used together with
    -    "--name-only" or "--long" , they are mutually exclusive (actually
    -    "--name-only" and "--long" can be combined together before, this
    -    commit by the way fix this bug).
    +    Even so, if a user is prefer to use "--format=%(objectname)", this is entirely
    +    welcome because they are not only equivalent in function, but also have almost
    +    identical performance. The reason is this commit also add the specific of
    +    "--format=%(objectname)" to the current fast-pathes (builtin formats) to
    +    avoid running unnecessary parsing mechanisms.
     
    -    In terms of performance, there is no loss comparing to the
    -    "master" (2ae0a9c), here are the
    -    results of the performance tests in my environment based on linux
    -    repository:
    +    The following performance benchmarks are based on torvalds/linux.git:
     
    -        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    -        Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    -        Time (mean ± σ):     105.8 ms ±   2.7 ms    [User: 85.7 ms, System: 20.0 ms]
    -        Range (min … max):   101.5 ms … 111.3 ms    28 runs
    +      When hit the fast-path:
     
    -        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD"
    -        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD
    -        Time (mean ± σ):     105.0 ms ±   3.0 ms    [User: 83.7 ms, System: 21.2 ms]
    -        Range (min … max):    99.3 ms … 109.5 ms    27 runs
    +          Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --object-only HEAD
    +            Time (mean ± σ):      83.6 ms ±   2.0 ms    [User: 59.4 ms, System: 24.1 ms]
    +            Range (min … max):    80.4 ms …  87.2 ms    35 runs
     
    -        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
    -        Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    -        Time (mean ± σ):     337.4 ms ±  10.9 ms    [User: 308.3 ms, System: 29.0 ms]
    -        Range (min … max):   323.0 ms … 355.0 ms    10 runs
    +          Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(objectname)' HEAD
    +            Time (mean ± σ):      84.1 ms ±   1.8 ms    [User: 61.7 ms, System: 22.3 ms]
    +            Range (min … max):    80.9 ms …  87.5 ms    35 runs
     
    -        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD"
    -        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD
    -        Time (mean ± σ):     337.6 ms ±   6.2 ms    [User: 309.4 ms, System: 28.1 ms]
    -        Range (min … max):   330.4 ms … 349.9 ms    10 runs
    +      But for a customized format, it will be slower:
    +
    +           Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='oid: %(objectname)' HEAD
    +             Time (mean ± σ):      96.5 ms ±   2.5 ms    [User: 72.9 ms, System: 23.5 ms]
    +             Range (min … max):    93.1 ms … 104.1 ms    31 runs
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ Documentation/git-ls-tree.txt: OPTIONS
     +--object-only::
     +	List only names of the objects, one per line. Cannot be combined
     +	with `--name-only` or `--name-status`.
    ++	This is equivalent to specifying `--format='%(objectname)'`, but
    ++	for both this option and that exact format the command takes a
    ++	hand-optimized codepath instead of going through the generic
    ++	formatting mechanism.
      
      --abbrev[=<n>]::
      	Instead of showing the full 40-byte hexadecimal object
    @@ builtin/ls-tree.c: static const char *format;
      	unsigned mode;
      	enum object_type type;
     @@ builtin/ls-tree.c: static const  char * const ls_tree_usage[] = {
    - enum {
    + static enum mutx_option {
      	MODE_UNSPECIFIED = 0,
      	MODE_NAME_ONLY,
     +	MODE_OBJECT_ONLY,
      	MODE_LONG,
    - };
    + } cmdmode;
      
    -@@ builtin/ls-tree.c: static int fast_path(void){
    - 	} else if (!strcmp(format, name_only_format)) {
    - 		shown_fields = FIELD_PATH_NAME;
    - 		return 1;
    -+	} else if (!strcmp(format, object_only_format)) {
    -+		shown_fields = FIELD_OBJECT_NAME;
    - 	}
    - 	return 0;
    - }
    -@@ builtin/ls-tree.c: static int parse_shown_fields(void)
    - 		shown_fields = FIELD_PATH_NAME;
    +@@ builtin/ls-tree.c: static int parse_shown_fields(unsigned int *shown_fields)
    + 		*shown_fields = FIELD_PATH_NAME;
      		return 0;
      	}
     -
     +	if (cmdmode == MODE_OBJECT_ONLY) {
    -+		shown_fields = FIELD_OBJECT_NAME;
    ++		*shown_fields = FIELD_OBJECT_NAME;
     +		return 0;
     +	}
      	if (!ls_options || (ls_options & LS_RECURSIVE)
      	    || (ls_options & LS_SHOW_TREES)
      	    || (ls_options & LS_TREE_ONLY))
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    - 		return 0;
    + 			return recurse;
    + 	}
      
     +	if (shown_fields == FIELD_OBJECT_NAME) {
     +		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
     +		return recurse;
     +	}
    ++
      	if (shown_fields == FIELD_PATH_NAME) {
      		baselen = base->len;
      		strbuf_addstr(base, pathname);
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		OPT_SET_INT(0, "full-name", &chomp_prefix,
      			    N_("use full path names"), 0),
      		OPT_BOOL(0, "full-tree", &full_tree,
    +@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    + 	} else if (format && (!strcmp(format, name_only_format))) {
    + 		shown_fields = FIELD_PATH_NAME;
    + 		fn = show_tree;
    ++	} else if (format && (!strcmp(format, object_only_format))) {
    ++		shown_fields = FIELD_OBJECT_NAME;
    ++		fn = show_tree;
    + 	} else if (format)
    + 		fn = show_tree_fmt;
    + 
    +
    + ## t/t3103-ls-tree-misc.sh ##
    +@@ t/t3103-ls-tree-misc.sh: test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
    + 
    + for opts in \
    + 	"--name-only --long" \
    +-	"--name-status --long"
    ++	"--name-status --long" \
    ++	"--name-only --object-only" \
    ++	"--name-status --object-only" \
    ++	"--object-only --long" \
    ++	"--object-only --format"
    + do
    + 	test_expect_success "usage: incompatible options: $opts" '
    + 		test_expect_code 129 git ls-tree $opts $tree
    +     '
    + done
    +-
    + test_done
     
      ## t/t3104-ls-tree-format.sh ##
     @@ t/t3104-ls-tree-format.sh: test_expect_success 'ls-tree --format=<name-only-like>' '
    @@ t/t3104-ls-tree-format.sh: test_expect_success 'ls-tree --format=<name-only-like
     +		"%(objectname)" \
     +		"--object-only"
     +'
    ++
    ++test_expect_success 'ls-tree --format=<object-only-like> --abbrev' '
    ++	test_ls_tree_format \
    ++		"%(objectname)" \
    ++		"--object-only --abbrev" \
    ++		"--abbrev"
    ++'
     +
      test_expect_success 'ls-tree combine --format=<default-like> and -t' '
      	test_ls_tree_format \
    @@ t/t3104-ls-tree-format.sh: test_expect_success 'ls-tree hit fast-path with --for
     +	test_cmp expect actual
     +'
      test_done
    -
    - ## t/t3105-ls-tree-oid.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description='git ls-tree objects handling.'
    -+
    -+. ./test-lib.sh
    -+
    -+test_expect_success 'setup' '
    -+test_commit A &&
    -+test_commit B &&
    -+mkdir -p C &&
    -+test_commit C/D.txt &&
    -+find *.txt path* \( -type f -o -type l \) -print |
    -+xargs git update-index --add &&
    -+tree=$(git write-tree) &&
    -+echo $tree
    -+'
    -+
    -+test_expect_success 'usage: --object-only' '
    -+git ls-tree --object-only $tree >current &&
    -+git ls-tree $tree >result &&
    -+cut -f1 result | cut -d " " -f3 >expected &&
    -+test_cmp current expected
    -+'
    -+
    -+test_expect_success 'usage: --object-only with -r' '
    -+git ls-tree --object-only -r $tree >current &&
    -+git ls-tree -r $tree >result &&
    -+cut -f1 result | cut -d " " -f3 >expected &&
    -+test_cmp current expected
    -+'
    -+
    -+test_expect_success 'usage: --object-only with --abbrev' '
    -+git ls-tree --object-only --abbrev=6 $tree >current &&
    -+git ls-tree --abbrev=6 $tree >result &&
    -+cut -f1 result | cut -d " " -f3 >expected &&
    -+test_cmp current expected
    -+'
    -+
    -+test_expect_success 'usage: incompatible options: --name-only with --object-only' '
    -+test_expect_code 129 git ls-tree --object-only --name-only $tree
    -+'
    -+
    -+test_expect_success 'usage: incompatible options: --name-status with --object-only' '
    -+test_expect_code 129 git ls-tree --object-only --name-status $tree
    -+'
    -+
    -+test_expect_success 'usage: incompatible options: --long with --object-only' '
    -+test_expect_code 129 git ls-tree --object-only --long $tree
    -+'
    -+
    -+test_done
-- 
2.34.1.402.gef0f5bd184


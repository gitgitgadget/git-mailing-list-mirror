Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF2C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiCWJO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiCWJO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:14:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399325D654
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so1065410pjb.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqPkbYubuGAkjTQtkie1Clz3LyRxJIk/C2V/SFiZ+cg=;
        b=duTcKiVg/GhmDXzhHE6LOaYiUQljOb0deiAyZmgBUJrqD6dFNu7UcphXezol9dDSei
         QH6eKvMmOrVjT8FRl3Mi0UeUrTO75a/XWGHD86OVwGdAD+rcgjoX5/J5HnMx2s8ahZoi
         fXhoPZXxp4i6zBmCUKvMke+WgkmL4wRVhJG52aNTmRvQzi9xmUZy1KCiTH8jvwlY3Mm6
         SKfLA0witRdV64OgziGOWyZAv1L1dttE+rwENtXXdVikl1kdQsrXDGTsdpNAbhki+IeS
         Bc6HtEE3oTNka2yRtIZfkgzX2iJWKLSo/pabtI5Ek2UeDo/c2kHHI9djxWVdsHtUDla2
         tIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqPkbYubuGAkjTQtkie1Clz3LyRxJIk/C2V/SFiZ+cg=;
        b=Bn1qbJpN6YMYG+a1dQw02H4dwG+P04czkCIrxWlXHcHlC/g92E72XpTPZKMj8jX5oF
         OcCKTyGjmWEzyGY9ohk3Rt9/S/ifOYavb1PMrrJ2voRxxNZ0mFwAaE5UAMyyUemcHn7d
         D9PYaXaUoKi84d2YPMFJ9R75UPWBspFnYARz96Ostm8zVLzW6sqxXb90AU0WyMFvzIgd
         6I/jjaQTsyc+rditOVEmiWuC4eW1zVI1tWGuPOCk33LZ++LuerA88N9FBSXXlDfXlJwf
         Ppw4vG1Ik6U9N7NMNHgfsF6bwy3+l+ON0H5uXfJC2djcbKXrpeJFCdowD4TrIc3wI06l
         hCnA==
X-Gm-Message-State: AOAM533VNMSc/37Cr9PFdc+itVdVc53TOVB7ZvGm/cGiVl5LZlUHQykT
        IQzGGgWgsMH8hNNqlhHeEO0=
X-Google-Smtp-Source: ABdhPJzvanJcLDG7GYPfG0qGAJJAPZbyn2B8D1DkUh1zFw+EtrkULZzPUCR5pi7UNQ+UdbQZdw1gew==
X-Received: by 2002:a17:90a:1db:b0:1bf:711d:267a with SMTP id 27-20020a17090a01db00b001bf711d267amr10325183pjd.155.1648026801930;
        Wed, 23 Mar 2022 02:13:21 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:21 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 00/15] ls-tree: "--object-only" and "--format" opts
Date:   Wed, 23 Mar 2022 17:13:00 +0800
Message-Id: <cover.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Main diff from v13:

1. fix missing {} braces in "else if" arm.

   https://public-inbox.org/git/220321.86wngnbqwx.gmgdl@evledraar.gmail.com/

2. move "ls-tree tests: add tests for --name-status" in front of the series.

   https://public-inbox.org/git/220321.861qyvd5j1.gmgdl@evledraar.gmail.com/

3. squash "ls-tree: remove FIELD_*, just use MODE_*" into previous commit "ls-tree: slightly refactor `show_tree()`".

   https://public-inbox.org/git/220321.86a6djd5m4.gmgdl@evledraar.gmail.com/

4. make a fix on the performance regression when hit default format fast-path.

   https://public-inbox.org/git/220321.865yo7d5ki.gmgdl@evledraar.gmail.com/#t

These changes are based on Ævar Arnfjörð Bjarmason's advices and I really appreciate it.

Thanks.

Johannes Schindelin (1):
  cocci: allow padding with `strbuf_addf()`

Teng Long (5):
  ls-tree: rename "retval" to "recurse" in "show_tree()"
  ls-tree: simplify nesting if/else logic in "show_tree()"
  ls-tree: fix "--name-only" and "--long" combined use bug
  ls-tree: slightly refactor `show_tree()`
  ls-tree: support --object-only option for "git-ls-tree"

Ævar Arnfjörð Bjarmason (9):
  ls-tree tests: add tests for --name-status
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
  ls-tree: introduce struct "show_tree_data"
  ls-tree: introduce "--format" option
  ls-tree: detect and error on --name-only --name-status
  ls-tree: split up "fast path" callbacks

 Documentation/git-ls-tree.txt   |  68 +++++-
 builtin/ls-tree.c               | 366 ++++++++++++++++++++++++++------
 contrib/coccinelle/strbuf.cocci |   6 +-
 t/t3101-ls-tree-dirname.sh      |  55 ++---
 t/t3103-ls-tree-misc.sh         |  15 ++
 t/t3104-ls-tree-format.sh       |  76 +++++++
 6 files changed, 492 insertions(+), 94 deletions(-)
 create mode 100755 t/t3104-ls-tree-format.sh

Range-diff against v13:
13:  a5c73de057 =  1:  ef1cf83d5e ls-tree tests: add tests for --name-status
 1:  2fcff7e0d4 =  2:  02779bfd5d ls-tree: remove commented-out code
 2:  6fd1dd9383 =  3:  93484b102d ls-tree: add missing braces to "else" arms
 3:  208654b5e2 =  4:  2b746624ec ls-tree: use "enum object_type", not {blob,tree,commit}_type
 4:  2637464fd8 =  5:  ca90461e03 ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
 5:  99e6d47108 =  6:  f51d4fab0a ls-tree: rename "retval" to "recurse" in "show_tree()"
 6:  a8d9b78dea !  7:  bff68d994f ls-tree: simplify nesting if/else logic in "show_tree()"
    @@ Commit message
         "mode" passed to us by read_tree(), instead of doing so with the S_*()
         macros.
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyronetengb@gmail.com>
     
      ## builtin/ls-tree.c ##
 7:  25a07e048f !  8:  1d1808bdf0 ls-tree: fix "--name-only" and "--long" combined use bug
    @@ Commit message
     
         [1] https://public-inbox.org/git/YZK0MKCYAJmG+pSU@coredump.intra.peff.net/
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## builtin/ls-tree.c ##
 8:  55f1e10d7e !  9:  f4fc377dfa ls-tree: slightly refactor `show_tree()`
    @@ Metadata
      ## Commit message ##
         ls-tree: slightly refactor `show_tree()`
     
    -    This is a non-functional change, we use a new int "shown_fields" to mark
    -    which columns to output, and `parse_shown_fields()` to calculate the
    -    value of "shown_fields".
    +    This is a non-functional change, we introduce an enum "ls_tree_cmdmode"
    +    then use it to mark which columns to output.
     
         This has the advantage of making the show_tree logic simpler and more
         readable, as well as making it easier to extend new options (for example,
         if we want to add a "--object-only" option, we just need to add a similar
    -    "if (shown_fields == FIELD_OBJECT_NAME)" short-circuit logic in
    -    "show_tree()").
    +    "short-circuit logic in "show_tree()").
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## builtin/ls-tree.c ##
    @@ builtin/ls-tree.c
      static int abbrev;
      static int ls_options;
      static struct pathspec pathspec;
    - static int chomp_prefix;
    - static const char *ls_tree_prefix;
    -+static unsigned int shown_fields;
    -+#define FIELD_PATH_NAME 1
    -+#define FIELD_SIZE (1 << 1)
    -+#define FIELD_OBJECT_NAME (1 << 2)
    -+#define FIELD_TYPE (1 << 3)
    -+#define FIELD_MODE (1 << 4)
    -+#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
    -+#define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
    - 
    - static const  char * const ls_tree_usage[] = {
    - 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
    +@@ builtin/ls-tree.c: static const  char * const ls_tree_usage[] = {
      	NULL
      };
      
    @@ builtin/ls-tree.c
     +	MODE_LONG = 1,
     +	MODE_NAME_ONLY,
     +} cmdmode;
    -+
    -+static int parse_shown_fields(void)
    -+{
    -+	if (cmdmode == MODE_NAME_ONLY) {
    -+		shown_fields = FIELD_PATH_NAME;
    -+		return 0;
    -+	}
    -+
    -+	if (!ls_options || (ls_options & LS_RECURSIVE)
    -+	    || (ls_options & LS_SHOW_TREES)
    -+	    || (ls_options & LS_TREE_ONLY))
    -+		shown_fields = FIELD_DEFAULT;
    -+	if (cmdmode == MODE_LONG)
    -+		shown_fields = FIELD_LONG_DEFAULT;
    -+	return 1;
    -+}
     +
      static int show_recursive(const char *base, size_t baselen, const char *pathname)
      {
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
     +{
     +	size_t baselen = base->len;
     +
    -+	if (shown_fields & FIELD_SIZE) {
    ++	if (cmdmode == MODE_LONG) {
     +		char size_text[24];
     +		if (type == OBJ_BLOB) {
     +			unsigned long size;
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -			printf("%06o %s %s\t", mode, type_name(type),
     -			       find_unique_abbrev(oid, abbrev));
     -		}
    -+	if (shown_fields == FIELD_PATH_NAME) {
    ++	if (cmdmode == MODE_NAME_ONLY) {
     +		baselen = base->len;
     +		strbuf_addstr(base, pathname);
     +		write_name_quoted_relative(base->buf,
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -				   stdout, line_termination);
     -	strbuf_setlen(base, baselen);
     +
    -+	if (shown_fields >= FIELD_DEFAULT)
    -+		show_default(oid, type, pathname, mode, base);
    ++	if (cmdmode == MODE_LONG ||
    ++		(!ls_options || (ls_options & LS_RECURSIVE)
    ++		 || (ls_options & LS_SHOW_TREES)
    ++		 || (ls_options & LS_TREE_ONLY)))
    ++			 show_default(oid, type, pathname, mode, base);
     +
      	return recurse;
      }
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		OPT_SET_INT(0, "full-name", &chomp_prefix,
      			    N_("use full path names"), 0),
      		OPT_BOOL(0, "full-tree", &full_tree,
    -@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	if (get_oid(argv[0], &oid))
    - 		die("Not a valid object name %s", argv[0]);
    - 
    -+	parse_shown_fields();
    -+
    - 	/*
    - 	 * show_recursive() rolls its own matching code and is
    - 	 * generally ignorant of 'struct pathspec'. The magic mask
 9:  85d0b0da1d ! 10:  5131c0dcff ls-tree: introduce struct "show_tree_data"
    @@ Commit message
         "show_tree()". This commit is a pre-prepared commit for supporting
         "--format" option and it does not affect any existing functionality.
     
    -    At the same time, we also move global "shown_fields" into "show_tree_data"
    -    , the purpose of this is to avoid use both global variable and pass-around
    -    struct.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ builtin/ls-tree.c: static int ls_options;
      static struct pathspec pathspec;
      static int chomp_prefix;
      static const char *ls_tree_prefix;
    --static unsigned int shown_fields;
    - #define FIELD_PATH_NAME 1
    - #define FIELD_SIZE (1 << 1)
    - #define FIELD_OBJECT_NAME (1 << 2)
    -@@ builtin/ls-tree.c: static unsigned int shown_fields;
    - #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
    - #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
    - 
     +struct show_tree_data {
     +	unsigned mode;
     +	enum object_type type;
     +	const struct object_id *oid;
     +	const char *pathname;
     +	struct strbuf *base;
    -+	unsigned int shown_fields;
     +};
    -+
    + 
      static const  char * const ls_tree_usage[] = {
      	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
    - 	NULL
    -@@ builtin/ls-tree.c: static enum ls_tree_cmdmode {
    - 	MODE_NAME_ONLY,
    - } cmdmode;
    - 
    --static int parse_shown_fields(void)
    -+static int parse_shown_fields(unsigned int *shown_fields)
    - {
    - 	if (cmdmode == MODE_NAME_ONLY) {
    --		shown_fields = FIELD_PATH_NAME;
    -+		*shown_fields = FIELD_PATH_NAME;
    - 		return 0;
    - 	}
    - 
    - 	if (!ls_options || (ls_options & LS_RECURSIVE)
    - 	    || (ls_options & LS_SHOW_TREES)
    - 	    || (ls_options & LS_TREE_ONLY))
    --		shown_fields = FIELD_DEFAULT;
    -+		*shown_fields = FIELD_DEFAULT;
    - 	if (cmdmode == MODE_LONG)
    --		shown_fields = FIELD_LONG_DEFAULT;
    -+		*shown_fields = FIELD_LONG_DEFAULT;
    - 	return 1;
    - }
    - 
     @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
      	return 0;
      }
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
     -	size_t baselen = base->len;
     +	size_t baselen = data->base->len;
      
    --	if (shown_fields & FIELD_SIZE) {
    -+	if (data->shown_fields & FIELD_SIZE) {
    + 	if (cmdmode == MODE_LONG) {
      		char size_text[24];
     -		if (type == OBJ_BLOB) {
     +		if (data->type == OBJ_BLOB) {
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
      	int recurse = 0;
      	size_t baselen;
      	enum object_type type = object_type(mode);
    -+	unsigned int shown_fields = *(unsigned int *)context;
     +	struct show_tree_data data = {
     +		.mode = mode,
     +		.type = type,
     +		.oid = oid,
     +		.pathname = pathname,
     +		.base = base,
    -+		.shown_fields = shown_fields,
     +	};
      
      	if (type == OBJ_BLOB) {
      		if (ls_options & LS_TREE_ONLY)
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 		return recurse;
    - 	}
    - 
    --	if (shown_fields >= FIELD_DEFAULT)
    --		show_default(oid, type, pathname, mode, base);
    -+	if (shown_fields>= FIELD_DEFAULT)
    -+		show_default(&data);
    + 		(!ls_options || (ls_options & LS_RECURSIVE)
    + 		 || (ls_options & LS_SHOW_TREES)
    + 		 || (ls_options & LS_TREE_ONLY)))
    +-			 show_default(oid, type, pathname, mode, base);
    ++			 show_default(&data);
      
      	return recurse;
      }
    -@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	struct object_id oid;
    - 	struct tree *tree;
    - 	int i, full_tree = 0;
    -+	unsigned int shown_fields = 0;
    - 	const struct option ls_tree_options[] = {
    - 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
    - 			LS_TREE_ONLY),
    -@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	if (get_oid(argv[0], &oid))
    - 		die("Not a valid object name %s", argv[0]);
    - 
    --	parse_shown_fields();
    --
    - 	/*
    - 	 * show_recursive() rolls its own matching code and is
    - 	 * generally ignorant of 'struct pathspec'. The magic mask
    -@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	tree = parse_tree_indirect(&oid);
    - 	if (!tree)
    - 		die("not a tree object");
    --	return !!read_tree(the_repository, tree,
    --			   &pathspec, show_tree, NULL);
    -+
    -+	parse_shown_fields(&shown_fields);
    -+
    -+	return !!read_tree(the_repository, tree, &pathspec, show_tree,
    -+			   &shown_fields);
    - }
10:  eddcf903ad = 11:  e4769b64c9 cocci: allow padding with `strbuf_addf()`
11:  7451242daa ! 12:  8b21b204a5 ls-tree: introduce "--format" option
    @@ Documentation/git-ls-tree.txt: quoted as explained for the configuration variabl
      Part of the linkgit:git[1] suite
     
      ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static const char *ls_tree_prefix;
    - #define FIELD_MODE (1 << 4)
    - #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
    - #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
    --
    +@@ builtin/ls-tree.c: static int ls_options;
    + static struct pathspec pathspec;
    + static int chomp_prefix;
    + static const char *ls_tree_prefix;
     +static const char *format;
    -+static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
    -+static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
    -+static const char *name_only_format = "%(path)";
    ++
      struct show_tree_data {
      	unsigned mode;
      	enum object_type type;
    -@@ builtin/ls-tree.c: static enum ls_tree_cmdmode {
    +@@ builtin/ls-tree.c: static const  char * const ls_tree_usage[] = {
    + };
    + 
    + static enum ls_tree_cmdmode {
    +-	MODE_LONG = 1,
    ++	MODE_DEFAULT = 0,
    ++	MODE_LONG,
      	MODE_NAME_ONLY,
      } cmdmode;
      
    @@ builtin/ls-tree.c: static enum ls_tree_cmdmode {
     +	return len;
     +}
     +
    - static int parse_shown_fields(unsigned int *shown_fields)
    + static int show_recursive(const char *base, size_t baselen, const char *pathname)
      {
    - 	if (cmdmode == MODE_NAME_ONLY) {
    + 	int i;
     @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
      	return 0;
      }
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
      static int show_default(struct show_tree_data *data)
      {
      	size_t baselen = data->base->len;
    -@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    +@@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    + 	return recurse;
    + }
    + 
    ++struct ls_tree_cmdmode_to_fmt {
    ++	enum ls_tree_cmdmode mode;
    ++	const char *const fmt;
    ++};
    ++
    ++static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
    ++	{
    ++		.mode = MODE_DEFAULT,
    ++		.fmt = "%(objectmode) %(objecttype) %(objectname)%x09%(path)",
    ++	},
    ++	{
    ++		.mode = MODE_LONG,
    ++		.fmt = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)",
    ++	},
    ++	{
    ++		.mode = MODE_NAME_ONLY, /* And MODE_NAME_STATUS */
    ++		.fmt = "%(path)",
    ++	},
    ++	{ 0 },
    ++};
    ++
    + int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    + {
    + 	struct object_id oid;
      	struct tree *tree;
      	int i, full_tree = 0;
    - 	unsigned int shown_fields = 0;
     +	read_tree_fn_t fn = show_tree;
      	const struct option ls_tree_options[] = {
      		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		usage_with_options(ls_tree_usage, ls_tree_options);
      	if (get_oid(argv[0], &oid))
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 
    - 	parse_shown_fields(&shown_fields);
    - 
    --	return !!read_tree(the_repository, tree, &pathspec, show_tree,
    --			   &shown_fields);
    + 	tree = parse_tree_indirect(&oid);
    + 	if (!tree)
    + 		die("not a tree object");
    +-	return !!read_tree(the_repository, tree,
    +-			   &pathspec, show_tree, NULL);
     +	/*
     +	 * The generic show_tree_fmt() is slower than show_tree(), so
     +	 * take the fast path if possible.
     +	 */
    -+	if (format && (!strcmp(format, default_format))) {
    -+		fn = show_tree;
    -+	} else if (format && (!strcmp(format, long_format))) {
    -+		shown_fields = shown_fields | FIELD_SIZE;
    -+		fn = show_tree;
    -+	} else if (format && (!strcmp(format, name_only_format))) {
    -+		shown_fields = FIELD_PATH_NAME;
    -+		fn = show_tree;
    -+	} else if (format)
    ++	if (format) {
    ++		struct ls_tree_cmdmode_to_fmt *m2f;
    ++
     +		fn = show_tree_fmt;
    ++		for (m2f = ls_tree_cmdmode_format; m2f->fmt; m2f++) {
    ++			if (strcmp(format, m2f->fmt))
    ++				continue;
    ++
    ++			cmdmode = m2f->mode;
    ++			fn = show_tree;
    ++			break;
    ++		}
    ++	}
     +
    -+	return !!read_tree(the_repository, tree, &pathspec, fn, &shown_fields);
    ++	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
      }
     
      ## t/t3104-ls-tree-format.sh (new) ##
12:  2bcd08ebd0 ! 13:  27fd1d9e2c ls-tree: support --object-only option for "git-ls-tree"
    @@ Commit message
                  Time (mean ± σ):      96.5 ms ±   2.5 ms    [User: 72.9 ms, System: 23.5 ms]
                  Range (min … max):    93.1 ms … 104.1 ms    31 runs
     
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## Documentation/git-ls-tree.txt ##
    @@ Documentation/git-ls-tree.txt: OPTIONS
      	Instead of showing the full 40-byte hexadecimal object
     
      ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static const char *format;
    - static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
    - static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
    - static const char *name_only_format = "%(path)";
    -+static const char *object_only_format = "%(objectname)";
    +@@ builtin/ls-tree.c: static struct pathspec pathspec;
    + static int chomp_prefix;
    + static const char *ls_tree_prefix;
    + static const char *format;
    +-
      struct show_tree_data {
      	unsigned mode;
      	enum object_type type;
    -@@ builtin/ls-tree.c: static const  char * const ls_tree_usage[] = {
    - static enum ls_tree_cmdmode {
    - 	MODE_LONG = 1,
    +@@ builtin/ls-tree.c: static enum ls_tree_cmdmode {
    + 	MODE_DEFAULT = 0,
    + 	MODE_LONG,
      	MODE_NAME_ONLY,
     +	MODE_OBJECT_ONLY,
      } cmdmode;
      
      static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
    -@@ builtin/ls-tree.c: static int parse_shown_fields(unsigned int *shown_fields)
    - 		*shown_fields = FIELD_PATH_NAME;
    - 		return 0;
    - 	}
    --
    -+	if (cmdmode == MODE_OBJECT_ONLY) {
    -+		*shown_fields = FIELD_OBJECT_NAME;
    -+		return 0;
    -+	}
    - 	if (!ls_options || (ls_options & LS_RECURSIVE)
    - 	    || (ls_options & LS_SHOW_TREES)
    - 	    || (ls_options & LS_TREE_ONLY))
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
      			return recurse;
      	}
      
    -+	if (shown_fields == FIELD_OBJECT_NAME) {
    ++	if (cmdmode == MODE_OBJECT_ONLY) {
     +		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
     +		return recurse;
     +	}
     +
    - 	if (shown_fields == FIELD_PATH_NAME) {
    + 	if (cmdmode == MODE_NAME_ONLY) {
      		baselen = base->len;
      		strbuf_addstr(base, pathname);
    +@@ builtin/ls-tree.c: static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
    + 		.mode = MODE_NAME_ONLY, /* And MODE_NAME_STATUS */
    + 		.fmt = "%(path)",
    + 	},
    ++	{
    ++		.mode = MODE_OBJECT_ONLY,
    ++		.fmt = "%(objectname)",
    ++	},
    + 	{ 0 },
    + };
    + 
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
      			    MODE_NAME_ONLY),
      		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		OPT_SET_INT(0, "full-name", &chomp_prefix,
      			    N_("use full path names"), 0),
      		OPT_BOOL(0, "full-tree", &full_tree,
    -@@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - 	} else if (format && (!strcmp(format, name_only_format))) {
    - 		shown_fields = FIELD_PATH_NAME;
    - 		fn = show_tree;
    -+	} else if (format && (!strcmp(format, object_only_format))) {
    -+		shown_fields = FIELD_OBJECT_NAME;
    -+		fn = show_tree;
    - 	} else if (format)
    - 		fn = show_tree_fmt;
    - 
     
      ## t/t3103-ls-tree-misc.sh ##
     @@ t/t3103-ls-tree-misc.sh: test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
14:  89402a8518 ! 14:  1d5d9470ab ls-tree: detect and error on --name-only --name-status
    @@ Commit message
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static const  char * const ls_tree_usage[] = {
    - static enum ls_tree_cmdmode {
    - 	MODE_LONG = 1,
    +@@ builtin/ls-tree.c: static enum ls_tree_cmdmode {
    + 	MODE_DEFAULT = 0,
    + 	MODE_LONG,
      	MODE_NAME_ONLY,
     +	MODE_NAME_STATUS,
      	MODE_OBJECT_ONLY,
15:  b8afca193a <  -:  ---------- ls-tree: remove FIELD_*, just use MODE_*
16:  010e3c0ece ! 15:  55a96e933b ls-tree: split up "fast path" callbacks
    @@ builtin/ls-tree.c: static int show_tree_fmt(const struct object_id *oid, struct
      	}
      
     -	if (cmdmode == MODE_LONG ||
    --	    (!ls_options || (ls_options & LS_RECURSIVE)
    --	     || (ls_options & LS_SHOW_TREES)
    --	     || (ls_options & LS_TREE_ONLY)))
    --		show_default(&data);
    +-		(!ls_options || (ls_options & LS_RECURSIVE)
    +-		 || (ls_options & LS_SHOW_TREES)
    +-		 || (ls_options & LS_TREE_ONLY)))
    +-			 show_default(&data);
     +	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
     +	       find_unique_abbrev(data.oid, abbrev), size_text);
     +	show_tree_common_default_long(base, pathname, data.base->len);
    @@ builtin/ls-tree.c: static int show_tree_fmt(const struct object_id *oid, struct
      
      int cmd_ls_tree(int argc, const char **argv, const char *prefix)
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    + 	struct object_id oid;
      	struct tree *tree;
      	int i, full_tree = 0;
    - 	unsigned int shown_fields = 0;
     -	read_tree_fn_t fn = show_tree;
     +	read_tree_fn_t fn = NULL;
      	const struct option ls_tree_options[] = {
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
     -			if (strcmp(format, m2f->fmt))
     -				continue;
     -
    -+	while (m2f++) {
    ++	while (m2f) {
     +		if (!m2f->fmt) {
     +			fn = format ? show_tree_fmt : show_tree_default;
     +		} else if (format && !strcmp(format, m2f->fmt)) {
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
     +		} else if (!format && cmdmode == m2f->mode) {
     +			fn = m2f->fn;
     +		} else {
    ++			m2f++;
     +			continue;
      		}
     +		break;
      	}
      
    - 	return !!read_tree(the_repository, tree, &pathspec, fn, &shown_fields);
    + 	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
-- 
2.34.1.404.g92931a4a2c.dirty


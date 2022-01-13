Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B90DC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiAMDmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiAMDmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:19 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0FC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z3so7595536plg.8
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDCpQvAJ8eDuBHYFz3muoAEzb+OuPKpj1vP6KGTL1l8=;
        b=j7P7z6WE/WQFpstLO5bH/mO6eOaMRe+2oNbf2gB0kVKcf5hfiUoFoFn3j5HqM7vOti
         34mr/UN6+pd5j3SczRfsGBeHp5Zqz3X1RojJKcsMiQxHdBr0SHwTEjcfg+xVOQkzIUJL
         zQWve85eLYXLD8dqtdgMczjtlcdfp61N/e+vBho0Zhm4FF03DahDZZWWfwNJ+GOeDGTT
         2dAISMJ6XQxWh2E5eW2E0TDz03+zw5K7GsmfocCf/UMnAPERuR83JDN7/SJ/ukhWwhU1
         6sqckbyqmiQdkzRVSWG0B6yzKhBcqTe6ylRvUAUcDA18Rz9fwWj9Ba+zj4a9Vdql9u6S
         vYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDCpQvAJ8eDuBHYFz3muoAEzb+OuPKpj1vP6KGTL1l8=;
        b=bOKIs9ehf1lI92P+KFLrF2RHCmRep5Ylm+fQ6SMwvHSUtdpDChr/fYPOqvqi0mJ4Ib
         B3F5TTcYOFWBhQ5j4AuBveTKIkVboy+SNHwpc+CYVRdRrUZwLtZfujffDXSPFyzuqd4b
         oYqM0gw+bJdjmSxz98I4z5SYinZNEP+aD+ySzbnn52mXsBb3RQWJVQNhOsniNMgW3asr
         vA3USrE+PQrVs0q564bRuoy0/D1jIXyms+jGuM7CpClxlpHsClqFn7hAp8nNPEGtxneg
         m0yTSkFlGQueSkHxix4K2CTt44Dm7WJmb5tuCjMMo68K37RHtvrUhgmqEuIEuwWIuz6g
         KbDQ==
X-Gm-Message-State: AOAM531Q4knCCTpRsonGscPfRkPoSsxjtlxKfO+ZZA1hzypdGe5WNGEq
        KgGBARhx7kHnuos38zhjrTM=
X-Google-Smtp-Source: ABdhPJwLqNkN4zjD4olripSeKRGC6PJ1qZjY2baNOOtg9llkbrOgXKRHj/HTHypH1L+tRP+vEx2zRg==
X-Received: by 2002:a62:f80d:0:b0:4c1:1262:ea00 with SMTP id d13-20020a62f80d000000b004c11262ea00mr2421099pfh.53.1642045339128;
        Wed, 12 Jan 2022 19:42:19 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:18 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: [PATCH v10 0/9] ls-tree: "--object-only" and "--format" opts
Date:   Thu, 13 Jan 2022 11:42:03 +0800
Message-Id: <cover.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Major diff from v9:

    1. Exchange the order of "cocci: allow padding with `strbuf_addf()`"
and "introduce "--format" option".
       
       (Advice from Johannes Schindelin) 
       Let coccillene's changes take effect before the commit with the rule
       check failure. 

    2. ls-tree.c: support --object-only option for "git-ls-tree"
       
       (Advice from Junio C Hamano)
       Rename the return value name from "recursive" to "recurse".
       Rename "init_type()" to "get_type()".
       Remove "init_recursive()"       

    3. ls-tree.c: introduce "--format" option
       
       (Advice from Martin Ågren)
       Fix some document errors and wording.
       Bug fixing in "t3105" (Always return 129 without specifying an argument).

    4. cocci: allow padding with `strbuf_addf()`  

       (Advice from Ævar Arnfjörð Bjarmason)
       Fix the other logic errors as well.

Thanks.

Teng Long (5):
  ls-tree: optimize naming and handling of "return" in show_tree()
  ls-tree.c: support --object-only option for "git-ls-tree"
  ls-tree.c: introduce struct "show_tree_data"
  cocci: allow padding with `strbuf_addf()`
  ls-tree.c: introduce "--format" option

Ævar Arnfjörð Bjarmason (4):
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"

 Documentation/git-ls-tree.txt   |  56 +++++-
 builtin/ls-tree.c               | 328 +++++++++++++++++++++++++-------
 contrib/coccinelle/strbuf.cocci |   6 +-
 t/t3104-ls-tree-oid.sh          |  51 +++++
 t/t3105-ls-tree-format.sh       |  55 ++++++
 5 files changed, 426 insertions(+), 70 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh
 create mode 100755 t/t3105-ls-tree-format.sh

Range-diff against v9:
 1:  75503c41a7 <  -:  ---------- ls-tree: optimize naming and handling of "return" in show_tree()
 -:  ---------- >  1:  2fcff7e0d4 ls-tree: remove commented-out code
 -:  ---------- >  2:  6fd1dd9383 ls-tree: add missing braces to "else" arms
 -:  ---------- >  3:  208654b5e2 ls-tree: use "enum object_type", not {blob,tree,commit}_type
 -:  ---------- >  4:  2637464fd8 ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
 -:  ---------- >  5:  b04188c822 ls-tree: optimize naming and handling of "return" in show_tree()
 2:  e0274f079a !  6:  bcfbc935b8 ls-tree.c: support --object-only option for "git-ls-tree"
    @@ builtin/ls-tree.c
      {
      	int i;
      
    -@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
    - 	return 0;
    +@@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
    + 	        : OBJ_BLOB);
      }
      
     +static int show_default(const struct object_id *oid, enum object_type type,
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
     +	return 1;
     +}
     +
    - static void init_type(unsigned mode, enum object_type *type)
    + static int show_tree(const struct object_id *oid, struct strbuf *base,
    + 		const char *pathname, unsigned mode, void *context)
      {
    - 	if (S_ISGITLINK(mode))
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
      	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    - 		return !READ_TREE_RECURSIVE;
    + 		return 0;
      
     -	if (!(ls_options & LS_NAME_ONLY)) {
     -		if (ls_options & LS_SHOW_SIZE) {
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -		}
     +	if (shown_fields == FIELD_OBJECT_NAME) {
     +		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
    -+		return recursive;
    ++		return recurse;
      	}
     -	baselen = base->len;
     -	strbuf_addstr(base, pathname);
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     +					   chomp_prefix ? ls_tree_prefix : NULL,
     +					   stdout, line_termination);
     +		strbuf_setlen(base, baselen);
    -+		return recursive;
    ++		return recurse;
     +	}
     +
     +	if (shown_fields >= FIELD_DEFAULT)
     +		show_default(oid, type, pathname, mode, base);
     +
    - 	return recursive;
    + 	return recurse;
      }
      
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 3:  725c4d0187 !  7:  3ddffa1027 ls-tree.c: introduce struct "show_tree_data"
    @@ builtin/ls-tree.c: static unsigned int shown_fields;
      static const  char * const ls_tree_usage[] = {
      	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
      	NULL
    -@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen,
    - 	return 0;
    +@@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
    + 	        : OBJ_BLOB);
      }
      
     -static int show_default(const struct object_id *oid, enum object_type type,
    @@ builtin/ls-tree.c: static int show_default(const struct object_id *oid, enum obj
      }
      
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - {
    - 	int recursive = 0;
      	size_t baselen;
    --	enum object_type type = OBJ_BLOB;
    + 	enum object_type type = get_type(mode);
    + 
     +	struct show_tree_data data = {
     +		.mode = mode,
    -+		.type = OBJ_BLOB,
    ++		.type = type,
     +		.oid = oid,
     +		.pathname = pathname,
     +		.base = base,
     +	};
    - 
    --	init_type(mode, &type);
    -+	init_type(mode, &data.type);
    - 	init_recursive(base, pathname, &recursive);
    - 
    --	if (type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
    -+	if (data.type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
    - 		return recursive;
    --	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    -+	if (data.type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    - 		return !READ_TREE_RECURSIVE;
    - 
    - 	if (shown_fields == FIELD_OBJECT_NAME) {
    ++
    + 	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
    + 		recurse = READ_TREE_RECURSIVE;
    + 	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
      	}
      
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -		show_default(oid, type, pathname, mode, base);
     +		show_default(&data);
      
    - 	return recursive;
    + 	return recurse;
      }
 -:  ---------- >  8:  4b58a707c2 cocci: allow padding with `strbuf_addf()`
 4:  7df58483a4 !  9:  db058bf670 ls-tree.c: introduce "--format" option
    @@ Documentation/git-ls-tree.txt: OPTIONS
     +--format=<format>::
     +	A string that interpolates `%(fieldname)` from the result
     +	being shown. It also interpolates `%%` to `%`, and
    -+	`%xx` where `xx`are hex digits interpolates to character
    ++	`%xx` where `xx` are hex digits interpolates to character
     +	with hex code `xx`; for example `%00` interpolates to
     +	`\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
     +	When specified, `--format` cannot be combined with other
    @@ Documentation/git-ls-tree.txt: quoted as explained for the configuration variabl
      
     +Customized format:
     +
    -+It's support to print customized format by `%(fieldname)` with `--format` option.
    ++It is possible to print in a custom format by using the `--format` option,
    ++which is able to interpolate different fields using a `%(fieldname)` notation.
     +For example, if you want to only print the <object> and <file> fields with a
     +JSON style, executing with a specific "--format" like
     +
    @@ builtin/ls-tree.c: static int parse_shown_fields(void)
      static int show_recursive(const char *base, size_t baselen,
      			  const char *pathname)
      {
    -@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen,
    - 	return 0;
    +@@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
    + 	        : OBJ_BLOB);
      }
      
    -+static void init_recursive(struct strbuf *base, const char *pathname,
    -+				int *recursive)
    -+{
    -+	if (show_recursive(base->buf, base->len, pathname))
    -+		*recursive = READ_TREE_RECURSIVE;
    -+}
    -+
    -+static void init_type(unsigned mode, enum object_type *type)
    -+{
    -+	if (S_ISGITLINK(mode))
    -+		*type = OBJ_COMMIT;
    -+	else if (S_ISDIR(mode))
    -+		*type = OBJ_TREE;
    -+}
    -+
     +static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
     +			 const char *pathname, unsigned mode, void *context)
     +{
     +	size_t baselen;
    -+	int recursive = 0;
    ++	int recurse = 0;
     +	struct strbuf line = STRBUF_INIT;
    ++	enum object_type type = get_type(mode);
    ++
     +	struct show_tree_data data = {
     +		.mode = mode,
    -+		.type = OBJ_BLOB,
    ++		.type = type,
     +		.oid = oid,
     +		.pathname = pathname,
     +		.base = base,
     +	};
     +
    -+	init_type(mode, &data.type);
    -+	init_recursive(base, pathname, &recursive);
    -+
    -+	if (data.type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
    -+		return recursive;
    -+	if (data.type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    -+		return !READ_TREE_RECURSIVE;
    ++	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
    ++		recurse = READ_TREE_RECURSIVE;
    ++	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
    ++		return recurse;
    ++	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    ++		return 0;
     +
     +	baselen = base->len;
     +	strbuf_expand(&line, format, expand_show_tree, &data);
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen,
     +	fwrite(line.buf, line.len, 1, stdout);
     +	strbuf_release(&line);
     +	strbuf_setlen(base, baselen);
    -+	return recursive;
    ++	return recurse;
     +}
     +
      static int show_default(struct show_tree_data *data)
      {
      	size_t baselen = data->base->len;
    -@@ builtin/ls-tree.c: static int show_default(struct show_tree_data *data)
    - 	return 1;
    - }
    - 
    --static void init_type(unsigned mode, enum object_type *type)
    --{
    --	if (S_ISGITLINK(mode))
    --		*type = OBJ_COMMIT;
    --	else if (S_ISDIR(mode))
    --		*type = OBJ_TREE;
    --}
    --
    --static void init_recursive(struct strbuf *base, const char *pathname,
    --				int *recursive)
    --{
    --	if (show_recursive(base->buf, base->len, pathname))
    --		*recursive = READ_TREE_RECURSIVE;
    --}
    --
    - static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 		const char *pathname, unsigned mode, void *context)
    - {
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
      	struct object_id oid;
      	struct tree *tree;
    @@ t/t3105-ls-tree-format.sh (new)
     +. ./test-lib.sh
     +
     +test_expect_success 'ls-tree --format usage' '
    -+	test_expect_code 129 git ls-tree --format=fmt -l &&
    -+	test_expect_code 129 git ls-tree --format=fmt --name-only &&
    -+	test_expect_code 129 git ls-tree --format=fmt --name-status &&
    -+	test_expect_code 129 git ls-tree --format=fmt --object-only
    ++	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
    ++	test_expect_code 129 git ls-tree --format=fmt --name-only HEAD &&
    ++	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD &&
    ++	test_expect_code 129 git ls-tree --format=fmt --object-only HEAD
     +'
     +
     +test_expect_success 'setup' '
 5:  8dafb2b377 <  -:  ---------- cocci: allow padding with `strbuf_addf()`
-- 
2.34.1.390.g2ae0a9cb82.dirty


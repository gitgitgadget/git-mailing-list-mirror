Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8CDC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiAFEbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiAFEbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:31:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600FC061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:31:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so7091432pjf.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5rCDVHjJxxQxFSAkJAOq0JiK4/CsxDskx/qDU63uHkk=;
        b=KvUsDPgOmjYlnZupTuedEwEJFZahbPAzROM3tqbIgWhaI28TrQ5Af5F+EYZnTsPJlb
         hG45kfstuRfUogByiVWEUwEqX34gYYmtvXY58jBNtTUGEQPK/ntfa1Sq2PF6ne02RcpI
         hfZy7rux4YXAAkzDM+GshvDvAPxQ5mGscUByDhDb24hdGOivdIAF1tn3ERa5+Lq1H6wV
         X0EyTeRB5L2gzNLrb0ktlErtlQ0/BS2NICEg85h9/H1v9ysQz1VWr1TSOYzy0+fBulDg
         zLd14LOnLuX8U1ye69a72o9XbSCbg7WfcORoPy/tIhtNc97gV+8KwL56xrMONf/7fA9W
         3JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rCDVHjJxxQxFSAkJAOq0JiK4/CsxDskx/qDU63uHkk=;
        b=HSX9YvoxrwfUpc5rT/b5wM1lNyPYp/P1dxd5XLBU4DSSJ3FwpTSQVUg9W1jRqp1dRS
         C5vCsKgi21u9k/ydTb9EbzKE/Ub+p7tau5rqsAtOSCCsFNOap2AfhXp/aCpb9TRn/FxL
         lcygwKF1I4zRX3AlXYzMTpowSu+WjJLI7SVUBC80XzfFXU1NpqYQqOpOSk2Hz+vSHtKW
         SRvaeTJgCr7C+SifcFcKoqHKBP6vU7/fgKATAz8KdNIj09iEOWUgXbFT/7T8sslyW0JZ
         Dunx0kCJGekFYomVyZEk4NZU1TVlM7164t1NFydBJBkRaw3Y548vdh4W4oNkMf6CvpvV
         0h1Q==
X-Gm-Message-State: AOAM53367fHlMcb5N7tH7RfoM73O/li1kGSl5mSgzHr+9x37Y+yKtWqI
        0Yi4eEMNpQVYd/4palFeE7o=
X-Google-Smtp-Source: ABdhPJy3uR41k+rRBazCJW0lZrex2nY4tHSWG67SVuoo0DdFo5JqrH489fgiolrkd4MlaufRgHKZPQ==
X-Received: by 2002:a17:902:cec8:b0:148:f0dd:3ce0 with SMTP id d8-20020a170902cec800b00148f0dd3ce0mr57274940plg.156.1641443500366;
        Wed, 05 Jan 2022 20:31:40 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:31:39 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 0/9] ls-tree.c: introduce "--format" option
Date:   Thu,  6 Jan 2022 12:31:23 +0800
Message-Id: <cover.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641043500.git.dyroneteng@gmail.com>
References: <cover.1641043500.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff from v8:

1). [Delete] ls-tree: split up the "init" part of show_tree()
2). [New] ls-tree: optimize naming and handling of "return" in show_tree()

In last patch v8, I use commit "ls-tree: split up the "init" part of show_tree()"
(d77c895a4b) from RFC patch v7 [1] and I did not notice the handling of return
value which was called "retval" in it. As Junio mentioned in his reply [2], I
took a look about the "retval" and found it needs to be handled with care.

So, instead I introduced this new commit (instead of the old commit) to take
responsiblies for renaming "retval" and try to let the relevant codes maybe
more easier to understand.

3). [Append] ls-tree.c: support --object-only option for "git-ls-tree"

Junio pointed out that some of these fields are ambiguous [2] and on the
necessary of using xOR. 

I modified the commit and it's basically according to the steps I replied
in [3], except the issue of using xOR, Junio suggest me to use
"if ((shown_fields & FILE_NAME_FIELD) == FILE_NAME_FIELD)" instead, but
in here I think use "if (shown_fields == FILE_NAME_FIELD)" is enough.

4). [Append] ls-tree.c: introduce struct "show_tree_data"

I had a spelling mistake which was found by Junio ("show_data" should be 
"shown_data"), that reminded me the "show_data" is a little abtract, so I
rename it to "show_tree_data" which is the data struct used in function
"show_tree", I think it's a bit better than before.

5). [Append] ls-tree.c: introduce "--format" option

Doc format modifications. Fix strbuf leaks and some other non-functional
modifications in "ls-tree.c"

6). [New] cocci: allow padding with `strbuf_addf()`

Fix the static-analysis issue[4] which found by Johannes Schindelin. 

Thanks.

[1] https://public-inbox.org/git/xmqqwnjgfe4t.fsf@gitster.g/
[2] https://public-inbox.org/git/xmqqwnjgfe4t.fsf@gitster.g/
[3] https://public-inbox.org/git/20220104072951.10153-1-dyroneteng@gmail.com/#t
[4] https://public-inbox.org/git/nycvar.QRO.7.76.6.2201051348050.7076@tvgsbejvaqbjf.bet/

Teng Long (5):
  ls-tree: optimize naming and handling of "return" in show_tree()
  ls-tree.c: support --object-only option for "git-ls-tree"
  ls-tree.c: introduce struct "show_tree_data"
  ls-tree.c: introduce "--format" option
  cocci: allow padding with `strbuf_addf()`

Ævar Arnfjörð Bjarmason (4):
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"

 Documentation/git-ls-tree.txt   |  55 +++++-
 builtin/ls-tree.c               | 332 ++++++++++++++++++++++++++------
 contrib/coccinelle/strbuf.cocci |   2 +-
 t/t3104-ls-tree-oid.sh          |  51 +++++
 t/t3105-ls-tree-format.sh       |  55 ++++++
 5 files changed, 427 insertions(+), 68 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh
 create mode 100755 t/t3105-ls-tree-format.sh

Range-diff against v8:
 1:  d77c895a4b <  -:  ---------- ls-tree: split up the "init" part of show_tree()
 -:  ---------- >  1:  2fcff7e0d4 ls-tree: remove commented-out code
 -:  ---------- >  2:  6fd1dd9383 ls-tree: add missing braces to "else" arms
 -:  ---------- >  3:  208654b5e2 ls-tree: use "enum object_type", not {blob,tree,commit}_type
 -:  ---------- >  4:  2637464fd8 ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
 -:  ---------- >  5:  75503c41a7 ls-tree: optimize naming and handling of "return" in show_tree()
 2:  cb881183cb !  6:  e0274f079a ls-tree.c: support --object-only option for "git-ls-tree"
    @@ builtin/ls-tree.c
      static struct pathspec pathspec;
      static int chomp_prefix;
      static const char *ls_tree_prefix;
    -+static unsigned int shown_bits;
    -+#define SHOW_FILE_NAME 1
    -+#define SHOW_SIZE (1 << 1)
    -+#define SHOW_OBJECT_NAME (1 << 2)
    -+#define SHOW_TYPE (1 << 3)
    -+#define SHOW_MODE (1 << 4)
    -+#define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
    ++static unsigned int shown_fields;
    ++#define FIELD_FILE_NAME 1
    ++#define FIELD_SIZE (1 << 1)
    ++#define FIELD_OBJECT_NAME (1 << 2)
    ++#define FIELD_TYPE (1 << 3)
    ++#define FIELD_MODE (1 << 4)
    ++#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
    ++#define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
      
      static const  char * const ls_tree_usage[] = {
      	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
    @@ builtin/ls-tree.c
     +static int parse_shown_fields(void)
     +{
     +	if (cmdmode == MODE_NAME_ONLY) {
    -+		shown_bits = SHOW_FILE_NAME;
    ++		shown_fields = FIELD_FILE_NAME;
     +		return 0;
     +	}
     +	if (cmdmode == MODE_OBJECT_ONLY) {
    -+		shown_bits = SHOW_OBJECT_NAME;
    ++		shown_fields = FIELD_OBJECT_NAME;
     +		return 0;
     +	}
     +	if (!ls_options || (ls_options & LS_RECURSIVE)
     +	    || (ls_options & LS_SHOW_TREES)
     +	    || (ls_options & LS_TREE_ONLY))
    -+		shown_bits = SHOW_DEFAULT;
    ++		shown_fields = FIELD_DEFAULT;
     +	if (cmdmode == MODE_LONG)
    -+		shown_bits = SHOW_DEFAULT | SHOW_SIZE;
    ++		shown_fields = FIELD_LONG_DEFAULT;
     +	return 1;
     +}
     +
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
     +{
     +	size_t baselen = base->len;
     +
    -+	if (shown_bits & SHOW_SIZE) {
    ++	if (shown_fields & FIELD_SIZE) {
     +		char size_text[24];
     +		if (type == OBJ_BLOB) {
     +			unsigned long size;
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, c
     +	return 1;
     +}
     +
    - static int show_tree_init(enum object_type *type, struct strbuf *base,
    - 			  const char *pathname, unsigned mode, int *retval)
    + static void init_type(unsigned mode, enum object_type *type)
      {
    + 	if (S_ISGITLINK(mode))
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 	if (show_tree_init(&type, base, pathname, mode, &retval))
    - 		return retval;
    + 	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    + 		return !READ_TREE_RECURSIVE;
      
     -	if (!(ls_options & LS_NAME_ONLY)) {
     -		if (ls_options & LS_SHOW_SIZE) {
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -			printf("%06o %s %s\t", mode, type_name(type),
     -			       find_unique_abbrev(oid, abbrev));
     -		}
    -+	if (!(shown_bits ^ SHOW_OBJECT_NAME)) {
    ++	if (shown_fields == FIELD_OBJECT_NAME) {
     +		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
    -+		return retval;
    ++		return recursive;
      	}
     -	baselen = base->len;
     -	strbuf_addstr(base, pathname);
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -				   stdout, line_termination);
     -	strbuf_setlen(base, baselen);
     +
    -+	if (!(shown_bits ^ SHOW_FILE_NAME)) {
    ++	if (shown_fields == FIELD_FILE_NAME) {
     +		baselen = base->len;
     +		strbuf_addstr(base, pathname);
     +		write_name_quoted_relative(base->buf,
     +					   chomp_prefix ? ls_tree_prefix : NULL,
     +					   stdout, line_termination);
     +		strbuf_setlen(base, baselen);
    ++		return recursive;
     +	}
     +
    -+	if (!(shown_bits ^ SHOW_DEFAULT) ||
    -+	    !(shown_bits ^ (SHOW_DEFAULT | SHOW_SIZE)))
    ++	if (shown_fields >= FIELD_DEFAULT)
     +		show_default(oid, type, pathname, mode, base);
     +
    - 	return retval;
    + 	return recursive;
      }
      
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 3:  296ebacafe !  7:  725c4d0187 ls-tree.c: introduce struct "shown_data"
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    ls-tree.c: introduce struct "shown_data"
    +    ls-tree.c: introduce struct "show_tree_data"
     
    -    "show_data" is a struct that packages the necessary fields for
    -    reusing. This commit is a front-loaded commit for support
    -    "--format" argument and does not affect any existing functionality.
    +    "show_tree_data" is a struct that packages the necessary fields for
    +    "show_tree()". This commit is a pre-prepared commit for supporting
    +    "--format" option and it does not affect any existing functionality.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static unsigned int shown_bits;
    - #define SHOW_MODE (1 << 4)
    - #define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
    +@@ builtin/ls-tree.c: static unsigned int shown_fields;
    + #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
    + #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
      
    -+struct shown_data {
    ++struct show_tree_data {
     +	unsigned mode;
     +	enum object_type type;
     +	const struct object_id *oid;
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen,
     -static int show_default(const struct object_id *oid, enum object_type type,
     -			const char *pathname, unsigned mode,
     -			struct strbuf *base)
    -+static int show_default(struct shown_data *data)
    ++static int show_default(struct show_tree_data *data)
      {
     -	size_t baselen = base->len;
     +	size_t baselen = data->base->len;
      
    - 	if (shown_bits & SHOW_SIZE) {
    + 	if (shown_fields & FIELD_SIZE) {
      		char size_text[24];
     -		if (type == OBJ_BLOB) {
     +		if (data->type == OBJ_BLOB) {
    @@ builtin/ls-tree.c: static int show_default(const struct object_id *oid, enum obj
      
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
      {
    - 	int retval = 0;
    + 	int recursive = 0;
      	size_t baselen;
     -	enum object_type type = OBJ_BLOB;
    -+	struct shown_data data = {
    ++	struct show_tree_data data = {
     +		.mode = mode,
     +		.type = OBJ_BLOB,
     +		.oid = oid,
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     +		.base = base,
     +	};
      
    --	if (show_tree_init(&type, base, pathname, mode, &retval))
    -+	if (show_tree_init(&data.type, base, pathname, mode, &retval))
    - 		return retval;
    --
    - 	if (!(shown_bits ^ SHOW_OBJECT_NAME)) {
    - 		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
    - 		return retval;
    +-	init_type(mode, &type);
    ++	init_type(mode, &data.type);
    + 	init_recursive(base, pathname, &recursive);
    + 
    +-	if (type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
    ++	if (data.type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
    + 		return recursive;
    +-	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    ++	if (data.type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    + 		return !READ_TREE_RECURSIVE;
    + 
    + 	if (shown_fields == FIELD_OBJECT_NAME) {
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    + 	}
      
    - 	if (!(shown_bits ^ SHOW_DEFAULT) ||
    - 	    !(shown_bits ^ (SHOW_DEFAULT | SHOW_SIZE)))
    + 	if (shown_fields >= FIELD_DEFAULT)
     -		show_default(oid, type, pathname, mode, base);
     +		show_default(&data);
      
    - 	return retval;
    + 	return recursive;
      }
 4:  e0add802fb !  8:  7df58483a4 ls-tree.c: introduce "--format" option
    @@ Commit message
             Range (min … max):   328.8 ms … 349.4 ms    10 runs
     
         Links:
    -    [1] https://public-inbox.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/
    +            [1] https://public-inbox.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ Documentation/git-ls-tree.txt: quoted as explained for the configuration variabl
     +For example, if you want to only print the <object> and <file> fields with a
     +JSON style, executing with a specific "--format" like
     +
    -+		git ls-tree --format='{"object":"%(object)", "file":"%(file)"}' <tree-ish>
    ++        git ls-tree --format='{"object":"%(object)", "file":"%(file)"}' <tree-ish>
     +
     +The output format changes to:
     +
    -+		{"object":"<object>", "file":"<file>"}
    ++        {"object":"<object>", "file":"<file>"}
     +
     +FIELD NAMES
     +-----------
    @@ builtin/ls-tree.c: enum {
      
      static int cmdmode = MODE_UNSPECIFIED;
      
    --static int parse_shown_fields(void)
     +static const char *format;
     +static const char *default_format = "%(mode) %(type) %(object)%x09%(file)";
     +static const char *long_format = "%(mode) %(type) %(object) %(size:padded)%x09%(file)";
     +static const char *name_only_format = "%(file)";
     +static const char *object_only_format = "%(object)";
     +
    + static int parse_shown_fields(void)
    + {
    + 	if (cmdmode == MODE_NAME_ONLY) {
    +@@ builtin/ls-tree.c: static int parse_shown_fields(void)
    + 	return 1;
    + }
    + 
     +static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
     +			      const enum object_type type, unsigned int padded)
    - {
    --	if (cmdmode == MODE_NAME_ONLY) {
    --		shown_bits = SHOW_FILE_NAME;
    --		return 0;
    ++{
     +	if (type == OBJ_BLOB) {
     +		unsigned long size;
     +		if (oid_object_info(the_repository, oid, &size) < 0)
    @@ builtin/ls-tree.c: enum {
     +		strbuf_addf(line, "%7s", "-");
     +	} else {
     +		strbuf_addstr(line, "-");
    - 	}
    --	if (cmdmode == MODE_OBJECT_ONLY) {
    --		shown_bits = SHOW_OBJECT_NAME;
    --		return 0;
    ++	}
     +}
     +
     +static size_t expand_show_tree(struct strbuf *line, const char *start,
     +			       void *context)
     +{
    -+	struct shown_data *data = context;
    ++	struct show_tree_data *data = context;
     +	const char *end;
     +	const char *p;
     +	unsigned int errlen;
    -+	size_t len;
    -+	len = strbuf_expand_literal_cb(line, start, NULL);
    ++	size_t len = strbuf_expand_literal_cb(line, start, NULL);
    ++
     +	if (len)
     +		return len;
    -+
     +	if (*start != '(')
     +		die(_("bad ls-tree format: as '%s'"), start);
     +
    @@ builtin/ls-tree.c: enum {
     +	} else if (skip_prefix(start, "(size)", &p)) {
     +		expand_objectsize(line, data->oid, data->type, 0);
     +	} else if (skip_prefix(start, "(object)", &p)) {
    -+		strbuf_addstr(line, find_unique_abbrev(data->oid, abbrev));
    ++		strbuf_add_unique_abbrev(line, data->oid, abbrev);
     +	} else if (skip_prefix(start, "(file)", &p)) {
     +		const char *name = data->base->buf;
     +		const char *prefix = chomp_prefix ? ls_tree_prefix : NULL;
    @@ builtin/ls-tree.c: enum {
     +		strbuf_addstr(data->base, data->pathname);
     +		name = relative_path(data->base->buf, prefix, &sb);
     +		quote_c_style(name, &quoted, NULL, 0);
    -+		strbuf_addstr(line, quoted.buf);
    ++		strbuf_addbuf(line, &quoted);
    ++		strbuf_release(&sb);
    ++		strbuf_release(&quoted);
     +	} else {
     +		errlen = (unsigned long)len;
     +		die(_("bad ls-tree format: %%%.*s"), errlen, start);
    - 	}
    --	if (!ls_options || (ls_options & LS_RECURSIVE)
    --	    || (ls_options & LS_SHOW_TREES)
    --	    || (ls_options & LS_TREE_ONLY))
    --		shown_bits = SHOW_DEFAULT;
    --	if (cmdmode == MODE_LONG)
    --		shown_bits = SHOW_DEFAULT | SHOW_SIZE;
    --	return 1;
    ++	}
     +	return len;
    - }
    - 
    ++}
    ++
      static int show_recursive(const char *base, size_t baselen,
    + 			  const char *pathname)
    + {
     @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen,
      	return 0;
      }
      
    -+static int show_tree_init(enum object_type *type, struct strbuf *base,
    -+			  const char *pathname, unsigned mode, int *retval)
    ++static void init_recursive(struct strbuf *base, const char *pathname,
    ++				int *recursive)
     +{
    -+	if (S_ISGITLINK(mode)) {
    ++	if (show_recursive(base->buf, base->len, pathname))
    ++		*recursive = READ_TREE_RECURSIVE;
    ++}
    ++
    ++static void init_type(unsigned mode, enum object_type *type)
    ++{
    ++	if (S_ISGITLINK(mode))
     +		*type = OBJ_COMMIT;
    -+	} else if (S_ISDIR(mode)) {
    -+		if (show_recursive(base->buf, base->len, pathname)) {
    -+			*retval = READ_TREE_RECURSIVE;
    -+			if (!(ls_options & LS_SHOW_TREES))
    -+				return 1;
    -+		}
    ++	else if (S_ISDIR(mode))
     +		*type = OBJ_TREE;
    -+	}
    -+	else if (ls_options & LS_TREE_ONLY)
    -+		return 1;
    -+	return 0;
     +}
     +
     +static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
     +			 const char *pathname, unsigned mode, void *context)
     +{
     +	size_t baselen;
    -+	int retval = 0;
    ++	int recursive = 0;
     +	struct strbuf line = STRBUF_INIT;
    -+	struct shown_data data = {
    ++	struct show_tree_data data = {
     +		.mode = mode,
     +		.type = OBJ_BLOB,
     +		.oid = oid,
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen,
     +		.base = base,
     +	};
     +
    -+	if (show_tree_init(&data.type, base, pathname, mode, &retval))
    -+		return retval;
    ++	init_type(mode, &data.type);
    ++	init_recursive(base, pathname, &recursive);
    ++
    ++	if (data.type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
    ++		return recursive;
    ++	if (data.type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    ++		return !READ_TREE_RECURSIVE;
     +
     +	baselen = base->len;
     +	strbuf_expand(&line, format, expand_show_tree, &data);
     +	strbuf_addch(&line, line_termination);
     +	fwrite(line.buf, line.len, 1, stdout);
    ++	strbuf_release(&line);
     +	strbuf_setlen(base, baselen);
    -+	return retval;
    ++	return recursive;
     +}
     +
    -+static int parse_shown_fields(void)
    -+{
    -+	if (cmdmode == MODE_NAME_ONLY ||
    -+	    (format && !strcmp(format, name_only_format))) {
    -+		shown_bits = SHOW_FILE_NAME;
    -+		return 1;
    -+	}
    -+
    -+	if (cmdmode == MODE_OBJECT_ONLY ||
    -+	    (format && !strcmp(format, object_only_format))) {
    -+		shown_bits = SHOW_OBJECT_NAME;
    -+		return 1;
    -+	}
    -+
    -+	if (!ls_options || (ls_options & LS_RECURSIVE)
    -+	    || (ls_options & LS_SHOW_TREES)
    -+	    || (ls_options & LS_TREE_ONLY)
    -+		|| (format && !strcmp(format, default_format)))
    -+		shown_bits = SHOW_DEFAULT;
    -+
    -+	if (cmdmode == MODE_LONG ||
    -+		(format && !strcmp(format, long_format)))
    -+		shown_bits = SHOW_DEFAULT | SHOW_SIZE;
    -+	return 1;
    -+}
    -+
    - static int show_default(struct shown_data *data)
    + static int show_default(struct show_tree_data *data)
      {
      	size_t baselen = data->base->len;
    -@@ builtin/ls-tree.c: static int show_default(struct shown_data *data)
    +@@ builtin/ls-tree.c: static int show_default(struct show_tree_data *data)
      	return 1;
      }
      
    --static int show_tree_init(enum object_type *type, struct strbuf *base,
    --			  const char *pathname, unsigned mode, int *retval)
    +-static void init_type(unsigned mode, enum object_type *type)
     -{
    --	if (S_ISGITLINK(mode)) {
    +-	if (S_ISGITLINK(mode))
     -		*type = OBJ_COMMIT;
    --	} else if (S_ISDIR(mode)) {
    --		if (show_recursive(base->buf, base->len, pathname)) {
    --			*retval = READ_TREE_RECURSIVE;
    --			if (!(ls_options & LS_SHOW_TREES))
    --				return 1;
    --		}
    +-	else if (S_ISDIR(mode))
     -		*type = OBJ_TREE;
    --	}
    --	else if (ls_options & LS_TREE_ONLY)
    --		return 1;
    --	return 0;
    +-}
    +-
    +-static void init_recursive(struct strbuf *base, const char *pathname,
    +-				int *recursive)
    +-{
    +-	if (show_recursive(base->buf, base->len, pathname))
    +-		*recursive = READ_TREE_RECURSIVE;
     -}
     -
      static int show_tree(const struct object_id *oid, struct strbuf *base,
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
     +	 * The generic show_tree_fmt() is slower than show_tree(), so
     +	 * take the fast path if possible.
     +	 */
    -+	if (format && (!strcmp(format, default_format) ||
    -+				   !strcmp(format, long_format) ||
    -+				   !strcmp(format, name_only_format) ||
    -+				   !strcmp(format, object_only_format)))
    ++	if (format &&
    ++	    (!strcmp(format, default_format) ||
    ++	     !strcmp(format, long_format) ||
    ++	     !strcmp(format, name_only_format) ||
    ++	     !strcmp(format, object_only_format)))
     +		fn = show_tree;
     +	else if (format)
     +		fn = show_tree_fmt;
 -:  ---------- >  9:  8dafb2b377 cocci: allow padding with `strbuf_addf()`
-- 
2.33.0.rc1.1794.g2ae0a9cb82


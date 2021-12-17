Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42636C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 06:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhLQG5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 01:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLQG5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 01:57:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5FC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 22:57:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso4898941pji.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 22:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2IP7n1CL9PGJyoOwDEQNzclVX0x6QEsrmUdegBao+o=;
        b=bGQtvib+NaoVmIRY4sbWXlH2FnkxNJDU/7rVZw0WBAeRvrOKrtGvwfTu3Jp5CSRgzK
         RaYJ9drs3bXfxzm3lm+ehEXi67wW2RdPa7ykRFDy4mn/HKQbuvRZFDS8HSW5/412R7+J
         21nh5E4HJWjDmcjIe8j3FWThPDTC8bmQwyKNjoPu7worc3lASK0GWsskk2prgJ15/n2d
         7tTAHz6GlwB3mtDOeLKQute7PmARkNAFUrfB5VibUfQiMc1+dTkF87Mh44l7avJoDnRf
         IFRfOS8qnWZVdeLe/VGbuzbRPgkiHSqija3NAL6rsSzXOf5r8C990cfc7N2SLNp51oTu
         d4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2IP7n1CL9PGJyoOwDEQNzclVX0x6QEsrmUdegBao+o=;
        b=CzpW/w4fPrgH3lQu8dIyov+mvsNJLAptxPXJGSNTilPbRzbByVbfPzWSJq7Lf05F8Y
         WsE8GvC82cLWQv69WNE1Xz/11yK7JNAV7iVzN7gFErtKE6+wWu0/l7/+pf58iwZumLkU
         JX7kwoaDDEUISxkjrWVbQ9Tcv0b2B7grg3BvAv4xiGRCC9cBM5YsV8Y8gVUMF21p+l2L
         gWCo0RAuQrg8xiWDH9CPsgXsfTR6x4f3Z0RoWqvPkLVQ5ovL1f8t2i4GXwsqyDXu88WE
         xk9AI4XE9ndTrCFUAPlwJa0OjyOUnOyfbdxv6Bzi5fk4J9CAPpkM8MZ7MrxSaeqU6rho
         jZGA==
X-Gm-Message-State: AOAM533T8Mbte4fvnDzpHp7LPxynIitnhGxTbLH4eEDnah3ATICkjWcL
        QPDX/X/CjP/uI8N17Hqecfc=
X-Google-Smtp-Source: ABdhPJzS/pgJUBnmi+1CrF4YPxuCMPETnn7baCySVDLCWByKJrsbfHmMEK+r2HA+qhtCZzR7PeMGSg==
X-Received: by 2002:a17:90a:cb0d:: with SMTP id z13mr2220994pjt.89.1639724243465;
        Thu, 16 Dec 2021 22:57:23 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id b16sm7198952pgi.36.2021.12.16.22.57.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 22:57:22 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 0/1] support `--object-only` option for "git-ls-tree"
Date:   Fri, 17 Dec 2021 14:57:08 +0800
Message-Id: <cover.1639721750.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g5f17c1a2c1.dirty
In-Reply-To: <cover.1638891420.git.dyroneteng@gmail.com>
References: <cover.1638891420.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diffs from patch v5:

* Let "write_name_quoted_relative" support two terminations, they are
  "CQ_NO_TERMINATOR_C_QUOTED" and "CQ_NO_TERMINATOR_AS_IS" (They are
  used to let the function write "name" at a 'c_quoted' way or just
  'as-is', but without print a terminator).
  
* Rename "follow" to "interspace" (Representing whether any further
  output needs an inter-field space).

* Nits fixed.

Many thanks to Junio and Ævar for your help and patient explanation.
I noticed Ævar suggest the solution with using `--format`, but in
this patch, the current approach continues. If this part of code needs
to be improved or we want to support "--format" in "ls-tree" in the
future, I'm more than glad to continue to contribute.

Thanks.

Teng Long (1):
  ls-tree.c: support `--object-only` option for "git-ls-tree"

 Documentation/git-ls-tree.txt |   7 +-
 builtin/ls-tree.c             | 131 ++++++++++++++++++++++++----------
 quote.c                       |   8 +--
 quote.h                       |  19 +++++
 t/t3103-ls-tree-misc.sh       |   8 +++
 t/t3104-ls-tree-oid.sh        |  51 +++++++++++++
 6 files changed, 183 insertions(+), 41 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

Range-diff against v5:
1:  38d55a878c ! 1:  2e449d1c79 ls-tree.c: support `--object-only` option for "git-ls-tree"
    @@ builtin/ls-tree.c
     -#define LS_SHOW_TREES 4
     -#define LS_NAME_ONLY 8
     -#define LS_SHOW_SIZE 16
    -+#define LS_TREE_ONLY 1 << 1
    -+#define LS_SHOW_TREES 1 << 2
    -+#define LS_NAME_ONLY 1 << 3
    -+#define LS_SHOW_SIZE 1 << 4
    -+#define LS_OBJECT_ONLY 1 << 5
    ++#define LS_TREE_ONLY (1 << 1)
    ++#define LS_SHOW_TREES (1 << 2)
    ++#define LS_NAME_ONLY (1 << 3)
    ++#define LS_SHOW_SIZE (1 << 4)
    ++#define LS_OBJECT_ONLY (1 << 5)
      static int abbrev;
      static int ls_options;
      static struct pathspec pathspec;
      static int chomp_prefix;
      static const char *ls_tree_prefix;
    -+static unsigned int shown_bits = 0;
    -+#define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
    -+#define SHOW_MODE 1 << 4
    -+#define SHOW_TYPE 1 << 3
    -+#define SHOW_OBJECT_NAME 1 << 2
    -+#define SHOW_SIZE 1 << 1
    ++static unsigned int shown_bits;
     +#define SHOW_FILE_NAME 1
    ++#define SHOW_SIZE (1 << 1)
    ++#define SHOW_OBJECT_NAME (1 << 2)
    ++#define SHOW_TYPE (1 << 3)
    ++#define SHOW_MODE (1 << 4)
    ++#define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
      
      static const  char * const ls_tree_usage[] = {
      	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
    @@ builtin/ls-tree.c
     +	MODE_UNSPECIFIED = 0,
     +	MODE_NAME_ONLY,
     +	MODE_OBJECT_ONLY,
    -+	MODE_LONG
    ++	MODE_LONG,
     +};
     +
     +static int cmdmode = MODE_UNSPECIFIED;
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
      {
      	int retval = 0;
      	int baselen;
    -+	int follow = 0;
    ++	int interspace = 0;
      	const char *type = blob_type;
      
      	if (S_ISGITLINK(mode)) {
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -			       find_unique_abbrev(oid, abbrev),
     -			       size_text);
     +	if (shown_bits & SHOW_MODE) {
    -+		printf("%06o",mode);
    -+		follow = 1;
    ++		printf("%06o", mode);
    ++		interspace = 1;
     +	}
     +	if (shown_bits & SHOW_TYPE) {
    -+		printf("%s%s", follow == 1 ? " " : "", type);
    -+		follow = 1;
    ++		printf("%s%s", interspace ? " " : "", type);
    ++		interspace = 1;
     +	}
     +	if (shown_bits & SHOW_OBJECT_NAME) {
    -+		printf("%s%s", follow == 1 ? " " : "",
    ++		printf("%s%s", interspace ? " " : "",
     +		       find_unique_abbrev(oid, abbrev));
     +		if (!(shown_bits ^ SHOW_OBJECT_NAME))
    -+			printf("%c", line_termination);
    -+		follow = 1;
    ++			goto LINE_FINISH;
    ++		interspace = 1;
     +	}
     +	if (shown_bits & SHOW_SIZE) {
     +		char size_text[24];
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -			printf("%06o %s %s\t", mode, type,
     -			       find_unique_abbrev(oid, abbrev));
     +			xsnprintf(size_text, sizeof(size_text), "-");
    -+		printf("%s%7s", follow == 1 ? " " : "", size_text);
    -+		follow = 1;
    ++		printf("%s%7s", interspace ? " " : "", size_text);
    ++		interspace = 1;
     +	}
     +	if (shown_bits & SHOW_FILE_NAME) {
    -+		if (follow)
    ++		if (interspace)
     +			printf("\t");
     +		baselen = base->len;
     +		strbuf_addstr(base, pathname);
     +		write_name_quoted_relative(base->buf,
     +					   chomp_prefix ? ls_tree_prefix : NULL,
    -+					   stdout, line_termination);
    ++					   stdout,
    ++					   line_termination
    ++					   ? CQ_NO_TERMINATOR_C_QUOTED
    ++					   : CQ_NO_TERMINATOR_AS_IS);
     +		strbuf_setlen(base, baselen);
      	}
     -	baselen = base->len;
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -				   chomp_prefix ? ls_tree_prefix : NULL,
     -				   stdout, line_termination);
     -	strbuf_setlen(base, baselen);
    ++
    ++LINE_FINISH:
    ++	putchar(line_termination);
      	return retval;
      }
      
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      	 * show_recursive() rolls its own matching code and is
      	 * generally ignorant of 'struct pathspec'. The magic mask
     
    + ## quote.c ##
    +@@ quote.c: void quote_two_c_style(struct strbuf *sb, const char *prefix, const char *path,
    + 
    + void write_name_quoted(const char *name, FILE *fp, int terminator)
    + {
    +-	if (terminator) {
    ++	if (0 < terminator || terminator == CQ_NO_TERMINATOR_C_QUOTED)
    + 		quote_c_style(name, NULL, fp, 0);
    +-	} else {
    ++	else
    + 		fputs(name, fp);
    +-	}
    +-	fputc(terminator, fp);
    ++	if (0 <= terminator)
    ++		fputc(terminator, fp);
    + }
    + 
    + void write_name_quoted_relative(const char *name, const char *prefix,
    +
    + ## quote.h ##
    +@@ quote.h: int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
    + #define CQUOTE_NODQ 01
    + size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned);
    + void quote_two_c_style(struct strbuf *, const char *, const char *, unsigned);
    ++/*
    ++ * Write a name, typically a filename, followed by a terminator that
    ++ * separates it from what comes next.
    ++ * When terminator is NUL, the name is given as-is.  Otherwise, the
    ++ * name is c-quoted, suitable for text output.  HT and LF are typical
    ++ * values used for the terminator, but other positive values are possible.
    ++ *
    ++ * In addition to non-negative values two special values in terminator
    ++ * are possible.
    ++ *
    ++ * -1: show the name c-quoted, without adding any terminator.
    ++ * -2: show the name as-is, without adding any terminator.
    ++ */
    ++#define CQ_NO_TERMINATOR_C_QUOTED	(-1)
    ++#define CQ_NO_TERMINATOR_AS_IS		(-2)
    + 
    + void write_name_quoted(const char *name, FILE *, int terminator);
    ++/*
    ++ * Similar to the above, but the name is first made relative to the prefix
    ++ * before being shown.
    ++ */
    + void write_name_quoted_relative(const char *name, const char *prefix,
    + 				FILE *fp, int terminator);
    + 
    +
      ## t/t3103-ls-tree-misc.sh ##
     @@ t/t3103-ls-tree-misc.sh: test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
      	test_must_fail git ls-tree -r HEAD
-- 
2.33.1.10.g5f17c1a2c1.dirty


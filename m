Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD999EE49A4
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 09:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHTJAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjHTJAB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 05:00:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F227C3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso37287751fa.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521697; x=1693126497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlDb1U5K2a/xPp/A5ZZ4OQkHpGhsUqk1w6uwCHPZzC8=;
        b=mBP/o5hfazIx0jMcF+99aCnJI3hjmTf4JR5/Lt0LD2fbyjd3hZZJ8SHX0v7b/nDVLr
         BxSdP4E3ovuwDwO4HGJQm/rzTL8Lj0kQTzcpiHYCxRi/1PSJWEgZMb35lSGwS6uU0d0x
         7Bbs69I3uVbOiwU4zJbzYT6efZW+MupbfDAF9ac4CA0K8gVm9+8bypRwNvcdBZyq+Px+
         zAXLMaOCUy8cCC4SMWJct/O160KPTn3wiMgZQPzybUwE9vBhPP1MKrTLXMjtk/Dxcovq
         fArxXj6DPiHfWNavaCr0Vogu2RiMTVOzbzW8HyNNNV9G+wjt1NJT5NtHrtYg+9A1zVPR
         R6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521697; x=1693126497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlDb1U5K2a/xPp/A5ZZ4OQkHpGhsUqk1w6uwCHPZzC8=;
        b=f3VV9mHBWXVpzXHTKfnXmQQ6CyhZLnikX7opKJV9OK3w9kKZWwIuFU3+FX3qNne56u
         c+j2tkcqlo8LUqG9p+pUPU3HydgcebM9p2O+qABdodblb+wOmTLXMFUNRVg9osOASg6Q
         A4vD3grehv3HmWE1najtuSXliK5Sg9mg0l6qP/hZdG56hqaJw0uBIUYYursrOcvKXHl8
         4Xv6eWW9BhAFe0YjfuEhFhVJ7Aj6aTWfKtxrPGteYOFy7X1RMIG32BGsONiUxLrdJ/0t
         C9VKR4aYOEBTQRwR41/ql0Bbqu+j596/KMXXThjImoaojdPI8PnPA47J+aIwE5urZjqs
         5V8g==
X-Gm-Message-State: AOJu0YzE+vaDwjmiRYyW2IuDJdXBEauSHFl/tHtJe8vy2M1fs5xsxQQd
        oQMdQ9707t5dmDO0Ylx5VsMVEvmSBDQMfWPU
X-Google-Smtp-Source: AGHT+IFpMjvfN8Zp32US5eLnjolgvm72XINxUMCa1CQGVNVQwOhoHt+cswSZjWnSnQqVPOiK+MdGFg==
X-Received: by 2002:a2e:9896:0:b0:2b9:e53f:e1fd with SMTP id b22-20020a2e9896000000b002b9e53fe1fdmr2973281ljj.34.1692521697390;
        Sun, 20 Aug 2023 01:54:57 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:57 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 6/8] pretty: add %(decorate[:<options>]) format
Date:   Sun, 20 Aug 2023 09:53:34 +0100
Message-ID: <20230820085336.8615-7-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add %(decorate[:<options>]) format that lists ref names similarly to the
%d format, but which allows the otherwise fixed prefix, suffix and
separator strings to be customized. Omitted options default to the
strings used in %d.

Rename expand_separator() function used to expand %x literal formatting
codes to expand_string_arg(), as it is now used on strings other than
separators.

Examples:
- %(decorate) is equivalent to %d.
- %(decorate:prefix=,suffix=) is equivalent to %D.
- %(decorate:prefix=[,suffix=],separator=%x3B) produces a list enclosed
in square brackets and separated by semicolons.

Test the format in t4205-log-pretty-formats.sh and document it in
pretty-formats.txt.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/pretty-formats.txt | 10 +++++
 pretty.c                         | 72 ++++++++++++++++++++++++++++----
 t/t4205-log-pretty-formats.sh    | 27 ++++++++++++
 3 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 851a9878e6..709d85af21 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -224,6 +224,16 @@ The placeholders are:
 	linkgit:git-rev-list[1])
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
+'%(decorate[:<options>])'::
+ref names with custom decorations. The `decorate` string may be followed by a
+colon and zero or more comma-separated options. Option values may contain
+literal formatting codes. These must be used for commas (`%x2C`) and closing
+parentheses (`%x29`), due to their role in the option syntax.
++
+** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
+** 'suffix=<value>': Shown after the list of ref names.  Defaults to "`)`".
+** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
+
 '%(describe[:<options>])'::
 human-readable name, like linkgit:git-describe[1]; empty string for
 undescribable commits.  The `describe` string may be followed by a colon and
diff --git a/pretty.c b/pretty.c
index 24fb82a5a2..1639efe2f8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1252,8 +1252,8 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
 	return 0;
 }
 
-static struct strbuf *expand_separator(struct strbuf *sb,
-				       const char *argval, size_t arglen)
+static struct strbuf *expand_string_arg(struct strbuf *sb,
+					const char *argval, size_t arglen)
 {
 	char *fmt = xstrndup(argval, arglen);
 	const char *format = fmt;
@@ -1301,9 +1301,9 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 			opts->filter_data = filter_list;
 			opts->only_trailers = 1;
 		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argval, &arglen)) {
-			opts->separator = expand_separator(sepbuf, argval, arglen);
+			opts->separator = expand_string_arg(sepbuf, argval, arglen);
 		} else if (match_placeholder_arg_value(*arg, "key_value_separator", arg, &argval, &arglen)) {
-			opts->key_value_separator = expand_separator(kvsepbuf, argval, arglen);
+			opts->key_value_separator = expand_string_arg(kvsepbuf, argval, arglen);
 		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
 			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
 			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
@@ -1384,6 +1384,40 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 	return arg - start;
 }
 
+
+static int parse_decoration_option(const char **arg,
+				   const char *name,
+				   char **opt)
+{
+	const char *argval;
+	size_t arglen;
+
+	if (match_placeholder_arg_value(*arg, name, arg, &argval, &arglen)) {
+		struct strbuf sb = STRBUF_INIT;
+
+		expand_string_arg(&sb, argval, arglen);
+		*opt = strbuf_detach(&sb, NULL);
+		return 1;
+	}
+	return 0;
+}
+
+static void parse_decoration_options(const char **arg,
+				     struct decoration_options *opts)
+{
+	while (parse_decoration_option(arg, "prefix", &opts->prefix) ||
+	       parse_decoration_option(arg, "suffix", &opts->suffix) ||
+	       parse_decoration_option(arg, "separator", &opts->separator))
+		;
+}
+
+static void free_decoration_options(const struct decoration_options *opts)
+{
+	free(opts->prefix);
+	free(opts->suffix);
+	free(opts->separator);
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1540,10 +1574,15 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		format_decorations(sb, commit, c->auto_color, NULL);
 		return 1;
 	case 'D':
-		format_decorations(sb, commit, c->auto_color,
-			&(struct decoration_options){.prefix = "",
-						     .suffix = ""});
-		return 1;
+		{
+			const struct decoration_options opts = {
+				.prefix = "",
+				.suffix = ""
+			};
+
+			format_decorations(sb, commit, c->auto_color, &opts);
+			return 1;
+		}
 	case 'S':		/* tag/branch like --source */
 		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
 			return 0;
@@ -1640,6 +1679,23 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 2;
 	}
 
+	if (skip_prefix(placeholder, "(decorate", &arg)) {
+		struct decoration_options opts = { NULL };
+		size_t ret = 0;
+
+		if (*arg == ':') {
+			arg++;
+			parse_decoration_options(&arg, &opts);
+		}
+		if (*arg == ')') {
+			format_decorations(sb, commit, c->auto_color, &opts);
+			ret = arg - placeholder + 1;
+		}
+
+		free_decoration_options(&opts);
+		return ret;
+	}
+
 	/* For the rest we have to parse the commit header. */
 	if (!c->commit_header_parsed) {
 		msg = c->message =
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index dd9035aa38..6ba399c5be 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -576,6 +576,33 @@ test_expect_success 'clean log decoration' '
 	test_cmp expected actual1
 '
 
+test_expect_success 'pretty format %decorate' '
+	git checkout -b foo &&
+	git commit --allow-empty -m "new commit" &&
+	git tag bar &&
+	git branch qux &&
+
+	echo " (HEAD -> foo, tag: bar, qux)" >expect1 &&
+	git log --format="%(decorate)" -1 >actual1 &&
+	test_cmp expect1 actual1 &&
+
+	echo "HEAD -> foo, tag: bar, qux" >expect2 &&
+	git log --format="%(decorate:prefix=,suffix=)" -1 >actual2 &&
+	test_cmp expect2 actual2 &&
+
+	echo "[ HEAD -> foo; tag: bar; qux ]" >expect3 &&
+	git log --format="%(decorate:prefix=[ ,suffix= ],separator=%x3B )" \
+		-1 >actual3 &&
+	test_cmp expect3 actual3 &&
+
+	# Try with a typo (in "separator"), in which case the placeholder should
+	# not be replaced.
+	echo "%(decorate:prefix=[ ,suffix= ],separater=; )" >expect4 &&
+	git log --format="%(decorate:prefix=[ ,suffix= ],separater=%x3B )" \
+		-1 >actual4 &&
+	test_cmp expect4 actual4
+'
+
 cat >trailers <<EOF
 Signed-off-by: A U Thor <author@example.com>
 Acked-by: A U Thor <author@example.com>
-- 
2.42.0-rc2


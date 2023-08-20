Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFEEE49A8
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjHTS4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjHTS4A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:56:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67FF0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe9c20f449so25032665e9.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557456; x=1693162256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0fiMko5ylii7u2eXPnj2epzyNgneMAvv4Jp67l+SM4=;
        b=lofbjLjcS3hjr9eHicjFHbf60/2+qXIy4mpwbfW27S8sCg0ilFqN5qmWAK4YHOptZk
         A8ywEsoFI+lTl/fo9llNVAMbCeAYInbJQ9J8Q9K8EBpj0lEy3DkwMEDoKx7rlX3MmaOc
         kh1B7jbddK7kR8gqFL0EJqyHYqKJSV2vnsHz5gBkBasZ/qdYtGemhV7GZQsK9f1vBfXg
         GwskJHsA82awQtvITP0hDRUKpy2tFzw/v/iUn6L63fsht1PZUFbftnu4vipwAyYpudNu
         DVFPO58G7bk3SD8rz4VR5YQHia2LaJLeBS5C2tTjb0z1iAmUwpfgYwcfO/FGZZraHonW
         9iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557456; x=1693162256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0fiMko5ylii7u2eXPnj2epzyNgneMAvv4Jp67l+SM4=;
        b=l4bI9smLV6ouh1JKjWLNBCp8uwAKXipru0/ZVLHSKe7qoI9bjQ8d9vcyj2Cb7ekEao
         ATwzTj5YbQyQ7+pklc3jCw9CzES/3T3kmFobV15HTU0AVTJ/MbunpB5p19XTETj0X794
         c5bydHL0N7TBpWfEUB4W3TuU7DKaX9QTluFemDj65lCMdQBiRj/yW1dRo8BxXQ0im/VG
         DZ3djj3MG8P4frRWndAV0n7OGgWRpWWeZmw/tCAW1OkwUXLYCUI5oO0BT9GXal3Tymoq
         uEQcNmkcF+ro0M5agqKP/59jAnQpiz579///t4A4irtLt27GoJDN4rqR4tu3jrlOr88c
         X/aQ==
X-Gm-Message-State: AOJu0YxQz/KRnhicsrOxghxrzX+vZKc5PYCIZp71qA3Si4iEHhYkeX4B
        oFa+KgXbwZfbx+lthYqQmTtoe3PDdf1aFtE4
X-Google-Smtp-Source: AGHT+IGenZkh69nNxGcAto73m1fzGGT1Wy9v+4cEgZ0mqc7tPE8hejbe4wF2zovyEqwluxUw0ep10w==
X-Received: by 2002:a05:600c:3799:b0:3fe:5053:1a0b with SMTP id o25-20020a05600c379900b003fe50531a0bmr3690392wmr.11.1692557456577;
        Sun, 20 Aug 2023 11:50:56 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:56 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 6/8] pretty: add %(decorate[:<options>]) format
Date:   Sun, 20 Aug 2023 19:50:07 +0100
Message-ID: <20230820185009.20095-7-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
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
 Documentation/pretty-formats.txt | 10 ++++++
 pretty.c                         | 59 +++++++++++++++++++++++++++++---
 t/t4205-log-pretty-formats.sh    | 27 +++++++++++++++
 3 files changed, 92 insertions(+), 4 deletions(-)

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
index 69b6db3340..1639efe2f8 100644
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
@@ -1645,6 +1679,23 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
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


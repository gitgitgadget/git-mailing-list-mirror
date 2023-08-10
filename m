Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E74C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjHJVRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHJVRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAAB2737
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so11892665e9.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702224; x=1692307024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5jdDghUh+ntpNaTgiUA1G9d3WmUYHo8Y8TrvRAc3/k=;
        b=RvWEEwjzjIX/5M/8h9Hm+IUsYiuc0mgx9Nhou040EiQ548CeHoDnLPudUB43sSzxDz
         wXful6m5NO9hE2o1/DDWYUWiydWv6pVprvBRmtJdvXZTp159/bBdcT+BsMf0pyPW48wf
         u529vhYNgk5JXswkfokT48aqmi5TaQOKuXAOrggxmho3SEXq7yQxcOM0F7Uspbxfjwwi
         AzfaEmwzJh9OaAHkogZg4qWZFEwtraSR4l10pDlC4LPLUMdRtG/ZAtI2Y3Ix7XAhzWVf
         J+gTkvL6qzPUNGrNaFgwtuz2jRWkm/Zvf/O+ohsdybI7olaYf8jTwHKp2MjFgKGfYIdk
         octw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702224; x=1692307024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5jdDghUh+ntpNaTgiUA1G9d3WmUYHo8Y8TrvRAc3/k=;
        b=MGPcMzqNv+0WymQMRujtO5qNXBeY85L5ho3pN/HjmBgqgdkCLLn/vQ30IcvQji9eSF
         96yGDzSdyBYxqcROFHsZuCrFUJhoVkrnbb+w+kV9gWbeSbcXlRAZySR1vD3pIdGqLO0V
         fIT0eYXl8EWkuJGLbAKfMjN5rfv2OJxV+foPlGPtgudpWluScpSHA8dKzBN5H1GmWn9E
         GKTZsz9w54w4jHOmyeKFcc/JMrFeWXLKKzMlyKPO+fgF9wAwBIYnJa5kvu0QhGtH91bu
         wCoFp6TPH9I4AgI4mHzq0mvcI6WlKH/sAKh3M42nWOTm1JhzXj+VyRNxozhAWJe/Q3jz
         xMAw==
X-Gm-Message-State: AOJu0YxyuMgOOc0jAV3ygmy8+0UVOpNr8AsvcUGA58Sp1569VZ0cpzJh
        HQH0nyjsYSj28q6Kp5vS34G6S2GZ123weQ==
X-Google-Smtp-Source: AGHT+IHOUe29WINjDlgEj2Jh56oR9zMN1KbGJRj+N2Q8QRAyxaToIjoK4GFryZeSQCPXLlZeAaiHmQ==
X-Received: by 2002:a05:600c:259:b0:3fe:2102:8083 with SMTP id 25-20020a05600c025900b003fe21028083mr37407wmj.26.1691702223692;
        Thu, 10 Aug 2023 14:17:03 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm3169864wmf.41.2023.08.10.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:17:03 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 6/7] pretty: add %(decorate[:<options>]) format
Date:   Thu, 10 Aug 2023 22:16:18 +0100
Message-ID: <20230810211619.19055-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230810211619.19055-1-andy.koppe@gmail.com>
References: <20230715160730.4046-1-andy.koppe@gmail.com>
 <20230810211619.19055-1-andy.koppe@gmail.com>
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
index 24fb82a5a2..d972051543 100644
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
@@ -1640,6 +1674,23 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
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
2.42.0-rc1


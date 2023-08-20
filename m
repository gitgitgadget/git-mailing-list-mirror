Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811ACEE4996
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjHTS4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHTS4B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:56:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D4FF1
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so24838445e9.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557457; x=1693162257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK4dJKHnsgQTHz6D/V7urLIMYM3bYVHGa4CBQy0UjKc=;
        b=BPNhiybuEcbX16mkc/0Jr6AqHADO9qRfvG1MVNwISS6uqhrnoA1vx2TlJnDhx96Lki
         kfAqYZ9slZ25rrfzDVkne9Od/Nad2IZHwKBjhRcG7rJPyWhh1snZlKPndxd/D3KIg/rY
         s3ddX/tQymVFOhseTWp8alFyTC2ObMnrnWobqhzB5qhnhiRj/AGp8TyA1HYZ3UB27kkJ
         H31bbRYGz9AEsoqdbPP9gNCt4OxSzT9Q/zZdSoRM1jD5nHunrxj+EMykU7wDyd8IeYUY
         ot+M+iXLRbu3iJ1KagIsGkRNtJd0N1x/w9cP+ypl9euBPKMl4tJOCbc94rOy34YMiQdD
         Z/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557457; x=1693162257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK4dJKHnsgQTHz6D/V7urLIMYM3bYVHGa4CBQy0UjKc=;
        b=SAu3kXtbriWdU1ODrpxD5CqgHH+9DalTRCMbHViVhwP34/nu+VJzwKSc1x2spker/Q
         eb5VDa9GIc+VQ+5Mxl8ufkiS6X7PLvFASsxoS49OD7KsUOBRnO9ifG+XEoLG3BfMcyNJ
         E/YQ4vtD3eGWMIHuCRof2NIHcReJzKCtk/+DJckU+Xp2JDeJGwcARpnuvwfPNk6iDbFM
         odJ0sQJbODkQIJZIWxFc5VMZ/IS3PtYgFLPq/s+CKvb7xW6uFew0DugkNqmuno6sQUP7
         WowJKgpI7otN0bM4qQA1xhJIkM8C2KAbZ1Yat/1ifcB2eUxrk0TX+ldsdKdbFnlVXPXD
         6U1Q==
X-Gm-Message-State: AOJu0YzV9pBwSlEwPEPHM7t5H0Ggu5IeO/B7vqq3Thl4Y97TWO3WZETm
        ZfFc12xtulFC+Z5gtEuPTyavgxTA74+AvmFQ
X-Google-Smtp-Source: AGHT+IGu6HAvhIzGTM07uAWO7hzkUKZ9kreD6LCRzbLCsznnF3810SMhQUx9/nld1r+tuu/s8UMoHA==
X-Received: by 2002:a1c:6a16:0:b0:3fb:ff57:1750 with SMTP id f22-20020a1c6a16000000b003fbff571750mr3647127wmc.32.1692557457230;
        Sun, 20 Aug 2023 11:50:57 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:56 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 7/8] pretty: add pointer and tag options to %(decorate)
Date:   Sun, 20 Aug 2023 19:50:08 +0100
Message-ID: <20230820185009.20095-8-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add pointer and tag options to %(decorate) format, to allow to override
the " -> " string used to show where HEAD points and the "tag: " string
used to mark tags.

Document in pretty-formats.txt and test in t4205-log-pretty-formats.sh.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/pretty-formats.txt |  9 +++++++++
 log-tree.c                       | 12 +++++++++---
 log-tree.h                       |  2 ++
 pretty.c                         |  6 +++++-
 t/t4205-log-pretty-formats.sh    |  7 ++++++-
 5 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 709d85af21..d38b4ab566 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -233,6 +233,15 @@ parentheses (`%x29`), due to their role in the option syntax.
 ** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
 ** 'suffix=<value>': Shown after the list of ref names.  Defaults to "`)`".
 ** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
+** 'pointer=<value>': Shown between HEAD and the branch it points to, if any.
+		      Defaults to "{nbsp}`->`{nbsp}".
+** 'tag=<value>': Shown before tag names. Defaults to "`tag:`{nbsp}".
+
++
+For example, to produce decorations with no wrapping
+or tag annotations, and spaces as separators:
++
+`%(decorate:prefix=,suffix=,tag=,separator= )`
 
 '%(describe[:<options>])'::
 human-readable name, like linkgit:git-describe[1]; empty string for
diff --git a/log-tree.c b/log-tree.c
index 44f4693567..50b4850eda 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -317,6 +317,8 @@ void format_decorations(struct strbuf *sb,
 	const char *prefix = " (";
 	const char *suffix = ")";
 	const char *separator = ", ";
+	const char *pointer = " -> ";
+	const char *tag = "tag: ";
 
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
@@ -329,6 +331,10 @@ void format_decorations(struct strbuf *sb,
 			suffix = opts->suffix;
 		if (opts->separator)
 			separator = opts->separator;
+		if (opts->pointer)
+			pointer = opts->pointer;
+		if (opts->tag)
+			tag = opts->tag;
 	}
 
 	color_commit = diff_get_color(use_color, DIFF_COMMIT);
@@ -351,9 +357,9 @@ void format_decorations(struct strbuf *sb,
 				strbuf_addstr(sb, color_reset);
 			}
 
-			if (decoration->type == DECORATION_REF_TAG) {
+			if (*tag && decoration->type == DECORATION_REF_TAG) {
 				strbuf_addstr(sb, color);
-				strbuf_addstr(sb, "tag: ");
+				strbuf_addstr(sb, tag);
 				strbuf_addstr(sb, color_reset);
 			}
 
@@ -364,7 +370,7 @@ void format_decorations(struct strbuf *sb,
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
 				strbuf_addstr(sb, color);
-				strbuf_addstr(sb, " -> ");
+				strbuf_addstr(sb, pointer);
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
 				show_name(sb, current_and_HEAD);
diff --git a/log-tree.h b/log-tree.h
index 14898de8ac..41c776fea5 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -17,6 +17,8 @@ struct decoration_options {
 	char *prefix;
 	char *suffix;
 	char *separator;
+	char *pointer;
+	char *tag;
 };
 
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
diff --git a/pretty.c b/pretty.c
index 1639efe2f8..7f3abb676c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1407,7 +1407,9 @@ static void parse_decoration_options(const char **arg,
 {
 	while (parse_decoration_option(arg, "prefix", &opts->prefix) ||
 	       parse_decoration_option(arg, "suffix", &opts->suffix) ||
-	       parse_decoration_option(arg, "separator", &opts->separator))
+	       parse_decoration_option(arg, "separator", &opts->separator) ||
+	       parse_decoration_option(arg, "pointer", &opts->pointer) ||
+	       parse_decoration_option(arg, "tag", &opts->tag))
 		;
 }
 
@@ -1416,6 +1418,8 @@ static void free_decoration_options(const struct decoration_options *opts)
 	free(opts->prefix);
 	free(opts->suffix);
 	free(opts->separator);
+	free(opts->pointer);
+	free(opts->tag);
 }
 
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 6ba399c5be..16626e4fe9 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -600,7 +600,12 @@ test_expect_success 'pretty format %decorate' '
 	echo "%(decorate:prefix=[ ,suffix= ],separater=; )" >expect4 &&
 	git log --format="%(decorate:prefix=[ ,suffix= ],separater=%x3B )" \
 		-1 >actual4 &&
-	test_cmp expect4 actual4
+	test_cmp expect4 actual4 &&
+
+	echo "HEAD->foo bar qux" >expect5 &&
+	git log --format="%(decorate:prefix=,suffix=,separator= ,tag=,pointer=->)" \
+		-1 >actual5 &&
+	test_cmp expect5 actual5
 '
 
 cat >trailers <<EOF
-- 
2.42.0-rc2


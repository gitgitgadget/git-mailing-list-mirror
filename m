Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37187EE49A4
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 09:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjHTJAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjHTJAE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 05:00:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E3DF5
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c3df710bdso130062f8f.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521698; x=1693126498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK4dJKHnsgQTHz6D/V7urLIMYM3bYVHGa4CBQy0UjKc=;
        b=QeOsOi8q1055V+UGOKy0yf8uaoO24yPIkEfNd5PjYukmG1b/4/tyRUcyR5joHIKmk2
         8Rz9DLWznBG8IBDQfBvaW02J8Fgjh0BWTmXZqEmHgAI14IuSqDnuFgBFh/56HtWu7Jyq
         mgUbPoLtajnBmi1X9CSQt1nlib5nlwsIWEk/atrl0CJDPs5rXh3TsQH9TWQhBUwSzkrG
         a883EFg4lFWDZ7iJ6i1d7TiTlIQQQDgTbl5zlKOdNY8PwCcmcjLbqzxNAtBtRo/Ljqnw
         PkzdjRmkz2F+3ltU/AEiG0STrT4GtovGcJhnYwcp2fY9JsgfwplVeyVYIJnFAZ8xJwmI
         05Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521698; x=1693126498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK4dJKHnsgQTHz6D/V7urLIMYM3bYVHGa4CBQy0UjKc=;
        b=K1EnayFZzSB2rQzZ6Wqsw2KCJn7v+i3nWHFPR1Ham9Nyj37gF6OsdkS9usW9KvnyNW
         0sW+dK/oMnkKcJmbG9iZok4BT3GcA9+lEzh9WBhb1rgGjgGCRqEg6Aos8KNwpkP53SOX
         mg/uQ4cb4nhe150SLuqJ1aBi0z3ltE1SQybhfvS/w0YtzK9GotlWTvBEfd+3hxAHI+MZ
         WfQyVsvQ6NtKsj2ukw8dzGYRPe/LIxGm103D3ND84eAbLf2kjdqXeMp7+gqCeK+/tHo7
         WdDYfOzR99F4TcXogjUQJ8NjdvykR1NDY7pX7iMEEQBIuMUC9xh4FOMxH9PmOMZTsj7L
         mmaA==
X-Gm-Message-State: AOJu0Yzc7V+hN+qAJoP5U/NnQk0lg0tNv1uey+3IIRQklkctAthPlGZ1
        U/dhlwb2vy86weWdUt7emXz+n2zrXq8wrGaS
X-Google-Smtp-Source: AGHT+IGPLRPE8qe7cfUknurzsmifK+xJRuiZ6Lp2cVmnh/yNbn9LYatJBf+UbzTraer08X7EsFf7nQ==
X-Received: by 2002:a5d:494c:0:b0:314:1ce9:3c86 with SMTP id r12-20020a5d494c000000b003141ce93c86mr2772105wrs.0.1692521698396;
        Sun, 20 Aug 2023 01:54:58 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:58 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 7/8] pretty: add pointer and tag options to %(decorate)
Date:   Sun, 20 Aug 2023 09:53:35 +0100
Message-ID: <20230820085336.8615-8-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
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


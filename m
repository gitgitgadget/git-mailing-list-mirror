Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985BDC001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHJVRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHJVRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5402738
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so12119075e9.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702224; x=1692307024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa3zRENbvH4ytqyYszeqvnw3rUiLuRWy51egRlc9+Tc=;
        b=aiHKnvrujRnl/F+GuBgqiUwxtgtKajJF4jL6+k2LQKHq5TRtAW/UtIfB/03iRKSUPp
         pEVIYFRmXhtOwUdmXWHOGG2WxOI9MV30uBwKa77kKezqaz/sum6lrJY7X154+0IFPCHD
         mq3U3iF2E0thzLngONhZzVaDZY4cZ53Z4w8svrJTpAhrZkNNrQToMDptpbCd4Mo/aSNv
         ljturMsHrPHFhHDkBrgHIcMrJZP9cbKaFHSQJorOX2ts60+7oSXzbBcBakbSWhO4CbDR
         eB75l6NJbxyVdPoSft75rJmyaY4tflf7j1y3bMSiKj+BCgJPkdpb7uIQwGsKnri/O/zA
         AusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702224; x=1692307024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa3zRENbvH4ytqyYszeqvnw3rUiLuRWy51egRlc9+Tc=;
        b=JGhOKk0XKWs2dgoJjn/VZnxeaOZTm5t2mj2AduCWF27a4BB+x9CKIWCsPQ1NWkY294
         orL8mExd3mXvec3MloYWrgSVRwYrNLRcbH7kYw9rg9wjyG0Kkc56/SMngeXXnznmEce5
         8B4/4gaSExZeOe9iKx3s2hCEffIk+Hz3k304k2hMCyBZJmu8m2HH9MOKuPpbSezZUFpR
         dN8azNkNY0D9DehgU+QQxE6+9VL18WC2Car6CpgI6F4WPk60WH8jzLJD/iRiXWDJ2ASs
         kcHVKqtL0hsILQkyvyig44yjUE1Ftkwuw+zG4IU13/s7Njtt+9bJvnQpvUBiYB+usQZb
         ieJQ==
X-Gm-Message-State: AOJu0YyVjwXOfoGlVEsW7/hHz4z8s4qAQqiqHbOix+E/qzP4W4KXyw3V
        cWS+UiCWCQA/xSPXXIKGoUAjiyZNai7umA==
X-Google-Smtp-Source: AGHT+IE+PB6ZikPnBlTQKStbiwvV6eJRd4M0tKXc+rDjkX4u23PI2+4wEp/pVfXIoYpw/sRovqUPTg==
X-Received: by 2002:a05:600c:2482:b0:3fc:5bcc:a909 with SMTP id 2-20020a05600c248200b003fc5bcca909mr102378wms.2.1691702224428;
        Thu, 10 Aug 2023 14:17:04 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm3169864wmf.41.2023.08.10.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:17:04 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 7/7] pretty: add pointer and tag options to %(decorate)
Date:   Thu, 10 Aug 2023 22:16:19 +0100
Message-ID: <20230810211619.19055-7-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230810211619.19055-1-andy.koppe@gmail.com>
References: <20230715160730.4046-1-andy.koppe@gmail.com>
 <20230810211619.19055-1-andy.koppe@gmail.com>
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
index 3b62dca048..504da6b519 100644
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
 				strbuf_addstr(sb, color_commit);
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
index d972051543..5effbe9ad9 100644
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
2.42.0-rc1


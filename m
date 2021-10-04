Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E9C43219
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261EF6124F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhJDAsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhJDAsG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB4C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so17894995wmc.0
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dhk3sduOucoBBuG8GZdIrjhofCoKSIqDQ2p2Rot2YDE=;
        b=Mx05rYPHWHKwfDpuXY2zujcreKFywStH/PeP8aQ0NCRwQ9PmJNX1pie9KZfTxvN6HF
         4MmXebzTRhjZJHQsg8FaDVFf9cP3Y27ZXx1FsAbVqwvlFFW2YBrkxFT6mhGHrYhPLlkc
         WXTRr3ytqNvqOjbNymfaZP/mbX93zCN4ia1M2aqwxi3PeaHTclQMTxx7xesQCSuhquxy
         WljPwQTYgG6dz7HKQqIJ7O4ee5L6S3EUc5YjrmmhxYM+Rxhw5U8wghKTbp4c0ZTzht/L
         Qt2BBw4GYKjW60zo99HUUf6LjM+pOPpKJPxIJZm9QGmhVSLJHgEctH4J9S5FItHNax0P
         K6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dhk3sduOucoBBuG8GZdIrjhofCoKSIqDQ2p2Rot2YDE=;
        b=AVCLb5JRiY86xJmbjDupH3KkG1UDoVRonC8b49GPhfG83LaG0dKOCydNb6hCEEWX4D
         qNAn89YlNj+0J/1yGY3GA1SDb/6lAhhnI3hQ+OL7Paqb7xdwnFpz8JABTyQqclZbNU7p
         UgqG4l9TIhh+ywK4NEFel2XCQ8cje24zBbMhqfjbVcpJtTS4PH5TBVqScP+nVKOj68ek
         Dy1dzVmc1eEfSLcqviE3+Hfkq5p3GDmxTMiSBWU6ZAF+iSxTnFhG/uISOAVAhdpvEEx2
         jgF6Ge/Q6f6i4IACL58CfIXtzq1sfGstSkATpHsSZ+KTguVNmFdIQGhzVaSGXdGSUDW+
         ddyw==
X-Gm-Message-State: AOAM532a1YqsoutZOYFC4+ojfH95VBSxOFHDlITo6j+UAQchRZf+BoHA
        rcldHTGBztAeL8mzKXqAnpZgSk4f9liiVw==
X-Google-Smtp-Source: ABdhPJwQUnA1iMa0HQmLqb2qbXzZIuFi+7PdOh382EYa2CoIXdEO0gcmtk2tr1dcmxEAKUl+JKlX9Q==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr16187239wmh.140.1633308376900;
        Sun, 03 Oct 2021 17:46:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] merge-recursive.c: call a new unpack_trees_options_init() function
Date:   Mon,  4 Oct 2021 02:46:03 +0200
Message-Id: <patch-02.10-050399cbfbf-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit we introduced a new UNPACK_TREES_OPTIONS_INIT
macro, but "merge-recursive.c" could not be converted to it since
it (re-)initializes a "struct unpack_trees_options" on the heap.

In order to convert use the macro as the source of truth for
initialization we need to not only convert the initialization in
unpack_trees_start(), but also call the new
unpack_trees_options_init() just after the CALLOC_ARRAY() in
merge_start().

When we call merge_trees() we'll call merge_start() followed by
merge_trees_internal(), and it will call unpack_trees_start() before
it does much of anything. So it's covered by an initialization in
unpack_trees_start().

But when merge_recursive() is called it will call merge_start()
followed by merge_recursive_internal(), which won't call
unpack_trees_start() until its own call call to
merge_trees_internal(), but in the meantime it might end up using that
calloc'd "struct unpack_trees_options".

This was OK before, as setup_unpack_trees_porcelain() would call
strvec_init(), and our "struct dir_struct" in turn is OK with being
NULL'd. Let's convert the former to macro initialization, we'll deal
with the latter in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-recursive.c | 3 ++-
 unpack-trees.c    | 8 ++++++--
 unpack-trees.h    | 5 ++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e594d4c3fa1..d24a4903f1d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -405,7 +405,7 @@ static int unpack_trees_start(struct merge_options *opt,
 	struct tree_desc t[3];
 	struct index_state tmp_index = { NULL };
 
-	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
+	unpack_trees_options_init(&opt->priv->unpack_opts);
 	if (opt->priv->call_depth)
 		opt->priv->unpack_opts.index_only = 1;
 	else
@@ -3704,6 +3704,7 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 	CALLOC_ARRAY(opt->priv, 1);
 	string_list_init_dup(&opt->priv->df_conflict_file_set);
+	unpack_trees_options_init(&opt->priv->unpack_opts);
 	return 0;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 8ea0a542da8..393c1f35a5d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -108,8 +108,6 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	const char **msgs = opts->msgs;
 	const char *msg;
 
-	strvec_init(&opts->msgs_to_free);
-
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
@@ -189,6 +187,12 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		opts->unpack_rejects[i].strdup_strings = 1;
 }
 
+void unpack_trees_options_init(struct unpack_trees_options *o)
+{
+	struct unpack_trees_options blank = UNPACK_TREES_OPTIONS_INIT;
+	memcpy(o, &blank, sizeof(*o));
+}
+
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
 	strvec_clear(&opts->msgs_to_free);
diff --git a/unpack-trees.h b/unpack-trees.h
index ecf256cbcea..892b65ea623 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -91,7 +91,10 @@ struct unpack_trees_options {
 	struct checkout_metadata meta;
 };
 
-#define UNPACK_TREES_OPTIONS_INIT { 0 }
+#define UNPACK_TREES_OPTIONS_INIT { \
+	.msgs_to_free = STRVEC_INIT, \
+}
+void unpack_trees_options_init(struct unpack_trees_options *o);
 
 int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
-- 
2.33.0.1404.g83021034c5d


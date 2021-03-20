Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688FAC433E3
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442B61936
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCTWio (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCTWiR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F6C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g25so7392882wmh.0
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQ1zJhwHIJ7cjy6KjIaIobQ2Xqg8kbOZoXQJPv17mAY=;
        b=UvzxxzhYbcmMtXoAvVafojCPBCxVRxytZb1MWduyv4WYsezxe2rQ2LFcw0K8uVw+dH
         kA3XKofb+UfHr9liPTXVCQZRzzTgY+wZqYjIzEebgHcw5YUkadzMapd9SLQIGnWfXuks
         PbfyHeVTm4l08T7WZrE3AH5Mn3no6UfTXWc+/2T8UM7I6HsBRw/y4wj/wGNyO8v3fvWp
         BB7bfaozAEP/e1RkNORHi91uUDUhMFJcUR9/rZCAto6u5diqi9cFidKkUfdBy6nMqiA5
         YQkDvN84EX/FLJru1WEavm16sup6XXdLaJsdu6UUKMTaJJCH3UXxPgjRjCxP3spHPFr0
         lJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQ1zJhwHIJ7cjy6KjIaIobQ2Xqg8kbOZoXQJPv17mAY=;
        b=D2Y5oE9oH+4B2fmMQFBCJtw6bpc8QUOs93nqNYBWTXR1jR6zMuGQbOVXgJkHbt7PR3
         J7uG8U2im5DM9welC+mp3A7bfGW/D1JWjrvXXW0qSHZka0qF1Lc1d2hVNgkpY/AJIv1r
         z4Z/3EpZ9YEuO+2f2tMkyaZOoIC0n2TXOCt9wie/mvghGYQi+lIpxYBPNf8T3uYnWOsP
         LrM2xfR8sSdQndyWdHlWcWq55ULzQN/hJACw/F2lFZweZ+8/5Lo80/UIAPxHNWegtuq5
         DXhK/+phJJloYhqR5SAUuDLOWT/P9OCtGdep/S8MaNtUEjhCoFVqgtTYZKB85dbzwfue
         pTpg==
X-Gm-Message-State: AOAM530qASF5DDg0lQIE/DZkmaPbOwQJT5FBrVpi8PZAGd+Jmro0e7MJ
        BULA9twXRPGciKuyPF13Wkl1uJeLy/oNgw==
X-Google-Smtp-Source: ABdhPJx9kp5oXl8BUqNR1l+/txB4Nlf9r22XiKqyWUHMP6Aw787SML+yI+kkmneZVTbSpdZJrElySQ==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr9284208wmj.152.1616279895743;
        Sat, 20 Mar 2021 15:38:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/8] archive: stop passing "stage" through read_tree_recursive()
Date:   Sat, 20 Mar 2021 23:37:49 +0100
Message-Id: <02c42be924953e7172639a82d8005bcb664bb8b4.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "stage" variable being passed around in the archive code has only
ever been an elaborate way to hardcode the value "0".

This code was added in its original form in e4fbbfe9ecc (Add
git-zip-tree, 2006-08-26), at which point a hardcoded "0" would be
passed down through read_tree_recursive() to write_zip_entry().

It was then diligently added to the "struct directory" in
ed22b4173bd (archive: support filtering paths with glob, 2014-09-21),
but we were still not doing anything except passing it around as-is.

Let's stop doing that in the code internal to archive.c, we'll still
feed "0" to read_tree_recursive() itself, but won't use it. That we're
providing it at all to read_tree_recursive() will be changed in a
follow-up commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 5919d9e5050..4f271331543 100644
--- a/archive.c
+++ b/archive.c
@@ -107,7 +107,6 @@ struct directory {
 	struct object_id oid;
 	int baselen, len;
 	unsigned mode;
-	int stage;
 	char path[FLEX_ARRAY];
 };
 
@@ -138,7 +137,7 @@ static int check_attr_export_subst(const struct attr_check *check)
 }
 
 static int write_archive_entry(const struct object_id *oid, const char *base,
-		int baselen, const char *filename, unsigned mode, int stage,
+		int baselen, const char *filename, unsigned mode,
 		void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
@@ -197,7 +196,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 static void queue_directory(const unsigned char *sha1,
 		struct strbuf *base, const char *filename,
-		unsigned mode, int stage, struct archiver_context *c)
+		unsigned mode, struct archiver_context *c)
 {
 	struct directory *d;
 	size_t len = st_add4(base->len, 1, strlen(filename), 1);
@@ -205,7 +204,6 @@ static void queue_directory(const unsigned char *sha1,
 	d->up	   = c->bottom;
 	d->baselen = base->len;
 	d->mode	   = mode;
-	d->stage   = stage;
 	c->bottom  = d;
 	d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
 	hashcpy(d->oid.hash, sha1);
@@ -224,7 +222,7 @@ static int write_directory(struct archiver_context *c)
 		write_directory(c) ||
 		write_archive_entry(&d->oid, d->path, d->baselen,
 				    d->path + d->baselen, d->mode,
-				    d->stage, c) != READ_TREE_RECURSIVE;
+				    c) != READ_TREE_RECURSIVE;
 	free(d);
 	return ret ? -1 : 0;
 }
@@ -256,14 +254,14 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		if (check_attr_export_ignore(check))
 			return 0;
 		queue_directory(oid->hash, base, filename,
-				mode, stage, c);
+				mode, c);
 		return READ_TREE_RECURSIVE;
 	}
 
 	if (write_directory(c))
 		return -1;
 	return write_archive_entry(oid, base->buf, base->len, filename, mode,
-				   stage, context);
+				   context);
 }
 
 struct extra_file_info {
@@ -377,8 +375,8 @@ struct path_exists_context {
 };
 
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
-			const char *filename, unsigned mode,
-			int stage, void *context)
+			const char *filename, unsigned mode, int stage,
+			void *context)
 {
 	int ret = -1;
 	struct path_exists_context *ctx = context;
-- 
2.31.0.286.gc175f2cb894


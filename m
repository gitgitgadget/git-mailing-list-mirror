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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C3C43381
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0495D65272
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhCHUFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhCHUEr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE079C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d15so12798468wrv.5
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpg1rHY6bxEGpkIstcJ+Xapsq4U9fS6at352aouaqk4=;
        b=p8mcNOlbx36rXfErMUF8BeiAA0Cez060PMAmnazC49O1XJUUmGIPSk21wWULVOkuW9
         z8c0bYnSmbJRHW+7UVjVi8QphepFuDxiz1GYl4A7Aj6KVSQOgr2z7UbEsTvSG/7hEZn6
         BzAwdwjcAVbL1AGyxNfY56KuARYBiFZ7r5NKiabYrHXC9mlZ8z73NN2m9hziofr9VvyC
         7cZC9775DZ+lAeDM2GLq0ML4I0d2uKVSic87dlEfWg5wNIG/eY37YOTPJzyNF0RE+9Ij
         3Wk4MH/zRZDvBOrzXe0/ObTaSnedDtHzk0pfZtP2tib8if14cnzAu67SjeO31gW43rZi
         K9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpg1rHY6bxEGpkIstcJ+Xapsq4U9fS6at352aouaqk4=;
        b=GS5U07OEyuBLvpPJEFNgptG1PuZPR4jXl+fRlDNdJ+iXDU8fpvEZMigIZp+F7KTDvd
         wtBmZ4gmEJ206L5FUmPN1EHI3eJey1oPsKJjtIGp6haNVPojbW4U9zb5gbH5hv3qaUC+
         wiobBPJui4Em5+534yUV3mTAreQiS2tXYFpX6F6j0qlvN2j6MFl9m+SoIZjpMFDY8hiu
         HXGDSYczpQfJjvZVAkiT5PJnZ2QfqBbpLtgLLQQt/1xcV1SPUjmEw782agPXW0VacndU
         S71eacGonFa5YdGnhxbwj+XMQ1qhd9ZVz6ClKt/yIFBexjcNDfXgu8KD65XhHFtTwaWl
         E84A==
X-Gm-Message-State: AOAM5325b3rdhVarLk7L5kPYACm4XygoLEpBgq50ILJXNCdBeO6yMUWK
        9fnYcdscT1kzlR+F4jOfLKlIHZBDByDdfA==
X-Google-Smtp-Source: ABdhPJxwVlaPpjlZZ8hCMlORwyhQIkzuw22SqBTyjgzfn90X19Dv1EIjPpj4KwLuyDUmXDVG/wnMYw==
X-Received: by 2002:a5d:5744:: with SMTP id q4mr25269846wrw.390.1615233885354;
        Mon, 08 Mar 2021 12:04:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] object.c: add a utility function for "expected type X, got Y"
Date:   Mon,  8 Mar 2021 21:04:24 +0100
Message-Id: <20210308200426.21824-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor various "Object X is not Y" error messages so that they use
the same message as the long-standing object_as_type() error
message. Now we'll consistently report e.g. that we got a commit when
we expected a tag, not just that the object is not a tag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c |  9 +++------
 commit.c             | 10 ++++------
 object.c             | 34 +++++++++++++++++++++++++++++++++-
 object.h             |  5 +++++
 tree.c               |  7 ++++---
 5 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 253cfb07fbd..d9082831bb2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -217,8 +217,8 @@ static int mark_link(struct object *obj, int type, void *data, struct fsck_optio
 	if (!obj)
 		return -1;
 
-	if (type != OBJ_ANY && obj->type != type)
-		die(_("object type mismatch at %s"), oid_to_hex(&obj->oid));
+	if (type != OBJ_ANY)
+		oid_is_type_or_die(&obj->oid, obj->type, &type);
 
 	obj->flags |= FLAG_LINK;
 	return 0;
@@ -240,10 +240,7 @@ static unsigned check_object(struct object *obj)
 		if (type == OBJ_BAD)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
-		if (type != obj->type)
-			die(_("object %s: expected type %s, found %s"),
-			    oid_to_hex(&obj->oid),
-			    type_name(obj->type), type_name(type));
+		oid_is_type_or_die(&obj->oid, obj->type, &type);
 		obj->flags |= FLAG_CHECKED;
 		return 1;
 	}
diff --git a/commit.c b/commit.c
index 6ccd774841c..54627b546c3 100644
--- a/commit.c
+++ b/commit.c
@@ -299,9 +299,7 @@ const void *repo_get_commit_buffer(struct repository *r,
 		if (!ret)
 			die("cannot read commit object %s",
 			    oid_to_hex(&commit->object.oid));
-		if (type != OBJ_COMMIT)
-			die("expected commit for %s, got %s",
-			    oid_to_hex(&commit->object.oid), type_name(type));
+		oid_is_type_or_die(&commit->object.oid, OBJ_COMMIT, &type);
 		if (sizep)
 			*sizep = size;
 	}
@@ -489,10 +487,10 @@ int repo_parse_commit_internal(struct repository *r,
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
-	if (type != OBJ_COMMIT) {
+	ret = oid_is_type_or_error(&item->object.oid, OBJ_COMMIT, &type);
+	if (ret) {
 		free(buffer);
-		return error("Object %s not a commit",
-			     oid_to_hex(&item->object.oid));
+		return ret;
 	}
 
 	ret = parse_commit_buffer(r, item, buffer, size, 0);
diff --git a/object.c b/object.c
index eebacc28847..819ee0faa26 100644
--- a/object.c
+++ b/object.c
@@ -28,6 +28,8 @@ static const char *object_type_strings[] = {
 	"tag",		/* OBJ_TAG = 4 */
 };
 
+static const char *oid_is_a_X_not_a_Y = N_("object %s is a %s, not a %s");
+
 const char *type_name(unsigned int type)
 {
 	if (type >= ARRAY_SIZE(object_type_strings))
@@ -159,6 +161,36 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
 	return obj;
 }
 
+static int oid_is_type_or(const struct object_id *oid,
+			  enum object_type want,
+			  enum object_type type,
+			  int err)
+{
+	if (want == type)
+		return 0;
+	if (err)
+		return error(_(oid_is_a_X_not_a_Y),
+			     oid_to_hex(oid), type_name(type),
+			     type_name(want));
+	else
+		die(_(oid_is_a_X_not_a_Y), oid_to_hex(oid),
+		    type_name(type), type_name(want));
+}
+
+void oid_is_type_or_die(const struct object_id *oid,
+			enum object_type want,
+			enum object_type *type)
+{
+	oid_is_type_or(oid, want, *type, 0);
+}
+
+int oid_is_type_or_error(const struct object_id *oid,
+			 enum object_type want,
+			 enum object_type *type)
+{
+	return oid_is_type_or(oid, want, *type, 1);
+}
+
 void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
@@ -172,7 +204,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 	else {
 		if (!quiet)
-			error(_("object %s is a %s, not a %s"),
+			error(_(oid_is_a_X_not_a_Y),
 			      oid_to_hex(&obj->oid),
 			      type_name(obj->type), type_name(type));
 		return NULL;
diff --git a/object.h b/object.h
index 5e7a523e858..d2d4a236d0e 100644
--- a/object.h
+++ b/object.h
@@ -124,6 +124,11 @@ void *create_object(struct repository *r, const struct object_id *oid, void *obj
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
+void oid_is_type_or_die(const struct object_id *oid, enum object_type want,
+			enum object_type *type);
+int oid_is_type_or_error(const struct object_id *oid, enum object_type want,
+			 enum object_type *type);
+
 /*
  * Returns the object, having parsed it to find out what it is.
  *
diff --git a/tree.c b/tree.c
index 4820d66a10c..d9b1c70b28a 100644
--- a/tree.c
+++ b/tree.c
@@ -219,6 +219,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 	enum object_type type;
 	void *buffer;
 	unsigned long size;
+	int ret;
 
 	if (item->object.parsed)
 		return 0;
@@ -227,10 +228,10 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
-	if (type != OBJ_TREE) {
+	ret = oid_is_type_or_error(&item->object.oid, OBJ_TREE, &type);
+	if (ret) {
 		free(buffer);
-		return error("Object %s not a tree",
-			     oid_to_hex(&item->object.oid));
+		return ret;
 	}
 	return parse_tree_buffer(item, buffer, size);
 }
-- 
2.31.0.rc1.210.g0f8085a843c


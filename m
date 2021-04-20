Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD9C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6921F6113C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhDTNhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhDTNhi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4672C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so13186556wma.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o18dZx5ODPSOYuJsQ0/hh/CFt8AUBcOmkGfZpCS4ELo=;
        b=qQtoJladwVFx08K8dmKOdRuMXkNXZE5vIIKTvAJwtEO/Snbgce49ST4ypErlRGKcXg
         ba+GkjM5P+UfhlB21dOFxzCEgAhw+6ouNjKK22bNWL6yZTS/iyJ0Py8qZ35YEEceFJ7O
         1w2CJi8K3+eQcunq2ICQRrRUumBfVhnYJFY7E1A/ZIUTTxd5jO38k8OWnIbypL/sAUBm
         UXbAhTgVUuItmiQBj9+qhAJNr7Q7AYzN8G8zMI8agDewAfPPap3XUxVXGos/sIBgdn82
         2ryv+vWhVR6SBn02LWAfVLtL2Y2BUtp1LCVwoIROJFKC8TNwMasUeit70yqz+xgoPHhy
         1+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o18dZx5ODPSOYuJsQ0/hh/CFt8AUBcOmkGfZpCS4ELo=;
        b=rM9MyS0GjjJOVDoxfzY10h53rNgiwGmMUp79J0UCHQsmy1NoVV+lBP05wXbqlLIJf0
         nejXQoLgjLY93Aj03vkGZbv/guhZfBtgRB7nLWE8AVEgfaUxb8pzM0XpwqEx/pR9JaqA
         2j39YNHh/CPadd/pG/V5MSPTnyEYOQA7Hfhrqm19+NIgVOJj5yV7HtTTPAcu03PC6ucN
         04FFv39Wg8Q2BH//uLrNfbi6vlgK/PjlWlBer6tkJn4ifnIDMOMaUkAmEHlapfHAydpG
         eu0OYzkqCuFloc7Hq5h5ZYSN9vLZ6UA39hCfSOn99RwTEL9ntABrmhTEZ4yEgDopy018
         zV6g==
X-Gm-Message-State: AOAM5335DC2sBOnnAlwwuR5Hz+U1c5W6w4ETt5DY7kcia8qRpWH1HoSS
        MOyL3ZUTqux2dIxHwftZ2jbNKwYd/mfCPQ==
X-Google-Smtp-Source: ABdhPJxWy7hFeUXWljb7HfRrChhMg5wtFNxF4XQUAKUxBnxmp7lfL/kb+WyRq/9580ZvIE+FXizUgQ==
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr4599570wmm.87.1618925825177;
        Tue, 20 Apr 2021 06:37:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] object.c: add a utility function for "expected type X, got Y"
Date:   Tue, 20 Apr 2021 15:36:54 +0200
Message-Id: <patch-2.8-1b472fcd85-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
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
 combine-diff.c       |  3 +--
 commit.c             | 10 ++++------
 merge-recursive.c    |  1 +
 object.c             | 25 ++++++++++++++++++++++++-
 object.h             |  5 +++++
 tree.c               |  7 ++++---
 7 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c0e3768c32..eabd9d4677 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -218,8 +218,8 @@ static int mark_link(struct object *obj, enum object_type type,
 	if (!obj)
 		return -1;
 
-	if (type != OBJ_ANY && obj->type != type)
-		die(_("object type mismatch at %s"), oid_to_hex(&obj->oid));
+	if (type != OBJ_ANY)
+		oid_is_type_or_die(&obj->oid, obj->type, &type);
 
 	obj->flags |= FLAG_LINK;
 	return 0;
@@ -241,10 +241,7 @@ static unsigned check_object(struct object *obj)
 		if (type <= 0)
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
diff --git a/combine-diff.c b/combine-diff.c
index 06635f91bc..aa767dbb8e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -333,8 +333,7 @@ static char *grab_blob(struct repository *r,
 		free_filespec(df);
 	} else {
 		blob = read_object_file(oid, &type, size);
-		if (type != OBJ_BLOB)
-			die("object '%s' is not a blob!", oid_to_hex(oid));
+		oid_is_type_or_die(oid, OBJ_BLOB, &type);
 	}
 	return blob;
 }
diff --git a/commit.c b/commit.c
index 3580c62b92..3d7f1fba0c 100644
--- a/commit.c
+++ b/commit.c
@@ -304,9 +304,7 @@ const void *repo_get_commit_buffer(struct repository *r,
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
@@ -494,10 +492,10 @@ int repo_parse_commit_internal(struct repository *r,
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
diff --git a/merge-recursive.c b/merge-recursive.c
index 7618303f7b..b952106203 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2999,6 +2999,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 	if (!buf)
 		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
+		const char* msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
 		free(buf);
 		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
 	}
diff --git a/object.c b/object.c
index 3c962da6c9..9e06c0ee92 100644
--- a/object.c
+++ b/object.c
@@ -153,6 +153,29 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
 	return obj;
 }
 
+static const char *object_type_mismatch_msg = N_("object %s is a %s, not a %s");
+
+void oid_is_type_or_die(const struct object_id *oid,
+			enum object_type want,
+			enum object_type *type)
+{
+	if (want == *type)
+		return;
+	die(_(object_type_mismatch_msg), oid_to_hex(oid),
+	    type_name(*type), type_name(want));
+}
+
+int oid_is_type_or_error(const struct object_id *oid,
+			 enum object_type want,
+			 enum object_type *type)
+{
+	if (want == *type)
+		return 0;
+	return error(_(object_type_mismatch_msg),
+		     oid_to_hex(oid), type_name(*type),
+		     type_name(want));
+}
+
 void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
@@ -166,7 +189,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 	else {
 		if (!quiet)
-			error(_("object %s is a %s, not a %s"),
+			error(_(object_type_mismatch_msg),
 			      oid_to_hex(&obj->oid),
 			      type_name(obj->type), type_name(type));
 		return NULL;
diff --git a/object.h b/object.h
index 85e7491815..f8609a8518 100644
--- a/object.h
+++ b/object.h
@@ -123,6 +123,11 @@ void *create_object(struct repository *r, const struct object_id *oid, void *obj
 
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
index e9d2bd7ffd..f1c6e8f647 100644
--- a/tree.c
+++ b/tree.c
@@ -131,6 +131,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 	enum object_type type;
 	void *buffer;
 	unsigned long size;
+	int ret;
 
 	if (item->object.parsed)
 		return 0;
@@ -139,10 +140,10 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
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
2.31.1.723.ga5d7868e4a


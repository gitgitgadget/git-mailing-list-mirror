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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932B8C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55866611AE
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhDIIum (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhDIIud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223ACC061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 18so5637649edx.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJTjYpSgXIINYC5sJJJUbJk7vTaSlSoAGoPEtHEAvSw=;
        b=WJYBRgP2mcS6zWQ8HkEnGmsE/FnTJvi+HBFfvWTMa/7KrUx9Nr2Q1u7ttutNEUdoWq
         c9s4oSjY6lkSpFQ2dIo3cjlw8EWM6nxANvPtgk1/kjUHrp1Q1OBitvXbVhJNqGW/uNfR
         BJljZOG9kkftd4Ix+4iqD2B+zS5/coK1Tb63maKz1wSNPGe1sY5m0TQB/JCkoi0PcO4b
         zujwZMrxoCAhHgNLFyVvi095r81s7XDDLb7p4r8blC9khmF3cycik3PRUmoz4HtHBzOq
         9UBXmyGcwrHxaMWDVVjAIevDMLDU6wxdM5FEmiiW6P+0MZuGNdrH7ZklYIjtLClbANuf
         Mwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJTjYpSgXIINYC5sJJJUbJk7vTaSlSoAGoPEtHEAvSw=;
        b=BMN83rsZx5WYuxzGVzyXwyqNUZLh5prSSnC2+pszPFXokTmQHV+47aGD/4lsEJAadC
         ZphL6KNmLHb92hG6J2V9giyF2Pj+BkEqo0vvY3oLAnnDB9JrjJY67eK+g0m39xMQGDFH
         u2N6oaP6DFqIVTnNDSdSYfr6jJf/p5pzAzXwggwdS3dLjDwj51WdFdv29mVaEe/arCSi
         tpk7gpsE89XB3IaE/rZ+vEJlX2ZMdymNoPgDLh0pMJEy2/XiykJoz9VCjO56Pjwg3qm/
         r9n1BmMaM7qRZU16UhyQMiUi9sQ8lKUW1BBNrzrDwbPL4ZQdmmpzeWfHnloKWd5Cs4FH
         69jw==
X-Gm-Message-State: AOAM5338VighOJKrj/H6+Uk5PsJYvc6nYlO3Wjk19mGi6jJNndveTl5i
        2wFVNwG/vMoWfr5E3mfWn9AdO+ogmUvYhg==
X-Google-Smtp-Source: ABdhPJxFQcpDQ5f7AHkn1k3TgphO2eB806KqooHOLtcRdeGyEiZJaj1u2io68OCW4pAhahYPglmu8w==
X-Received: by 2002:a05:6402:1157:: with SMTP id g23mr16445618edw.303.1617958217601;
        Fri, 09 Apr 2021 01:50:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/7] object.c: remove "quiet" parameter from object_as_type()
Date:   Fri,  9 Apr 2021 10:50:02 +0200
Message-Id: <patch-7.7-64360ac260-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the now-unused "quiet" parameter from object_as_type(). As
shown in preceding commits the previous users of this parameter were
better off with higher-level APIs.

The "quiet" parameter was originally introduced when the
object_as_type() function was added in 8ff226a9d5e (add object_as_type
helper for casting objects,.  2014-07-13), but the commit.c use-case
for it is now gone.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blob.c                | 2 +-
 builtin/fsck.c        | 2 +-
 commit.c              | 8 +++++---
 object.c              | 9 ++++-----
 object.h              | 2 +-
 refs.c                | 2 +-
 t/helper/test-reach.c | 2 +-
 tag.c                 | 2 +-
 tree.c                | 2 +-
 9 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/blob.c b/blob.c
index 389a7546dc..b5bd27844e 100644
--- a/blob.c
+++ b/blob.c
@@ -10,7 +10,7 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_blob_node(r));
-	return object_as_type(obj, OBJ_BLOB, 0);
+	return object_as_type(obj, OBJ_BLOB);
 }
 
 int parse_blob_buffer(struct blob *item)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 70ff95837a..5d534cf218 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -221,7 +221,7 @@ static void mark_unreachable_referents(const struct object_id *oid)
 		enum object_type type = oid_object_info(the_repository,
 							&obj->oid, NULL);
 		if (type > 0)
-			object_as_type(obj, type, 0);
+			object_as_type(obj, type);
 	}
 
 	options.walk = mark_used;
diff --git a/commit.c b/commit.c
index 437a8b8548..3014559d66 100644
--- a/commit.c
+++ b/commit.c
@@ -38,9 +38,11 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
 		return NULL;
 
 	if (obj->type != OBJ_COMMIT) {
-		enum object_type want = OBJ_COMMIT;
+		if (obj->type <= 0)
+			BUG("noes");
 		if (!quiet)
-			oid_is_type_or_error(oid, OBJ_COMMIT, &want);
+			fprintf(stderr, "noes ohes");/*
+			oid_is_type_or_error(oid, OBJ_COMMIT, &obj->type);*/
 		return NULL;
 	}
 	return (struct commit *)obj;
@@ -68,7 +70,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_commit_node(r));
-	return object_as_type(obj, OBJ_COMMIT, 0);
+	return object_as_type(obj, OBJ_COMMIT);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/object.c b/object.c
index e3400d1039..715e358603 100644
--- a/object.c
+++ b/object.c
@@ -194,7 +194,7 @@ char* oid_is_type_or_die_msg(const struct object_id *oid,
 	return strbuf_detach(&sb, NULL);
 }
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet)
+void *object_as_type(struct object *obj, enum object_type type)
 {
 	if (obj->type == type) {
 		return obj;
@@ -205,10 +205,9 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 			obj->type = type;
 		return obj;
 	} else {
-		if (!quiet)
-			error(_(object_type_mismatch_msg),
-			      oid_to_hex(&obj->oid),
-			      type_name(obj->type), type_name(type));
+		error(_(object_type_mismatch_msg),
+		      oid_to_hex(&obj->oid),
+		      type_name(obj->type), type_name(type));
 		return NULL;
 	}
 }
diff --git a/object.h b/object.h
index cdc3242a12..61857ee48c 100644
--- a/object.h
+++ b/object.h
@@ -122,7 +122,7 @@ struct object *lookup_object(struct repository *r, const struct object_id *oid);
 
 void *create_object(struct repository *r, const struct object_id *oid, void *obj);
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet);
+void *object_as_type(struct object *obj, enum object_type type);
 
 void oid_is_type_or_die(const struct object_id *oid, enum object_type want,
 			enum object_type *type);
diff --git a/refs.c b/refs.c
index 261fd82beb..7f4ca3441c 100644
--- a/refs.c
+++ b/refs.c
@@ -341,7 +341,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 
 	if (o->type == OBJ_NONE) {
 		int type = oid_object_info(the_repository, name, NULL);
-		if (type < 0 || !object_as_type(o, type, 0))
+		if (type < 0 || !object_as_type(o, type))
 			return PEEL_INVALID;
 	}
 
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index cda804ed79..c9fd74b21f 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -67,7 +67,7 @@ int cmd__reach(int ac, const char **av)
 			die("failed to load commit for input %s resulting in oid %s\n",
 			    buf.buf, oid_to_hex(&oid));
 
-		c = object_as_type(peeled, OBJ_COMMIT, 0);
+		c = object_as_type(peeled, OBJ_COMMIT);
 
 		if (!c)
 			die("failed to load commit for input %s resulting in oid %s\n",
diff --git a/tag.c b/tag.c
index 871c4c9a14..e750b00cf5 100644
--- a/tag.c
+++ b/tag.c
@@ -104,7 +104,7 @@ struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_tag_node(r));
-	return object_as_type(obj, OBJ_TAG, 0);
+	return object_as_type(obj, OBJ_TAG);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tree.c b/tree.c
index 6717d982fa..0bd18abd64 100644
--- a/tree.c
+++ b/tree.c
@@ -107,7 +107,7 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_tree_node(r));
-	return object_as_type(obj, OBJ_TREE, 0);
+	return object_as_type(obj, OBJ_TREE);
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
-- 
2.31.1.592.gdf54ba9003


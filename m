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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CBC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A0361154
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhDTNhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhDTNhn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E5BC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so33928055wrt.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S07IAKh9C5bEtSSybcdhmZ98ZotlhpvcLy4S32jMjww=;
        b=AT93FR3eFiWw8Y0int2o6jTv6qIomrx8Ys9qOsAXzEyhJwdvgIcY14ed7/osYAxcjC
         RvktdAu2rRIi1BqjJftcaKndoqu7pU6TcExuykX77R2OhxBWsWl9rGfJ3wYwqa4HtK9q
         kL2k3zfsOuyb5A01OFCVVJKkkm3Vs3EWa8NQOWQ1284nu9SBZpwJsGeIQeuW1i/lSJoK
         EFIDXlMmQvfHerZQGvG3uPOUNru2OJ24cuFvKFCt2GeBlthif+nJ9epxplNwqGs+ky2T
         ShEqje4hNAeKc7utHlMTWU/RyD4D9xyJZE+RcrZu5z/GG2B7wOvdlV35fsBk6o8W0Gm1
         NZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S07IAKh9C5bEtSSybcdhmZ98ZotlhpvcLy4S32jMjww=;
        b=VasiksqQeEIP7wBuNAhSU+6aa9PEjJxvhkejBWgh+dvmpsoMvAbgtJdgJZWe/y9sS2
         laCsRgOvWBQYOQJbQK9+vQ3IjTgXc2a3XOl9QaP3wwfzo6BlSFLoNUggI/GQ2cmAs0iN
         Ync+tEKTOiobEkufhWL7IXou5qtdLImCvNVDXVZqC6af23UX787WDjzCTGLxG9HfZ7DZ
         sMfZtaJQU2wY5Nyxysy0iDWoDtUjGcU858M5VJRUaQSToUGXlFuV6PzBvl5dQ4rUaxXn
         2bMhWFNUvDdeEcvlWH/QKILBEKcp7bEKuLhE3mWY4GwiXaXSL9Kg2lZKHd8rqt9y1JOG
         qfpw==
X-Gm-Message-State: AOAM531se6LCReqa/MwJownFyCcRdENohRqEh4iqIxE+qG9dh5EMjPV7
        CINEybeejQSv/bWUs9ld0f2RoZXfnay+yQ==
X-Google-Smtp-Source: ABdhPJxBAflur/56kN4ykBiz8wlNYRweJLvVuCcht8225ovDD+E3sQbQ4fo/L53WWtkPL4DnvqXgrw==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr20460331wrs.67.1618925830309;
        Tue, 20 Apr 2021 06:37:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] object.c: remove "quiet" parameter from object_as_type()
Date:   Tue, 20 Apr 2021 15:37:00 +0200
Message-Id: <patch-8.8-a47d23f1b1-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
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
 commit.c              | 2 +-
 object.c              | 9 ++++-----
 object.h              | 2 +-
 refs.c                | 2 +-
 t/helper/test-reach.c | 2 +-
 tag.c                 | 2 +-
 tree.c                | 2 +-
 9 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/blob.c b/blob.c
index 1308299eab..f8d8f0b84e 100644
--- a/blob.c
+++ b/blob.c
@@ -15,5 +15,5 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_blob(r, oid);
-	return object_as_type(obj, OBJ_BLOB, 0);
+	return object_as_type(obj, OBJ_BLOB);
 }
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
index c3bc6cbec4..918c7c7a66 100644
--- a/commit.c
+++ b/commit.c
@@ -76,7 +76,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_commit(r, oid);
-	return object_as_type(obj, OBJ_COMMIT, 0);
+	return object_as_type(obj, OBJ_COMMIT);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/object.c b/object.c
index f694db7e87..9f6f36707b 100644
--- a/object.c
+++ b/object.c
@@ -188,7 +188,7 @@ char* oid_is_type_or_die_msg(const struct object_id *oid,
 	return strbuf_detach(&sb, NULL);
 }
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet)
+void *object_as_type(struct object *obj, enum object_type type)
 {
 	if (obj->type == type) {
 		return obj;
@@ -199,10 +199,9 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
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
index 7ae6407598..bb65a6cd5a 100644
--- a/object.h
+++ b/object.h
@@ -121,7 +121,7 @@ struct object *lookup_object(struct repository *r, const struct object_id *oid);
 
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
index 1bd81bf1d1..25d79c3db3 100644
--- a/tag.c
+++ b/tag.c
@@ -109,7 +109,7 @@ struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_tag(r, oid);
-	return object_as_type(obj, OBJ_TAG, 0);
+	return object_as_type(obj, OBJ_TAG);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tree.c b/tree.c
index f1c6e8f647..fd3ad18051 100644
--- a/tree.c
+++ b/tree.c
@@ -112,7 +112,7 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_tree(r, oid);
-	return object_as_type(obj, OBJ_TREE, 0);
+	return object_as_type(obj, OBJ_TREE);
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
-- 
2.31.1.723.ga5d7868e4a


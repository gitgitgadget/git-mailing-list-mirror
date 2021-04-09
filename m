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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CAC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA306611AF
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDIIu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhDIIu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065F8C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 18so5637452edx.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avqSmZXO+ZmGwi+38K71vAz0i3bCbHSQmqWF4mxaVM8=;
        b=sAQ7HRMEi7Lixav0gUrmBdi7dULr8agfUyhbtDqURC9m2S+jrtnowWYYksqRkN0RrW
         Y9mzMzAX5FaZA1gq+OaMuF7PLxY68569fQE+rQOikny3IPYYeGTQfDXtrWxIBJ1VlJ/l
         JeKpUtQvok3YYFikWc50W+BAAk5k2FkT8C0ZxE2s02f5U9ykrjko1YQfoLkDkfy1eftO
         nTiwz2A8xfpQKPF5j3MMPZksAPTmGsYrYo7tQGUkslKt0Z41eKEQDYaID0b/PSf8mShx
         QcSAG7bArC3x9tJyPmW4HwgwUGLGtonKxzO12ve+0W0P0EEVF8DDWoEh0UVjWE1Nkmre
         v/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avqSmZXO+ZmGwi+38K71vAz0i3bCbHSQmqWF4mxaVM8=;
        b=TU+CA5Ix2LYttZo3LNTWS3+zbCjRE12aT6Y3OXjxEBUXcqQ+Q322D0ORnBzOle5uzv
         PVrjCC9TiIUaAnHXmRHfY/pJ1mQxQ/kRY2D0fNUEx0rxHGG/iFW6UutZOJQ5TYgxb+mP
         +rBZjWXYErs9LxCUijLbY09Ua2YrwAT7CfT1YUpeWw0A8Ti6cS/614cgAo4xSYys0fui
         0zgKXp2Z/X8PjhkWBX9OdwIdShcPeWJmshuPeuJffAf4LErpHFmJmPV+ljLs9J3dezHe
         IE4wjkwUInuluUuROW9sGgfR9vdq70GFOUPzDqccUb14yh9ikNTyr2jA8usR147caPlF
         MIjw==
X-Gm-Message-State: AOAM533FXOpxkJ2jylvDh1/HWdZV0cXofHEoKYK7CjqPb5hw3RSUqVvs
        F1ZbXaYrlAQf4czYCyIFMU29JRSm+udVtg==
X-Google-Smtp-Source: ABdhPJy3AoMc9lh3leHon4I8lUIN4bBEmwjmWASg4F1xF5hG2uUl6q/1K3Pn0xwO7qspoAJkyQWflA==
X-Received: by 2002:aa7:d78a:: with SMTP id s10mr16198822edq.226.1617958213509;
        Fri, 09 Apr 2021 01:50:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/7] object.c: add a utility function for "expected type X, got Y"
Date:   Fri,  9 Apr 2021 10:49:57 +0200
Message-Id: <patch-2.7-0be843e838-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
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
index 8ea55a447f..b370100367 100644
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
diff --git a/merge-recursive.c b/merge-recursive.c
index ed31f9496c..be7f727b5a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2971,6 +2971,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 	if (!buf)
 		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
+		const char* msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
 		free(buf);
 		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
 	}
diff --git a/object.c b/object.c
index 2216cdcda2..8b2df3a94c 100644
--- a/object.c
+++ b/object.c
@@ -159,6 +159,29 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
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
@@ -172,7 +195,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 	else {
 		if (!quiet)
-			error(_("object %s is a %s, not a %s"),
+			error(_(object_type_mismatch_msg),
 			      oid_to_hex(&obj->oid),
 			      type_name(obj->type), type_name(type));
 		return NULL;
diff --git a/object.h b/object.h
index 5e7a523e85..d2d4a236d0 100644
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
index 482a37d8fa..6717d982fa 100644
--- a/tree.c
+++ b/tree.c
@@ -126,6 +126,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 	enum object_type type;
 	void *buffer;
 	unsigned long size;
+	int ret;
 
 	if (item->object.parsed)
 		return 0;
@@ -134,10 +135,10 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
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
2.31.1.592.gdf54ba9003


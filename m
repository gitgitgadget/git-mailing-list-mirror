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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82AEC433EB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EAA61613
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhC1CO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhC1COL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F6EC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x13so9313844wrs.9
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqlaGshNOmToy0hQYoI7jdbguFA76bpHYxc8c2W/XME=;
        b=TkDXSJTVIo39VXMc8WwL8KbullkSjas0h2Rl5a2HW6nNaj0HY80w/JsXbIYMtYZJuO
         Xusl4PaKe3nno5gJOORVPI9v0+DwZ8ZL69ILji/LVkywlpP3GtuZaY1qcxL5ri2YYhWZ
         iRGISBC9YA+nn75FUhaSWf3LSlYp+ZjZuyF/M8EAFrpimBCh881K8iGo2RqGjs2WOqft
         1bB5KnR8mARzLi8OxTD0mCpJDS6zJ1TGJo+wchl5U/fc7DMv+pIm3MHMqq2c95k/gQ+f
         rznbze66O1XMgnF3ad43W7Rj7q7Tbx5VY2Bcpt4MkTVN8WAIVp094AHyQNoZGGbGA/0R
         kRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqlaGshNOmToy0hQYoI7jdbguFA76bpHYxc8c2W/XME=;
        b=r50LGmyKozIB/24XfENmfiHrSDG8tSfk9DILJvm3iAjs8xH9FnspGmg2W1472Z29B7
         9hAlEFM2MhZ9PtEWDkJJVuDbv7B1HHL2OVb5kE/cRzKOjcvTZtu/iF2Ls0JkCcsw59dP
         xsIO5jT5SKCAYRpAqGHRCRQcCWIHWf0poTS2NPxxefzyfll6W2u++IUwPBTZr+VDBGPT
         GlE/SDMW5B77VA4LwtQFVwEyGBifJCq3K7qOqTB+YZTOhvyjuocsZanHbXKZgjS35WEX
         SGZ9DJOBxP8RruyoUUzfFKYIbwtkVCpKA9dOyAsAGdUrHLSfmc6HyAB7HtjIrhm77iJF
         j36w==
X-Gm-Message-State: AOAM533Mg1wn6LznBly0FrRpEWTS2ELYqUy5rb0edgbp3+SQBfzue6xR
        XhwCB6GIeGuj3p7zHSU3gP+y72nP9It4XA==
X-Google-Smtp-Source: ABdhPJyiQuokEcObZDA+xwEJCzi8VOvDSbpitZIMyhRGoeApC9+3afsHr3mxjCEK279UbieiUpqmkg==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr21402832wrx.85.1616897649867;
        Sat, 27 Mar 2021 19:14:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] object.c: add a utility function for "expected type X, got Y"
Date:   Sun, 28 Mar 2021 04:13:37 +0200
Message-Id: <patch-07.11-4bf29cbb383-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
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
index 17376db1e39..2a7a4df5f16 100644
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
index 06635f91bc2..aa767dbb8ea 100644
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
index 8ea55a447fa..b3701003678 100644
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
index b69e694d986..feb9bfeb8af 100644
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
index c0e68d4bbf6..fa18b243280 100644
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
2.31.1.442.g6c06c9fe35c


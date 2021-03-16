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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E254C43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A666511D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhCPQTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbhCPQSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3DC0613D7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so10755757wrx.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1C4KLosOvfPC9ghnuM63DVZODr7o1/aob0+caMMMEY=;
        b=BTc0P2oYY2jrNoq2bpTcI648myYc+U4LKEopaBBukxh1u2qu1NgQf4AiHX5OIgczPC
         b8z+nB6ZSbJ68rQxzugrlwZu0w43BZ5fCs0Evpgq0gfDZc5h2sUEa8DPxl7f8v6OGiBc
         HW4/sPqaxQTJp7N3cFIEJMvftmty3FT+Dkk4MqzNstY7oRNjZgze21ue2bLO86+Khd2b
         fnFVcgAnCm8UIBPT3tPJTP5MTNV+n+tkNb0Aa2bIGUZBpAYfweRi8dmmTbWcVjNLzDLY
         f33C6Hn3T84JBXnxK27zIPWm13M3qM8mVHBwatlxg6J+cpod1wM+P884+evUpfLcrmpG
         OEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1C4KLosOvfPC9ghnuM63DVZODr7o1/aob0+caMMMEY=;
        b=PCD5FHykb5FHjApgPJNLhGg0IJQTcLvwmzmoikBIb+f1TgRfs3Y6OYqVmihNo985Bn
         s2liO1RHVHANwILtHIX2FENgdFNMyDCgjICv21ajjJ5a9gvKK4oYJqN4POfGQmbOlZVn
         /DiK3ok5fcLK6OQ6ClbJR96q4v/QdQJLD2vela1SGvOB3KSBXy4tZm4FeklnwBhnPnu8
         IVKKxP66D+xy7dVU5P5uGFHdhOIU0zCJPfwNt1iRXimu4CDY5c0mOmsV2aIxsj759GrQ
         5QRMgO1XvrFbMZl6nBUJQYYbZzI6ZFT7OD4pK6dkVbUuVTAc2koKwhRxFG9FMOKefumG
         tOyA==
X-Gm-Message-State: AOAM532marrX0xr7xoiTg/kjSqbEM2/9SVI2n2KBqJzHEovEv8jyIvjK
        SnggNS7bNlwI5RDERbSPDS1olaI6xJVbyw==
X-Google-Smtp-Source: ABdhPJw18OCH9WbMhfHjEB/8IsEuIgquNHOSxekLN0t5QyUMWHKva32kOL3ENmScBo4F9VXKiWySwQ==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr5890168wrs.94.1615911492778;
        Tue, 16 Mar 2021 09:18:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 22/22] fetch-pack: use new fsck API to printing dangling submodules
Date:   Tue, 16 Mar 2021 17:17:38 +0100
Message-Id: <20210316161738.30254-23-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the check added in 5476e1efde (fetch-pack: print and use
dangling .gitmodules, 2021-02-22) to make use of us now passing the
"msg_id" to the user defined "error_func". We can now compare against
the FSCK_MSG_GITMODULES_MISSING instead of parsing the generated
message.

Let's also replace register_found_gitmodules() with directly
manipulating the "gitmodules_found" member. A recent commit moved it
into "fsck_options" so we could do this here.

Add a fsck-cb.c file similar to parse-options-cb.c, the alternative
would be to either define this directly in fsck.c as a public API, or
to create some library shared by fetch-pack.c ad builtin/index-pack.

I expect that there won't be many of these fsck utility functions in
the future, so just having a single fsck-cb.c makes sense.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile             |  1 +
 builtin/index-pack.c | 21 +--------------------
 fetch-pack.c         |  4 ++--
 fsck-cb.c            | 16 ++++++++++++++++
 fsck.c               |  5 -----
 fsck.h               | 22 +++++++++++++++++++---
 6 files changed, 39 insertions(+), 30 deletions(-)
 create mode 100644 fsck-cb.c

diff --git a/Makefile b/Makefile
index dfb0f1000f..3faa8bd0d3 100644
--- a/Makefile
+++ b/Makefile
@@ -882,6 +882,7 @@ LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
+LIB_OBJS += fsck-cb.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5ad80b85b4..11f0fafd33 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -120,7 +120,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int do_fsck_object;
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 static int verbose;
 static int show_resolving_progress;
 static int show_stat;
@@ -1713,24 +1713,6 @@ static void show_pack_info(int stat_only)
 	}
 }
 
-static int print_dangling_gitmodules(struct fsck_options *o,
-				     const struct object_id *oid,
-				     enum object_type object_type,
-				     enum fsck_msg_type msg_type,
-				     enum fsck_msg_id msg_id,
-				     const char *message)
-{
-	/*
-	 * NEEDSWORK: Plumb the MSG_ID (from fsck.c) here and use it
-	 * instead of relying on this string check.
-	 */
-	if (starts_with(message, "gitmodulesMissing")) {
-		printf("%s\n", oid_to_hex(oid));
-		return 0;
-	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
-}
-
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
@@ -1761,7 +1743,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 	fsck_options.walk = mark_link;
-	fsck_options.error_func = print_dangling_gitmodules;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
diff --git a/fetch-pack.c b/fetch-pack.c
index 229fd8e2c2..008a3facd4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,7 +38,7 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -998,7 +998,7 @@ static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
 
 	oidset_iter_init(gitmodules_oids, &iter);
 	while ((oid = oidset_iter_next(&iter)))
-		register_found_gitmodules(&fsck_options, oid);
+		oidset_insert(&fsck_options.gitmodules_found, oid);
 	if (fsck_finish(&fsck_options))
 		die("fsck failed");
 }
diff --git a/fsck-cb.c b/fsck-cb.c
new file mode 100644
index 0000000000..465a49235a
--- /dev/null
+++ b/fsck-cb.c
@@ -0,0 +1,16 @@
+#include "git-compat-util.h"
+#include "fsck.h"
+
+int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
+					   const struct object_id *oid,
+					   enum object_type object_type,
+					   enum fsck_msg_type msg_type,
+					   enum fsck_msg_id msg_id,
+					   const char *message)
+{
+	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
+		puts(oid_to_hex(oid));
+		return 0;
+	}
+	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+}
diff --git a/fsck.c b/fsck.c
index 565274a946..b0089844db 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1214,11 +1214,6 @@ int fsck_error_function(struct fsck_options *o,
 	return 1;
 }
 
-void register_found_gitmodules(struct fsck_options *options, const struct object_id *oid)
-{
-	oidset_insert(&options->gitmodules_found, oid);
-}
-
 int fsck_finish(struct fsck_options *options)
 {
 	int ret = 0;
diff --git a/fsck.h b/fsck.h
index bb59ef05b6..ae3107638a 100644
--- a/fsck.h
+++ b/fsck.h
@@ -153,9 +153,6 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
-void register_found_gitmodules(struct fsck_options *options,
-			       const struct object_id *oid);
-
 /*
  * fsck a tag, and pass info about it back to the caller. This is
  * exposed fsck_object() internals for git-mktag(1).
@@ -204,4 +201,23 @@ const char *fsck_describe_object(struct fsck_options *options,
 int fsck_config_internal(const char *var, const char *value, void *cb,
 			 struct fsck_options *options);
 
+/*
+ * Initializations for callbacks in fsck-cb.c
+ */
+#define FSCK_OPTIONS_MISSING_GITMODULES { \
+	.strict = 1, \
+	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	FSCK_OPTIONS_COMMON \
+}
+
+/*
+ * Error callbacks in fsck-cb.c
+ */
+int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
+					   const struct object_id *oid,
+					   enum object_type object_type,
+					   enum fsck_msg_type msg_type,
+					   enum fsck_msg_id msg_id,
+					   const char *message);
+
 #endif
-- 
2.31.0.260.g719c683c1d


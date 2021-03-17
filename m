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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE3C4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC01A64F6E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhCQSWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhCQSV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF3C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e9so2826468wrw.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VUlhJqV+4qqZa6g/W6Uzu8UXP2k0UGv75ptPp/Y4fU=;
        b=sHSlpYIFhYQoW7BEarmh2KN5eCL66fQDQctMqa2pwKOkrIgn+5UrOT7AipJyNIybhw
         3781RDewAlG05krmT0xLuE4JN8brDjRzTC2cQ7XsKxrt6RpYCzU1amWlWhkeIsYchg58
         +6NJ3f3+AXBCpZwvxpcb1gFTHhj/JgKwikUM4npoRnmffm+Vxd8oOek3FdqNHow15agh
         SsERgEn3XUBeFdtzfEHRWGPKAm/8qNDLCyAZVwhQ1OWNCvwOiTET/zzf4vrjQ3OorYij
         FYSjls+rvS09Ku09lg6xd0S0I4pCirptOknKFiwqewlJcO9oumc1HhVlssu4VrSjn5RO
         mikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VUlhJqV+4qqZa6g/W6Uzu8UXP2k0UGv75ptPp/Y4fU=;
        b=SJZHrchHHkSdOtg+fHKp3GZfOGra1R+OAQixEFIOX/rLiK8FCID18Xp/ZnQfdetTra
         nIEVsIQHjFfWcw/mFh4dxK68LWpdKMpnrit/4W1u0NQlSdM3Fus/KwnjsMrYHVRQRPeR
         uaptOKzYj5+iPCFzaNdb+a0AiNbcxg6I8bcYTmWbdc2q0f3bXF/fwrMyv1IbV7AmSf82
         OApWRauXb+ApPXMZ6v2D3Z6TSRR+hdyLUlXejHoMWdhsi3M9AVZHjYtBhybNpNwppZxR
         kXlPbuPrqo5uqKGG7A3E39rtAJdoxwTNO+3J6hNNxd6pAIoD47Fx0b2bUsuusMPDqQ1n
         584g==
X-Gm-Message-State: AOAM533GvPCIiLuY4KpigZpwKjyzqVBrF2afaw6in1Uy6GIjlvMssDI9
        lGqJADZv1mOZ3YE5cOgFPVI4KtQhcMPlVA==
X-Google-Smtp-Source: ABdhPJzWD+GHQUYtmndbUWaKfmEo3Y9Igl/C1QZW6sDd0VzyU7nHOfL3Yvan5jPVxpOLl13sN72ICQ==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr5807930wrn.349.1616005285493;
        Wed, 17 Mar 2021 11:21:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 19/19] fetch-pack: use new fsck API to printing dangling submodules
Date:   Wed, 17 Mar 2021 19:20:54 +0100
Message-Id: <20210317182054.5986-20-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
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

I'm sticking this callback in fsck.c. Perhaps in the future we'd like
to accumulate such callbacks into another file (maybe fsck-cb.c,
similar to parse-options-cb.c?), but while we've got just the one
let's just put it into fsck.c.

A better alternative in this case would be some library some more
obvious library shared by fetch-pack.c ad builtin/index-pack.c, but
there isn't such a thing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 21 +--------------------
 fetch-pack.c         |  4 ++--
 fsck.c               | 23 ++++++++++++++++++-----
 fsck.h               | 18 +++++++++++++++---
 4 files changed, 36 insertions(+), 30 deletions(-)

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
diff --git a/fsck.c b/fsck.c
index 00760b1f42..048cf81937 100644
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
@@ -1284,3 +1279,21 @@ int git_fsck_config(const char *var, const char *value, void *cb)
 
 	return git_default_config(var, value, cb);
 }
+
+/*
+ * Custom error callbacks that are used in more than one place.
+ */
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
diff --git a/fsck.h b/fsck.h
index b25ae9d8b9..da58f585d7 100644
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
@@ -203,4 +200,19 @@ const char *fsck_describe_object(struct fsck_options *options,
  */
 int git_fsck_config(const char *var, const char *value, void *cb);
 
+/*
+ * Custom error callbacks that are used in more than one place.
+ */
+#define FSCK_OPTIONS_MISSING_GITMODULES { \
+	.strict = 1, \
+	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	FSCK_OPTIONS_COMMON \
+}
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


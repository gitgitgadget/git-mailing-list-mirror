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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC70FC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CB264DF0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBQTpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD484C0617AB
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f14so24336591ejc.8
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZMYLQ9CMTPWNfzagt9s9gQ5FUyUabSH/Zr7S1KPYQQ=;
        b=JHOk7clA6aIvlX74V99mXqsXPX8L3FraEpDeuK4e4jSt14EMlpe2d+BEqbSX3pqTL+
         W2jOjPuWEjo9pLUZCmYRh3LgEKYWeic/fK/NfI53C644HUdDhyWN5wQQQFPYW6HT2ItT
         GH+6FxT4l0IQQ4E+7augDhMIlfrhfFS4i1JyqQzeDwvZigx18OBVHLiB8TH5FlxXCaV6
         g0sx/FmGZ4vfYrPMBupqfv5/GjXT1k23QPRTqx2OwpkRaA+JKnlx4JeiJqSyRmzsjisd
         HXIBVvja53gaPTRFDCtjJBOLCheOOhA3JnMoyMtViOtXeWr35WruXJkFPeQ/csazv1W6
         hOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZMYLQ9CMTPWNfzagt9s9gQ5FUyUabSH/Zr7S1KPYQQ=;
        b=gJg8dYbpYUAu/PMP/GiOCZdL1lXpcG7HvrgfaAxa3xcOqS4gnCa3pkgfG72qJieXE8
         5vf4nFANo96G3PJkjVp7ei6tVRr6ux/DtJfpi9lT+egw2H1Dgm4Y5vPgK2yc8sX4HSVj
         RM4buuZWkmhpS8th4XnigeIKpm7sAgIVdX8KGc6N/UZxGtRhpPhORFhN3pJiCwr93uF5
         atKCC1dqBPHShf6T6yNto0tI18VEH76JMs1UdVZW9oRqccpbw7O04XgNWE8QpZQt7baL
         tX3LLZu9+tkBtpKUhY0mXfEoX2rkBvmZOWBqBcvgDvAwg6aUECKEfmeBA50ybXu+OOPb
         D7yw==
X-Gm-Message-State: AOAM5330e/n7wTOUfU7XWMttDQbIidt3sxyELwdySI6boCmp54w2JP/S
        z3Akb2dGN3IeqWRY0+5UPaUt2RvTleVFIw==
X-Google-Smtp-Source: ABdhPJx8ZJi+ElnFfAoXeMdvgGu+V667WjLtwUM5KQvC5G/rEVxsjfYNEaKGRAr8fbuRct0vUIspjQ==
X-Received: by 2002:a17:906:1fd2:: with SMTP id e18mr539061ejt.398.1613590994223;
        Wed, 17 Feb 2021 11:43:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/14] fsck.c: move gitmodules_{found,done} into fsck_options
Date:   Wed, 17 Feb 2021 20:42:46 +0100
Message-Id: <20210217194246.25342-15-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the gitmodules_{found,done} static variables added in
159e7b080bf (fsck: detect gitmodules files, 2018-05-02) into the
fsck_options struct. It makes sense to keep all the context in the
same place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 19 ++++++++-----------
 fsck.h |  6 ++++--
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fsck.c b/fsck.c
index 54632404de5..f344b6be3d3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -19,9 +19,6 @@
 #include "credential.h"
 #include "help.h"
 
-static struct oidset gitmodules_found = OIDSET_INIT;
-static struct oidset gitmodules_done = OIDSET_INIT;
-
 #define STR(x) #x
 #define MSG_ID(id, msg_type) { STR(id), NULL, NULL, FSCK_##msg_type },
 static struct {
@@ -621,7 +618,7 @@ static int fsck_tree(const struct object_id *oid,
 
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
-				oidset_insert(&gitmodules_found, oid);
+				oidset_insert(&options->gitmodules_found, oid);
 			else
 				retval += report(options,
 						 oid, OBJ_TREE,
@@ -635,7 +632,7 @@ static int fsck_tree(const struct object_id *oid,
 				has_dotgit |= is_ntfs_dotgit(backslash);
 				if (is_ntfs_dotgitmodules(backslash)) {
 					if (!S_ISLNK(mode))
-						oidset_insert(&gitmodules_found, oid);
+						oidset_insert(&options->gitmodules_found, oid);
 					else
 						retval += report(options, oid, OBJ_TREE,
 								 FSCK_MSG_GITMODULES_SYMLINK,
@@ -1147,9 +1144,9 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 	struct fsck_gitmodules_data data;
 	struct config_options config_opts = { 0 };
 
-	if (!oidset_contains(&gitmodules_found, oid))
+	if (!oidset_contains(&options->gitmodules_found, oid))
 		return 0;
-	oidset_insert(&gitmodules_done, oid);
+	oidset_insert(&options->gitmodules_done, oid);
 
 	if (object_on_skiplist(options, oid))
 		return 0;
@@ -1220,13 +1217,13 @@ int fsck_finish(struct fsck_options *options)
 	struct oidset_iter iter;
 	const struct object_id *oid;
 
-	oidset_iter_init(&gitmodules_found, &iter);
+	oidset_iter_init(&options->gitmodules_found, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
 		enum object_type type;
 		unsigned long size;
 		char *buf;
 
-		if (oidset_contains(&gitmodules_done, oid))
+		if (oidset_contains(&options->gitmodules_done, oid))
 			continue;
 
 		buf = read_object_file(oid, &type, &size);
@@ -1251,8 +1248,8 @@ int fsck_finish(struct fsck_options *options)
 	}
 
 
-	oidset_clear(&gitmodules_found);
-	oidset_clear(&gitmodules_done);
+	oidset_clear(&options->gitmodules_found);
+	oidset_clear(&options->gitmodules_done);
 	return ret;
 }
 
diff --git a/fsck.h b/fsck.h
index 28137a77df0..99c77289688 100644
--- a/fsck.h
+++ b/fsck.h
@@ -116,11 +116,13 @@ struct fsck_options {
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
 	struct oidset skiplist;
+	struct oidset gitmodules_found;
+	struct oidset gitmodules_done;
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, OIDSET_INIT, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, OIDSET_INIT, OIDSET_INIT, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.30.0.284.gd98b1dd5eaa7


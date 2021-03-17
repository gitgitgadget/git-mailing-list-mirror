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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DCC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA31F64F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhCQSVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhCQSVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F1C06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so2843915wrd.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fx0sC5TkzFx2GfWSWJCiitiaa1S4K8HgpiWxq/HPxgY=;
        b=UlxIbGuZqU3cS66YILDSCtpDZiNWLmb6PWMLZQ4IqgUVJqHwDJJrYX3xmLHIprasAi
         tcQ86FPfHbQ5eYMtKqir8QUz5BbeMTcesO9RbDm+pNLiJMZsmYrp1wWp3lVjqB2bunkT
         OOPG2kugpCFT6GMfw8U5GZhWLae/xFRhWB/JLazqXG+19JLq4G4pUI4S8p5rNPhbWPP9
         NiopzLYauU1ypkPAb0KD0nmoBOiYjN/HPgWKlyUoiQQXhI+iqh1GI9gQ1OPPhAQux8NI
         1fQlxhFAY4ix16CRXSinTX+i76hdlFSt/ky4DoSAWtav9o1XiQKFuZI8Oqmmr3LawF2Z
         ju3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fx0sC5TkzFx2GfWSWJCiitiaa1S4K8HgpiWxq/HPxgY=;
        b=aEKZYdHsDJ5kekP02rbxbehp+vAwtQlG/jvmLdmULuBDLl4mIpWvei/Hhanc9BHA2q
         e0UZpRC/kJjCjdjZc+Rm+2Ir/4T1P7JDevYg+tlm2ge/RWhsyajz4/s90FWaN5Zk61rO
         0Q24HiZQL9oCoqfy4Nj70wXd/lM176AN92EalA4CAWds7zeBn5v8jzueb/7X06JqOPLr
         VdKIglhQUAPtpU43YDgnUZde+RpkHtNAfoB8m2wvA8quy/upI7shrARWk6bMZn/GyLwz
         KE37I7wNX/6U7AHuNIw1zJr+xOYBqs3Oqv+epJUJPKY02PJzhy72DH4DAoeVkb8PJaWC
         GcYA==
X-Gm-Message-State: AOAM533SHmJlxi5eUfIOAah2RoSlzJYy/GgmuTBmYrgZJKI7EfbeE0hB
        gUPLecFnNBTM0XCsymy3kU+1SKXaw6skeA==
X-Google-Smtp-Source: ABdhPJzu2Ny0Y68oix1fTgWJpsRSUjgbltMOCF2ViHvJt3rBdi2XL9aT+u+jPvRMu1EsPcSXQkYN7Q==
X-Received: by 2002:adf:fb8a:: with SMTP id a10mr5622881wrr.365.1616005271401;
        Wed, 17 Mar 2021 11:21:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/19] fsck.c: refactor and rename common config callback
Date:   Wed, 17 Mar 2021 19:20:36 +0100
Message-Id: <20210317182054.5986-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code I recently changed in 1f3299fda9 (fsck: make
fsck_config() re-usable, 2021-01-05) so that I could use fsck's config
callback in mktag in 1f3299fda9 (fsck: make fsck_config() re-usable,
2021-01-05).

I don't know what I was thinking in structuring the code this way, but
it clearly makes no sense to have an fsck_config_internal() at all
just so it can get a fsck_options when git_config() already supports
passing along some void* data.

Let's just make use of that instead, which gets us rid of the two
wrapper functions, and brings fsck's common config callback in line
with other such reusable config callbacks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  | 7 +------
 builtin/mktag.c | 7 +------
 fsck.c          | 4 ++--
 fsck.h          | 3 +--
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 821e7798c7..a56a2d0513 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -71,11 +71,6 @@ static const char *printable_type(const struct object_id *oid,
 	return ret;
 }
 
-static int fsck_config(const char *var, const char *value, void *cb)
-{
-	return fsck_config_internal(var, value, cb, &fsck_obj_options);
-}
-
 static int objerror(struct object *obj, const char *err)
 {
 	errors_found |= ERROR_OBJECT;
@@ -803,7 +798,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (name_objects)
 		fsck_enable_object_names(&fsck_walk_options);
 
-	git_config(fsck_config, NULL);
+	git_config(git_fsck_config, &fsck_obj_options);
 
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 41a399a69e..23c4b8763f 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -14,11 +14,6 @@ static int option_strict = 1;
 
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
-static int mktag_config(const char *var, const char *value, void *cb)
-{
-	return fsck_config_internal(var, value, cb, &fsck_options);
-}
-
 static int mktag_fsck_error_func(struct fsck_options *o,
 				 const struct object_id *oid,
 				 enum object_type object_type,
@@ -93,7 +88,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	fsck_options.error_func = mktag_fsck_error_func;
 	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
 	/* config might set fsck.extraHeaderEntry=* again */
-	git_config(mktag_config, NULL);
+	git_config(git_fsck_config, &fsck_options);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
 				&tagged_oid, &tagged_type))
 		die(_("tag on stdin did not pass our strict fsck check"));
diff --git a/fsck.c b/fsck.c
index e3030f3b35..5dfb99665a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1323,9 +1323,9 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
-int fsck_config_internal(const char *var, const char *value, void *cb,
-			 struct fsck_options *options)
+int git_fsck_config(const char *var, const char *value, void *cb)
 {
+	struct fsck_options *options = cb;
 	if (strcmp(var, "fsck.skiplist") == 0) {
 		const char *path;
 		struct strbuf sb = STRBUF_INIT;
diff --git a/fsck.h b/fsck.h
index 733378f126..f70d11c559 100644
--- a/fsck.h
+++ b/fsck.h
@@ -109,7 +109,6 @@ const char *fsck_describe_object(struct fsck_options *options,
  * git_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
  */
-int fsck_config_internal(const char *var, const char *value, void *cb,
-			 struct fsck_options *options);
+int git_fsck_config(const char *var, const char *value, void *cb);
 
 #endif
-- 
2.31.0.260.g719c683c1d


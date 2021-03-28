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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA4C433E0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F137D6196D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhC1NQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhC1NP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:15:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DACFC0613B1
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y124-20020a1c32820000b029010c93864955so7156778wmy.5
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxEnEh43fkjvjjoFmizQeHgxD0wf9BdC/1K4E1ED1AI=;
        b=OQR7h8cFuDS8CQrCnKRQ6O1VFQBIr7mZNg/FmLEjvyHdsHclWHYtt7D2aooKeatRKt
         dGmyST8/uvWhtlt/LNmvJ4RKOFBsMeC/GMSMnapEsi5lpPBuqQy94Bxq2gNvst05ekWm
         KrypLPcGKH3XP5Uxbab6yGHxnhcIDbbbOcU7R3Gls0jpJ/lNKvOk0iw8bx+YbtelUSfl
         01ehfksf5RHsZnOUlIK5OCDI53K9GoJlpveVI3uJq8Z1pRESQOhjKV2prbLwDEALI8VW
         1P8h5D+hp7GaJCXbsgo668T5WLPoYPh/8KbkBeLzEazzOqGke5V+TddBCGRq+8vjt2lQ
         GLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxEnEh43fkjvjjoFmizQeHgxD0wf9BdC/1K4E1ED1AI=;
        b=WoFAW0mkWru72LuUmz0nEqUFN8p+gUAPxvONxUbYO2+uZaNl0o4y0MaY8Xydp6OBQM
         R3iY9PiAJoDrq0XybuDL3xc416DAs+hPCS7v2l2zaX58f7+QRLGc9BT41lnazuYIFq+S
         RWLGtonAh3mxX4MviBNJmJNBYf+Nq3On7cD0bdKM96SeYKJ8BC3xFdW1ehLu0WC9P8BS
         wac9FIAOiOImdCmshi0v5r186lEsewFm5/fZbe2162lPUuSSYmEnlYEtYT1k/2Z4LPFu
         mcuRg2iuzQfENUQvQ7AvYEdCwzALjDhhEgn4PIbJdIbEGmmMcf1cE52t/0bTx/u7zLKc
         ojvg==
X-Gm-Message-State: AOAM531KX/aL/nMN8hEHlhaIiFpVf46faYQYkyFrVE0LskQe7f49BnHt
        O6dTt3Ldj85CrsFNXeqmsHfHuNUdN6yPJQ==
X-Google-Smtp-Source: ABdhPJw+oGGw+j/L4LHLMU9YSGzmU2j7y6bdwwdcvnyyQUtabr/LgMQhN20CrXDsxN+XKfKSeA3ccA==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr21102187wmm.64.1616937354966;
        Sun, 28 Mar 2021 06:15:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/19] fsck.c: refactor and rename common config callback
Date:   Sun, 28 Mar 2021 15:15:33 +0200
Message-Id: <patch-01.20-579af32ab3e-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index 821e7798c70..a56a2d0513a 100644
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
index 41a399a69e4..23c4b8763fa 100644
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
index e3030f3b358..5dfb99665ae 100644
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
index 733378f1260..f70d11c5594 100644
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
2.31.1.445.g087790d4945


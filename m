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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4836C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8BD64DF0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhBQTpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CBC0617A9
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n1so7667400edv.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsttLlDyjHM3sSQgHa2TPvT2u2XHgCRpXmjmtRxYHOo=;
        b=qnvAYQSW3q/ggexw1sS3WgD5QHJcKOSH9gCUlB1QAM0Mk8pPiQl91kArpsHOA8NlPN
         vqd5L64NWiNRP+nzcrbiXsTKYsh7ljxqjvX6I2dtyqwhQq/0EvNdpT/vHT7pRm+i3DyF
         VyyFWNrl1nVGD5cvNOgAZEfhZGAy2IT9IWvzLmNwG7OP7ISjee7UzIlKN71JXy0Z7ZyU
         sO+VbhuD7uz4347gt/51QgJqvijy77OTaz60ifU4LOYxqN5KWN4tw0BF3vaVUAUexQf6
         ByuTb5dIAYSCJ8tuTK0gTxlijt0wLhlIhnPlzM1q5VZajEWVZAnHU6Pf6BaL+WNW3Nu3
         4bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsttLlDyjHM3sSQgHa2TPvT2u2XHgCRpXmjmtRxYHOo=;
        b=PHkryNeLA+MYZxV38uJpcDuAfsX3VkXXz0vIcO6lZ5g5qomnwT1tFmcf1/eH9mm32n
         1RwuHLQkdZe9NYCnyjNEbJm/czwFgzC1kW590kG01Nla+CtBF8m5mxFfUmshGcBKv0WJ
         rxLTknAonP9jvxJOayPHl7R1brKKa2iCimaG1+2o5zMtFCpMsjmrdXmB6BVnNetBcqBy
         MEmo0WLd3+tW8v4LBoAIYdefX2zr9UqQHyk7KiGjIl9pTD68P6/4+c4PCY0tQDnnGgc2
         k/mjKuQp6ExhXS1H14q/KBBsNKGXVf4b8xjMZGVtPdkcXe6dpALzlUjCkzxi2LF/FOM1
         umWg==
X-Gm-Message-State: AOAM531fAbcg4SSPBj7FaF9BlisWYwraBsBlDqHLPLYYRBCnuEGCnyYF
        6dO4AP0gLCBDJDF1NcAiL7SHhPrmihExmA==
X-Google-Smtp-Source: ABdhPJwTGx10VHwNtBeK9CL8X9nYZqhK1hzida++MmgvPP8fuQ3L3SmqPi5NjC8Yvgojm0R53sy5wA==
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr432171edx.300.1613590992730;
        Wed, 17 Feb 2021 11:43:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/14] fsck.c: add an fsck_set_msg_type() API that takes enums
Date:   Wed, 17 Feb 2021 20:42:44 +0100
Message-Id: <20210217194246.25342-13-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code I added in acf9de4c94e (mktag: use fsck instead of custom
verify_tag(), 2021-01-05) to make use of a new API function that takes
the fsck_msg_{id,type} types, instead of arbitrary strings that
we'll (hopefully) parse into those types.

At the time that the fsck_set_msg_type() API was introduced in
0282f4dced0 (fsck: offer a function to demote fsck errors to warnings,
2015-06-22) it was only intended to be used to parse user-supplied
data.

For things that are purely internal to the C code it makes sense to
have the compiler check these arguments, and to skip the sanity
checking of the data in fsck_set_msg_type() which is redundant to
checks we get from the compiler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c |  3 ++-
 fsck.c          | 27 +++++++++++++++++----------
 fsck.h          |  3 +++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index dc989c356f5..de67a94f24e 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -93,7 +93,8 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 		die_errno(_("could not read from stdin"));
 
 	fsck_options.error_func = mktag_fsck_error_func;
-	fsck_set_msg_type(&fsck_options, "extraheaderentry", "warn");
+	fsck_set_msg_type_from_ids(&fsck_options, FSCK_MSG_EXTRA_HEADER_ENTRY,
+				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
 	git_config(mktag_config, NULL);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
diff --git a/fsck.c b/fsck.c
index 007f02b556a..54632404de5 100644
--- a/fsck.c
+++ b/fsck.c
@@ -134,6 +134,22 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 	return 1;
 }
 
+void fsck_set_msg_type_from_ids(struct fsck_options *options,
+				enum fsck_msg_id msg_id,
+				enum fsck_msg_type msg_type)
+{
+	if (!options->msg_type) {
+		int i;
+		enum fsck_msg_type *tmp;
+		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
+		for (i = 0; i < FSCK_MSG_MAX; i++)
+			tmp[i] = fsck_msg_type(i, options);
+		options->msg_type = tmp;
+	}
+
+	options->msg_type[msg_id] = msg_type;
+}
+
 void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id_str, const char *msg_type_str)
 {
@@ -146,16 +162,7 @@ void fsck_set_msg_type(struct fsck_options *options,
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
-	if (!options->msg_type) {
-		int i;
-		enum fsck_msg_type *tmp;
-		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
-		for (i = 0; i < FSCK_MSG_MAX; i++)
-			tmp[i] = fsck_msg_type(i, options);
-		options->msg_type = tmp;
-	}
-
-	options->msg_type[msg_id] = msg_type;
+	fsck_set_msg_type_from_ids(options, msg_id, msg_type);
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
diff --git a/fsck.h b/fsck.h
index 56536d7f29e..af145bb4596 100644
--- a/fsck.h
+++ b/fsck.h
@@ -80,6 +80,9 @@ enum fsck_msg_id {
 struct fsck_options;
 struct object;
 
+void fsck_set_msg_type_from_ids(struct fsck_options *options,
+				enum fsck_msg_id msg_id,
+				enum fsck_msg_type msg_type);
 void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
-- 
2.30.0.284.gd98b1dd5eaa7


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2CFC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E965260F90
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhGZXWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhGZXWB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:22:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29CC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:02:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b128so6379970wmb.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJFwdpvX4uQi3/mf03rN0lk+As0d7XaeyDhNJuXirrA=;
        b=Qqt12RzdWW9E5ZDiQe3q++depdZsEKPd8fWWFXQLOkzkxGV0oCC7DLlCnDxp3htE+c
         pPon3ZWoCulS1SmksmLXfcVa2k3v0LOI4bGMMv4oFDbrubwOp/AmqRjQeJPGyt3v8awv
         6ofjMHJHdFXP9F9eL3lOnJALVP6R/qZWmG2vQHIiM+SQsNotdm01CvTiyZwbxupwvPsb
         ho1Xxe7plVKuaZlYq/3b4ngemBa0dqK6IDDxvo98REwyXJNAk65sKeW8FS1SFGru9H/+
         xttthFlNmPLCBJdFVYZhZPoWhbOAQnskAWpdIMKvxGvcZrWOEQ/Vnq/y1Az0kSozcfDq
         pXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJFwdpvX4uQi3/mf03rN0lk+As0d7XaeyDhNJuXirrA=;
        b=CYYDEaiMEK3kF9AhzGnxClDYzXKEU6uV3V41ayUCeWMDixbG6/CxCtvXv0WE33t/zN
         mfFUNpbu/XhFdq/6fsM+mFhsplIDE92meX7L8je5YNVldrwMNgwPL9oePzV3W3CmbNVo
         mJNy3SXNe3LZWXT8YpOtW4jE4CoHwtePhRUdsYJRfE8bmH3UXwzKEmbuQssZLYO5InzP
         3E/PKTLqbKAWaBMnaeIBWEBodFJ86GEVPyJVxxiEEwSz5LsU9hAfJ8Cw+DuiaUkHwziB
         XJuLmeLV4frh+uil+2PbyVLv3X0+eV+vGDMoBcAKs/ECvo+FLTHyHZU3SRojeuZI+gQD
         ThUw==
X-Gm-Message-State: AOAM532H5frTGhioRkkg6LUFCRf3usvP+w62YsBhznIANzY378csUCwA
        13Yiud5tINag+hMNy6juTXlosHEWbv3SmA==
X-Google-Smtp-Source: ABdhPJxgtCySiC74DgzA+ea2cZlKDWKjjibLZu7zAEJak1Utxpd+oLF4tth4YpVLc5LQJKC1drAmFA==
X-Received: by 2002:a1c:c9:: with SMTP id 192mr4287747wma.128.1627344146634;
        Mon, 26 Jul 2021 17:02:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 19sm1184481wmu.17.2021.07.26.17.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:02:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] fetch-negotiator: call BUG() on API misuse, don't segfault
Date:   Tue, 27 Jul 2021 02:02:24 +0200
Message-Id: <patch-1.1-f1da49de63-20210727T000203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in ec06283844a (fetch-pack: introduce negotiator API,
2018-06-14) it's important that the fetch negotiator's callbacks be
called in the documented order, and that some of them never be called
again after other "later" callbacks are called.

But let's assert that with a BUG(), instead of setting the relevant
callbacks to NULL. We'll now give a meaningful error on API misuse,
instead of segfaulting.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-negotiator.c    | 11 +++++++++++
 fetch-negotiator.h    | 10 ++++++++++
 negotiator/default.c  |  6 +++---
 negotiator/noop.c     |  3 +++
 negotiator/skipping.c |  6 +++---
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 57ed5784e1..b0888e2656 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -24,3 +24,14 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 	}
 }
+
+void known_common_BUG(struct fetch_negotiator *negotiator,
+		      struct commit *commit)
+{
+	BUG("known_common() called after add_tip() and/or next() was called");
+}
+
+void add_tip_BUG(struct fetch_negotiator *negotiator, struct commit *commit)
+{
+	BUG("add_tip() called after next() called");
+}
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index ea78868504..b6461260f5 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -28,6 +28,9 @@ struct fetch_negotiator {
 	 * Once this function is invoked, known_common() cannot be invoked any
 	 * more.
 	 *
+	 * Set "known_common" to "known_common_BUG" in this callback
+	 * to assert the invocation flow.
+	 *
 	 * Indicate that this commit and all its ancestors are to be checked
 	 * for commonality with the server.
 	 */
@@ -37,6 +40,10 @@ struct fetch_negotiator {
 	 * Once this function is invoked, known_common() and add_tip() cannot
 	 * be invoked any more.
 	 *
+	 * Set "add_tip" to "add_tip_BUG" in this callback to assert
+	 * the invocation flow, and "known_common" to
+	 * "known_common_BUG" as noted for in add_tip() above.
+	 *
 	 * Return the next commit that the client should send as a "have" line.
 	 */
 	const struct object_id *(*next)(struct fetch_negotiator *);
@@ -56,4 +63,7 @@ struct fetch_negotiator {
 void fetch_negotiator_init(struct repository *r,
 			   struct fetch_negotiator *negotiator);
 
+void known_common_BUG(struct fetch_negotiator *, struct commit *);
+void add_tip_BUG(struct fetch_negotiator *, struct commit *);
+
 #endif
diff --git a/negotiator/default.c b/negotiator/default.c
index 434189ae5d..d6ad595ba4 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -135,14 +135,14 @@ static void known_common(struct fetch_negotiator *n, struct commit *c)
 
 static void add_tip(struct fetch_negotiator *n, struct commit *c)
 {
-	n->known_common = NULL;
+	n->known_common = known_common_BUG;
 	rev_list_push(n->data, c, SEEN);
 }
 
 static const struct object_id *next(struct fetch_negotiator *n)
 {
-	n->known_common = NULL;
-	n->add_tip = NULL;
+	n->known_common = known_common_BUG;
+	n->add_tip = add_tip_BUG;
 	return get_rev(n->data);
 }
 
diff --git a/negotiator/noop.c b/negotiator/noop.c
index 60569b8350..3271048b27 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -11,10 +11,13 @@ static void known_common(struct fetch_negotiator *n, struct commit *c)
 static void add_tip(struct fetch_negotiator *n, struct commit *c)
 {
 	/* do nothing */
+	n->known_common = known_common_BUG;
 }
 
 static const struct object_id *next(struct fetch_negotiator *n)
 {
+	n->known_common = known_common_BUG;
+	n->add_tip = add_tip_BUG;
 	return NULL;
 }
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 1236e79224..18448aeb80 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -204,7 +204,7 @@ static void known_common(struct fetch_negotiator *n, struct commit *c)
 
 static void add_tip(struct fetch_negotiator *n, struct commit *c)
 {
-	n->known_common = NULL;
+	n->known_common = known_common_BUG;
 	if (c->object.flags & SEEN)
 		return;
 	rev_list_push(n->data, c, 0);
@@ -212,8 +212,8 @@ static void add_tip(struct fetch_negotiator *n, struct commit *c)
 
 static const struct object_id *next(struct fetch_negotiator *n)
 {
-	n->known_common = NULL;
-	n->add_tip = NULL;
+	n->known_common = known_common_BUG;
+	n->add_tip = add_tip_BUG;
 	return get_rev(n->data);
 }
 
-- 
2.32.0.988.g1a6a4b2c5f


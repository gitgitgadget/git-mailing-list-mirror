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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BD1C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1396109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhFPOSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhFPOSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA60C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r9so2868626wrz.10
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ci1ZwiNLrFUinSF2vfnFSd9/j+T9JQB23K+KLPrND2c=;
        b=HfYqhQHHQTDOTuj9Bi72C1HI6A0Zb8E5cxomOOVOT9nRZmEzZpA3lVAsuR1op6AKtq
         XA9T7rvBVAN00Cvb8KI3ZHcSUcZFqG888sAF6o/tjgdElI3PFLh7qIFMoLxidLIwl4qC
         uECF2igAdF66Xtv8kWbW0p++F9fvZFgh9n+OTi5+9BblDYM9yCPsOwzOgd/EbefOFr9q
         aPKzUkBYS0j2RjZCTQZsH1IWpI2Z02UbTT0QX/lpZEayfWRrjVHYrBXSQZZuICizeS4H
         HvYgx0oyP2khD+/lsQYjTOjRsmqdWNCsD63PE+5DbvMiWedAUVw1U66+/luZyD5NvBDF
         YHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ci1ZwiNLrFUinSF2vfnFSd9/j+T9JQB23K+KLPrND2c=;
        b=Ea7Wufn7QLqcxCVPcOsZQ6pmnrFQ5wMdaL8YuKfr3+Km3Vwc2mvVxoPysbuHa4hl8B
         t7PTjUTZ4RZbEOWSRBdy0hSTpIHDdfhB2+V6/SjGQMttnFyM9n6HpxkC/Qjt2qy3XNal
         on93xOW3Q5KVOZtPsdK66jgdBn2U9kMog4yNb2PJ/XnfTnWUfwo1RF3vYrUfEUJobPyk
         zBRItqeXNEB1IAskiiL4RJ4yOEG1jrhZCt1dpGf/ow59HzjyjlcOKH56EIU+jq51itTm
         BIg0svJ4uvh/IXWVKyn8DXWfRCtRzOryOyBXs/ShEQd866h1Vxc+3oDQcediqVkM1MLM
         /Qbw==
X-Gm-Message-State: AOAM533TYZwHpW4ektNAJiHzZFn1c1j8zlFphzjvPXSmPK7M8uewtytX
        SbTqxINxvX/We5cXTCjUlgMZa/ESCesbsQ==
X-Google-Smtp-Source: ABdhPJy2Hawk1zHfnnwLrmCTZSnx+BZhh9YeFVedoPBn4ScuoFS0GkXgcrqw3eCAcS64ItP8i9ykKw==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr5735622wrm.326.1623852992222;
        Wed, 16 Jun 2021 07:16:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm2258555wrv.37.2021.06.16.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:16:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] transport: use designated initializers
Date:   Wed, 16 Jun 2021 16:16:19 +0200
Message-Id: <patch-3.5-369efe0eed5-20210616T141332Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the assignments to the various transport_vtables to use
designated initializers, this makes the code easier to read and
maintain.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport-helper.c | 12 ++++++------
 transport.c        | 30 ++++++++++++------------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 8d445a8f3ee..e8dbdd11530 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1261,12 +1261,12 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 }
 
 static struct transport_vtable vtable = {
-	set_helper_option,
-	get_refs_list,
-	fetch_refs,
-	push_refs,
-	connect_helper,
-	release_helper
+	.set_option	= set_helper_option,
+	.get_refs_list	= get_refs_list,
+	.fetch_refs	= fetch_refs,
+	.push_refs	= push_refs,
+	.connect	= connect_helper,
+	.disconnect	= release_helper
 };
 
 int transport_helper_init(struct transport *transport, const char *name)
diff --git a/transport.c b/transport.c
index f60985e2dbd..bdd9b5a93cf 100644
--- a/transport.c
+++ b/transport.c
@@ -880,12 +880,10 @@ static int disconnect_git(struct transport *transport)
 }
 
 static struct transport_vtable taken_over_vtable = {
-	NULL,
-	get_refs_via_connect,
-	fetch_refs_via_pack,
-	git_transport_push,
-	NULL,
-	disconnect_git
+	.get_refs_list	= get_refs_via_connect,
+	.fetch_refs	= fetch_refs_via_pack,
+	.push_refs	= git_transport_push,
+	.disconnect	= disconnect_git
 };
 
 void transport_take_over(struct transport *transport,
@@ -1029,21 +1027,17 @@ void transport_check_allowed(const char *type)
 }
 
 static struct transport_vtable bundle_vtable = {
-	NULL,
-	get_refs_from_bundle,
-	fetch_refs_from_bundle,
-	NULL,
-	NULL,
-	close_bundle
+	.get_refs_list	= get_refs_from_bundle,
+	.fetch_refs	= fetch_refs_from_bundle,
+	.disconnect	= close_bundle
 };
 
 static struct transport_vtable builtin_smart_vtable = {
-	NULL,
-	get_refs_via_connect,
-	fetch_refs_via_pack,
-	git_transport_push,
-	connect_git,
-	disconnect_git
+	.get_refs_list	= get_refs_via_connect,
+	.fetch_refs	= fetch_refs_via_pack,
+	.push_refs	= git_transport_push,
+	.connect	= connect_git,
+	.disconnect	= disconnect_git
 };
 
 struct transport *transport_get(struct remote *remote, const char *url)
-- 
2.32.0.576.g59759b6ca7d


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12F1C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D506361222
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGUW7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhGUW7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1FC0613C1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c12so3903600wrt.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+8ZAAQNDihFUXFEwCrjmlIzX0BXJVDYNDsNA3Ze5RI=;
        b=BDNruivgF43eWwfvD+Z6kd9FKXdquKzyDKXzto6VTR+tp2e2WhonA/pkj8qZ/20vFI
         s9qvWcz/1S0lVwmpOtMXGI660dIzx/kJCKM2zxOWMtdQ5d7+M32iP/1nyNhD3iqc4KsB
         k+i/e8/r2ubuAFb3et7smy8SOeatJRljW0pO7MvYjRVER86GnRCM6D5iLI3NfMskcDPK
         6jZA3NL/9NVnDu0J/mcp/5mvlVsCLIC8aJ1Wj1XME7y73Rg4oLAIeu11J1SBE5m3RoJS
         RdTneIvaL7e0EggvQ0KCid2nn5kowKkosANfBSeXJAUaGrd0KQKAj8GxIIUkdWabsv2h
         GVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+8ZAAQNDihFUXFEwCrjmlIzX0BXJVDYNDsNA3Ze5RI=;
        b=tKYtryxFwn+S2j+YoltGbbUy2/JlAI0kcWSQMWJtSFaCYijWI3q4dluecph98TmdBR
         jRIgwU3+1Pe7S2EOgHMEaKzS1BlGecZxIMu/kXeB2sQiHB2BmZtu4xYnAYK/F4Pz5Q9L
         ZZ17AJd2tCrWrPnIQQS8dtNkf+4u+SQvfRhASgLP/xJ2n32atLhkdkM5mcmiR1Qh8w3Y
         Q8jMdY/3rV+kV/vYWYBJI1ciJobzZGqWcBqAjOWm2Ieyi1cM42NfodQ5oovw/tMpnYrS
         35oa6sszsaCB90qMhB0sKgAnMN25sU6Di5HQxavmWWCENdLLVwqzgYjG1jNzGkqNImoE
         4Zuw==
X-Gm-Message-State: AOAM532OxQ51NmsSg4xu92BchOOQT8z3lS9KOk2V4y9j8fb8tLN1Zogb
        fdWWSfxXpmjWLuh80wmZ0O+dXzAwHmdeuA==
X-Google-Smtp-Source: ABdhPJzTSR+penfx8Po7Knk6+zJtnqyhCSce4CJ3G46nyMRcLRU+8BaoHjs+FMjD7ZZwsZx5/Bwv/w==
X-Received: by 2002:a5d:4e05:: with SMTP id p5mr45065358wrt.322.1626910819790;
        Wed, 21 Jul 2021 16:40:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/12] transport: use designated initializers
Date:   Thu, 22 Jul 2021 01:40:04 +0200
Message-Id: <patch-03.12-d31690614af-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
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
index 3e8a27b0321..f9400b9b0bd 100644
--- a/transport.c
+++ b/transport.c
@@ -883,12 +883,10 @@ static int disconnect_git(struct transport *transport)
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
@@ -1032,21 +1030,17 @@ void transport_check_allowed(const char *type)
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
2.32.0.955.ge7c5360f7e7


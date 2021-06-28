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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE710C11F66
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BF961997
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhF1TWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhF1TWD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BAC061767
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso152936wmh.4
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2uro04gEiRKvFmfFcUKQpqQa9AQXX3y0z6jJPc+XBY=;
        b=nfVr2UxI8IFaFXsVFq9cz58eQlfEjFocaRBngDBrsxTDEhlzHLNTOJ43DeGS5fbvQX
         nb3J9xD1Ivo2s8ouIY1ZrIcCamnoeyJh49fjS4mzSyR01sJkQQKp+YIL3lBfzZeRA5eU
         BlS4+3a/atUJATyqXtwajAgFbLQjwV+hG0J+rhPUB/mC3Qtj0ia8zqk9XQMF93TkO5aN
         D0qP/g7/4ymou31YQbPOMBKlMFXxcVYlgOTIL9e8xNVjq6v6HxuFr0ydlUCfnQYHHP0d
         4E7BMxr4hTVmRb/tdogyt3gOsv/QDMXYL8D6F6NlmglGp/Ri3cZ5O05y6Vu8okQc1CiQ
         aCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2uro04gEiRKvFmfFcUKQpqQa9AQXX3y0z6jJPc+XBY=;
        b=WqZh7oI4NrfmGOkbHa9QyTsdAg6iOJxmHVqnxM79c9hyXXuwv6IkWUM5nvPKRvEXhf
         lu3N4zzc4smg+P+R0xf+hxSQ3Ja4w9OKRvIGfzL9trw/6TWbBVhokRulKPjNfG2rVa4b
         I28QJ5tnKysx+/RGQKYnPHAvPXhPcnEC4WKPfvn65JQbEqKlpT/c+Lo33qHSPWMT/htP
         WaHScCe8ptaHaEJttOpScXMqxjHTtfOXrV22vJk8Bf7WrijirnwcVCFepb8I9WBubKRh
         jxsVvVgXvFfGcVCaD0dKARaD8LINDmQgsv8ygOT+WwdbVmtpOn/lx8jg95vBBOtCUB24
         piow==
X-Gm-Message-State: AOAM531g/yOAS6VjCFEGWG3euE+UkSYcGuKThi3bDw/QWwzNCIMrE/gX
        WCKvi9Aow7bsSLl9j6y5rtW+n7/o9gN6Hw==
X-Google-Smtp-Source: ABdhPJzb6OMTs+OnfACSUwg/Glnl1JA3KBxSHSIKeDSlRb90TwoGVF6M2AW5Mf4fil8S8j5fssZ7+w==
X-Received: by 2002:a1c:9a51:: with SMTP id c78mr587936wme.103.1624907974437;
        Mon, 28 Jun 2021 12:19:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] transport: use designated initializers
Date:   Mon, 28 Jun 2021 21:19:20 +0200
Message-Id: <patch-3.8-766045e5f1d-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
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
2.32.0.611.gd4a17395dfa


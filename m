Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA3CC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D370161992
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhF1TWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhF1TWF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E67C061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p8so6483847wrr.1
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BJK6EM5uaSUttMB1wcIdc6cwrE+wbRlHtGLr0eBXQM=;
        b=UCtUgMgImpZBWOA9wm0gP046mrK450uKhv9JqO3AFur4wsrIGzmNbKo1JcHb5kShcL
         rWGpqwub9ZNOGJZhACsxggAXstI1Eg16rM2bnMBlZLu5tUyKZpwnlsAFYtKRR40msGdI
         KGNpzIPBn3WekNhnwO+B3dug2PQK4qnX8H/wwbvMynNWRqHAVXGKOx/Iiu4+MRQguCL6
         DO1aUU/2ns+yY7Zn5bqatVUS4f7tBnd2AWoJr1GZ7yPRCcO6OUSBZetFfe+GCi5OSZ0+
         2cU2quX5TqtNgE+AUzpv5CBNN+7U2SOvEsNl3lD5+mGtB4WERjuGJQ1ARaeOsKWGUai7
         iosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BJK6EM5uaSUttMB1wcIdc6cwrE+wbRlHtGLr0eBXQM=;
        b=JnBf793DzTqW5GbRaLnSYp/+u5xBHccDUj0rzPIU3K97IUxEEdHkjXi1KKk/4M/2zQ
         Iw7rDt04SHcS6xuGc0vaX5G6UefGdK2pDtPz8Fhmp2lkgU2ms2ebCKGTPTgGDwfgu61M
         U0Wt5REFggbxa70r+xe96vq2VQWVMgDPZn9YpmJZDQcNc4cN/hU78kAS0Y0fJKvs/Pn1
         KSmLCx/ATtvFP7euwgsjAjLLd84JJjJhz7y8YsGn60hToefzAxcHPEBHNqOabgcnAbM2
         3U1HjF5E6MeHKgoefZ0c9hP/nBw4Mnhl4MT7roCoTbjWw2KeXKCX2L+l88WJqiu2SOjL
         I7DA==
X-Gm-Message-State: AOAM532H5QAkEpb6dszyILb3T5751wukYnFYJ9+ounaBYqvZbqnUeQW/
        plHr/wTQeeUfvhO0wUqx0792MUj7WwhDHA==
X-Google-Smtp-Source: ABdhPJywruw6Lyv1eQpPwzSyVH2+wC5JJnnFB3Bb4A932+AJXKJZ8ii1S7YQ4I8lwWerEV9XKXAtQQ==
X-Received: by 2002:adf:bb54:: with SMTP id x20mr29260864wrg.19.1624907976935;
        Mon, 28 Jun 2021 12:19:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:36 -0700 (PDT)
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
Subject: [PATCH v2 6/8] serve.c: add trace2 regions for advertise & command
Date:   Mon, 28 Jun 2021 21:19:23 +0200
Message-Id: <patch-6.8-baeee6539ad-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we've factored out "call_{advertise,command}()" in a
preceding commit it becomes easy to trace all these callbacks with
trace2. Let's do that. As the tests demonstrate there's no v2 push
protocol, which the tests assert.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c                               | 24 ++++++++++++++++++++++--
 t/t5705-session-id-in-capabilities.sh | 16 ++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/serve.c b/serve.c
index 85cd3eab26e..6dbd05248b9 100644
--- a/serve.c
+++ b/serve.c
@@ -111,14 +111,34 @@ static struct protocol_capability capabilities[] = {
 static int call_advertise(struct protocol_capability *command,
 			  struct repository *r, struct strbuf *value)
 {
-	return command->advertise(r, value);
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+	const char *msg;
+
+	strbuf_addf(&sb, "advertise/%s", command->name);
+	trace2_region_enter("serve", sb.buf, r);
+	ret = command->advertise(r, value);
+	msg = ret ? "advertised" : "hidden";
+	trace2_region_leave_printf("serve", sb.buf, r, "%s", msg);
+	strbuf_release(&sb);
+
+	return ret;
 }
 
 static int call_command(struct protocol_capability *command,
 			struct repository *r, struct strvec *keys,
 			struct packet_reader *request)
 {
-	return command->command(r, keys, request);
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addf(&sb, "command/%s", command->name);
+	trace2_region_enter("serve", sb.buf, r);
+	ret = command->command(r, keys, request);
+	trace2_region_leave("serve", sb.buf, r);
+	strbuf_release(&sb);
+
+	return ret;
 }
 
 static void advertise_capabilities(void)
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index f1d189d5bcc..cda78fa7a1d 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -57,7 +57,13 @@ do
 			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
 			origin &&
 		grep \"key\":\"server-sid\" tr2-client-events &&
-		grep \"key\":\"client-sid\" tr2-server-events
+		grep \"key\":\"client-sid\" tr2-server-events &&
+
+		if test "$PROTO" = 2
+		then
+			grep \"event\":\"region_enter\".*\"category\":\"serve\" tr2-server-events &&
+			grep \"event\":\"region_leave\".*\"category\":\"serve\" tr2-server-events
+		fi
 	'
 
 	test_expect_success "session IDs advertised (push v${PROTO})" '
@@ -71,7 +77,13 @@ do
 			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
 			origin HEAD:new-branch &&
 		grep \"key\":\"server-sid\" tr2-client-events &&
-		grep \"key\":\"client-sid\" tr2-server-events
+		grep \"key\":\"client-sid\" tr2-server-events &&
+
+		if test "$PROTO" = 2
+		then
+			! grep \"event\":\"region_enter\".*\"category\":\"serve\" tr2-server-events &&
+			! grep \"event\":\"region_leave\".*\"category\":\"serve\" tr2-server-events
+		fi
 	'
 done
 
-- 
2.32.0.611.gd4a17395dfa


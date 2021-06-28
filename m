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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA9C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C916198E
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhF1TWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhF1TWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C888C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so172702wms.1
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFb4KrSbP4oprPBBt9LPcaEQfuq166rH4eTe9iGNomc=;
        b=jB8ZiynV9BdtEdqVKzMhSQ/CQQtzSyFacow8zvjpj4MSgN2NIy4fbjCQcfioo/4f3E
         AMJuQqSgXiT438A9bOgogDWN31kvj1D/Dm1vHAvQloE52VJs5I6pe1IfJZi99ylv6erh
         g+nl2u4CdDs0xltG2huZ1iacJCoPXTzoK8MwoCM0nB4T/eandmMJxaZeptYOFVogUVX4
         NNWbDkvGxdpkvh0usju/KqeulTcKzzvE2v2Z7FY2RW4eBuN1t36cUdkZUYbd43MbMQ/1
         h5vg8c6G7hS0ipNMfrTmlfsPv7MIpe2Ol8Dkr3ldgw4ua9cqlekhXQcYeLXa3Ue/wrcg
         8mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFb4KrSbP4oprPBBt9LPcaEQfuq166rH4eTe9iGNomc=;
        b=sb2YY8QYEGr7ZgBrhEhVBcpnYBCSE6H1oqJZmwHSFGvbv7ZHE5M+DRCEKyrpfJvQvA
         XgSQeOClj1IKFn4Ztox7IBAbyZLqR243Vn05vXfxhu4wEhdCWwRHygxjzp8l2mVY0Im9
         FIKrondoOyZdS+pKI7xWKQUEuvhH4ad32gwOfToyr0FMwgMSoF4eQ3Hm0FDeFA8YdCsY
         ad5RlvlBkeo6P/iQYN8wFATZZbT01Q3RvxRA89+QEgKaZs2LwnJCAWztRiVUPacPGnZE
         zTnyd9NhqrHv16IvE36SdSCSm+dcxVSid7X+e2qob1UfFKEhyQKvy6JoJnFHGJdEbo98
         416A==
X-Gm-Message-State: AOAM530Gmns50VkhhyNYa+Hs2VumB2jk9uM++tRdcxg2zBvvyO1HBc9L
        kLdwDutyHunGi5//ocSK6XywulBbuKwEfQ==
X-Google-Smtp-Source: ABdhPJzQ+LnFZyWg6treBQIFMi+lhdNuFdzdAlqXA7tYc7nz4i+2lElt/1WhjtDRKJZlzo2ri61hwg==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr28014870wmh.8.1624907976035;
        Mon, 28 Jun 2021 12:19:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:35 -0700 (PDT)
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
Subject: [PATCH v2 5/8] serve.c: add call_{advertise,command}() indirection
Date:   Mon, 28 Jun 2021 21:19:22 +0200
Message-Id: <patch-5.8-d0b02aa0c7d-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of directly calling the callbacks defined in the "struct
protocol_capability", let's call them via new
"call_{advertise,command}()" functions. There's no use in this
indirection now, but it'll be used in a subsequent commit to ensure
that config is read before they're called.

See ed10cb952d3 (serve: introduce git-serve, 2018-03-15) for the
introduction of the code being changed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/serve.c b/serve.c
index 49ea9fc8fd5..85cd3eab26e 100644
--- a/serve.c
+++ b/serve.c
@@ -42,6 +42,10 @@ static int session_id_advertise(struct repository *r, struct strbuf *value)
 	return 1;
 }
 
+typedef int (*advertise_fn_t)(struct repository *r, struct strbuf *value);
+typedef int (*command_fn_t)(struct repository *r, struct strvec *keys,
+			    struct packet_reader *request);
+
 struct protocol_capability {
 	/*
 	 * The name of the capability.  The server uses this name when
@@ -56,7 +60,7 @@ struct protocol_capability {
 	 * If a value is added to 'value', the server will advertise this
 	 * capability as "<name>=<value>" instead of "<name>".
 	 */
-	int (*advertise)(struct repository *r, struct strbuf *value);
+	advertise_fn_t advertise;
 
 	/*
 	 * Function called when a client requests the capability as a command.
@@ -67,9 +71,7 @@ struct protocol_capability {
 	 *
 	 * This field should be NULL for capabilities which are not commands.
 	 */
-	int (*command)(struct repository *r,
-		       struct strvec *keys,
-		       struct packet_reader *request);
+	command_fn_t command;
 };
 
 static struct protocol_capability capabilities[] = {
@@ -106,6 +108,19 @@ static struct protocol_capability capabilities[] = {
 	},
 };
 
+static int call_advertise(struct protocol_capability *command,
+			  struct repository *r, struct strbuf *value)
+{
+	return command->advertise(r, value);
+}
+
+static int call_command(struct protocol_capability *command,
+			struct repository *r, struct strvec *keys,
+			struct packet_reader *request)
+{
+	return command->command(r, keys, request);
+}
+
 static void advertise_capabilities(void)
 {
 	struct strbuf capability = STRBUF_INIT;
@@ -115,7 +130,7 @@ static void advertise_capabilities(void)
 	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 
-		if (c->advertise(the_repository, &value)) {
+		if (call_advertise(c, the_repository, &value)) {
 			strbuf_addstr(&capability, c->name);
 
 			if (value.len) {
@@ -155,9 +170,9 @@ static struct protocol_capability *get_capability(const char *key)
 
 static int is_valid_capability(const char *key)
 {
-	const struct protocol_capability *c = get_capability(key);
+	struct protocol_capability *c = get_capability(key);
 
-	return c && c->advertise(the_repository, NULL);
+	return c && call_advertise(c, the_repository, NULL);
 }
 
 static int is_command(const char *key, struct protocol_capability **command)
@@ -170,7 +185,7 @@ static int is_command(const char *key, struct protocol_capability **command)
 		if (*command)
 			die("command '%s' requested after already requesting command '%s'",
 			    out, (*command)->name);
-		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
+		if (!cmd || !call_advertise(cmd, the_repository, NULL) || !cmd->command)
 			die("invalid command '%s'", out);
 
 		*command = cmd;
@@ -294,7 +309,7 @@ static int process_request(void)
 	if (has_capability(&keys, "session-id", &client_sid))
 		trace2_data_string("transfer", NULL, "client-sid", client_sid);
 
-	command->command(the_repository, &keys, &reader);
+	call_command(command, the_repository, &keys, &reader);
 
 	strvec_clear(&keys);
 	return 0;
-- 
2.32.0.611.gd4a17395dfa


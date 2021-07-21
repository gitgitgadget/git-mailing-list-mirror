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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076B3C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB0D60FDA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhGUW7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhGUW7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A90C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so462854wmh.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTOiJfnIT2RXCZYRRLrLqdCWnviE/dc7wsNL07F7uGw=;
        b=JYPLvCT3bqQUo/lQYw++06SbkEpPOS65wJzsxDA1lMi3AQ4U2ZEDqdV+N4+v91evoB
         JcHFmiwAy/JEqh+wQHpanblHjB80fytQjOzVAseF233qphoqcPRC3tY6XS7aluIIoQUO
         9BDdO4AW445lbLCPPELuqY/i0MOWFXZU+s0BgQJiRAJ3WPExqkg58pkBcTEob6Q/7VVF
         KBpX2yknXluWPIoD4C5/dmPxwTfc0tETeC/T7jsHmXo63ErxLSXLASB5Qtbfkmdk9AjE
         kjl+YO7nY73VnwGgWzhV/sSrJKbHT51SgDCIPRdCiBvHGPLIEA+qLz1FxiGcWslCuGAi
         o/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTOiJfnIT2RXCZYRRLrLqdCWnviE/dc7wsNL07F7uGw=;
        b=AwWwkkTAAl0bC1HXv9nwrEuXh+jaYYqlGt2rkU4+tLfVLy+NoKZfCDfe6nvmwG0ksJ
         2UMxSUuP8Cg/UGUa3Ir00ZCF69UMqVUR9NG+zbM47YR9zu30tQKHpM+Q1NZbbdtU8H4A
         JghbgWadvQ8EUOEVdPqgawlIIIVx0X1tQ9Zbx4QXTyNUvNT9HwoA6KpFzpHy6k/sCICo
         lLRyTlwqTYDR4zGySspq8j8QaefoGJ40auti4Le6iIb2w++mJRVZn9kKEf10u2Jr+DaY
         lpm7ClT0S6D6Z5SYn8H58W/34AejMQ7+mgY7ofnXWnoau9zV9gioRisMV8GQfYiFFuT5
         0ZzQ==
X-Gm-Message-State: AOAM53044p7wo98VviD4HeePb/iin2zw2h8/N4OmIvV+XiEpEHsxflRi
        UDuaK/ttdY7rOGjJmtmqn7UJRQwE7xmmrQ==
X-Google-Smtp-Source: ABdhPJxAa3z/hQ5uv0IhL/0/tpbZGSfKPwve7jET9sn4yxcjTVJYelPk6jdUQjVSzun34Edxy/HUfA==
X-Received: by 2002:a1c:7410:: with SMTP id p16mr6151130wmc.6.1626910821411;
        Wed, 21 Jul 2021 16:40:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:21 -0700 (PDT)
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
Subject: [PATCH v3 05/12] serve.c: add call_{advertise,command}() indirection
Date:   Thu, 22 Jul 2021 01:40:06 +0200
Message-Id: <patch-05.12-99eeff6f890-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
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
2.32.0.955.ge7c5360f7e7


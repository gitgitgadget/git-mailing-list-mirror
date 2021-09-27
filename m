Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE8C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADDB6103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhI0NA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhI0NA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 09:00:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46AC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so51639935wrc.11
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IomzZ86x24zWVNUlJzN/X79HbuN8rS9DJ8UqAZrLRyA=;
        b=YmXS1fk29RrfgDTQXJFY37Z0kHgnHYASnRjZz+xPzpxafWSkHDx40Ta8Fcb7YZt1Z0
         MW5Q62a4AI5vLnz733g3GR1HzpK8j7KNXT76nmPp8PY+fn8I49EjvtsaVebhMYetahWN
         NVixkh2SxkxMmfGRkeQ3vqvhYpzJN1gDDGPSX7GgcleTk9+4A+Dncz3Sg7If671EjNfL
         e7EdkChw2YjBKIJY0COZ2l4Wt1nXht4QgtJ8XI9AG8hCfqPuX7k0M/2Jhn9A7iCjaLpl
         wgHd5RZ/gSvEfJNolNzmPQem77KG9wrnh/TlUYLoDJWCLUfC6jl6Y3rB4a5esxFhs1bn
         Trxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IomzZ86x24zWVNUlJzN/X79HbuN8rS9DJ8UqAZrLRyA=;
        b=tTIKiT3NB4XXxY3dheluMt03EL+kCX+yo6d4KOVMFHjs3kQ8jLneLGT3lm+i88hPzt
         o+GIsS8XIttX9/ePfx7Vz3iL5D2nrkmzVzJYl8mSbFxduhjA0/sBNrugCrrI8VxXoyR1
         BgiY7KzE/J4R1xVAvYn19jg7J3gZHdIHyxxkikSvlszLG4qk61C27hcGBHhVg8Fpx8lc
         Vq13/2HS1fowVpTTXMxOyEFiuxSEMFo6yZ3V8JIoxrwOubUT7khIlsblvFgL0m5pd2aA
         O6c08p79xTDLuPw4xAfPPCHWhiIOXUxMIzKTh0A7xMMl5y0Tbn/PpAPpNjA1hI6Ea28o
         WZyg==
X-Gm-Message-State: AOAM531/UbI+dDRPghPuaARa5kG2NdyTbGd4MuuhaidYx4+JdaiwEDAZ
        CC/4fyFfD0/VJ1oGPEqclF0kGreOqPNZZg==
X-Google-Smtp-Source: ABdhPJyM/3G9QTndXa2NHKfgyqvFcz81EjrHN/85mgm3rQ3CrGXfE1O+3KiGIAWgAaGJE7G7Wf1r0A==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr28362567wrr.278.1632747528731;
        Mon, 27 Sep 2021 05:58:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j21sm17562179wmj.40.2021.09.27.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:58:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
Date:   Mon, 27 Sep 2021 14:58:41 +0200
Message-Id: <patch-v2-1.5-3130693b416-20210927T125715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the hostinfo_init() function added in 01cec54e135 (daemon:
deglobalize hostname information, 2015-03-07) and instead initialize
the "struct hostinfo" with a macro.

This is the more idiomatic pattern in the codebase, and doesn't leave
us wondering when we see the *_init() function if this struct needs
more complex initialization than a macro can provide.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 daemon.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/daemon.c b/daemon.c
index 5c4cbad62d0..d80d009d1a1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -63,6 +63,12 @@ struct hostinfo {
 	unsigned int hostname_lookup_done:1;
 	unsigned int saw_extended_args:1;
 };
+#define HOSTINFO_INIT { \
+	.hostname = STRBUF_INIT, \
+	.canon_hostname = STRBUF_INIT, \
+	.ip_address = STRBUF_INIT, \
+	.tcp_port = STRBUF_INIT, \
+}
 
 static void lookup_hostname(struct hostinfo *hi);
 
@@ -727,15 +733,6 @@ static void lookup_hostname(struct hostinfo *hi)
 	}
 }
 
-static void hostinfo_init(struct hostinfo *hi)
-{
-	memset(hi, 0, sizeof(*hi));
-	strbuf_init(&hi->hostname, 0);
-	strbuf_init(&hi->canon_hostname, 0);
-	strbuf_init(&hi->ip_address, 0);
-	strbuf_init(&hi->tcp_port, 0);
-}
-
 static void hostinfo_clear(struct hostinfo *hi)
 {
 	strbuf_release(&hi->hostname);
@@ -760,11 +757,9 @@ static int execute(void)
 	char *line = packet_buffer;
 	int pktlen, len, i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
-	struct hostinfo hi;
+	struct hostinfo hi = HOSTINFO_INIT;
 	struct strvec env = STRVEC_INIT;
 
-	hostinfo_init(&hi);
-
 	if (addr)
 		loginfo("Connection from %s:%s", addr, port);
 
-- 
2.33.0.1316.gb2e9b3ba3ae


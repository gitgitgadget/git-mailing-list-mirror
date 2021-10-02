Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72405C433FE
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4730361B00
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhJBUSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhJBUSI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:18:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756DCC061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:16:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z2so9795274wmc.3
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7EohN61JJltfJHWHGID3IYcz7OTQlmI51tJlcXVt1E=;
        b=R3I8pXhVv7CQjYQm8RvVqIHvXf8OLYw8v/KoGqvoyT6sJf3fUuo0MjyIq28SYO2k2f
         wEoJAFU5/nW9Zq52ntxUGsDzmffwgYXqIi+lxl5y6IxGEBhqyXBnsY0cslMG4Vh5DG6y
         c+NFXY4Pjfw4lgnSPIBzBuC3+/Rudkth4417EUePPzpmGpfSkbOX8ZRZRIlcCg2/8Xcb
         tF+Ya7df/cmXVX9iFLFFnM0sos+vysKXDpICqT9nAvKrgDia+WkWdXxcuJd83THnCley
         Y89DC7fyYw0j7KSm+obki0cGIYzh6b8IkR2gag1V3rhRPnhwv8+cZU/PrFayua9FO9l8
         Mqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7EohN61JJltfJHWHGID3IYcz7OTQlmI51tJlcXVt1E=;
        b=b7uiBHf2Hs0a86zoMvz1hEvKRP/2WHtTym/wFnzVXdqoSKou1J5qsD2tvTeB3PORqD
         RZvuq/WS5PSi9wdeC+bsK2gWAbNZjiQYWXU9uSDaCZQLgPQRbVgvnEk2B/ewsmfCSzFR
         Bs4OLbHu9wolC/FGdAS7Ll8cdMOIYoLyyx8hZc0YA2+wvli+bnI3aDrnmJisrLMHEXgW
         gbCpAzCWxFUK7pnX/FPlXNO+hOnX15WH4pnKBGhwbKJaIRtORnvMUcliKroFjbMEu2r5
         ntI17TramAzTvQpwzDjYhWj0NLiBx+czTdjiy+fXLHc5D00DovgKII8alLV0Ib2addIL
         FfOg==
X-Gm-Message-State: AOAM5320JTybuuAVlz5UxDJX9cvTpp1/R9o4rxwsK2jpFOmr5P/ATOwR
        gqJ9J+essgtfmb0eb3a7Uxm67nZngD4pUg==
X-Google-Smtp-Source: ABdhPJx3CK7Yram9yXW+Z5XsGNuhrT9yQPhQEqxSJjpvEUldtBZW8yRhqqoATitT0hE2N28jf4TsPw==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr10769253wml.9.1633205780788;
        Sat, 02 Oct 2021 13:16:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g2sm9946009wrb.20.2021.10.02.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:16:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/5] daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
Date:   Sat,  2 Oct 2021 22:16:13 +0200
Message-Id: <patch-v4-1.5-8f3f3f97fcb-20211002T201434Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
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
2.33.0.1380.g193143c62ce


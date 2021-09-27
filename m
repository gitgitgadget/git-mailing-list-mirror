Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFD6C433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D634B60F92
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhI0AzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhI0AzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:55:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F4C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g16so47272928wrb.3
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IomzZ86x24zWVNUlJzN/X79HbuN8rS9DJ8UqAZrLRyA=;
        b=kwnRyvSBMrbew6FFUDbAUqBKsreKRl/XnUWdvEJ2SJUjz/2W+x280uVnoJPNQ9xc3w
         dtTd86tZsIU1x53XR53e+1+SosGIP6lO7pJXp0fbWB8AN7BJcjjPkbGaSFHgMUOiox6z
         daGUJdrfNJjTgR3qqwUJQco29zUw1QebXGqoSdx1bhIKBIr4tyP42uygO5I5r6876LZw
         xLmL+V8v4fTtzgJpqx9Q7H61k7AsbSkneAdQ7UcpJ0cSa7SMlOX4H8rurOwgZ4VYroU8
         G9HAlqUAmYAK+n/qYBI+W3jL3bM2kZSLuo55pvOIHPgnLliEGBXfNc/aQKxxdVdGedWU
         KIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IomzZ86x24zWVNUlJzN/X79HbuN8rS9DJ8UqAZrLRyA=;
        b=LhuJPosD8UDRl2IfQCzscsNEEmZN1GedTqP7gZDUeW1LMACBvNSmUJ12X6lVnds0V+
         1dZqp75SzAlYTt8Nkf+8qdIL0LAreh9xmgyAnHLYWeWAcyTpZAGBuhHPUKZWftx6LGh+
         SQ1OCjpGZm3evscyXxTOxbTT9YPQioVbxm3H19ER2SVbCrEV+GRViMxIYicxgJVrbB2q
         OVHKvAQDB4xz2Yn2Mvp41TScNyQcUWmNCSNJGgcirWAZ1OABaYBR5+gYfmIaDZuXoMrq
         C4KyPFW7I6ugiUODkWXaero17igJy7czQCOBHFLfB78C3a4QwHOQXYNn1mkD1oDVBgVf
         3XwQ==
X-Gm-Message-State: AOAM532pkOmJTsx7GaEFqL20q7DYeY4DN6fn+YaHfaHezRgqKNdKW8sl
        dDXOzWPYVE4gABEtpbtVnHMjnJ9tSiQSww==
X-Google-Smtp-Source: ABdhPJy4ZV5t09CAzUwq1bikTh5Hkdsmf2FVSfT6rUiA6SUJ9uJZVsHNYOXMbIlFfF1TJHON83TGHA==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr2409101wrr.294.1632704003245;
        Sun, 26 Sep 2021 17:53:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm14749745wrq.78.2021.09.26.17.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:53:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
Date:   Mon, 27 Sep 2021 02:53:15 +0200
Message-Id: <patch-1.6-3130693b416-20210927T004920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4A2C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8CE61361
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353573AbhJAK3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353569AbhJAK33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:29:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A4C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:27:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so14746630wri.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icwplYCFQXDQZ25Mnj2TxVvaPQyqdARYvXsA+5WLHW8=;
        b=p5Co9x8/gyReXYO/2OqvpxEh4HJLiUtoEuI9kcki9qu5sk0r1B5ooBB+lRwQsYfmhI
         uBHpMhNPxqmGeFyXkSq3wyFpBJoFd4wmuquXFV8kN8X9lDUSqF9xuS3WF40T1y3UNfdX
         FnQKzphEg94ejw93sFZndCy3PTxdEzTyoqUGgax14JTZ5LFO1ueIpsbXC8a8nU16EPGn
         C3BuDBqF9SE+IWNIJmhIqRWwwx/fI7DoDaj0AzNiFBJ9NHrxpfzFT30c4b/hxn1oleeW
         1LdEuv3T9PbsU7V5ii2KKOwHx6IgoMsDfaYYlVyOy1r1qQH0owjVY7iQo15BpCLdpKMs
         AZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icwplYCFQXDQZ25Mnj2TxVvaPQyqdARYvXsA+5WLHW8=;
        b=a+JAZ67Kyy8pQ1XWzlsqaB1tPt0ym+/X7DzWuCqiz7LnzfpK5sSSnAVSPe/TyHPgkp
         ZwX0oNWWLvpNShejv9V+rsmKBaiPBIwBXLh2IVCn+qt3lN2YbJ3WlECNRU0tE5KAlNSp
         AQ7SPaC/iUAX0e97iO7n9a1TYH6YOKP3xAQD21O3jGxv4pEe3v/Q2BfflqQx9yNG0hc5
         ZOh0AcBTRJg4z3cCCOm99L2/AB1NJ677E6heXL5KoD6QHb8iZYoA0UQScK2h5T0RNZI/
         YnImKmfvV74Gu82w60DEGQtN7VYI0YdwbHoF3tw3iT95DKzb86MUeEIzZkkR5q4YKPir
         d1xw==
X-Gm-Message-State: AOAM530PiVFLeprp7b2jcxMtyxyj2jkpiVsaBZI/fJ0aiggF7misO4V5
        evgsUVtKgFW72J66ee+bodU6t+OkXgyjrw==
X-Google-Smtp-Source: ABdhPJwb0tAcNHmMrKhyeV4rQnbJRUPtTGnb6CMKXuuApG4a7iySVJy0blcjOYYzT62GPoO7aGarnw==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr11181910wrs.122.1633084063915;
        Fri, 01 Oct 2021 03:27:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h7sm5398952wrx.14.2021.10.01.03.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:27:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
Date:   Fri,  1 Oct 2021 12:27:31 +0200
Message-Id: <patch-v3-1.6-8f3f3f97fcb-20211001T102056Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
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
2.33.0.1375.gbbd823cc90f


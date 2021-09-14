Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC709C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B76861164
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbhINH1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbhINH1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 03:27:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D552C061764
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a10so13692804qka.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QY3rvjAOPnajg8o1FS33HlBW4t+bK5wwKNdoOTpJmy0=;
        b=HU7bl66qkbdBZE6vqZwT/fETU3iBJJ7EV+KNQkQETZywSN15F4RZWg8WBwlJC/GMEq
         UOW0dif00uXhcOhOicRDYrvkznSFX+ljmhwhl3c0SUHKW/52zJLOax1dbBq/YdWlZX6W
         1tOHx8RCQQWorZRKr+icm77XhBtQpEQpe05FJEyS1tcOKFSMiyBr6Slut6NXdBOL4VEd
         fdZZmeampiqmzKEbFgdiSmo5bcL66+h3xXfwryPg4ihLjqz0JT+ts4w0cLmFelyDTX+1
         yyhqQy+3Oe4ixFGbkpCIasS7PDNyeR+K2nlvQxebiw0AukObYVvw6SuDbVd0EdUtP3iG
         Ho+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QY3rvjAOPnajg8o1FS33HlBW4t+bK5wwKNdoOTpJmy0=;
        b=A11eoApoAgwCX0qpSKWe+BMx//PW/HaHg8lvdDnB7uHkKI4gc5t3FvB7moFnihGFnu
         kfcyf8I1LGKSd4vPQBfnp8OKOC+Szlzm6HM/gwpnkp0V7mE+sqVTOS9kQmwpb38I02j5
         iDjHsUzVplO1pMdDjOb4N8mlnw3/ZzeOUuZtotM+vg1m4d1BmVH1i8IbGmUB78HJPcmh
         UdC6tjRdsnw2Bzrzio6I3G4GtfEjgA3h3bjKcuZ6tevSJ4tG5nnu83nZjPBPfx0vtSf2
         v1JWj8aKmD4xXIXa5/oj/V1afr3HVkyrh7J9llRQKF5jY39pcgns5OYY85TqvIFInsP1
         PSUQ==
X-Gm-Message-State: AOAM530Wm6FiOfMammtEmSy3/MunI7hYYYtp9RPMRGTZqv4V6R+cgMAJ
        +WXPtxhqA06n/B5KziZAkD5Q+raDVtk=
X-Google-Smtp-Source: ABdhPJw4iiQ6nebwdMSovO4FUN+7L6NSQrrhSKgd+wmXmWgggFDBmiQXRXGRXKVFmglGncrF98m/+w==
X-Received: by 2002:a37:8044:: with SMTP id b65mr3504346qkd.295.1631604379334;
        Tue, 14 Sep 2021 00:26:19 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o12sm5486554qtt.94.2021.09.14.00.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:26:19 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 2/3] credential-cache: check for windows specific errors
Date:   Tue, 14 Sep 2021 00:25:59 -0700
Message-Id: <20210914072600.11552-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210914072600.11552-1-carenas@gmail.com>
References: <20210913085600.35506-1-carenas@gmail.com>
 <20210914072600.11552-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Connect and reset errors aren't what will be expected by POSIX but
are instead compatible with the ones used by WinSock.

To avoid any possibility of confusion with other systems, checks
for disconnection and availability had been abstracted into helper
functions that are platform specific.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v3:
* use a better define as suggested by Dscho
v2:
* Use helper functions to separate error handling as suggested by Junio

 builtin/credential-cache.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index e8a7415747..78c02ad531 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -11,6 +11,32 @@
 #define FLAG_SPAWN 0x1
 #define FLAG_RELAY 0x2
 
+#ifdef GIT_WINDOWS_NATIVE
+
+static int connection_closed(int error)
+{
+	return (error == EINVAL);
+}
+
+static int connection_fatally_broken(int error)
+{
+	return (error != ENOENT) && (error != ENETDOWN);
+}
+
+#else
+
+static int connection_closed(int error)
+{
+	return (error == ECONNRESET);
+}
+
+static int connection_fatally_broken(int error)
+{
+	return (error != ENOENT) && (error != ECONNREFUSED);
+}
+
+#endif
+
 static int send_request(const char *socket, const struct strbuf *out)
 {
 	int got_data = 0;
@@ -28,7 +54,7 @@ static int send_request(const char *socket, const struct strbuf *out)
 		int r;
 
 		r = read_in_full(fd, in, sizeof(in));
-		if (r == 0 || (r < 0 && errno == ECONNRESET))
+		if (r == 0 || (r < 0 && connection_closed(errno)))
 			break;
 		if (r < 0)
 			die_errno("read error from cache daemon");
@@ -75,7 +101,7 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	}
 
 	if (send_request(socket, &buf) < 0) {
-		if (errno != ENOENT && errno != ECONNREFUSED)
+		if (connection_fatally_broken(errno))
 			die_errno("unable to connect to cache daemon");
 		if (flags & FLAG_SPAWN) {
 			spawn_daemon(socket);
-- 
2.33.0.481.g26d3bed244


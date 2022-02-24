Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBEC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiBXJdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBXJdn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04B269A8E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:13 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c192so732526wma.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGzTC6z1OY5uudc7Qpzwkc64PxTnbNBJXPlcPruFrqQ=;
        b=VlA3Dpo+htQoCSCa7Qhawt6sFYGNbl6Wl94gGqej0L/SS/trhk/8f5Cm2qkun8Meu6
         Za+B1MpdTQZjPaW/tKI36kTU/cnVDEb6vOHhHtMJWrsoz3KvvU2AtIVmB7pQqrg5+6pw
         NCRO/IOyAO67NMedJj1YhFS16OmmziKOG97Q5agOPxgRHXcpOy2mx774a1d7h3sVLsCK
         OuRaN7/ThbgO66TwJHOQswkz3BX5VK0HEzVogksR7Rj0owHwU1UMPaVq/OF47vQKT55T
         +98ocZC0g/uBA83ChxrQCzXqVgDM8tfZpa8W9uaVGPo4/wp1itjncpw43RS+ZS/HYrhe
         CeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGzTC6z1OY5uudc7Qpzwkc64PxTnbNBJXPlcPruFrqQ=;
        b=cjIf2FWfkDQQZFCWDlwZ1uzEdtovSaz1VsvpQT5WPN6DksXNs0Y2qxCKXop2NAId0J
         ss9lJib3x/UxXuAPWcsCOrjwsuPJtYXhLGMRTMpMMlnhqCepfluDsody8aSA4N0gZRKT
         p8OgATh2AhuFFp1uMyOG/NV4Q9w2xD/XT9KJ30PeSwo4+vulWjXL4XPcJDOAcZc3YkB+
         MU98j6B4HA/L4Gq1yB+J9ZhEAw631YcoWa6KjnXXk8Xp4dQw7I90PeBlEiAj36/bJ4K3
         Lb/QAdehS10d/PJJ5VAU5tK7e8359QbXc+01Hgn45WJKIYcRbcTwaTSfIuy5yyiy8Hcp
         yTtQ==
X-Gm-Message-State: AOAM531V3RxydTtNbHAFBZTn1uwxRcgx2Oaemts4jWSmPa5Q6k/4p0mP
        lhW+lwLZW1rLECwrwJ7N3m5MSrdKAg05uw==
X-Google-Smtp-Source: ABdhPJynMj3ZysmlNbuiAq+kWRi5xVAs9un1SPEEm/vp4rQLSUhdOjHcSVGp2bK/6duyPP8HC+9fzA==
X-Received: by 2002:a05:600c:2e54:b0:380:d3c8:ef33 with SMTP id q20-20020a05600c2e5400b00380d3c8ef33mr1469453wmf.69.1645695191606;
        Thu, 24 Feb 2022 01:33:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/12] imap-send.c: use designated initializers for "struct imap_server_conf"
Date:   Thu, 24 Feb 2022 10:32:56 +0100
Message-Id: <patch-01.12-e4a7054bef4-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cut down a lot on the verbosity of the "server" assignment in
imap-send.c using designated initializers, only the "ssl_verify"
member was being set to a non-NULL non-0 value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 imap-send.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index e6090a0346a..5ac6fa9c664 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -98,17 +98,7 @@ struct imap_server_conf {
 };
 
 static struct imap_server_conf server = {
-	NULL,	/* name */
-	NULL,	/* tunnel */
-	NULL,	/* host */
-	0,	/* port */
-	NULL,	/* folder */
-	NULL,	/* user */
-	NULL,	/* pass */
-	0,   	/* use_ssl */
-	1,   	/* ssl_verify */
-	0,   	/* use_html */
-	NULL,	/* auth_method */
+	.ssl_verify = 1,
 };
 
 struct imap_socket {
-- 
2.35.1.1157.g524e2d5a0db


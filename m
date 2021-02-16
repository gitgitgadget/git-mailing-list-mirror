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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ACCC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A8264DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBPMFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhBPMCR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:02:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD58DC06121D
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l17so8932265wmq.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbFuVlkdL+cvefCBepqIeb6uX/e5I4QKr2ytrg07Zhg=;
        b=OsXx7r16dSdrszjwpphTmOXAG414vAZA8a05yqSu9gMUS0T77HEiIC9IRHf+VHmQkF
         /r3/Im77V+mBxkHOMLXTMKZVOoXPmd3MyoWlXP302IzBE+aCFTziMJSGT3XEVgaEOgR4
         2Qq8mNSr/0EspA1hVOaUKa8JZYnbHMptT4Vkb9Hw1HRxH2hEOptV/JVBOSTpkmKR2QBX
         m5/oDsKdX7ARAK9D5FVlYOF0hkhRtyoA3c8b3CpNPNLZu8I3M4FFAVyXmzFarUe3ShEx
         qNBAoqn3nJFnj08oqAX2ZpHt67PFWDzPoegNLWh88XryRwWQbwKfDNhU+2E2Jqw08TVx
         MqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbFuVlkdL+cvefCBepqIeb6uX/e5I4QKr2ytrg07Zhg=;
        b=Hnbptnpc27rtDeyOq0nFoXsLUy1K/Edft2Ol9WJ1Pca5VwWicV72JZ6erSY5IGY6hq
         ey02MO0EJ6abg7BdmClciE3Wxpb/b5U4UyQpArIgpn1aR4DPVK6uHQTwsMRHZwVrV4R5
         4+4cVjlaRBLcmmS0flA0Oer5fgQKw/u7jTWL5qpTmBUKo1jcDG4B9UuXYKvOHyEFK0bf
         uYOGnHefvRX1LfJskETcgi0LYHK/b//Ib8e84bYOIUCmcbu+GpKqQvRoizkYYxTgpyID
         F3+sfJoj6xYNdJwlRb0cjISqmftf4AhWELaCO1qZCgvjWUigvEMBXWw/VGFJgTymgKeT
         uGTw==
X-Gm-Message-State: AOAM5313NJRnq0rIAzF/YxcU+ZoCDZAD2EYtwKMh57DferO6FsQAcXoP
        Gv+36+Cel/wU2niECPUUvZBbxQ+y8Efc2Q==
X-Google-Smtp-Source: ABdhPJxhV/bF+PVFf/C6Gf3qq9zKbXB29843WMl+esyb6HKYiTvPz27AywfZJUfhHrB7BR1DO1byrg==
X-Received: by 2002:a1c:730f:: with SMTP id d15mr3038395wmb.135.1613476708294;
        Tue, 16 Feb 2021 03:58:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/22] pickaxe -S: slightly optimize contains()
Date:   Tue, 16 Feb 2021 12:57:57 +0100
Message-Id: <20210216115801.4773-19-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "log -S<pat>" switch counts occurrences of <pat> on the
pre-image and post-image of a change. As soon as we know we had e.g. 1
before and 2 now we can stop, we don't need to keep counting past 2.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 66e34d254f1..76c178bae2b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -68,7 +68,8 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	return ecbdata.hit;
 }
 
-static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
+static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws,
+			     unsigned int limit)
 {
 	unsigned int cnt = 0;
 	unsigned long sz = mf->size;
@@ -88,6 +89,9 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 				sz--;
 			}
 			cnt++;
+
+			if (limit && cnt == limit)
+				return cnt;
 		}
 
 	} else { /* Classic exact string match */
@@ -99,6 +103,9 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 			sz -= offset + kwsm.size[0];
 			data += offset + kwsm.size[0];
 			cnt++;
+
+			if (limit && cnt == limit)
+				return cnt;
 		}
 	}
 	return cnt;
@@ -108,8 +115,8 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	unsigned int c1 = one ? contains(one, regexp, kws) : 0;
-	unsigned int c2 = two ? contains(two, regexp, kws) : 0;
+	unsigned int c1 = one ? contains(one, regexp, kws, 0) : 0;
+	unsigned int c2 = two ? contains(two, regexp, kws, c1 + 1) : 0;
 	return c1 != c2;
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7


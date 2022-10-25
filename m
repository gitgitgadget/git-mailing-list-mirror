Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE94C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 12:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiJYM3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiJYM3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 08:29:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E7911E47D
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:29:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a14so17742651wru.5
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Xy3rfHatgO+s++eAWkxIOchVuJYYtwfcORqnpRNX0=;
        b=V5wuvEtLO46mO79YIFUVDiN94fudbDjzRrPBeaQyA2SWJSTs8QLajhoS1K60UPHnxA
         aV5THIIGkwwmFmC4NvQdwwoad4QaNdXXrMVu6/diRLUVUfVcjHvM08/W5majqhj1cbP5
         en9i5yml57FzCM9wp0qP/P5VjVG/ygWalQi2JhFZQ9y+NSb8CpJnFxQRdBmK4OmhTrhf
         efGekSbfa2K/VxXd2pFO94mcH8kh06TsL2q5+L7kn1tkyoS6oRc5R5q9mcj7Nkj4bHzt
         GkoJvTQlgW4+Rhc3FU0Mii48vL0MhnUrzvC7mHRRR5EkPeNaHYF5GZSVoUjTxg7dh3oQ
         KNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8Xy3rfHatgO+s++eAWkxIOchVuJYYtwfcORqnpRNX0=;
        b=HDOG9Cz4uX2ARb9rWvJJc/x1HuZjwN4SdjlpKYaKm2uFgrERiG9BfMEJSXkslgkMaL
         RBxy9yEuoP5Q6uz5fdEDJNMRmjpP0/w6+j/9vNy61PbARuIjnV1oapj4cMK+GWHBzh+b
         mt8jQFJ4pUh2vWRBfaKQ2Fu73HVzZiOaY7sXoVRMIvCAGE94CnnVMFP7pwXiIWa4EB34
         2un18z/2VqZMNzNtQq0HP/74Cd0pgeYU0VFAommwpk38RuP/cn0n0DqqWVvC4/Kl/KMv
         zHh9TJYaqdhELEm+kRnK11uUGGQEsRnXuGmCYd9EWA9MZ4c/3ZKThqKIwPAwewvBn2KS
         7Xvg==
X-Gm-Message-State: ACrzQf1ZhIPaZFKMzDLL2COqqBGVjxfQIoBqdRx+bfcA2Z4t23ycb80M
        2y6ZlClVFtaPzbrn4hWWK4a1QQy5TAY=
X-Google-Smtp-Source: AMsMyM6MKZGWlLVXIl8L6uejMy2UJbZySMOeKKZ+kdjkZ1AGwuaiHytv/LJYxFH7FGi2BJsH9ljzFA==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr24847813wrr.2.1666700973993;
        Tue, 25 Oct 2022 05:29:33 -0700 (PDT)
Received: from Precision-5550.lan (ber13-h01-176-133-175-75.dsl.sta.abo.bbox.fr. [176.133.175.75])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b00236860e7e9esm686975wrs.98.2022.10.25.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:29:33 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/2] pack-objects: allow --filter without --stdout
Date:   Tue, 25 Oct 2022 14:28:55 +0200
Message-Id: <20221025122856.20204-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.1.145.g80cce38e46.dirty
In-Reply-To: <20221025122856.20204-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20221025122856.20204-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <chriscool@tuxfamily.org>

9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
taught pack-objects to use --filter, but required the use of
--stdout since a partial clone mechanism was not yet in place to
handle missing objects. Since then, changes like 9e27beaa23
(promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
and others added support to dynamically fetch objects that were missing.

Remove the --stdout requirement so that in a follow-up commit, repack
can pass --filter to pack-objects to omit certain objects from the
resulting packfile.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05caf..d707e6230d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4385,12 +4385,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (pfd.have_revs && pfd.revs.filter.choice) {
-		if (!pack_to_stdout)
-			die(_("cannot use --filter without --stdout"));
-		if (stdin_packs)
+	if (pfd.have_revs && pfd.revs.filter.choice && stdin_packs)
 			die(_("cannot use --filter with --stdin-packs"));
-	}
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
-- 
2.38.1.145.g80cce38e46.dirty


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3310DC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CF360EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhKATME (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhKATL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:11:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7985C061766
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o14so29446618wra.12
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzlJzQtD48Z6qakgyJN9Jyj7/OVEDeqjq2OC7yZmO2s=;
        b=Z6OeyCRfMB7O9YDGJIqVYpC4Q3SGltCvqlfX3Ht63ZgIPGr2/CK4Q0vUsk3M3JXpFr
         IKNLqx+L3el7U28iGcxViiBKWhxS1Bl3wMQPDiBTQXNLC8LvXtlYHE+Zk0sbMvrH11aP
         o1oWnMPj3SGOUCUy7PYZ7LyT/PVAiPtXfU03yO0+o7dAjRZtYk29YVzPXQjccEdfjgoZ
         aRTJydH41hV7n9WzTv3mnfi1p7aX24wMkkfWa3kMGi/+QO5b+YivowCwSssrBYWet9gb
         VvG3Dr/q9zHT94ffDYk/RPkQfub3BOJ3omR80W3U407EXsIYo1VN64Os6rms6E3096YF
         exPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzlJzQtD48Z6qakgyJN9Jyj7/OVEDeqjq2OC7yZmO2s=;
        b=VObQxppQfoL/YiR25o+djRLL0llaIr2Vd/ad3uP9QXR0PTAsKSPGmWcp4qtva9a/8f
         JkYB/s7fDFdjVWpWf9CmE10aDMdRYLbSBWEgM1YlMDbdpDtqo45nBRAEvdUzR18kkpYN
         L1rseqyf/VbFnn4sZTSnji8Fx8b6hZ6sLJkvQWBhoomXWLm1wUu65QowwM1boxw8RTqF
         dH8G+a11nA01AabD04/XGUH83X5N+73CggmhsEK7Un8MMZbUX0b1U0lg92qUF/mN31SA
         OQphtruL23d4V8sR+L02yoCryKdDf4ZAOexRNriw1u+H9vTbi2JlANmKdC9/klBDPqij
         JOFw==
X-Gm-Message-State: AOAM533EiN0gD0/R+kaFzKefgmZcoXTUrTo+MY3fmjX3BQ8q7l8Lq3+i
        Rgw9bUGPeQwpqiaGiJZyCJjTA1b/JWe02zMC
X-Google-Smtp-Source: ABdhPJwUvij5mSXsnuuIcsB85tN38Av7uB1gginMWg6kEcfdg/gQP0w6N9/9IJIs2eedn9OvYEHnFw==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr9445908wrs.219.1635793762210;
        Mon, 01 Nov 2021 12:09:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/8] progress.c: add temporary variable from progress struct
Date:   Mon,  1 Nov 2021 20:09:11 +0100
Message-Id: <patch-v5-5.8-3a95613cd04-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a temporary "progress" variable for the dereferenced p_progress
pointer to a "struct progress *". Before 98a13647408 (trace2: log
progress time and throughput, 2020-05-12) we didn't dereference
"p_progress" in this function, now that we do it's easier to read the
code if we work with a "progress" struct pointer like everywhere else,
instead of a pointer to a pointer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf93..76a95cb7322 100644
--- a/progress.c
+++ b/progress.c
@@ -325,15 +325,16 @@ void stop_progress(struct progress **p_progress)
 	finish_if_sparse(*p_progress);
 
 	if (*p_progress) {
+		struct progress *progress = *p_progress;
 		trace2_data_intmax("progress", the_repository, "total_objects",
 				   (*p_progress)->total);
 
 		if ((*p_progress)->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
-- 
2.33.1.1570.g069344fdd45


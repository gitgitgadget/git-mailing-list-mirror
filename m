Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC3FC6379D
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D70208B8
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coU8eq0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKYXet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgKYXet (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:34:49 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10BC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:49 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c80so264315oib.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rhFx8cgz7NLXK+mcDt67MnwPgOaJv95HxU0iA1BqIo=;
        b=coU8eq0NG1tb40t3BcXpaQDCd4K5hdflT8kT8APbt3MIFTjU627rS+Q8fCXt7Y4eko
         x/rPN3RKAyNBRLkG1Xi9qmhC+Tx6dxUTA6AxmBtRQV8+oc7WwlRg/LiEGWIATXumc/ZS
         ICSFDdGDpct5E6b+OM+AD0fEVEii3d5uv0sDktEhhBRnEe6bDHdoToZIF5ktEHFLJWHo
         +c11ejlRJKq8vSMv/CM0JLBFDapt4B0g9Zsz6duTpQcLO5KRJ7mQW0jcBBwG0APJH8XX
         ogmSTNnTcZ6Qh9ByL3YFkwaVXTCvz45BSFM/4rM6wId5+69Xq3mcLomLOIOVECu8EFLQ
         jBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rhFx8cgz7NLXK+mcDt67MnwPgOaJv95HxU0iA1BqIo=;
        b=AXS2kw79SqII3mx05OBVHck0YQa2zkoV54+GZSRd/DLnNLIdPnynLzlH3/ptIkYfrW
         PkFCSf1HnLxDxo0eRDgO7nC1dDJ6ewdwWnXTFB0b8zY25mEKoK4SLcKTuf9UzP/zToo6
         DjmOjTwiHtupIf4e4Lhjb0lzZaXkNyG1fKnHJiz8llScX/RL/aVs6nfTe1VX1hO7jqN5
         X2snAhiUQjnwqptfchljBvm+9tICWbSc7yKmHeimMdZKpg6nyRpyW5/U/rXNXEnNC55d
         bv5Kt4rZjEqQ+uQ+IV37cQnQB5AtSG+Z8bFDtnPqRJdTnuCAeGBeDmj5fBVvVC4STwun
         MK/A==
X-Gm-Message-State: AOAM531K3xocDQc8Uqupuq5LUSf5q1oVqNTMZY+GaTv8QdI5ph2q2AgG
        Qode7qJEvZCgBG6C4pJX4WvtEvi9Up/4MQ==
X-Google-Smtp-Source: ABdhPJyICT6xq5ZaIDWO7Poag7UeYAt+58QCO6ydD6CAFdysuNYnbfqlgvbVsUInVW8j2Uf/4Dh+Dw==
X-Received: by 2002:a05:6808:494:: with SMTP id z20mr366822oid.10.1606347288843;
        Wed, 25 Nov 2020 15:34:48 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o135sm2231356ooo.38.2020.11.25.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:34:48 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/3] tests: push: trivial cleanup
Date:   Wed, 25 Nov 2020 17:34:42 -0600
Message-Id: <20201125233443.63130-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125233443.63130-1-felipe.contreras@gmail.com>
References: <20201125233443.63130-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No need to do two checkouts.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5516-fetch-push.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4077471937..245eafb170 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -457,8 +457,7 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 test_expect_success 'push with +HEAD' '
 
 	mk_test testrepo heads/master &&
-	git checkout master &&
-	git checkout -b local &&
+	git checkout -b local master &&
 	test_when_finished "git checkout master; git branch -D local" &&
 	git push testrepo master local &&
 	check_push_result testrepo $the_commit heads/master &&
-- 
2.29.2


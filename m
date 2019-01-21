Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A992E1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 19:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfAUTuW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 14:50:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42076 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfAUTuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 14:50:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so12908915qke.9
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 11:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jt0TwFalnoOs3X+JISct5xn71tVqgNgcixSW2MBMuJE=;
        b=Jk33fwqr8/4gyqC9LBVjqod1asMUYHvhxBHPKsrlz8cEvdFeSigIhYVsYOQgbBxglc
         RRduwiSDbdkakOsFspzgUgRCfR2giikHNeW6pZ2J87OcmARxzYYXwLcA3QSTjPkuIcIA
         JO54TvKOH/i2G/OE1L7odbHJToYv1+0zamj3FGLRaXvYXOsCiH5Lmr5n4514QRKPTTAa
         tD5WaM6eeY3ghx6VbaTDo1rRUhKHlTJFFjwmZWGuWyPc6aeBs9rWx26q0K0T+/kDiNMQ
         ROMMh4vCZpoIaWaDrqrjcVUQCaNPXBsKq9n/tzLCG//9/Y0Rpfy/lvMMDPPrrYShQsjy
         NxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jt0TwFalnoOs3X+JISct5xn71tVqgNgcixSW2MBMuJE=;
        b=GepYv/mwWDkuD6IKldxbQ85UbLpD4cgQ0saPjLes247APrqFA40ZqMvGii3/nuOfqL
         uGHBruV8CMFGyr4fzGDo2L+LSdymQGVb2EiNtRqQYgEjXo+x6vLECHdoxepl+NeFaz24
         f7rWjSpx9mM2fAHLdsvtJ6i0Cab5TJf/QuIod5qHbuHskVVaJTyijJ11GliG8omR1FoV
         heMw2OW7PzChPaFhEi83QVNUUdv0pmVZ66PxBWfzM3u/Q9VCVrK/QKxlaCVRJ2wOwppA
         GlT2aAXFK36xMAQRUgy8bb4QnX5PCVs+aiRkCvIG2+sxNS66h5ML2S6fSl654eBBvbsb
         JGSw==
X-Gm-Message-State: AJcUukeboWdmX6lh3Eo9JWIcGfuBowOD0K5A33PCY7ZQeDVRuS24jpSF
        T/qPt006udhmv79EMzX0zGIbLRW8u9Q=
X-Google-Smtp-Source: ALg8bN67doFZ0kGyxsbeWLP9qBx46Q812tfq2A2GSu7wfXz6cLzSLqmVj0YcSaU8ApKwcTpED6XvXg==
X-Received: by 2002:ae9:f212:: with SMTP id m18mr25224501qkg.5.1548100220036;
        Mon, 21 Jan 2019 11:50:20 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n62sm22760625qkn.43.2019.01.21.11.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 11:50:18 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     asottile@umich.edu, benpeart@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com, peartben@gmail.com
Subject: [PATCH v2 1/2] checkout: add test to demonstrate regression with checkout -b on initial commit
Date:   Mon, 21 Jan 2019 14:50:07 -0500
Message-Id: <20190121195008.8700-2-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190121195008.8700-1-peartben@gmail.com>
References: <20190118185558.17688-1-peartben@gmail.com>
 <20190121195008.8700-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Commit fa655d8411 (checkout: optimize "git checkout -b <new_branch>", 2018-08-16)
introduced an unintentional change in behavior for 'checkout -b' after doing
'clone --no-checkout'.  Add a test to demonstrate the changed behavior to be
used in a later patch to verify the fix.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t2018-checkout-branch.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 2131fb2a56..6da2d4e68f 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -198,4 +198,13 @@ test_expect_success 'checkout -B to the current branch works' '
 	test_dirty_mergeable
 '
 
+test_expect_failure 'checkout -b after clone --no-checkout does a checkout of HEAD' '
+	git init src &&
+	test_commit -C src a &&
+	rev="$(git -C src rev-parse HEAD)" &&
+	git clone --no-checkout src dest &&
+	git -C dest checkout "$rev" -b branch &&
+	test_path_is_file dest/a.t
+'
+
 test_done
-- 
2.19.1.gvfs.1.16.g9d1374d


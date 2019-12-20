Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF6C2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E112064B
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrisMvnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLTSOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35761 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLTSOh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id i23so216546pfo.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWeg/wl9RrK6mqFq+reQZd+RrvAMP1+PT+GY5lcwJck=;
        b=MrisMvnbMA6+/h6WnOvvMszYRzjd2cw7NkL28d6skpjNKhN/mFD05W9gjI2ZxCc/JH
         K9sld4NkcjBnjXEvrUEBrT3knlHHfPqQ+9CRThpMdF8tir63gCM1k+t6J/8jBcC2Ri81
         JNx/4piinD3ufs6pk9sOE3oJ58odTtq43e8I2tHjjCSdBOJjt0HBzTzKoN0YbvNBkzzL
         4IKjHfMGthRtO16a36fjBeAtZDntBBHlKO9LCkatIVuY8SmvDjScYnRJvdxnwYHa6L+2
         yGtpd3nN8OSgmfNVYRtRlxaDqyHWJuAPgYKLmPqgfAf/A6cO/MMe4d1YdAHeD2KfKVWa
         zozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWeg/wl9RrK6mqFq+reQZd+RrvAMP1+PT+GY5lcwJck=;
        b=qqr05BqvxuIG2F2c8KvVEMwJLBmOn8TxOfMoeddw04gdP9+vSGVEg0JDxL6fm+25g1
         W+ww/NlD1ngqNUNu1GjptXylGG9wrldoiDj5B6NstEK8ZEZkPz/iPBkJNZGOgOCkrZkY
         Nco2LA5LtiwiHHcvlrGBGWgTD8PStJDESvQBzqC1h5Zz9pbDvWfsI57OJAeFxU2MQJX2
         wIwmOk2JYwgjNXx8UPW3G6zEvNb2KR8+9AVXlciGklRF7x9iFkt+ebnb3KM0Fqglo5nJ
         /onjhNPvVDl9KZrK0YvZPiKJBcd4TBkjMJ8o70fefVMUNF4pNy9hA63hkVYm+144XNEU
         zJwA==
X-Gm-Message-State: APjAAAWBxv9fmiA7yiuCRDIngs9UHyB+jzczzJ4BswNUiEYHu1DP2hZo
        WO0NeMrmmasGdh5Sx1sTVIZgAMG2
X-Google-Smtp-Source: APXvYqz4ck+z2U10GRI1qa37crM5y3bHkEv0MQtrVr9lwDllOQXYgLuhjZz/9w3EtZtXuq/J3BdW2g==
X-Received: by 2002:a62:a117:: with SMTP id b23mr17953271pff.174.1576865676347;
        Fri, 20 Dec 2019 10:14:36 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:35 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/15] t0003: use named parameters in attr_check()
Date:   Fri, 20 Dec 2019 10:15:50 -0800
Message-Id: <9374fcd8db831b411c1485c204cf8d029426e966.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had named the parameters in attr_check() but $2 was being used
instead of $expect. Make all variable accesses in attr_check() use named
variables instead of numbered arguments for clarity.

While we're at it, add variable assignments to the &&-chain. These
aren't ever expected to fail but if a future developer ever adds some
code above the assignments and they could fail in some way, the intact
&&-chain will ensure that the failure is caught.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 71e63d8b50..3569bef75d 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -5,19 +5,16 @@ test_description=gitattributes
 . ./test-lib.sh
 
 attr_check () {
-	path="$1" expect="$2"
+	path="$1" expect="$2" git_opts="$3" &&
 
-	git $3 check-attr test -- "$path" >actual 2>err &&
-	echo "$path: test: $2" >expect &&
+	git $git_opts check-attr test -- "$path" >actual 2>err &&
+	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual &&
 	test_line_count = 0 err
 }
 
 attr_check_quote () {
-
-	path="$1"
-	quoted_path="$2"
-	expect="$3"
+	path="$1" quoted_path="$2" expect="$3" &&
 
 	git check-attr test -- "$path" >actual &&
 	echo "\"$quoted_path\": test: $expect" >expect &&
-- 
2.24.1.703.g2f499f1283


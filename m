Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90A320951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbdCNVrE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:04 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33086 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdCNVrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:02 -0400
Received: by mail-pf0-f174.google.com with SMTP id w189so75907504pfb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UOEocnF5PoOFTtXUNcmXpNYsBijbs7q3OEPvCbJkF0o=;
        b=XEzZev4DlJKOwtb/DtlkCq+/LAu8LRrCk7apvLM+/uT46BYO7RTZ8rK6Z5NMhrgtv8
         o9ohO2f2TV6NPg6BwOKe7ZWJCM6Ir/I9+rZBavKjby9SUmAKGeoG9YFIpYrecH8IVrGc
         IIp+W7aKQ4GzOD2etKzbiEQNaGV0t4CyVDfIF8ue5gc1ykwtAAu4IXYZv+ym3l9Yp1V3
         oM7So+BhrjhDHaJn269+SskMJt4MzjWRKViv2Echhz6deMF5b1qGzKSrpDUu8w80p5Yn
         H0b0hcwRrVYeaEWo4YueHfQbIpld6KdYXJboFDzIoolrYBnqMDm/YOj86Acoou8ts7d2
         xn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UOEocnF5PoOFTtXUNcmXpNYsBijbs7q3OEPvCbJkF0o=;
        b=K6hiyXmK/RWPgsw4Nc6II5Ci6ucY8W6GVkESTjMiIJobarXe7amLwZUzQ1xYAv2RJf
         vZNA88e9k7sT84NHWfBIjPJf7oOfT5FRAh9jcxvSy4r8Y3pZVlTQpZGzkvz+dhxBtLDJ
         sn2CaNievwJs0NQsMKYOmTuc9LjTH6Ymp7pVZIUAGH1cv/eIqt2FcprHrdYYTXLK2ahr
         hrMXYDiGK9XWDLS6u+0eecQrCa66shNN8WqUlRditOBVT4Di+N9ZooHufzsMhz9Uo7rd
         8aHu4GIgFXoNZ93fp14fTo7MqCyVf/OrR41LHS+ieirPlefal4NK2oKLFvk7q6zvMf7h
         +18w==
X-Gm-Message-State: AMke39naaJRCsI3iy6dc92JhJcyy0ZEepR3JiQ1lhjS0rQnWKYKSTCMXaoM5RPFnn18vZOj8
X-Received: by 10.98.72.199 with SMTP id q68mr46684815pfi.152.1489528015743;
        Tue, 14 Mar 2017 14:46:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id e76sm40261678pfk.75.2017.03.14.14.46.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 05/19] lib-submodule-update: teach test_submodule_content the -C <dir> flag
Date:   Tue, 14 Mar 2017 14:46:28 -0700
Message-Id: <20170314214642.7701-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index c0d6325133..00128f28b5 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -193,6 +193,11 @@ test_superproject_content () {
 # Test that the given submodule at path "$1" contains the content according
 # to the submodule commit recorded in the superproject's commit "$2"
 test_submodule_content () {
+	if test x"$1" = "x-C"
+	then
+		cd "$2"
+		shift; shift;
+	fi
 	if test $# != 2
 	then
 		echo "test_submodule_content needs two arguments"
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty


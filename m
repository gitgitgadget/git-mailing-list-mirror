Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C9C20133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbdCFVGy (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:06:54 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35273 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754123AbdCFVGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:06:53 -0500
Received: by mail-pg0-f54.google.com with SMTP id b129so70413505pgc.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5aBc1+QG1OKTb1MBIhB25cmm4PZXeh8XBO81p/93DVw=;
        b=r8I4t5lBygbeDGFV7Xwmgc6i+iO8sN67QouwcQoVHmpZM0BEVEbUKgTUCf6wU1bIvy
         glAJiJEvy9BHMjQuboTnOdibn/rvrvLfMAE9LmV5dI01NVoVaqGxsplPu39IuGEn5f7f
         +K5qT5z/66ePEWm+3E9ulwx9XIUsJYw1p3cMGXLgiXnwghro2Rp/SavW8t58pMHj8Vy1
         Z7iFi0fgl+DatmY1MrfLm2MCJM5W++qdkI5mHToDPYJMmbhd+YQeIxH8vyvCSKK/P+gu
         YN4FYEw4AAN9lydI8VwYeMPZMZeBEBo73XKytd6YOE0j8UKJnNijXyZiA7Xf6tXLYG5Y
         7EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5aBc1+QG1OKTb1MBIhB25cmm4PZXeh8XBO81p/93DVw=;
        b=TweCuR2gJTTtnauV6LmG/4kRgJDgX7UEtn3A9kMG4Le8S0oHlg5ssS766Fb6fp0VAT
         PhzEmJRwZ2jAhG/S7XjTzxuJAZwEBHBGRE2RtufFttTghNlJlvkm+rKv/tMeARDDSkEE
         CtIX+xZNcmm4JbJ/RicGevSRBt/thgagzMKrB1IQLWkixchlSKJYwDpqosFUnW373TPB
         bPOIFOXRA9ky+k+KW861olGPCyW7E/LhRTmKOLPU90FcV9m47K3yJCxhDPSJZALseogR
         BHRwMyZB6KbcJDe1VkvFU7sNfq1mog69UW3PdD70BIyO41kleegVpprO+adxeZyFFoBf
         LZwA==
X-Gm-Message-State: AMke39mxQPIIHY93U5HIcphAGFeys9Pd62/0n7uXqcoA5f+tRhJuRBKeSp81lh5w8a9iBMIT
X-Received: by 10.99.231.83 with SMTP id j19mr22610398pgk.50.1488833967375;
        Mon, 06 Mar 2017 12:59:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id o189sm41542866pga.12.2017.03.06.12.59.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 03/18] lib-submodule-update: teach test_submodule_content the -C <dir> flag
Date:   Mon,  6 Mar 2017 12:59:04 -0800
Message-Id: <20170306205919.9713-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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
2.12.0.rc1.52.ge239d7e709.dirty


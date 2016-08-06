Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5251F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbcHFULh (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:11:37 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34820 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbcHFULg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:11:36 -0400
Received: by mail-pa0-f41.google.com with SMTP id iw10so102110508pac.2
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:11:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WL348H6m/PBwj5zIdb7eqN4QJSfEtah075kgCqCc8qQ=;
        b=oA9zLzloVOhRDeOnWFgLSKfXpfc6sNo8hjAslLX9IgwQHBhNklBS85Ev/v/7LKoS5R
         uW/IGCPLd/AD/NBNZ5IAiV5cgmvLxmHuLu4uXhZeZciPhy4ZkJXsBGJNth0megSPTwPP
         Ot2g3X/EkJ2C8zqBV2R3wPX7c4gpXCOISLVVfhOR1NanT3JeZw3LbfKU9lZ0pdl2bkrX
         8zDDSuxBDwmoydv2jwj+NWECT0Ju4zPQQVDMl9yhfkh16OV8fQcLcGmsYj7t1Ynlug1E
         GGs5+QBbqgf9skC1/QONq+Vu3dutHfe7E4F1K5+gWZlf3t/l+4HiVvonTxc4KxsM4b3e
         nKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WL348H6m/PBwj5zIdb7eqN4QJSfEtah075kgCqCc8qQ=;
        b=JKdzTgj9cqIYFxzukr0TNBl/9sKgsmKW+uB4yNpLbnfr3DXbJGT114HeIfV+ihGKq7
         mtV01ZQzdosRzZER800LQ5xIeTIGhjrUaO+VWWwU4Gjsartk6RJcrHFa8pbvtcH3gTM0
         ru1qLnGz6cPUSvN3N80KX54cjyFPvzlvNVzU3l/MtAb04sZe57bNuO/eJzbp/zApgbn4
         GO8NDYUo270Q02tbEimMnRqu3aVjxKsI4IBsDrDaMf8tsZDkjUN2ND7o3swuU5J49WQ9
         7kwAGerZX+LHzWG6kgFdzccPYiGuQncEQej+GraVoQ6Cjk5YYaKujZ5pgG2nlJKBe8YW
         J9/A==
X-Gm-Message-State: AEkoouvtEM77LgoAhVTWvjPBMbKStO30hpX5RHS3PbN6j2JTG+GtTlNem3znK3msdb2Lhqvd
X-Received: by 10.66.72.40 with SMTP id a8mr142062854pav.15.1470446615784;
        Fri, 05 Aug 2016 18:23:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id e10sm30706736pay.39.2016.08.05.18.23.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 18:23:35 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, Jens.Lehmann@web.de
Cc:	git@vger.kernel.org, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/6] t7408: merge short tests, factor out testing method
Date:	Fri,  5 Aug 2016 18:23:14 -0700
Message-Id: <20160806012318.17968-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160806012318.17968-1-sbeller@google.com>
References: <20160806012318.17968-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Tests consisting of one line each can be consolidated to have fewer tests
to run as well as fewer lines of code.

When having just a few git commands, do not create a new shell but
use the -C flag in Git to execute in the correct directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7408-submodule-reference.sh | 49 +++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index beee0bb..1d9326e 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -8,6 +8,15 @@ test_description='test clone --reference'
 
 base_dir=$(pwd)
 
+test_alternate_usage() {
+	alternates_file="$1" &&
+	working_dir="$2" &&
+	test_line_count = 1 "$alternates_file" &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git -C "$working_dir" count-objects >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'preparing first repository' '
 	test_create_repo A &&
 	(
@@ -40,44 +49,20 @@ test_expect_success 'preparing superproject' '
 	)
 '
 
-test_expect_success 'submodule add --reference' '
+test_expect_success 'submodule add --reference uses alternates' '
 	(
 		cd super &&
 		git submodule add --reference ../B "file://$base_dir/A" sub &&
 		git commit -m B-super-added
-	)
-'
-
-test_expect_success 'after add: existence of info/alternates' '
-	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
-'
-
-test_expect_success 'that reference gets used with add' '
-	(
-		cd super/sub &&
-		echo "0 objects, 0 kilobytes" > expected &&
-		git count-objects > current &&
-		diff expected current
-	)
-'
-
-test_expect_success 'cloning superproject' '
-	git clone super super-clone
-'
-
-test_expect_success 'update with reference' '
-	cd super-clone && git submodule update --init --reference ../B
-'
-
-test_expect_success 'after update: existence of info/alternates' '
-	test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates
+	) &&
+	test_alternate_usage super/.git/modules/sub/objects/info/alternates super/sub
 '
 
-test_expect_success 'that reference gets used with update' '
-	cd super-clone/sub &&
-	echo "0 objects, 0 kilobytes" > expected &&
-	git count-objects > current &&
-	diff expected current
+test_expect_success 'updating superproject keeps alternates' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super-clone &&
+	git -C super-clone submodule update --init --reference ../B &&
+	test_alternate_usage super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
 test_done
-- 
2.9.2.572.g9d9644e.dirty


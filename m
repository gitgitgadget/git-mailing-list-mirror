Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904122031F
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbdCIWQC (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:02 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36777 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbdCIWQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:01 -0500
Received: by mail-pg0-f52.google.com with SMTP id g2so13776968pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFZFVT4k1RrmJhu0VkAca7+v2C5CDPmIzcaVcyDR+E0=;
        b=B5cbYyzuCJpWiISbjVmfuBKMyKJXLl92ZB6cd6PwCYLS7OBpBfSlWMllBT2gkfG90F
         9+WgZ0fadBv9c/zDdWCDiJZCfjw8P6Sd7Yu6IZUhbkfyemPXQfuzRkAhjB8yJzYVI1VF
         GuRrHk14PejZVAdwGtIcEZRO6pB08O+ygpnoW4StdTUiGeqIA6CILfIJFseiw4aQ57ts
         N/8v+zrBvGvWYGgvCy6mT9N6qpa7yWe4NVUZaVQj2CSM38MQc2K7Ips4W3Wh0bFGIBR2
         TYsJh3UubfATza1s4Z3QTKRwKDoT+68qCCpKVjanfeCN8Ua5TPE7gOA7TFrHeJM9yyyZ
         aRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFZFVT4k1RrmJhu0VkAca7+v2C5CDPmIzcaVcyDR+E0=;
        b=PcH66PAzYRcqLCruDDtjcBjt2rb5K6Bk4ArvqKXkJzofGdg7XCRmz67NGyF0z4DYXo
         2fJElVxDA3GKgp6FiJ5sg1LCxfIvCph0QMqd9wOrUJnaWwuUfxFz/td47JkjMdC+MXgn
         C1CPsXnYxhSB+Go/opzN4kqf9gSVRVbM/bT+Zb7R4G749mx2d7wTrQIGRVakdUCCP7TR
         cGJlqpt5sYtDFXc+wKGU4VIjIRMH5E/7vR9B8xdJhckmuH8k7+dlhTsWW/jwzQarQ4xc
         Ry4N7OA0bnNYSrRkUJvmeWHJ53xUMaG6DJdc4K/Pd9su1h7KiHqQ7ieCOISH8LS82+M/
         8Pcw==
X-Gm-Message-State: AMke39mU6ly4bbPrKvtcG0WMZgqbm9FVVrza8029v3p5UHFn+2A1tzVhCXF2oC2+eo/mwBKi
X-Received: by 10.99.94.71 with SMTP id s68mr15947260pgb.181.1489097760451;
        Thu, 09 Mar 2017 14:16:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id s21sm14399287pgg.65.2017.03.09.14.15.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:15:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 03/17] lib-submodule-update: teach test_submodule_content the -C <dir> flag
Date:   Thu,  9 Mar 2017 14:15:29 -0800
Message-Id: <20170309221543.15897-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b


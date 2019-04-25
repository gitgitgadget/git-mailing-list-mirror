Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D278E1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfDYRI5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 13:08:57 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51319 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYRI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 13:08:57 -0400
Received: by mail-pl1-f202.google.com with SMTP id g6so134648plp.18
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=S+aYmji8Uvl0Fyi1o8SV60lgG6qwX4jkdZPhWp4lRbY=;
        b=vd7qna+CVbwpIRpqqvGr6U7Z2+1wDqUB74zSbfHg6eAHvn+OmnDi7no3OdKqlnuICy
         6+LZNIfB1KDC3944apCjzY8xnpcEUnStHOFX0xIGPc0KD+cMpfSs1Vt1WdowqRoVssr2
         /QqeDotUTtY/002pGwbpopMAMc6qHziNc9lTOVAmXs0VNc7bqPZexCtaQLAg0lr817/S
         U4/UFILp0e67nTuGfptB/kiTNAa16R380jn7Yjv0peRcsakyM8k/Epkjhbd8+87R8nhd
         wIT3IDeqY7KX0SzQZylCAkcKNT53VjXijwHpb0EA/0KrqQvRxKEXUUC8kcwY7GJuReZv
         6JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=S+aYmji8Uvl0Fyi1o8SV60lgG6qwX4jkdZPhWp4lRbY=;
        b=lFcTSZG7P34tvdbC4npEILMT9z35jbfLPrHLYHrQA/LqZA4MaQk2Yx9qTurDwGF0wY
         DLEjhsrmJaLfgen1fkQXRvsBtvFLOMLgHysfZFnNkva+IBpagYrZQZEtqIEdbH6c7HRD
         7YErvhlX4GOZCneakm6pEWJKMMjvYvfv9eejruKoWccoHq5uQ2s1tQ36AIZNqf42hgIT
         Jfrb2VhPNxsO5DnybLMRTFBnhQh5SJWoT/ukz0WNBYTJyzy1CbA2U/OlC9dIJTz+zURH
         BlWpBn37O3rdNaf+5wmDKiNToaV+61MkA0UbvtPiD//8OTRqTT6VgyOSGkQUM03Rld9m
         bNVA==
X-Gm-Message-State: APjAAAWN6bvv77pPePf6MGninCcRRU3ptT19t913CY3b9NxhwWjTFESH
        9kBT3sErxVxyerE14aXqnE/KM47g1zlNd4bMDXYgOyVeLnUzcTQIy5AZaSixJCt+j5YqqSnF5xY
        s3I05T9Ub/A7g+QMMdAW8aKFW2bKcJaSXAV5TpVe2bNZXxvu7v2y6BniEYb/yt+w=
X-Google-Smtp-Source: APXvYqyzI91gcVM27cXyzb4lx7YbJ0pyMSoFBcZ4K+ssfW9DTvO9wqHqRg+nvti8sNAT+0cPCKSq46NFIKEftQ==
X-Received: by 2002:a63:1604:: with SMTP id w4mr33657901pgl.148.1556212136455;
 Thu, 25 Apr 2019 10:08:56 -0700 (PDT)
Date:   Thu, 25 Apr 2019 10:08:53 -0700
Message-Id: <548a9b833f4569c526cf94c048ae115a76d54be9.1556211995.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] trace2: fix incorrect function pointer check
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix trace2_data_json_fl() to check for the presence of pfn_data_json_fl
in its targets, rather than pfn_data_fl, which is not actually called.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 trace2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace2.c b/trace2.c
index 8bbad56887..a73cfdf6fe 100644
--- a/trace2.c
+++ b/trace2.c
@@ -717,7 +717,7 @@ void trace2_data_json_fl(const char *file, int line, const char *category,
 	us_elapsed_region = tr2tls_region_elasped_self(us_now);
 
 	for_each_wanted_builtin (j, tgt_j)
-		if (tgt_j->pfn_data_fl)
+		if (tgt_j->pfn_data_json_fl)
 			tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,
 						us_elapsed_region, category,
 						repo, key, value);
-- 
2.21.0.593.g511ec345e18-goog


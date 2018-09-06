Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0158F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeIFTt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:49:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46787 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeIFTt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:49:28 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so12614513qtn.13
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oGZh7/61UhlI6ogIikuaFH9nZcvXcCwg7YbXoNkN7F4=;
        b=QJgybtXz2PHsf6T18NsM2PGj4z2OQwfrV8mXiXcsmchmKYme8hc2iIhC1BFE2xnloF
         SVI66K4v27v/VVSgT6aHptDU2LO3u+Y5hIbhjKxTfuGteLo5NYZrylOn9tSOJicwFLqV
         IrWR/cuKHU+koq6p0vcBwOAWSIYbCR/PK2ByeUjyo0MScJwoeh+aPkt2l7en6Qwv+xZg
         78Gp4KsCNnrrln+XDbDuwtUMdFEl59HPWeeLoQZ1XC85jZUanoSmWoZ8KthUi+TLFdD4
         qGOSobFadr9kz6fPFMm0Bwc1v56jm1KYOKs+utyNLNaoUsFKORqSldvvW1WQ9y+9n3Az
         5U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oGZh7/61UhlI6ogIikuaFH9nZcvXcCwg7YbXoNkN7F4=;
        b=WwMi97K7wzlUUcpfNx3zYeRDEKA2/WIWFLm8tdd3/dTKrRiOTU41V5aKLukdqApUH2
         OxQjvEiZwgIiq7mkrC5EpdfLQ7175NRWoNdrOx2zgxz/PEBochYZgNEi2iD5/6hceU6J
         Rra403kytVJMFF/JLS80gCUI18+5ZjooLAvFyfarRsXM5SwUq+Gg+QVqoRIPAnIiOHu/
         CnRDiGEgzsYfLb3k3FVNyuPSROMiHtcHqtb+JBAdQniONNHcDcHU4+GmlrtuP43aS8iH
         goGr7u7Aj7EX58Pmqoj/svouQkAGQx8lIsVYM2pB9OrIupm0ZAMNHa9HzjTXEfOtvIKC
         XQJQ==
X-Gm-Message-State: APzg51Bwxm6SWOsW6KNlv5/56u9URS7lrAmO1g/slpFtJO4aEJ4TfMWc
        0PReR6/Vii/R/cvwoy39oPMAD8qz
X-Google-Smtp-Source: ANB0VdaCH4jBuiOsfxwcqaB1i2o85eTqzskg8IwUeIhrmH+FL5sfb+xCwS06CRuw0vpJisIinAyzOA==
X-Received: by 2002:a0c:bd96:: with SMTP id n22-v6mr2399811qvg.139.1536246809094;
        Thu, 06 Sep 2018 08:13:29 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2752030qkc.55.2018.09.06.08.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:13:22 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 1/6] commit-reach: add trace2 telemetry and walk count
Date:   Thu,  6 Sep 2018 15:13:04 +0000
Message-Id: <20180906151309.66712-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906151309.66712-1-dstolee@microsoft.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

paint_down_to_common() is used by many Git commands, and sometimes
multiple times in a single call. It is important to measure
performance of this method, but the actual time it takes can vary
due to interactions outside Git's control (file system, CPU
contention, etc.). Instead, count how many times we execute the
while loop, which is consistent between runs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 86715c103c..ee374dce20 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -38,6 +38,9 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 	struct commit_list *result = NULL;
 	int i;
 	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
+	uint32_t num_walked = 0;
+
+	trace2_region_enter("paint_down_to_common");
 
 	one->object.flags |= PARENT1;
 	if (!n) {
@@ -55,6 +58,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
+		num_walked++;
 
 		if (commit->generation > last_gen)
 			BUG("bad generation skip %8x > %8x at %s",
@@ -88,6 +92,10 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 	}
 
 	clear_prio_queue(&queue);
+
+	trace2_data_intmax("paint_down_to_common", "num_walked", num_walked);
+	trace2_region_leave("paint_down_to_common");
+
 	return result;
 }
 
-- 
2.19.0.rc2


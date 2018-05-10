Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E9B1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEJT7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:59:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43512 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeEJT7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:59:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id k11-v6so1406672pgo.10
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PSeLNprxEb3z4AWcomo3UBT0ZXjdahQSQNLsm7EU2Y=;
        b=k1V62hwUGXPe27mVhMDM+cRa1/0sGf011AcsFOPpImWuiji9LH5IxAIUhCu/kta2Id
         t3U3b6GBfeM1searhjbWjCioOpzGYx0lXBZyrUMGOlLy9wXnNxz8ieibfmYdLmDfkcfh
         rtrbfIFexzvgOPlckR2fjw7g6BI5RGwEdgKB/nYEZrcKGKuHD8rvGamRP8Uh3uasISmK
         QqPKT7OspJ/d9PRr4Qr5l7r4Q7Z1WEikb++4tt2igLNMWG7zmRjeNZnkcf0PdyiWAX0B
         sgDyajrOzbP5walj6/3GDarmjWe4/fkq8d+PiuM+3LG3YY4Iuu4ROboWtDIZIQ7zbiXV
         FpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5PSeLNprxEb3z4AWcomo3UBT0ZXjdahQSQNLsm7EU2Y=;
        b=sVJ97Tm6JtyUMIMvDk3A00cTIXEv3/D3bzIu8MXuBQP0t+zutS+Bup0xsI2f7vQc5Z
         TrX4e9X/wfRscCfAHvQ1m31Fjqp0yhzXhEC2//GPGbCwquXlrhdgCKiRSaY2aU7In7Hu
         Kyxht9MmUSK4ZsDYUNVbQQNjtJKd61a2EN+J8h1+zQDAIb3hTO3616FCIFYexBf5bqWJ
         aoTqDy/uA9LFUI4L4VgiWm5cxXBB8bL0XorJGqh1GVxTqYckcLIki2cXM/ltbEHcMbco
         sMgE9zLIAvaBGB7qvYwJu31M4PS8TAeHU7wa05Qhza5MDpD9FE/scrxQEW/Uy1XysSB2
         Faqg==
X-Gm-Message-State: ALKqPweYTiQYA2hcH4VBFbZC6MNF47Bub2k5+xYa+ctJJ7ysxz4ZevEp
        EP35LtmPH4Vd2FRFvOUZZcyNDg==
X-Google-Smtp-Source: AB8JxZqX1TOTRHmw1ZW2UjXHf7xemsyI06RqLbA/pPu9h7e/jKBABRfVMSiJHP4nCJm/5Nmh5uDMqg==
X-Received: by 2002:a63:9a02:: with SMTP id o2-v6mr2112773pge.439.1525982339450;
        Thu, 10 May 2018 12:58:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e15-v6sm2974421pgt.50.2018.05.10.12.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 12:58:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 3/4] object.c: free replace map in raw_object_store_clear
Date:   Thu, 10 May 2018 12:58:48 -0700
Message-Id: <20180510195849.28023-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510195849.28023-1-sbeller@google.com>
References: <20180510195849.28023-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The replace map for objects was missed to free in the object store in
the conversion of c1274495 ("replace-object: eliminate replace objects
prepared flag", 2018-04-11). We also missed to free the replaced objects
that are put into the replace map in that whole series.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/object.c b/object.c
index 242d922d953..80d1cae53c0 100644
--- a/object.c
+++ b/object.c
@@ -481,6 +481,9 @@ void raw_object_store_clear(struct raw_object_store *o)
 	FREE_AND_NULL(o->objectdir);
 	FREE_AND_NULL(o->alternate_db);
 
+	oidmap_free(o->replace_map, 1);
+	FREE_AND_NULL(o->replace_map);
+
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
 
-- 
2.17.0.255.g8bfb7c0704


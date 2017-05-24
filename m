Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D344320281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969120AbdEXFQT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33512 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969114AbdEXFQR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so31065700oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCQzE5kWt1LTdH6+v5Y0UVVen1LTDxj9B6VG2n6RLgA=;
        b=cJ6D/jSzVc5Z4/wHByBbh0J4wYZZMZktzRih3zIRfIEkbq1JNJFyRvrP3sQv8WiMJj
         RjdeMPNfBG7fUKg3+qGbKobmcvSqYlkA5Ly4YQSWLWT+/Cz0U6kn6vVb3UehG3O2YlMh
         PruK/Ji/CZWmcRJbnrWcXyzcjC7uPJ8+urnlGjxEgOm2Ne7bvvokXfH6OgYVoNnDrVKL
         HBc8iCqTnWji66oA0FxzElWblnjTMTX65HRXRVU5XBNKMd8Oy399nvbIFYx5pgYu372r
         cTBvNbZ7xU6iSEt26Vtiwr9S3mml1NoaqhZJgBWEtCyu+11ihpTspw4iuDeepTwRp6dx
         fOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCQzE5kWt1LTdH6+v5Y0UVVen1LTDxj9B6VG2n6RLgA=;
        b=X7dFi5+ykd0HxNE5ISlu77B2YxB70KL22HP+ntPnZKKANhzJGKr3q9/FeftPv+rCbf
         h+Mby/66hEIP9voc3ykoJAwSUYTCUsn/CIU9RH6fK+8XfsJrHlBkpT94ZKHrjmJkI0O+
         Bo3Hp4akC7ZeA0zxCpB3b18TjSRt+ucYBOvnQummlorgkyk4MMCtmyea9wChC/xOYYq9
         LSL9PhnmZ10BtPbdoNvatXpMoLmkyepZDmviBQktXU/Dc/ZMq3e3wg9WoRDWEKXul0Ig
         SwqZdsPWV4VDjoo9tZLRdG3gUAJOpfmdO4ZU+mg9UcuOc9KpFbAA9S1XGm6vU6I6ZBtT
         jhHw==
X-Gm-Message-State: AODbwcCrDdtEWupkuqGFuqhx8ErWUpZWwZ9zmADPFSIkbwTA0drFgk4B
        HQhJ1e/Wk7D7FA==
X-Received: by 10.157.14.14 with SMTP id c14mr4405819otc.90.1495602976756;
        Tue, 23 May 2017 22:16:16 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:16 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 01/29] blame: remove unneeded dependency on blob.h
Date:   Wed, 24 May 2017 00:15:09 -0500
Message-Id: <20170524051537.29978-2-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With commit 21666f1 ("convert object type handling from a string to a
number", 2007-02-26), there was no longer a need for blame.c to include
blob.h but it was not removed.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f00eda1..d39f6af 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -8,7 +8,6 @@
 #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
-#include "blob.h"
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
-- 
2.9.3


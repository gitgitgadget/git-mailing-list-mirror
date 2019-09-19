Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA211F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbfISVrn (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38196 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404918AbfISVri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so52281wmi.3
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKmsVKExkfAYw0IYzUUv32f/XB7grMwgZaMtwvnCIHk=;
        b=OPO4vQ7dGAq8T+Og+BEyb+EwgG2AKe9KHqGT6p/S2kYKDZIgX+bDbkebUAHCq1l/HW
         xiQnKPHkNYS++X3AnkKAsby2Umbu846pvM88j/BgpC2oaNj1NG0ClFFUyqAeNW1ufZn7
         ijPIXIlds5aUO/JEXVLqdqLCmcWE3gxC1esQkSkdgEU7/+JAUFvOBAEdgCu6wbdriumC
         PZYhbqox94MwrnDEd2RAfHopKK3YFREkLc6rXlCl/uC5Vz2pLFahAQZzQNqxWPsKQ7jk
         IqegSqDx+yJpM6mOLhfZyVY1F5udSlyQL6osq6FSMqsSfpnnd3TR7avDEW6KQ204Bsv0
         PMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKmsVKExkfAYw0IYzUUv32f/XB7grMwgZaMtwvnCIHk=;
        b=hrqqop2AfUHzSDGiIyHsr62EVw9mqoYV0WzAlUz3LkcmZ/eQOYLWToU26sCxHep0hK
         mHMn2iH419jBqsn8h3cEW8XwkjJmA+QRq57200nZQfOHYgx5pqw9iwtUaX/rOsHfkvxQ
         ps69NEEI8HWmNq4cxUKxD5RMT0m6IvS2LxbPh8lISIjZZo3DAlMDLfQPj2p1F5KGdsBC
         bXXkSybb0nBbPWH8jDup8yG4/zCUQLUFhXbvCsUJOBC/8P1M+B58TS0DirgfQbkeaMP7
         cTw/k0hMFUn+J+E2o+rXMbsuBHpA6APteC6cmXq15NjDoXYhnJ0h9jrE42TF8ot272ez
         pVoA==
X-Gm-Message-State: APjAAAVsXtHPB0IEmruFXlrzDCweDE8SHobjFRdNz69z7RbvT6rvz692
        4EEuhVt4wAH0ur4ujF2ocyI=
X-Google-Smtp-Source: APXvYqyEAPwMjJTy10c/WSWIAovrtBTkCdm3sy7bn30Mgl3FNQrmfJhFtzRa6J7antO5gR/YVUbO8w==
X-Received: by 2002:a1c:4102:: with SMTP id o2mr42791wma.66.1568929656480;
        Thu, 19 Sep 2019 14:47:36 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 15/15] name-rev: plug a memory leak in name_rev() in the deref case
Date:   Thu, 19 Sep 2019 23:47:11 +0200
Message-Id: <20190919214712.7348-17-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name_rev() function's 'tip_name' parameter is a freshly
xstrdup()ed string, so when name_rev() invokes:

  tip_name = xstrfmt("%s^0", tip_name);

then the original 'tip_name' string is leaked.

Make sure that this string is free()d after it has been used as input
for that xstrfmt() call.

This only happens when name_rev() is invoked with a tag, i.e.
relatively infrequently in a usual repository, so any reduction in
memory usage is lost in the noise.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 3331075aa4..d65de04918 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -101,18 +101,22 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 }
 
 static void name_rev(struct commit *start_commit,
-		const char *tip_name, timestamp_t taggerdate,
+		const char *start_tip_name, timestamp_t taggerdate,
 		int from_tag, int deref)
 {
 	struct commit_list *list = NULL;
+	const char *tip_name;
 	char *to_free = NULL;
 
 	parse_commit(start_commit);
 	if (start_commit->date < cutoff)
 		return;
 
-	if (deref)
-		tip_name = to_free = xstrfmt("%s^0", tip_name);
+	if (deref) {
+		tip_name = to_free = xstrfmt("%s^0", start_tip_name);
+		free((char*) start_tip_name);
+	} else
+		tip_name = start_tip_name;
 
 	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
 				   from_tag)) {
-- 
2.23.0.331.g4e51dcdf11


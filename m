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
	by dcvr.yhbt.net (Postfix) with ESMTP id 738731F464
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404914AbfISVrf (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50667 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404825AbfISVra (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so64675wmg.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9grYBVb2QrwHg32GGd+08YZzcMYeXCvSFlmu5NRvCE=;
        b=QLFRMZV30ivm9x8vbkxkWhrx35taIbRGFMYsQzOwxg6if5fYAs72gVkF7FV730H4zH
         C1cVyz43flmOa7TYxcK75eI8AN9T0r2+DRRKnHi1gcQs5lhtI6XsPocKs8JDwDtGTyNH
         QlMam5EpKcVmUgkyiiwKEkIAmRrAd6BWNrc54l2Gvd33IcK14PBAOjsw41pgsH9lTlah
         wI9sudynjE4kqsIgRK9xQDcD0lHuuc/7sX3Zb47joEUqWWfp2HjylYYpGnvjWctvQEvA
         /b5794scL88K0CBOrmq0wn8ASbyCumU+cfsPJNz7vNeNsWsIaIddfLJFr/pgKa1fVj4g
         jsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9grYBVb2QrwHg32GGd+08YZzcMYeXCvSFlmu5NRvCE=;
        b=NM8SDHrwtyhBP5f5EZ2ImiU7GU3gFHblOjmDPHtaLJqV6Nb391rJ15b2qp5EHllsFP
         C3+uEKSD0WYFXe6g6s8m6BGBTaCTYTXy4FscmWh967MR0YF/V3Zkc8Gkb8gUi5aXz55w
         lBVv2Qp9ZL4GtYy6188aLXbddQzh73Aa87xWlkEDEt+5vmyvgvo5nmKyPdRq24SwQVCH
         ObXhm5ySjvzAcXvkNHgF/ASKRBRIJLTROFk2h5/ess7SHUe50Uuh+OuNoM9Ki+f5hbAR
         PUuthJ4HoiMgcBMAdpJiK1cH+b10f1dRSveSIotJPxA1F46bjWDgxQuBqjBF2eMydQxR
         ACrQ==
X-Gm-Message-State: APjAAAWmQkNMA5+26Wt+hd1QBt7ZVLWcbr0vvuvxlvBqW9DEmAASltca
        kEa8ISgxchJU3Wd23HmKBr0=
X-Google-Smtp-Source: APXvYqwJgnVvXR8iUZ4zsP6mb4S12fG81bEF88cHf6XFx5JEGpUhyH8qkpQ2fVO26Isr9B3FbqEfEw==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr30322wmi.160.1568929646709;
        Thu, 19 Sep 2019 14:47:26 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/15] name-rev: extract creating/updating a 'struct name_rev' into a helper
Date:   Thu, 19 Sep 2019 23:47:02 +0200
Message-Id: <20190919214712.7348-8-szeder.dev@gmail.com>
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

In a later patch in this series we'll want to do this in two places.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index dec2228cc7..cb8ac2fa64 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -75,12 +75,36 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }
 
+static struct rev_name *create_or_update_name(struct commit *commit,
+					      const char *tip_name,
+					      timestamp_t taggerdate,
+					      int generation, int distance,
+					      int from_tag)
+{
+	struct rev_name *name = get_commit_rev_name(commit);
+
+	if (name == NULL) {
+		name = xmalloc(sizeof(*name));
+		set_commit_rev_name(commit, name);
+		goto copy_data;
+	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
+copy_data:
+		name->tip_name = tip_name;
+		name->taggerdate = taggerdate;
+		name->generation = generation;
+		name->distance = distance;
+		name->from_tag = from_tag;
+
+		return name;
+	} else
+		return NULL;
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int generation, int distance, int from_tag,
 		int deref)
 {
-	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 	char *to_free = NULL;
@@ -97,18 +121,8 @@ static void name_rev(struct commit *commit,
 			die("generation: %d, but deref?", generation);
 	}
 
-	if (name == NULL) {
-		name = xmalloc(sizeof(*name));
-		set_commit_rev_name(commit, name);
-		goto copy_data;
-	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-copy_data:
-		name->tip_name = tip_name;
-		name->taggerdate = taggerdate;
-		name->generation = generation;
-		name->distance = distance;
-		name->from_tag = from_tag;
-	} else {
+	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
+				   distance, from_tag)) {
 		free(to_free);
 		return;
 	}
-- 
2.23.0.331.g4e51dcdf11


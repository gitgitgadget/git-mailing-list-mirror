Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5164C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiI3Lgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiI3Lfo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2513DDAB
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso4866464wma.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wW3vRPdjiiACCOwHlqoltDisbTjb2a1UVWeKzYTgHKg=;
        b=UMLb5s+fH+fnvfmic7zYDx70AYbEDkaXyqpfY/AB7hm7bMryKql3QgfLdDlcavLZt3
         MeH/aDOGUrbC0LB6GU2SCmtf1GFCqmqktQ5q8HiY9SXnURMbyzU9IcsFzXKdVo9reBBa
         k8896ft5YLzAISlra2PZUTY9glEnzpy/VkdyjU61jyZd7lGvalZhxDr9epfcKQ5ggpCg
         Jw73ULkcPl3M9rPWpzh9s9JiIVYopcM0Vlk1wFYFToU4vQ8SgmJptXG0zZt/uWlr+Iv0
         TocFYLCvOfTU1AxRhNl0XBfd8HJOuw3tlWQ1r7wtLjHxn0SESnGYN060/kVd4ApsZtrZ
         rkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wW3vRPdjiiACCOwHlqoltDisbTjb2a1UVWeKzYTgHKg=;
        b=WclJkXCDOsWryeHbpNZrh0BexfNPP+ibXyVAyMYop4lTl3oT6L8NbXkVqO4kHkncRB
         fys45I1EqljcugbhZrMpOx1rwZTt9R+EqTX9X88DUeaV4YSoCrX+jn3UsGAvo1J3gKUr
         z8tQvWw9uXm9VuRepHtEbNjGGs6iQi8tVEdbJl71mAGCpt3KIgYDCG+487copymft1eB
         JmsoNpRwWZKwg37Po8PDaONVdo5mBFGrE0E/Vnsr1XvRVf2/MMB9OM/rGBBNYx8RE2gF
         M/jkI7D1ae2MMimx6/UcFW/eKlwOZP/aG/axcZZQgV5bs9pF03L07IKP/iG+IzAl7rLV
         REIQ==
X-Gm-Message-State: ACrzQf3TSN/Rh9kl2jD3ACyMVPNgaTNYn9AzDCLHM6hxor3E7epXkNZJ
        yy3pP0jbnl5gOWwwiou9djie+f4RcYkPdQ==
X-Google-Smtp-Source: AMsMyM5nbyor883IH9hUbpgwDqhcm+kiOqv37fxxIp2acm5d9gS4HQtoeOcwDHUlleob/E2yHR+9ng==
X-Received: by 2002:a05:600c:5014:b0:3b5:889:58a5 with SMTP id n20-20020a05600c501400b003b5088958a5mr5405324wmr.140.1664537305940;
        Fri, 30 Sep 2022 04:28:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/15] run-command.c: add an initializer for "struct parallel_processes"
Date:   Fri, 30 Sep 2022 13:28:06 +0200
Message-Id: <patch-09.15-015edcc42f9-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a PARALLEL_PROCESSES_INIT macro for the "struct
parallel_processes" used in run-command.c.

This allows us to do away with a call to strbuf_init(), and to rely on
other fields being NULL'd.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1a604af14fb..31a856f8b9a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1525,6 +1525,9 @@ struct parallel_processes {
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
 };
+#define PARALLEL_PROCESSES_INIT { \
+	.buffered_output = STRBUF_INIT, \
+}
 
 static int default_start_failure(struct strbuf *out,
 				 void *pp_cb,
@@ -1589,11 +1592,8 @@ static void pp_init(struct parallel_processes *pp,
 	pp->shutdown = 0;
 	pp->ungroup = ungroup;
 	CALLOC_ARRAY(pp->children, jobs);
-	if (pp->ungroup)
-		pp->pfd = NULL;
-	else
+	if (!pp->ungroup)
 		CALLOC_ARRAY(pp->pfd, jobs);
-	strbuf_init(&pp->buffered_output, 0);
 
 	for (i = 0; i < jobs; i++) {
 		strbuf_init(&pp->children[i].err, 0);
@@ -1794,7 +1794,7 @@ void run_processes_parallel(unsigned int jobs,
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	int ungroup = run_processes_parallel_ungroup;
-	struct parallel_processes pp;
+	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
 
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
-- 
2.38.0.rc2.935.g6b421ae1592


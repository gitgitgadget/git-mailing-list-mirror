Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7044920248
	for <e@80x24.org>; Sun, 31 Mar 2019 23:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfCaXMm (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 19:12:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38695 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbfCaXMl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 19:12:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so9116435wmc.3
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QUYWoxWb0J1tYNbLlwRt/n0BEjG7SOVsvpS1LzJnLZQ=;
        b=MnVMtMYsQ20vxAaEJzZBPG+NPyMdfe6i5ll22wv8VlJHkyIgXKKLukkn13Cfx1UPWb
         yJEECrHMUlRDuUAQShYSRnsDDMW5WsgT7IqTUGHgaHxEmqx/bu9UjlmLsnuVzEysVDm4
         WOggEUtpf6tNDAnZFz470CBGRTHF3W28ruOotvjf7zPjTDg+SPQrrrDdInjUN2Mp0aH5
         JGqm7KPD+lZuIIHN7MG2BKsRdeqZJW1u4bJv2gMeIcLMqDfPYfsFSysMcW2GoH426V4+
         jfhTw1ZM93GlXngfEdtpSyDOJHGK2lf1A0ZqdmCTpTDzheD+KohvggG8ti26qsvza9WT
         CsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QUYWoxWb0J1tYNbLlwRt/n0BEjG7SOVsvpS1LzJnLZQ=;
        b=GRHiyvmmRMRGl6fp+UvaUV6pk4l4Kl3y1KcO0cjHQdPhnQ8Hp7fkMx7NT5od713Jx1
         wM5I2zc3pN/iO/LUNuuKzsU9VqRdRf7pVJFuL4BdztP2kkkHPWC5fdm5FQiENk0IydRQ
         uOK3fsXIdEtejGj8wkbiteD5GDI4QMWSHj9NYyjbTeoB/bs4JbDoSrVs8FRnh6OtoGXh
         zAYCI3VHTllm+xpczDR17P4rzqCxe68rA80LNgrAWI+0PUx++eIeILokjOCg7knz1Ys4
         GwVGh7QLGEnRESW/YoI9i4lTMf0FF6oNHPiguhAcX4NHC2dr5ymP3zn83SVB9uqtO9WW
         Q6OA==
X-Gm-Message-State: APjAAAXpGLocvc+dmSvJX8kIjdIMw1GpecZw5bi7uAuo2L56vjbiR5s/
        r8kNpwNo8IB9EymHKNhf6Mk=
X-Google-Smtp-Source: APXvYqx2TmUb4FIQ7zRgze9S5AKm9OZg0OLvKj3XTSXyTsK8DzxBjJ3mDbHsrowYxtkUoVPzSBeUXw==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr10566994wmb.101.1554073959699;
        Sun, 31 Mar 2019 16:12:39 -0700 (PDT)
Received: from localhost.localdomain (x4d0c00e5.dyn.telefonica.de. [77.12.0.229])
        by smtp.gmail.com with ESMTPSA id r30sm18269459wrr.46.2019.03.31.16.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Mar 2019 16:12:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] index-pack: show progress while checking objects
Date:   Mon,  1 Apr 2019 01:12:35 +0200
Message-Id: <20190331231235.8131-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git index-pack' is run by 'git clone', its check_objects()
function usually doesn't take long enough to be a concern, but I just
run into a situation where it took about a minute or so: I
inadvertently put some memory pressure on my tiny laptop while cloning
linux.git, and then there was quite a long silence between the
"Resolving deltas" and "Checking connectivity" progress bars.

Show a progress bar during the loop of check_objects() to let the user
know that something is still going on.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/index-pack.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 31046c7a0a..ccf4eb7e9b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -219,8 +219,16 @@ static unsigned check_objects(void)
 	unsigned i, max, foreign_nr = 0;
 
 	max = get_max_object_index();
-	for (i = 0; i < max; i++)
+
+	if (verbose)
+		progress = start_delayed_progress(_("Checking objects"), max);
+
+	for (i = 0; i < max; i++) {
 		foreign_nr += check_object(get_indexed_object(i));
+		display_progress(progress, i + 1);
+	}
+
+	stop_progress(&progress);
 	return foreign_nr;
 }
 
-- 
2.21.0.539.g07239c3a71.dirty


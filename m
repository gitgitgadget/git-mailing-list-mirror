Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F0FC388F9
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0830620B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oayLES9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgKATei (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbgKATeb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:31 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A651C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:29 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a7so14617639lfk.9
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH5lezwYC3Zj4pfYQSJSrzR0Zof/a66wlzNTt5jMg30=;
        b=oayLES9cxh8gwf5iKGMQWbLtI/Fxm8IBdkYSnSD9PD8xxu7XUc3836FYpa0Jy7+S3i
         kt6Aj2gNqZVKNWaO1N2MnqMGIcAo1jnZpa7SKV4aNL8ut5l4JiDE9H1SELr/DbpvyDGU
         hwg++miFhS7uJUwcd6cz1IN2Z5f78BQMJlOPfrwVQY717y5KRKSu20NIVVs06/o98p5D
         2omBOZOZnVxdZYNE4ZxphBksfgKw9UnbjAd1Udr6BRMsBehnfqLO3R47uu0GAhwmZu2K
         7GEiCsPOyeCRpNuJgRMpbgJygyXkWiEbMgbwpVqQk1yQOzI9pEwEmtyj0S50/G6CVyYq
         ivpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH5lezwYC3Zj4pfYQSJSrzR0Zof/a66wlzNTt5jMg30=;
        b=BHzjA2YHWwpScb7eOELzTkb1JWdwy255sDHiPoP89yqjriVlBeL+gownwRjs/PaQcy
         fxDemKUNcVAGsiYboUAg7Eu8AthfR7XCaTHMJ0WYNpQGuuRq9UwguuYr30DA/hgTmPvR
         tLBHh+4BCRasdmoz82GZ5oMyGxn80MID6W4zfg7i+OS3v5vienkHmHXm1Ch04R6yB+uo
         HwYHtU7O02oo+mEB7cKpkkX4hcsYKWAMQHVJt7+gvl5V3I1m/pdzHxE9mD7MS4G13hXI
         Bje5RYKmh67CvpsQ2kp6mrtSlA3oLt/+64gl3WCyK83yRjy3T0GzWnFr//vF3zkarycN
         bA3A==
X-Gm-Message-State: AOAM533wxdsx9MwGjtonUX5zvDMsNhOuXqBfBLPj0dxhRecxI9iXAY9h
        6zjWZO4jqFYdUcjchwrqQYc=
X-Google-Smtp-Source: ABdhPJzOKB9cnFoMtrHp3zEk6KEe+RAwujDNYdh+o1EvMJKsyvR2PkxQTGVAkCLj7MHpY2WVwNu9cQ==
X-Received: by 2002:a19:4815:: with SMTP id v21mr4935080lfa.603.1604259267850;
        Sun, 01 Nov 2020 11:34:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:27 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 26/26] doc/rev-list-options: document --first-parent implies --diff-merges=first-parent
Date:   Sun,  1 Nov 2020 22:33:30 +0300
Message-Id: <20201101193330.24775-27-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before introduction of new --diff-merges options, --first-parent
implicitly changed the default diff format for merge commits to
showing only the diff with respect to the first parent, and there were
no way to get such format from "git log" without affecting history
traversal logic that --first-parent causes.

Now, after introduction of the --diff-merges=first-parent, the
--first-parent simply implies the former, and this patch corrects
documentation accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/rev-list-options.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 002379056a07..ded383e62ae5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -129,6 +129,9 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	adjusting to updated upstream from time to time, and
 	this option allows you to ignore the individual commits
 	brought in to your history by such a merge.
+ifdef::git-log[]
+	Implies `--diff-merges=first-parent`.
+endif::git-log[]
 
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
-- 
2.25.1


Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCCCC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567F922CA1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm6GnNBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHEWIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgHEWIw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:08:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81971C061757
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:08:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so14022386ljo.12
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfpWEMYvvZyYjzcOdTyEFdaPNlmRw5fq+TPEm2LYO2w=;
        b=Lm6GnNBzZTCud4y8tBfWcvLVIPPnIvOdLx+zxYB8rg8GqpmMrJfhbmUDsAtO2VcTF4
         be8QpYdJRBysC3Sv1hTVcnHAU2JGJCgFjlvppU3Z+8xnkTJO83D8dKDNngPDmwZPD/YW
         jukbs5tGk+Xd/NuOpnK5V4uEqi3DlaGrzFIO1HmFZAFuKzW858oepLibcyaclEck937E
         AZ7h9Qsv6A/LH5W9h2axwwq3IPQWugAdp2nSTnhWXQoHlOsmm22u6zT8eBTKNdYEQyDH
         ooDZa4w3JlMGX2z4owUkfMWE0AMHDV91eeGa9pxm0KQ97A9p8/qUb6zBlSmmthFj1i8S
         eP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfpWEMYvvZyYjzcOdTyEFdaPNlmRw5fq+TPEm2LYO2w=;
        b=djXq2vzRKLoT9OaY12T3WNpI6jo5Ei8Oko1oav+L3SF7Q9XT0wPi9hPtQZfkehNC7q
         clSyl9XJhTvvXm3oWpnwhw6nDW0xpOEPP5UJcYGnKjo3gdG1d0pojuXYx+3X0nalM3M3
         LbyyNc/20r3I46FuAJCsXqoTMDkdZcaH0fRDz7SrxPIMPA9G/aucTO3mASLXdLrl3qu2
         Xs2e1e4KiFJorYnd0IBDR1Ay3XV7XFYo+KXfsIMBfQMdj2nyeiAKUafPbVZtOkVouT6G
         ozze+Usdnrj/lrCAL6cK9ERh1j/JBLNDZq8JKf7dCXu1eV9S/u0p9gF57TfGxHZW1olh
         B6ZA==
X-Gm-Message-State: AOAM533hGLnCbUnXZHcBLu9Y/xJxtYXH6zEBuSi7ggDlzHzN1tsquXnC
        Ly5qndxWBjyj2Xl5TBvaXk0=
X-Google-Smtp-Source: ABdhPJx/0aGaHqTmUoBjWJT7qGpV2RSoKx1l4rP0rYS9E/J8dKgT7caZuOe2k3CqYryLl4UZnXYKMQ==
X-Received: by 2002:a2e:9e5a:: with SMTP id g26mr2570818ljk.207.1596665330049;
        Wed, 05 Aug 2020 15:08:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g18sm1544183ljk.27.2020.08.05.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:08:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH  2/3] doc/git-log: describe --diff-merges=off
Date:   Thu,  6 Aug 2020 01:08:31 +0300
Message-Id: <20200805220832.3800-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200805220832.3800-1-sorganov@gmail.com>
References: <20200805220832.3800-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-log.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 9ccba65469d7..f3727c786453 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -145,7 +145,6 @@ combined-diff option or with `--no-diff-merges`).
 	rename or copy detection have been requested).
 
 -m::
---diff-merges::
 	This flag makes the merge commits show the full diff like
 	regular commits; for each merge parent, a separate log entry
 	and diff is generated. An exception is that only diff against
@@ -153,6 +152,11 @@ combined-diff option or with `--no-diff-merges`).
 	in that case, the output represents the changes the merge
 	brought _into_ the then-current branch.
 
+--diff-merges=off::
+--no-diff-merges::
+	Disable output of diffs for merge commits (default). Useful to
+	override `-m`, `-c`, or `--cc`.
+
 :git-log: 1
 include::diff-options.txt[]
 
-- 
2.20.1


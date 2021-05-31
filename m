Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1909DC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A0861057
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhEaTx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhEaTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF41C06174A
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x15so13246381oic.13
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDwlh8AXPMncEEFKLEk3U6unvHtClflb0YM1CVsYvK0=;
        b=klxFVkZrr4zHPgO2vQCaZ9727LsWLXlS7Yk1QO9hMPAlpe34fzP/3DtTflcd/PbpZ8
         bKHWmJSudkTMvlxQXQ2jDGUgbkg6p+k2CbGbgBTXyl7R2dATq17oiNryvgxFy6mcDSt4
         OQ+dxilnIblFzYgUyuhuaUcKc3TOrpTY63yVQuunmDppjFH8ibpZKoP1sOcqBSWSrxJD
         2cZny77EE+VDrMRLwHR11uh6z7QcJ4hwNfFQX3L7yxQ9IUmGQPg432nlKTT92ES7mys7
         VKKN+QM20G/e+Vn6GdoJZHewMIq+SXr0UWrTlLaE0USoq2tNIxp0z9sUSNrS7wpYT0CI
         cP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDwlh8AXPMncEEFKLEk3U6unvHtClflb0YM1CVsYvK0=;
        b=JL6XdYU3mLRBrBmTpUH7wPAPgH44JT29NbuWwexyq20Y/jIg/vwAsXRmGzEVZVCqdd
         Nf1M38zziWI+oCqDp8A/bG2317YETHHNFskbe8sovcFLkNlh+E8VUcgb9yra/8zWkOuU
         fIb7J9hFC+TVB7Xubgl8kCYIuj63Z55tfXlmbaxrmLDWz2kjn54sBDPRFOVr1pvFwG2Y
         J/Pf7yk7kNShOQxK7E5VFz6wen4dqW5iZWKvYLTIZy9qbWaqz3OHRDKoGjkyQ/FyYR8t
         YBwnYU3m3Se9pbQTlCN2YBVyDWZYlxZmM7mGNFgRk3VIbF2YmZUlKXPnKXaU8++3evNo
         Y09w==
X-Gm-Message-State: AOAM530UiOs3BWWj4ld20I2H+ZPyCDtZZFzP+yuQ+59yvMw+pqT/gDNg
        aXSEgFlclwi0HtxG6eysnP8h5Y2gs8cgFQ==
X-Google-Smtp-Source: ABdhPJwkNfO9bWTBzFIJCHqww2bjr7vYUz3g6RrE9DniV39LMXf3VmeDOhRx2OnF/Mz/YAWSWowtfQ==
X-Received: by 2002:aca:400b:: with SMTP id n11mr14913127oia.111.1622490691305;
        Mon, 31 May 2021 12:51:31 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k14sm789809ooi.21.2021.05.31.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/13] push: split switch cases
Date:   Mon, 31 May 2021 14:51:14 -0500
Message-Id: <20210531195124.218325-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want all the cases that don't do anything with a branch first, and
then the rest. That way we will be able to get the branch and die if
there's a problem in the parent function, instead of inside the function
of each mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 0aa1d0f07d..f64b7100f0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -254,11 +254,20 @@ static void setup_default_push_refspecs(struct remote *remote)
 	int same_remote = is_same_remote(remote);
 
 	switch (push_default) {
-	default:
 	case PUSH_DEFAULT_MATCHING:
 		refspec_append(&rs, ":");
 		return;
 
+	case PUSH_DEFAULT_NOTHING:
+		die(_("You didn't specify any refspecs to push, and "
+		    "push.default is \"nothing\"."));
+		return;
+	default:
+		break;
+	}
+
+	switch (push_default) {
+	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		setup_push_simple(remote, branch, same_remote);
@@ -271,11 +280,6 @@ static void setup_default_push_refspecs(struct remote *remote)
 	case PUSH_DEFAULT_CURRENT:
 		setup_push_current(remote, branch);
 		return;
-
-	case PUSH_DEFAULT_NOTHING:
-		die(_("You didn't specify any refspecs to push, and "
-		    "push.default is \"nothing\"."));
-		return;
 	}
 }
 
-- 
2.32.0.rc0


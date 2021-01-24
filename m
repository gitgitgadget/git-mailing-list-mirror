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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37627C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A1422B48
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 06:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbhAXGC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 01:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAXGCW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 01:02:22 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C0C061574
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:40 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q131so6467908pfq.10
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 22:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EYdL5OjMK2CXLSPqJbACYpOL4vEjl0Ed2rKzj7VOyM=;
        b=LHbAb6iYhry4f3cASnBmzPxIGu0DECT/k5hgCfLeHVmp3pITR/Vwtf2VywakUF5cDd
         +vJAFfMtCs2JHcozicn/rQSl0eg24RWU8o5KpTpp/8e9c8HAAbvMNblDv7u222cCW7S9
         2DnTzalCEIVZQbgy4T8kA8R1Ug+DJCNLbf7WE8SVGAqvT5DfscPpdSrWDUSR38z4gsP/
         In97fk6tsfsfeAp7MDtolYGbCzu0xZ7D3u0rjhLZNDePm/ImUV0sgYQ5sa8MAj+dcNF/
         8/WWu/9P/ta/NcdKXb/pljkrLjte73fX40A+59mkPdBfjGJNyrRMCb/l8mAmEw5AHLyD
         Qrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EYdL5OjMK2CXLSPqJbACYpOL4vEjl0Ed2rKzj7VOyM=;
        b=Q1mwM4He/2knKmE9Na8ewkrL0HZjtSwtieFkSaCxIw+AyUoMwzcCbZg6zFCweACrj/
         +gsIV6+iYwTITLju3SvRR9BC0Klaiqmydi6no6AKmXhzAVoVyRw8Ea/jwsKIxMfWkfsE
         EfRbtXayIS4irSoeUl7h0tvtZ3uW8FC2K5ruSdaF90zyBqa8Buv5jv0WoYmLyMoasEfc
         eS3P2oL0CsLuItc+TqPhS3iY81BUQZuc+Ck/ke0VPj5q7X5w5+ENgSErPxmGvjQ1hFyt
         5KYB+yRI4vQjo380jXH/fSKXYzahHUvcli/m2Ir/Ea/mqpAyHXjapqUhULg/yvRXfKAP
         4h0w==
X-Gm-Message-State: AOAM531Wc+JRUR+tItniGeJuOAn4WRSx3OO2xEmmpImL7K9Bm1bjL8JK
        NHWe2UpGxTtTa8CeFjffKsXL1VzpVqs=
X-Google-Smtp-Source: ABdhPJyEXO5JW+DlQ6tm6/hRXc7Ioz54y2gO1+r+U6mrzJTmrKtYFseru/usdv2Vy+y0SsQKRe1CYw==
X-Received: by 2002:a63:d214:: with SMTP id a20mr12526074pgg.63.1611468099876;
        Sat, 23 Jan 2021 22:01:39 -0800 (PST)
Received: from tiger.hsd1.ca.comcast.net ([2601:646:8d80:9ab0:f634:2e28:1242:da6])
        by smtp.gmail.com with ESMTPSA id i26sm13275331pfq.219.2021.01.23.22.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 22:01:39 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 1/3] merge-ort: fix massive leak
Date:   Sat, 23 Jan 2021 22:01:10 -0800
Message-Id: <20210124060112.1258291-2-newren@gmail.com>
X-Mailer: git-send-email 2.30.0.135.g7f7d4a3e17
In-Reply-To: <20210124060112.1258291-1-newren@gmail.com>
References: <20210115192958.3336755-1-newren@gmail.com>
 <20210124060112.1258291-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a series of merges was performed (such as for a rebase or series of
cherry-picks), only the data structures allocated by the final merge
operation were being freed.  The problem was that while picking out
pieces of merge-ort to upstream, I previously misread a certain section
of merge_start() and assumed it was associated with a later
optimization.  Include that section now, which ensures that if there was
a previous merge operation, that we clear out result->priv and then
re-use it for opt->priv, and otherwise we allocate opt->priv.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 05c6b2e0dc..b5845ff6e9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3227,11 +3227,28 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	assert(opt->obuf.len == 0);
 
 	assert(opt->priv == NULL);
+	if (result->priv) {
+		opt->priv = result->priv;
+		result->priv = NULL;
+		/*
+		 * opt->priv non-NULL means we had results from a previous
+		 * run; do a few sanity checks that user didn't mess with
+		 * it in an obvious fashion.
+		 */
+		assert(opt->priv->call_depth == 0);
+		assert(!opt->priv->toplevel_dir ||
+		       0 == strlen(opt->priv->toplevel_dir));
+	}
 
 	/* Default to histogram diff.  Actually, just hardcode it...for now. */
 	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
 
 	/* Initialization of opt->priv, our internal merge data */
+	if (opt->priv) {
+		clear_or_reinit_internal_opts(opt->priv, 1);
+		trace2_region_leave("merge", "allocate/init", opt->repo);
+		return;
+	}
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 
 	/* Initialization of various renames fields */
-- 
2.30.0.135.g7f7d4a3e17


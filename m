Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B67DC4741F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA74214DB
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzNYBrdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgJ3Dm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgJ3Dmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68479C0613E1
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:00 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j7so5349137oie.12
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRq3ceItSoCNIEoFX+x4KRX7d9hx7jei8MnJe9/TxCY=;
        b=RzNYBrdWRe94C7gkM34NsiB26VhqZ4vNt8SPpgKeyrtaagPRfcXHxB9v/PZac8czEJ
         1pgJhHVLyCUh1fN2JVGEsxFHNajovI46SGSWDQrFgitelo00n6aCCRJAmoVSl6xdK7KE
         6rD+yrg+rqQGRVcvoW2wYw0r86DpF1XcTiUDhEkJQbWVBBDs6/020NVH8/Dq1jWi1ZUI
         A8RHN52FkiMXQ8EqhbOsOy1lJ3TkI1tXuT6+DHA41Z5NdmjlIrnG/Q1PUaTammFIukdT
         qPNcQB/NAmNP6EPJhyxgO2d+rl/v49ZK3u3pBe4AZtx7/PqrxwGvJYHP7uVukT1z7P44
         B7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRq3ceItSoCNIEoFX+x4KRX7d9hx7jei8MnJe9/TxCY=;
        b=J0a+OgwoVX4/RiLHkCYt0DocvMCtYYs7Z3srTaL1BFgvv/9koVhS/sWI3rBpeRS71m
         uf6rCZw1T5ZzIiooL9z0HeKQr64QxjTfxDR/nIJiFLUBqfRATOHLhvNZqsGTQQh88eOI
         FUfAlb8k3es24nXDAgC5aON0/dLk7n6Yn78zrXtuGkYaWp7HkkJoSlbSUR8ItA6GQtwk
         cdB1WTvE+Sxb1+oA6eM6UMa62O00lZuU2gNaR58qX3/Lg64Db+DFYnXa3/cxo4VJ8qGQ
         KYv2B+s9Uj3DE7D6EitaO7Ctaxuv/lKrDkU9FVrD19RXHizh7lZ02swV+2YcQF+CSwOB
         9NgA==
X-Gm-Message-State: AOAM5327IiVtUv0BDKDgU40fVrksSZzba70Af+R3cF07rM0MabJIbunK
        CJd8GXsDbveZSaa5Aoe69hfIZ3fLt1sVAg==
X-Google-Smtp-Source: ABdhPJzbB09lOL7t7qN1Rlu3pOBY6TZlC02RZmDTBofhBXLDN7GQAUd/IdvO0a2QVRGY40wYluDW7w==
X-Received: by 2002:aca:b1c2:: with SMTP id a185mr271402oif.83.1604029319681;
        Thu, 29 Oct 2020 20:41:59 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:59 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 16/20] merge-ort: basic outline for merge_switch_to_result()
Date:   Thu, 29 Oct 2020 20:41:27 -0700
Message-Id: <20201030034131.1479968-17-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a basic implementation for merge_switch_to_result(), though
just in terms of a few new empty functions that will be defined in
subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index ac58fa6f04..a5b97adfc4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -659,13 +659,53 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&dir_metadata.offsets, 0);
 }
 
+static int checkout(struct merge_options *opt,
+		    struct tree *prev,
+		    struct tree *next)
+{
+	die("Not yet implemented.");
+}
+
+static int record_unmerged_index_entries(struct merge_options *opt,
+					 struct index_state *index,
+					 struct strmap *paths,
+					 struct strmap *unmerged)
+{
+	if (strmap_empty(unmerged))
+		return 0;
+
+	die("Not yet implemented.");
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
 			    int update_worktree_and_index,
 			    int display_update_msgs)
 {
-	die("Not yet implemented");
+	assert(opt->priv == NULL);
+	if (result->clean >= 0 && update_worktree_and_index) {
+		struct merge_options_internal *opti = result->priv;
+
+		if (checkout(opt, head, result->tree)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+
+		if (record_unmerged_index_entries(opt, opt->repo->index,
+						  &opti->paths,
+						  &opti->unmerged)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+	}
+
+	if (display_update_msgs) {
+		/* TODO: print out CONFLICT and other informational messages. */
+	}
+
 	merge_finalize(opt, result);
 }
 
-- 
2.29.1.56.ga287c268e6.dirty


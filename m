Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730151F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJMDgf (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:36:35 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:37473 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJMDgf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:35 -0400
Received: by mail-io1-f73.google.com with SMTP id t4-v6so1456303iof.4
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X8etmNkm5cahn3Xe4oNKVyMsNgBR7cAD6/dP6b1S2is=;
        b=qEN3ACQKJPcbkAb+a15FxybPbjd1VIqTBDO2m71qpgxZpsqgdtKsUWxj8SzggnuMpo
         2dFIKNNuXJfDnFPA7prWNaHiF/1YLzcKqdt9coGerkym9ZpMIFy1D+is+zaNjRhBqZtg
         amDYMLwCduuIIf6bLgrgMtZFXGSN2p7ny5hB9F/M613f845gm3xs8yzFn3EMq49kkurh
         ax/AO4/+HYLEZTWzw5JL6Is53RvIR61qheDJ2Ik6KnWzq5yEpjL1Tw4fFllEigJ01QKz
         XyZ8B6tWeSvfwtvcnp78XYcuqI5HAsVMD+ALHo7MPURatwqpAwOFpS/CuLlh2knE9ZwE
         vQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X8etmNkm5cahn3Xe4oNKVyMsNgBR7cAD6/dP6b1S2is=;
        b=AJddb/4Ao5rWjrVNXO9dSsLv+GKZvBlJSwCXDcxjko3odnW4YKrOxkyYr8vjzNzIlr
         4mWDwy13sYGf1YgsjoiaSWDaaOBuLpzLS6UdM2xX0kzJkReqNFRT2ImdRN3SQZEyJgMs
         nvWdR61PQbIX8ZmrtMx4SQUAFuobtAnvjFReLjmy71kGs6Tqwq66AGKyMSoE52J27ZAB
         qM1wWRtOpzbtJ58R40DHH6lnpPEqyX4JKk39boDErd6dveThZC1gqEjJv2uY+ckjn3rq
         dEmleKGRsDScP8I4FO42WBnbmsiJR5lePhNWh+D5w4BJL169l3vRBRr1TR/8ye5AQ8vQ
         VQxw==
X-Gm-Message-State: ABuFfojDUjuAW2qz8YeEkbyvrN1LY22aSG8eb8EQmIuxkmZsdQ24mE1D
        oEP6RVr/7sMzkXSV8C+5a8YEbon19TI2zmUxMMF2inY0WiFfL0csR+ezCajfyjOI40fjzycLDHi
        HMXwkzrx8f8/g0U26r36SqhZey/DBXL5Bv6duy+1GP7tUGqxJQ3qE2hooBPg=
X-Google-Smtp-Source: ACcGV63potSKCAVK1kfnLl0vHdhdspC1oGlNf0wDefwd10X1W+zz7eOt5IP6hTe7TmzMksm9hgEprcZye3hZ
X-Received: by 2002:a24:2153:: with SMTP id e80-v6mr6223991ita.1.1539374547648;
 Fri, 12 Oct 2018 13:02:27 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:44 -0700
In-Reply-To: <cover.1539373969.git.matvore@google.com>
Message-Id: <0d1285a0ec412846e5417ec524a866f6b2c39d82.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 3/8] list-objects: always parse trees gently
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If parsing fails when revs->ignore_missing_links and
revs->exclude_promisor_objects are both false, we print the OID anyway
in the die("bad tree object...") call, so any message printed by
parse_tree_gently() is superfluous.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index ccc529e5e..f9b51db7a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -143,8 +143,6 @@ static void process_tree(struct traversal_context *ctx,
 	struct rev_info *revs = ctx->revs;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
-	int gently = revs->ignore_missing_links ||
-		     revs->exclude_promisor_objects;
 
 	if (!revs->tree_objects)
 		return;
@@ -152,7 +150,7 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, gently) < 0) {
+	if (parse_tree_gently(tree, 1) < 0) {
 		if (revs->ignore_missing_links)
 			return;
 
-- 
2.19.1.331.ge82ca0e54c-goog


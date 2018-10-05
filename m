Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB33C1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeJFEcR (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:32:17 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41937 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEcR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:32:17 -0400
Received: by mail-pf1-f202.google.com with SMTP id 87-v6so10644024pfq.8
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lRBW4T+Uj1qpBIE5Q/etFfBP2/bdQ1ZPeAB+hIuj5tY=;
        b=A4BeheiDpJERQoFqW+k6MqoeDF2pDQlRy0exoBIfJKckbuxI5hE5vYOBLp/BxOJP2o
         RyPzZlQFSdp82h8Rx/khfB76M7MHUOxH+GcLzp73pMPt/bTXWYu1ejaMiHpN7oyq+lJw
         wYOQ6vwQZrTmOT2FSMDpWKoEc9TFZ+qaR5gSUR3m6xZEsXTTdgHfZ945ZWK8CQgrdmHv
         poNn19iR2dHth4pslO3vW0y8dGCoS3Oev+8L5H8Bh9W2BZUy2dKIx3GSnJ9POk9HTfMY
         Kj2PK1AgS8sk8/1t9RAtXPy5lwCJZPx/YV8blZ5JBwoOkCBc1BzG3G/EkMHq3EdWPtLL
         afWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lRBW4T+Uj1qpBIE5Q/etFfBP2/bdQ1ZPeAB+hIuj5tY=;
        b=MivlBGXLzS4mYFZzZf//Gjy/OvctyVPmWRD8R+Y//l3BMm0OCbEkdqHs+bumHR5o3g
         Px7/ZZCoEb3VoV6QWVnwxXHpQ0j7Ox44Di+Lm6ZsSC41L6K9jqzJPYQ62z8auNsqGtJt
         o4sByDVT03+eNuWhK+ftIaOo/zhltxFL/VJReATXsFt6Jm49RbVBN/w64vtn9ElCJJ9V
         J7d55OTaUanK0Y/ITIvvZfmqafDriHhasI5wA/q+QU+yXLN2jLsF9MP+unoF2fzVPWQt
         D0sdwnNWI1ekxYB4mAPg8yT/HwcyrzeiZEOexKaq4S68JrpmVdiHGKHqmC3T7kO06zfF
         vWOw==
X-Gm-Message-State: ABuFfohY8A0AmyXKQRjEWcAQYFNnjto9n4pEc8GPZ/xf1YHsMkSKZlnv
        +Yq+8Qumdw1YMojr60FSWtV0FMiwPkwMug2rQD2tW6bO2bB2v80QU7xcTz7McaO1X+Svsmdct1+
        AI2n5nnEV9Xc74P5ZCp28U7CuZmWAS6NksrOjMwj9cpQ2WpdkGL1VSckbiGs=
X-Google-Smtp-Source: ACcGV628h1kSm9t/Hvbu4RMxsAy0cRhmnGcfyfPdC6qaxY9NT1Nh6LqXhxtgRNvCOGVw2e/OYZmEXSN/CyQX
X-Received: by 2002:a63:f553:: with SMTP id e19-v6mr5820679pgk.68.1538775103037;
 Fri, 05 Oct 2018 14:31:43 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:31:22 -0700
In-Reply-To: <cover.1538774738.git.matvore@google.com>
Message-Id: <0d1285a0ec412846e5417ec524a866f6b2c39d82.1538774738.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538774738.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v11 3/8] list-objects: always parse trees gently
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
2.19.0.605.g01d371f741-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F061F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJDCmc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:42:32 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:51049 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:42:32 -0400
Received: by mail-vs1-f73.google.com with SMTP id m5-v6so2251113vsn.17
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lRBW4T+Uj1qpBIE5Q/etFfBP2/bdQ1ZPeAB+hIuj5tY=;
        b=mxWSJI5zSifQ8ENzAXIOo+IT1U/0T7wq27yUga+fyCG7Vrhs3VOOtQ+WJ3q+m0a0HT
         DacqLpJw4f/PW7L5ODLpmpUai4/VC4Nu4CYPupClfMsKjMn5K5cFkNun3WWUkCAlRH2l
         H7M9gIUvFFJiafELkMXXIHeqZ5A5QHWLfApGG6xFnT6UuIfSYaFjWWi5OLU9Vbe0fuB5
         EaN3zP9XMui+VCZ+RrseWKtUMtj3LP/q5ygf8bD4MlM0DOCVTpPYy9hcCVFbkjwsTRGD
         3/SRsAB2aRR2FIsPZg9g2ZbfjWYopAPo2yYEupzcazPmTt/lYmuE7nmb4zzwDbLEJUjL
         RfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lRBW4T+Uj1qpBIE5Q/etFfBP2/bdQ1ZPeAB+hIuj5tY=;
        b=gNKK9mFncsfMvJYKOZzFwjPOES6UEM2BhOeD+euWcyAhy5c66sStsD3taVADLSWjVI
         P6ZMQ0/yzKNsen6QtKzldmBHQW3I1Pzmmrj8std2g5VLld++9WrTJzXcJfB09SBGNe6W
         OS2cIx24RorKH2jGATJH27N27eJ2OEkxcrPqjrqs7VPayKqSqqSri6THuBHaeMlIOSCf
         DgkDowgo/8NOa1Gu8oSa1AiZuAHS4VfEnHk6N0MoAUgw2bA2I9J9rXW2qcxoZEdVEvcx
         kjixvvT6tW+xKZf1gUan6pbhD7SwiLEyYqTM5DoMr/vFN5sMuxSzzDo5OzKLNmgJ7cKL
         v9Sw==
X-Gm-Message-State: ABuFfogGn/5asFq3R87PbD8xxO5j4iUSNwr5iXfnrq5AJUq7VX4uhoVa
        adshe8Mh8t4ACqv5CwQrSlpRzNt6XjakFN5MU7oETfhw5iGDpTEBbE2RrJGQ5qzxjAEmaOEURQm
        6OlbbwzT4Q4sOH7kAu2o1wZQf6+sY4cEKN21sonaxnnRURSxNmKBRmaBUxtg=
X-Google-Smtp-Source: ACcGV62cZ2yKSCxsg5ZTetJEHoXQ9bGmXqxsPHpTqqhvYLeT8uISHgWEZVOC5gQ2fmhcCFOml/asM6klnohE
X-Received: by 2002:a1f:ae4d:: with SMTP id x74-v6mr2736697vke.8.1538596362477;
 Wed, 03 Oct 2018 12:52:42 -0700 (PDT)
Date:   Wed,  3 Oct 2018 12:52:14 -0700
In-Reply-To: <cover.1538592829.git.matvore@google.com>
Message-Id: <0d1285a0ec412846e5417ec524a866f6b2c39d82.1538592829.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538592829.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v10 3/8] list-objects: always parse trees gently
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


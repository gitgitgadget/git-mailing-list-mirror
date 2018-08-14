Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2937E1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbeHNURX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:17:23 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:49056 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388648AbeHNURW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:17:22 -0400
Received: by mail-ua1-f73.google.com with SMTP id k17-v6so10495033uao.15
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cFs64oHbmPJN0W27R2gcFguVHvIocmtm8oG/F0UYfEQ=;
        b=U1jiY+CrCX43SEgmoMokMNQdhij2QDddDWqXJ8Z+7NlQz60v+9j+iUbAecaz0Ow1bL
         SzayIHWuJW4Ecqe7fvurktL3oe6aP0tQITdgJw7tmXJzbuQKmcXLIXHJYo1KXYmvwAyQ
         KqfWnUYeLM+byx3EUcgfvAO9tCxmwMkaVlyXdK2nlfFxP20TyyWU6kRcBSoS/fQrXgBY
         gtirGCXr4UXvswCSAJAAVw7wffeczZB1cUCPQ4o2ZGzVWGkShB4Z3O8VfvKoc2sXh4FW
         e9lgTpXCcU/b+ctlxl9DgpWpFb/PxXAbT8w+3sLXtUyZ5dNgcSt4WJxzBBCqYVhl8lm7
         6Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cFs64oHbmPJN0W27R2gcFguVHvIocmtm8oG/F0UYfEQ=;
        b=jvYi+yWZqLyZIs8/NsLfyfNKN2E56XWdzY8YKcNuaXmO0jlQ74m7W6XK2+p5evD/PO
         +Ex2vN45SVMAuv5ZklXqwmJdiqqwXrsxzogQnbPsdSh4+gOLVfmcsho9/rxyUn1E8cZe
         dlzCuKD4DsTesVcXZvPRKkUHoUqJLBbr/sZtaOl0kkAXyKZQy1gUYJ+QdI/RoipnTu/k
         ob4KEDXXwvcX8sfJVbQLnW4r4Q9C/nsjVoSRw9AGkSBYiiSUnvzctG9emH4CQ8vCFY5i
         pna7FTFXFkryzojfhuNTkethO5sg1q7Ibpde5p0J3tCvSS1fFwEZk96P4oQiOYqHPV7y
         jqyg==
X-Gm-Message-State: AOUpUlG1CnGV1ChIAe+runRjkH9v47HRz6N5Nqo4mzuhKL4vl9iNIP/Q
        VerQDOcJnM8TLx892N0DyhCzg8SDxpccPbQI26AZ2SUvKhidvsQBiVmyHkfJiB4m0YKfXi9PJRB
        zv9PVealygCxYUhx3Nnl32dXHMToooBFC7ZIV4ae6g1D6aSylR37Z2ngNwqI=
X-Google-Smtp-Source: AA+uWPzpFBXfhsc8oQPItbBAM5WP9wZYKxLkFz/AumkAlEjkCGraG7nClU663vWH4soeD67liOfFsyPNlX93
X-Received: by 2002:a1f:4043:: with SMTP id n64-v6mr12987429vka.44.1534267754685;
 Tue, 14 Aug 2018 10:29:14 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:28:10 -0700
In-Reply-To: <cover.1534267611.git.matvore@google.com>
Message-Id: <7b9ffe47c4e91d442078e1ed99b53653f5fed6a3.1534267611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534267611.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v4 3/6] list-objects: always parse trees gently
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
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
2.18.0.865.gffc8e1a3cd6-goog


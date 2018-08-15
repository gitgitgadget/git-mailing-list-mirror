Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCD91F404
	for <e@80x24.org>; Wed, 15 Aug 2018 23:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeHPCRf (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 22:17:35 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:45469 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeHPCRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 22:17:35 -0400
Received: by mail-io0-f202.google.com with SMTP id l24-v6so2406004ioj.12
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cFs64oHbmPJN0W27R2gcFguVHvIocmtm8oG/F0UYfEQ=;
        b=PKK9yUYaBE5T9Dlh63jpMjGni4VGADSpgppbZoeQvPZtNYaBT/zbFTHZm/33c+A6dC
         SuRQJQ2cJtq6v/0zppOZW/5YH4rzD5PZKV27N7gWJ/8om8JMeE+93wjUD3DDW/06QWXI
         86nS/zhaUR3IgTxxPLTEDMtsXTAOs0mW7w8qop4sbTQz32JJBXesUthmHhV6/k+YEprN
         /gSouCF7XVJpTiGQKXUZkQC4rQP1otHTaNtkc+Q0ZnZJ8Zx6xHtGOgBaKtusawgEgZ0o
         VqAVjKmACo/K88ZqRIW8euRHPs3ch+2f8MVd1bMgivRMx2bsE0bdQb3AnRbAwd2ni/Nt
         KhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cFs64oHbmPJN0W27R2gcFguVHvIocmtm8oG/F0UYfEQ=;
        b=QfNDpMfngsgVxNLYt3RZrzOVYPo7rj539hglD8lqRUhdHWHoggijSjfdE81O0H35p/
         GhqHTyN05dbuyztr+zSpeRhwDkrCCyVXfqBw3Dh/FLMZ2OJfNESBH2Li575g1hV8X4AZ
         Djq3b0embcQ6nNeCylX+2ZQjqK4YvPLwbKbSHY49WbpRBh8G87qTolhHydVwQ2p31VOs
         Se1tXftPleiwsDwPljeuAxhja3D8byu4C55ODdvf9bJdlCQqvvk0RNoOcYZ0WEstirL7
         uZAdxFT+CfKxtsRyuhYLzeO/DP7nzWXwMeSYCm9/Rii7GqDF0QReGLk1LsR81/S1Knmh
         ZPOA==
X-Gm-Message-State: AOUpUlHMchzC9eauRP95bBsXw3bCNvJ1/nE9eMhMOqDGK7zkyZT+KbdX
        vFlTr0wbGCgOwc9qG4WEO2dqn091Qoy30+RWxnakh0e1F1v/ggbAJK0nyUZQYXMylPCKo5lct2V
        Bz0KTAf1kNA/VG2lnpauLd244kDStBlqWwJM5Mg7p+hJzRLqVQN9UjwI9bgw=
X-Google-Smtp-Source: AA+uWPzGpAzGD4fURyrBba7dUzuqfEIx4SRPZ9pGC/EZHquvk3u+C2cXMrWCnYDEv8Y7EKLi5417WMpRByR5
X-Received: by 2002:a6b:9245:: with SMTP id u66-v6mr12860076iod.11.1534375393939;
 Wed, 15 Aug 2018 16:23:13 -0700 (PDT)
Date:   Wed, 15 Aug 2018 16:19:08 -0700
In-Reply-To: <cover.1534374650.git.matvore@google.com>
Message-Id: <55da169659b3c04e3f38f876744ee76eb6d0db93.1534374650.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v6 3/6] list-objects: always parse trees gently
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com
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


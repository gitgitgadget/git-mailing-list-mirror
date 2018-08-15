Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030BF1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 00:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeHODMu (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 23:12:50 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:42064 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 23:12:50 -0400
Received: by mail-qk0-f202.google.com with SMTP id m2-v6so22130504qka.9
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cFs64oHbmPJN0W27R2gcFguVHvIocmtm8oG/F0UYfEQ=;
        b=OD1Ccg1CL3votFBeLT5xTc1Zd0ttkc8iwmimG1z3hESJvio1FDOXh17CfQKeVgfTvA
         zJgLAK0xb9o6CR5tVvVVRvo41bVAXSMu75U9bonEhvsLMHod9ykYbDSXcsk1kmx5DY9P
         lZF0wd+ztIUvqOIn75oK+g5orQXkjgkvjC1IU2yZvg+1EzFiEfMa8gpQzIdGl1El3yGt
         d2zRtFw4WqX05B51JGeNqUN64Xxh92JGzE1IoSj3N6rJ1P+Q0X+Ey1kZ9FG1tCjPpi8N
         zbCj71aouav9JGbArWC3eU+b4/FI4Gt8xa5lO4biY0TAmP3nDyJcmkhQFWHscGBQC0Qt
         Asag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cFs64oHbmPJN0W27R2gcFguVHvIocmtm8oG/F0UYfEQ=;
        b=TOuZbEourCyAR7TVb13VjG+MdAphTn7rYPdQq+Q5ZKT617PNmIh3z578eW+jTabTWi
         Q9Naz7+fsuRR27QflYPRQ+YpboKgtMJmvnxIKK5nMFs3a+Iu2qZQOruxZTP+ihVgGdE0
         Bex9Nv9+VCISNIoCPUToIBQ+6W7pFYUTrMF+5fXZ9fVlbxxVO+Zx+0mvuUg7vnjaZnMR
         EVZjrWGtG5EcJcfj7e7brh4ECGnrMY8muJSiBzhBs9/T0aQXvslG9dv26ngjHu4k67YG
         onHFmVdmQw1Lj/AhBuNeZUtOe5Sc5egGhZEdxEW9QLYCXb7tGDi4MqsnScUmAzf5nSFv
         tWdg==
X-Gm-Message-State: AOUpUlEMqCUlpxcHlVuIdbm0tY/0qOCcMbIaGsveIHoTkU/JaHFpItZ6
        H8ZSM17pkGs0Xkj+lkHTT5c5Zz9w8qrRtH0PxjjEwEKa2aUF7F+Lp7faRFScSs1OZF6VOMItIBq
        tnVvljPXxkluxc+AKsTcfD7t4cIAopHZT3TJr5oNHsX602nRPNMPdYmNJews=
X-Google-Smtp-Source: AA+uWPwrkac7ioSL1ZHSo8uqDfFJcXxRbiqvAPrXEgazJIEjgetYRDUOlYu6M9m/mm5JneGpR4wkH1LCDys8
X-Received: by 2002:a0c:9b88:: with SMTP id o8-v6mr12384938qve.43.1534292589726;
 Tue, 14 Aug 2018 17:23:09 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:22:52 -0700
In-Reply-To: <cover.1534291033.git.matvore@google.com>
Message-Id: <7b9ffe47c4e91d442078e1ed99b53653f5fed6a3.1534291033.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534291033.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v5 3/6] list-objects: always parse trees gently
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B043E1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 00:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeINGIH (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 02:08:07 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:33421 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeINGIH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 02:08:07 -0400
Received: by mail-ua1-f73.google.com with SMTP id z12-v6so2601595uao.0
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tFOkoJrX1T+lw4BO0Jcp4q4CDKJpXdSkWCIbJ2xMgZA=;
        b=nYH8iCRXGznd5PCw37cpUMjccdVdhvBRzG7va5YoZnZcANlTreum8/3R/0KYhXNu/y
         DDaQhWzm0gJYl0s1qxnIy3nS5+vIOrKTdi8mGMig7bEfsUfhRoynoC8yfzLC1wqAd3HC
         VzQ0HHwskh32QXHFJSEo88Jf7QawryAa4BS431Mdy/JSfJYsJk8tlJPDrC54FIiqpoZF
         H4Xc5bR5cfrWxF8GitiJWDLastujHs6WEKrp7wG/fSVT3HorORkrkHSMkEN+1n3Bglhl
         t+g5wOATdmrfYMfza4p4nYzQ2myjZIUIjnDBd++a1hV/gzugL98vacJzhPQLJLrqG0Fs
         S10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tFOkoJrX1T+lw4BO0Jcp4q4CDKJpXdSkWCIbJ2xMgZA=;
        b=UP9DUJsDu2bbi/1b2HpouV9VZBGHc0JfmKTGqqKk7p+iaEptladYer1vgCiUlsek9L
         uh6AkQXn3jZ2HDq5vr5YNXJBnLBYo9TWs9AhrrFGAnXS/OCtzeyRHLoKOecBYBqUU8/C
         jOP1vrf4OglGcCTSnrJmq+K86Q7MqnKUovV5meM9SH1Rgz5xbk0b5QmCyarQ/c5ZKImP
         uuagZCjMryoHGuInE8pw09sIF08flWIVSo10EP50WLLCWgnr8ioZCwBvhlzGMelBIeCL
         ibhdhDafwwiWMO6OjbmWOkIfXfK0hJkgoY4dV9INPi8q/2BJBixSXINESTbrGtJJnNPx
         McrA==
X-Gm-Message-State: APzg51Bwl/tQkuNIb0i1QdL2za4rvv4amiFB48UXym4UGKX1nZaycGlg
        SJbYW6k3uLQDEY8SxKj1q4EPFJVZPKI=
X-Google-Smtp-Source: ANB0VdY9ixqVRpdzB3KZOI2ynxNNd5x85Ix3v80mSQx+SW6YDBZFR5G8HHNHs6MccvlfoKHRS2Z6v7NKpuCy
X-Received: by 2002:a1f:d5:: with SMTP id 204-v6mr1656725vka.3.1536886571311;
 Thu, 13 Sep 2018 17:56:11 -0700 (PDT)
Date:   Thu, 13 Sep 2018 17:55:23 -0700
In-Reply-To: <cover.1536885967.git.matvore@google.com>
Message-Id: <28f5ce6d48a69fd7326ce6a6995e5567a6f32d62.1536885967.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536885967.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH v8 3/7] list-objects: always parse trees gently
From:   Matthew DeVore <matvore@google.com>
To:     sbeller@google.com, git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com, pclouds@gmail.com
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
2.19.0.397.gdd90340f6a-goog


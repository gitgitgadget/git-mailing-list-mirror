Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DB81F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeIDWcj (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:32:39 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:57277 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDWcj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:32:39 -0400
Received: by mail-qt0-f201.google.com with SMTP id k21-v6so4906753qtj.23
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=StaRE/FLTMq1XAqQsZseEI8hCEpD0hyUZfjsXbjvYqk=;
        b=IComg9MFc7AUAc7xPFi9Q/wKOpblTzfYZIEHBafGrnJRQ393lI/0zKi1aWSSuiEmfI
         c4R+Opbdyq+5ITRGG4qOJM+XRT4aWesqXb1SHeJ0buyhBgoarF3lh+Xq1zGBESygg6GO
         GwO1a3GNiAIV1DyOoj2CnSDnJu82KZszThpm6fnElqZM4yHlXO0EZ8KyGcILNI8e+q/o
         8T2kz7u6DPg/cZ/XUEAD/yxVrY7XMFNu5/RTF/3LR7WrCTLum53EYFK/eeyJ1L50YOtH
         +ZNOIG0/ub0VWKjZMoxQ4T3lczlomvi7axajUOe7B3KN7k2REbr9aj7GHLKRXOujuuYj
         a2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=StaRE/FLTMq1XAqQsZseEI8hCEpD0hyUZfjsXbjvYqk=;
        b=b00Pghy350plwEjOjCaLjIn89wzV7R4crbgltNSyYkEBfgW7V6Dzc9GaYkHFeQrEQN
         2G/7LLK1PhldAWMGxrXA3IHg6p6swMShaRKRVav7goXo8SUYU8NjDMXj3t4mvTnfsRY3
         XeobLM45KEZ7Fwl4o+BBRgAoNjmADerwqxixJ+S3fBxKdP3tPd2545IXtwfRoL21uIWS
         tz592Xrz6IY+FV8DwP9cHWVDT2+Pz8DSpAGkL8/KRrmEYjMne9iquE7GjLLQsEcVOU+5
         yq8s7vDr+9FnklwaMVdqUuZ4aOWPvbg71K3uDbrVjfmibZ5jOYPvQtuGGxpRobIWYTVs
         bhTA==
X-Gm-Message-State: APzg51A72TKTZ2lo1PCB0rgA5VsSo8Fxg71Gju68qoSv7OXWy8LlDL4/
        Kjspa7AAjS4rOp6j+4p0Y6BwOcqVl7w=
X-Google-Smtp-Source: ANB0VdYsqb+MqUconBNQo4DmiIBHwP+q4h6eRtW/hKwFnpB6Br8xFnDQ44pyrKzQEAqdWVMuUXBImnQxTudF
X-Received: by 2002:a0c:c306:: with SMTP id f6-v6mr18408742qvi.14.1536084386162;
 Tue, 04 Sep 2018 11:06:26 -0700 (PDT)
Date:   Tue,  4 Sep 2018 11:05:46 -0700
In-Reply-To: <cover.1536081438.git.matvore@google.com>
Message-Id: <55da169659b3c04e3f38f876744ee76eb6d0db93.1536081438.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536081438.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH v7 3/7] list-objects: always parse trees gently
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
2.19.0.rc1.350.ge57e33dbd1-goog


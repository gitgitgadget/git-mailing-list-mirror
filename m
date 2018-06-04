Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E4F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeFDR3r (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:29:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36937 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeFDR3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:29:46 -0400
Received: by mail-pg0-f67.google.com with SMTP id a13-v6so14738951pgu.4
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMM56mnyerveRr/gFK9/Px4dJjUYxLpwnNz5LD4G2q0=;
        b=GCqyFq4qVCSjIDesoVKbwkxwV4huh36pS1Aw1/5wJIuW8iNSLGxHA4+hOxwA7jWHqj
         DBj7BxmnPrkvJLxOyj/q+U9nqYs5vvS7xJMNf11GTT3QwjJNvzB39/gyC2P2kINg1ZDf
         vr7OOs78v4CNWFr8sZnb51GkveSHgD3/EJG+apmzF6JrWbmSmaxO0N7StB+GiTLfLoFw
         655NhoKW7v48oHuMmlCj27BphMSUHQ2cNN6soB9vzWWMa6tAtCfzSVItAUQ6Uwgn15cV
         ULxisUb5X2xkkWN7uOz27lR2WtYlNKbWcv7pDJXqQNIoyCrc8r7UPF06e3V1BQX0fX4i
         Z9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMM56mnyerveRr/gFK9/Px4dJjUYxLpwnNz5LD4G2q0=;
        b=egY9eYDrxAd1GE5cDM4D9rYRDRdkk694zIqw3AZiQ3sxpBsWySpMI/LxGn3RCuL8gh
         KgwT/slo9e/qQ1O6pfxkQq33euZ+75C4Bd+uSpiuLqgTxgzuGaeYfPH8XVOyAO7YRovR
         v1sToaVw+nJ4QraSrjtVeoLdaQndCm3YAmMyQv7L9bm/JbXJTz0DNanXKiZXAvTiIugW
         BHW0JyYZWEkLe/HZNtRMfNVKLJfwsTf6UU/32q+Yv3v0TlyXKu/b7XncHkX6+67XXu6/
         roYRq+x4w2h0YGXleGK5FVRcUlpKs9EW6Cw47g0j2RZK/QC3/p8olampNKsU/LGdtmvF
         P5Mg==
X-Gm-Message-State: ALKqPwdtgcin1Y5Wymqi4xklnDIrWgHPOYYxNukujXWHTZadCcGV/Gsl
        d7bUwnz3nx+VluwS6URSsj+I/wpnATM=
X-Google-Smtp-Source: ADUXVKKSu6QQeEOcXnnYOmg7KIs4dsVSwjgapwu3jEao/zYcFLCNLWRGNszvNZ4HPZkzxhiXefhTWA==
X-Received: by 2002:a63:9a01:: with SMTP id o1-v6mr11365709pge.439.1528133385242;
        Mon, 04 Jun 2018 10:29:45 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4491994pfn.11.2018.06.04.10.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:29:43 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        bmwill@google.com
Subject: [PATCH 1/6] fetch-pack: clear marks before everything_local()
Date:   Mon,  4 Jun 2018 10:29:31 -0700
Message-Id: <b9d6d8fef370fae316f78c851833dbd706ff6f7c.1527894919.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1527894919.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If tag following is required when using a transport that does not
support tag following, fetch_pack() will be invoked twice in the same
process, necessitating a clearing of the object flags used by
fetch_pack() sometime during the second invocation. This is currently
done in find_common(), which means that the work done by
everything_local() in marking complete remote refs as COMMON_REF is
wasted.

To avoid this wastage, move this clearing from find_common() to its
parent function do_fetch_pack(), right before it calls
everything_local().

This has been occurring since the commit that introduced the clearing of
marks, 420e9af498 ("Fix tag following", 2008-03-19).

The corresponding code for protocol v2 in do_fetch_pack_v2() does not
have this problem, as the clearing of flags is done before any marking
(whether by rev_list_insert_ref_oid() or everything_local()).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a320ce987..1358973a4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -336,9 +336,6 @@ static int find_common(struct fetch_pack_args *args,
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked = 1;
 
 	for_each_ref(rev_list_insert_ref_oid, NULL);
 	for_each_cached_alternate(insert_one_alternate_object);
@@ -1053,6 +1050,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
 		goto all_done;
-- 
2.17.0.768.g1526ddbba1.dirty


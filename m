Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC2D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbeFFUr3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35378 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeFFUr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id c22-v6so3297800pfi.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6tQzjObKtvFQd/OiVYx8DLIqw/u7lQ1iqPpTBtuoYA=;
        b=Wk0ngOcWVMdezDfPq0GKc+9J2ADkmnVIc29fZ+zcPgmrfN3KYiFBG2uouaMvURN3Ma
         SS5sWtraveQvlL5mS6+o8MWwgEmvZZMWFJ6L6Dg9jSpDUaQ9RX9TntotbFEQJSATRBaK
         zJeRJcMbFwc6l2Z57yxmVieBa35cOFhpiHhpR6CF3zafaPmt/iXIkuADnQXCIqUMu3e/
         KT4ynlTdzjkUUr5/U5Os/VujdjppSJ9f+WHl6/mC6OJ8IwSzKQDtc6udsQyD0ygcsNnL
         LYZxw9kyuwx8UqQxftGQYkcpha9yFGPfGiupjigh0zLAbRYuIpF8gWa2uL6pPxKfxQtj
         n62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6tQzjObKtvFQd/OiVYx8DLIqw/u7lQ1iqPpTBtuoYA=;
        b=YJoi6b3Vp/WtkhuAv9CWAHEEs5DSt/kHiaoAWof2l+L02Pl1Si9B9skSegR3ih0g5C
         sut1aW1aCRJzg6sc1PSyTT7LvStB7wZMhvAGjoPPAVO9SsYzofTCH21QlOC+NPa1dkvK
         buTLVoMU/85QONIVuYFRev0I4suKcbw4oyT2nV39aUI4xFKHus9mYElnizw/XKVF2509
         I1BJ2g7e3QUQMbYts7JD297hke6QCtuXTSk87494YHpCmm2OAm1JntV5BE4BZJj1Riz7
         tuT07xHw2inGbia9a5xmxoKkQ4mKMrRsCndB5m1vAsYassPLOwtr4awVlWeaYmXP08Tv
         Tuog==
X-Gm-Message-State: APt69E3K7x1HKxuf8TrW0rsibkaC22eBfFRNNdbUSJ/hM51kJlR5gbM9
        Ny1g9XiK9CV0GN6zx7SjJIomexSYQ04=
X-Google-Smtp-Source: ADUXVKISJ5GBHWwIyXNdlKWcLywyTkwpP7r2H3GoDtNjR8YA+61L5/ZaQXb2ACagy4IhQmncWyBlYA==
X-Received: by 2002:a65:4a90:: with SMTP id b16-v6mr3781388pgu.136.1528318044815;
        Wed, 06 Jun 2018 13:47:24 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:22 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 2/8] fetch-pack: clear marks before re-marking
Date:   Wed,  6 Jun 2018 13:47:08 -0700
Message-Id: <dca6619c551b8259aef0476146184996657a80e9.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If tag following is required when using a transport that does not
support tag following, fetch_pack() will be invoked twice in the same
process, necessitating a clearing of the object flags used by
fetch_pack() sometime during the second invocation. This is currently
done in find_common(), which means that the invocation of
mark_complete_and_common_ref() in do_fetch_pack() is useless.

(This cannot be reproduced with Git alone, because all transports that
come with Git support tag following.)

Therefore, move this clearing from find_common() to its
parent function do_fetch_pack(), right before it calls
mark_complete_and_common_ref().

This has been occurring since the commit that introduced the clearing of
marks, 420e9af498 ("Fix tag following", 2008-03-19).

The corresponding code for protocol v2 in do_fetch_pack_v2() does not
have this problem, as the clearing of flags is done before any marking
(whether by rev_list_insert_ref_oid() or
mark_complete_and_common_ref()).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 5c87bb8bb..2812499a5 100644
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
@@ -1070,6 +1067,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
 	mark_complete_and_common_ref(args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
 	if (everything_local(args, &ref)) {
-- 
2.17.0.768.g1526ddbba1.dirty


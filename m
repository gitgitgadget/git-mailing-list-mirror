Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7FAC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADD623440
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392223AbhATTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391908AbhATThl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:37:41 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FFAC061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:37:00 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l3so24034111qvr.10
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MwyoX1YueVsJs/tXm9Tp3Cjd/jFLDzSkMNnQ6sPtjCc=;
        b=UdHbT+9xKext1TY97W7UROD35WyXXVMzU70zTpK5gxIE2yczbHad6MeQJeE3uXqu5W
         b7pdH73g0QXfvV0TH1gkpUTFI96BHyF3tZfghHGrqQQUcxRBJoGZnwbMQUbdqb0w+TlG
         DXCaHXOlA7XapX/KxGbnvxloOuDjNcnq1VODG8KScFq98iZwgFKWxpQmVKO5/8tXitLh
         Chy9kVrtUDhuu2Ay0lYJkZSxHw/Tfan2q/OTwej42p31Gc6Vfj8QH1TRn4DelLjamAkm
         z72ChdyqpiaA7esI8GKYfJkMPfzUv5+DQJEz6QMH9Wq8I0mDxYuIXMgxHWg1o4RUs06W
         RX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MwyoX1YueVsJs/tXm9Tp3Cjd/jFLDzSkMNnQ6sPtjCc=;
        b=U1wUgZpyBHJBy9DZXGyoAUmWeaepAJV70tdktqEW/QUDSI2MI6akSTShog8ou/y6oo
         CNoxS8Zuw3EIWuCFnAZcnaJwB72qvLxPRlLy7MT/v1C1O1CR80EtuhNcawTWx8x9AEeO
         D2E99RKlNvU98TZfwOH/bgeee5p5XrwkKV43dMJg2H1VzyaTrjlNJk6Tx5zwT6NBVITS
         rjSMJYPRj4HAsKoz6rOQfop1h1JY9nTygPwRK4Lufy47yth8g3iWxKoFyYLFrlRjMACM
         8a1d9nZcfZFqz1UMq5I9aaNe8CjIlMmTf/tiRNqkGjhjHgHksDzUYCP9RlZshk+N1L9y
         YHjg==
X-Gm-Message-State: AOAM530JK2IlokSTS1MvgF6h8L3rl9h72C7/EzqgV/y8mD77s54ZBhLB
        0sPrkWZRnbgI691MkK2AglAZLO9ix0rYqhx/N+uGFpslcTwy7rtrgrdOpCiNKn3nJFOu34Zd68W
        GpCI+jsfcpKO+SkDk9LV05M9WMlBYJx/xWsWhmY+9qB8GhCsq6dIUfl/2P5ayr4sBc8IGZAWX7F
        RQ
X-Google-Smtp-Source: ABdhPJzZpSDdTOKXK+7wADjRsFYeIP8ecCCWW1aA4qwa5185f+PgpZbH9Yn5+5R3ghXl4IezbxByXBhRDuO293I/+Vwy
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:5904:: with SMTP id
 ez4mr10908354qvb.30.1611171419208; Wed, 20 Jan 2021 11:36:59 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:36:57 -0800
In-Reply-To: <87o8hk820f.fsf@evledraar.gmail.com>
Message-Id: <20210120193657.1807392-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87o8hk820f.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] Doc: clarify contents of packfile sent as URI
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify that, when the packfile-uri feature is used, the client should
not assume that the extra packfiles downloaded would only contain a
single blob, but support packfiles containing multiple objects of all
types.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/packfile-uri.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index 318713abc3..f7eabc6c76 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -37,8 +37,11 @@ at least so that we can test the client.
 This is the implementation: a feature, marked experimental, that allows the
 server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
 <uri>` entries. Whenever the list of objects to be sent is assembled, all such
-blobs are excluded, replaced with URIs. The client will download those URIs,
-expecting them to each point to packfiles containing single blobs.
+blobs are excluded, replaced with URIs. As noted in "Future work" below, the
+server can evolve in the future to support excluding other objects (or other
+implementations of servers could be made that support excluding other objects)
+without needing a protocol change, so clients should not expect that packfiles
+downloaded in this way only contain single blobs.
 
 Client design
 -------------
-- 
2.30.0.284.gd98b1dd5eaa7-goog


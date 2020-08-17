Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29D7C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9622B20658
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7NzC9Eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgHQTtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgHQTsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:48:33 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA20C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ei10so11444844pjb.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1ADX3FfZOu5kbBBMDbPp/aKIrw2ohWcm/lEUqfN3uwc=;
        b=n7NzC9EbzFWTWfkpMaQoZUyfy5hCGDOkJmhXljTnb+bHKkeBFmnk/ItLTrtaZHGNu4
         39wsDLkm1cHF/0XJXhCKSBv++51L5CftOjIcSM22br+n+Hkc/bCSrtqdBuyoT7rSlBdq
         4ytUnO6bUBrjvFEeHMTxa1Hex5lpsYRQBIxMnWBFFvxDwItXp80yK5haQ/cr1BBarcH0
         /snYlWLLvT2RH/K+9bU+xyOS4rLQzkbM4NJCnkS8WH82wvThyGzVIlPJU2rDLVVze7TT
         ZHv1RPirRGXbznclk9HC0m7++xlbl7acRlESgBZYkm654sIDaZcLwG2r0131BMmyWkUk
         uqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1ADX3FfZOu5kbBBMDbPp/aKIrw2ohWcm/lEUqfN3uwc=;
        b=DLGd8l4UtlihKoHInr3I+PlAg45iEY+4rJ5CgF122pmr+DErVa0/XN/9LGHPa+6IQV
         +C8YG4ilXuxkPu2fl3KdDdJaFwXRr/kasaG/v+AumcCZwvQ1TM8oMLpYys/BKIlcavo3
         bVip8Iu076n20sJL7PiVug2u/ILOF28mIOkyD0sYTbOCJXeZDGMeLPy/BlGojdlxGjsZ
         lR2TaZ7ooehkE2fI1M3APzVt6z6bwT+C+HtACeQP7IKDgtNfXUkI0OLt5alSFKvaRVaN
         2t06SQICfxrR+TX+y9sok7afTzLwbul1uQqv0qqsxx41CHMHsCTpxlEU/WZVxfZrS0p2
         JMjA==
X-Gm-Message-State: AOAM531GRjddBuESUTzI6WcuRWd+Ym+n8LVZu/uostOjsQ0GgZEoJqBE
        QemYbiAQ4+GgIqetKjeBTu2g/PSehEcP/PK3tvEx+TA693L1gU9DizyKG07+CTzRIFGJLtAM/3Z
        OtIpEABtRHq5k/dMVUZBOXSRBjnZjTKxRgE0X6qNXFbBDQZlA0osBjmgu2xEJNIPaSgne3EMNi4
        DI
X-Google-Smtp-Source: ABdhPJyGQADmPqjk5U9yo/LFaLZkBDA2NlmwbDYoSakXiwXUkhbOwq7qNITcCsUM3mAGz19xCrGRNC50FxyUcSRyngCk
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr13684009pjr.168.1597693712320;
 Mon, 17 Aug 2020 12:48:32 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:48:19 -0700
In-Reply-To: <cover.1597693540.git.jonathantanmy@google.com>
Message-Id: <eae9024f73e67d1d5fc60c589ebb2106faefcb56.1597693540.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200814193234.3072139-1-jonathantanmy@google.com> <cover.1597693540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 2/3] fetch-pack: document only_packfile in get_pack()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dd4b732df7 ("upload-pack: send part of packfile response as uri",
2020-06-10) added the "only_packfile" parameter to get_pack() but did
not document it. Add documentation.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7f20eca4f8..289121038e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -794,6 +794,10 @@ static void write_promisor_file(const char *keep_name,
 	strbuf_release(&promisor_name);
 }
 
+/*
+ * Pass 1 as "only_packfile" if the pack received is the only pack in this
+ * fetch request (that is, if there were no packfile URIs provided).
+ */
 static int get_pack(struct fetch_pack_args *args,
 		    int xd[2], struct string_list *pack_lockfiles,
 		    int only_packfile,
-- 
2.28.0.220.ged08abb693-goog


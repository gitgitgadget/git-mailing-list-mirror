Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79E61F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJMDhK (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:37:10 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:34672 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJMDhK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:37:10 -0400
Received: by mail-vk1-f202.google.com with SMTP id r75-v6so5334740vkr.1
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q2dYhBMUsxAP1K6GkP391nNcskyC4L814p76LtjEPIs=;
        b=OHyhEcRWi3FqvpmJIbkSY0+4iuv1gjMpOf+i4/RiW70JPVOtPzpeNyy0LFud/Dis6n
         BcRZi5UXvxKol5g4zFO5VphaXDzakraniWTF26IAwi8pNnBdMwF8Wv9uj78fXru6piJk
         Vvw/Fqs8yS5jQ8KcYsCfza72TOo1w7SdK8ohtthtlSp/CW1T87jOyvcrWw45rVaqR7yx
         IUS8WPpnrJq2hthRBsS1qbsqguWYt5dnpGz5W72tGlqU6PM2mn+K3REt4xbVjkSN/JGE
         y/1Yb2DwP3APnFTPVmyRYkhWjmu70qcihIteOdgOqoucYnF8IQr1IphRLU1UW1YCnR5i
         aTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q2dYhBMUsxAP1K6GkP391nNcskyC4L814p76LtjEPIs=;
        b=Sm/hmu+ohx1DdmYxeDRGC3PGKJ2NB577Q3H/ckUeJWxNlBQzjplQ25UHAB3Jk6BErg
         JOrW42WKWNQanqMVx6gUpdZWzNtd76hRCTZpvatkT9ef/67ZiK7ByEIxVTDHi9wB3+tP
         xtrIkg1AQSdfvHdONWuQLh1Nh/mcDQF1n8pkQDV6t8wsRmHGVtiLHbi5dk9JdG6h0J9M
         RNORv6iViDkMBaDyoP14mWr6RWUWSf6JgoPhgEHqgHaKdAmh6ODO1WwJ25mt9iWZrVXz
         SH0/HKh50UElDY9P8XRCAiA+neozHFdJBHJrEatUKVC2DA98tKMNGfuS54xj6O6XuHqX
         zPjA==
X-Gm-Message-State: ABuFfohi4u/usCd1AEAjYb+/4DM3SmlvUWcleCn3E8EZqhNPZ+u+Y3i9
        ZKDnOLjElheVhdVaHqcNY9zJkS9KS1hP9qgATrDmnO92avgP2MOzaJugCM1qb19mV2k+TElhbdt
        vlSmbYBIYyYTG66EEeh5eqsC6tpt4aohtas/tXZSnJjF6pCBVRYWmfiafW/Q=
X-Google-Smtp-Source: ACcGV63Hq7rYVkeQhJv+tdv0cA5jseko7BkLw3DjhZvUcMhokpD2LGyllnnxhHc6Rj487O9jKuM/1VDqAUWq
X-Received: by 2002:ab0:7217:: with SMTP id u23mr7111807uao.20.1539374582652;
 Fri, 12 Oct 2018 13:03:02 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:48 -0700
In-Reply-To: <cover.1539373969.git.matvore@google.com>
Message-Id: <9d3b59e0ca6f6b06b01ef7b2702528c1f3401364.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 7/8] list-objects-filter-options: do not over-strbuf_init
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

The function gently_parse_list_objects_filter is either called with
errbuf=STRBUF_INIT or errbuf=NULL, but that function calls strbuf_init
when errbuf is not NULL. strbuf_init is only necessary if errbuf
contains garbage, and risks a memory leak if errbuf already has a
non-STRBUF_INIT state. It should be the caller's responsibility to make
sure errbuf is not garbage, since garbage content is easily avoidable
with STRBUF_INIT.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0e2bd6a0..d259bdb2c 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -30,7 +30,6 @@ static int gently_parse_list_objects_filter(
 
 	if (filter_options->choice) {
 		if (errbuf) {
-			strbuf_init(errbuf, 0);
 			strbuf_addstr(
 				errbuf,
 				_("multiple filter-specs cannot be combined"));
@@ -71,10 +70,9 @@ static int gently_parse_list_objects_filter(
 		return 0;
 	}
 
-	if (errbuf) {
-		strbuf_init(errbuf, 0);
+	if (errbuf)
 		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
-	}
+
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
-- 
2.19.1.331.ge82ca0e54c-goog


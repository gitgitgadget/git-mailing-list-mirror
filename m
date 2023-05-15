Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62AC77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244870AbjEOVuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjEOVuL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 17:50:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1EE720
        for <git@vger.kernel.org>; Mon, 15 May 2023 14:50:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c2999fdc7so253686277b3.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684187409; x=1686779409;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3gcePHDpISfC1uT335V5oapGdccWwrpWya0/EgvtOJE=;
        b=3ZzQsv85XY7QGanIS19+fe2I7vbmmEM5k6mik9nWUVfjm0uLWW2yn5qJYTpK94O17L
         +cPznQAoHXjHQMuViZKXPXKoPIyJGnJHp1xmG2jgugDVUhZ3ueY7aYDBrseGwJiaFW75
         83dDae4IqpyDm9F7hBxQuseBURkfKtySovqTCXNjz6AkmnADK2ctbTzCTA4GO5wGvIWP
         7GKDBW1DQtOfyrb9QiWJE7WbGxv6r1Z7F9zuLLo8P0mTF45iv38ORSQgjU+WeOpD/MmP
         E7sYxLq5QAmbQDizsCM3dYR9Ax42Q6/b/3rQdjuR3xqlqP8Ygxwj1B1gUgB7bpQaF7P7
         l1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187409; x=1686779409;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gcePHDpISfC1uT335V5oapGdccWwrpWya0/EgvtOJE=;
        b=UrRRbLQliZ0UbYI7ZspxMuNAFRLjm3af++YmEVbE2YCu0cAjyZ82SF+SLQtc/cdT2d
         nzcmDJLnNURHruExxdkAU9WRzGIDGHZ0HfY0zGmZ370o4fjov+Vku/OxW/qNiIP5YxrT
         GnRawQ8eJA2IMjQgYNbjNXhgbpxPlzMiXR8rsufZUy5Gs+SYK/JPrRA0UB786i92gQvA
         WPFJxHG1fI9Z9rUaB2zY5kWpvFIRKk/E10BYZDcZ7udf5SE6IQkMEhG9hOHdNFA5KCQl
         ECrpTSLStZWO7An+OqVvbzqiw6uEXcPDC7flU0vkawE62MfyCduemyYJq8NAY5hLxMPn
         nxFA==
X-Gm-Message-State: AC+VfDzjRazfHr/L+KI8toJQJcirCMXdaXx3C1iYnjCSjl2q8Pn1oMrh
        Fpr5yJmiiGl1cWLDxXEYIH1rgK/MWNtE8bOgv3Wk
X-Google-Smtp-Source: ACHHUZ6L9j5IEpPnisTu+teSyfryD/1WEkWm6rQg8ckuRuJPQD5283lS8rvPwuPNRCjRQnd9rNyOOuACHgSvEk4B26Yd
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:3aab:56bd:1f4b:d239])
 (user=jonathantanmy job=sendgmr) by 2002:a81:bc09:0:b0:55d:95b7:39d8 with
 SMTP id a9-20020a81bc09000000b0055d95b739d8mr20589939ywi.7.1684187409754;
 Mon, 15 May 2023 14:50:09 -0700 (PDT)
Date:   Mon, 15 May 2023 14:50:07 -0700
In-Reply-To: <abfb127b812c3c7501e54bbb9213c8598056ad50.1683875070.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230515215007.1446214-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 15/27] repository.h: move declaration of the_index from cache.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Elijah Newren <newren@gmail.com>
> 
> the_index is a global variable defined in repository.c; as such, its
> declaration feels better suited living in repository.h rather than
> cache.h.  Move it.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Up to here looks good. Now to look at the read-cache-ll/read-cache split
in patch 16...
 

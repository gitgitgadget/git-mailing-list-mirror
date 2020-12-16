Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2EC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3748230FC
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgLPCIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 21:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPCIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 21:08:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6979C061793
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 18:08:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x17so10325487ybs.12
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 18:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nXc5RMUZ+Jg12F9QJnTx0k+3T2eg7FMFKE0zvY3ZjCs=;
        b=YdCiCyarrGz8ysRSCkyemKmJ0MTBMU/36MDMhpta55m3fbjSNs5X5HF2uOcVH09iqw
         3l+KtpIs/xkazJJENhraWXiI8erCMULZQrUz31bVQkcfsz+WcmyULJeTDE1get3tXXOo
         WdFh6uz+12xs60QlLzpjF5ionJTOia4hT+RxJOflCZHBOGeVHIHHzG7puXWhMCN8Lk6m
         +X2LebrS8Czgg9L4TIMC5oVjicLEXbbA+mKGhVXfsI8tNzxhO9EZP56cuavo7tO0tJYb
         6TUvViZAC5X0Q0qkXZwLaHZDV6yhWWuj3T59NbTfS8lRh4TfdEiATlVWLIcSTYOwFetk
         UT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nXc5RMUZ+Jg12F9QJnTx0k+3T2eg7FMFKE0zvY3ZjCs=;
        b=cLcs496YMWK9V9BBK3fG0/fhMKdJhB19Txan9sueEdrqkbO6TakzP12/SnLSJUyCWS
         rLEe0vReUo9VI54n+e65bjBJPI7JcHVyA6OKBUMrbLMq9KAXugatDZ9tVXLpL6FmI0nY
         V1QoL//N7xh8ZJZNGXpbxb/WoqpVFacpn8sbKvKAVoezo8r0N3rMvf2L/jkwcUSCv669
         EZNqvzs8FSLi3OCKxGDs1tBbBIC2JuKKTVy2D/XtQBEvZTINbckKCXZd2OehTOZLWC4n
         XyL4ubiW5XMWC39Sgci3WWjaZbm5Fq9t/8Izkjsu8Ag5trhfV+rbSWYXS0MD6Gi5Qltw
         ioEg==
X-Gm-Message-State: AOAM530ZNrfhT3QCEfgvhokF/TwBOFi8byIPMX+ExxmAo3uaz7ZR5RMb
        SBT6E7Yp+FR4St9wLvkGzQ3i7+2E5zQJDI/UNum2Vx3OgTa6k72ENI4yDIkhdxItb/s7RCtWC+K
        dZm4vkCrCDf/zzKEu7PxRxwJog6C6JTVN1BVEKW/Nwcjh26cUhd3TbuXoo46iPvO491giwJBu9m
        Ol
X-Google-Smtp-Source: ABdhPJyMbh5zw46G2PhGKR8JGHe9lH7GXqGeGBNfC0c/FA3EGH2vzsmaiQPiJIKWF5/VoleFCSBYV5L9KCQZgN6eFh56
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:340a:: with SMTP id
 b10mr51643845yba.95.1608084489902; Tue, 15 Dec 2020 18:08:09 -0800 (PST)
Date:   Tue, 15 Dec 2020 18:07:55 -0800
In-Reply-To: <20201211210508.2337494-1-jonathantanmy@google.com>
Message-Id: <cover.1608084282.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201211210508.2337494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, felipe.contreras@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your comments. Changes from v1:

 - Split into patches. Patch 1 has the server-side changes, and patch 2
   is a preparatory patch that just updates the API, so that reviewers
   can more clearly see the difference in logic in patch 3.
 - Updated commit messsage.
 - Updated test to use "-c init.defaultBranch" instead of "-c
   init.defaultbranch" (capitalization).

Jonathan Tan (3):
  ls-refs: report unborn targets of symrefs
  connect, transport: add no-op arg for future patch
  clone: respect remote unborn HEAD

 Documentation/config/init.txt           |  2 +-
 Documentation/technical/protocol-v2.txt | 10 ++++-
 builtin/clone.c                         | 19 +++++++--
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         |  2 +-
 builtin/ls-remote.c                     |  2 +-
 builtin/remote.c                        |  2 +-
 connect.c                               | 29 +++++++++++--
 ls-refs.c                               | 54 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 remote.h                                |  3 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  7 ++--
 t/t5702-protocol-v2.sh                  | 17 ++++++++
 transport-helper.c                      |  7 +++-
 transport-internal.h                    | 13 +++---
 transport.c                             | 29 ++++++++-----
 transport.h                             |  7 +++-
 18 files changed, 166 insertions(+), 43 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog


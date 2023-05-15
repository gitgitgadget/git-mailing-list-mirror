Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6812C7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 21:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbjEOVoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbjEOVoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 17:44:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDAE7DB6
        for <git@vger.kernel.org>; Mon, 15 May 2023 14:44:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618857518dso1420647b3.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684187062; x=1686779062;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sv+yQecMy8Kiy6/eLlgmBkcz4z4j3I7gtvLM9f5nuZA=;
        b=h7fMcSeOJiXfiLSaOg1O+CVkaHwIHWFfeJyH5P192hZCd7JQz+hZUgwesteFrASSJC
         R2LWzGOULs/CMhqYn3tOs5H+RO8xFRzqvOBSsH9jTVSqhoxSEcmIUOJRBUlMyLJFxIW4
         EeFH8CGdbhltg6QZouC8jhJDNXcZHqaL//GJYk7nmeUVYILtCv25f5RWKf88SCzyQKLv
         KW2z/YCCUEtqDvBaU++aX7aY3Shf3DpOXupTOx7DjWjTsWp8yIfsAAKWBiOQd0KQT1Q4
         XKXWAtCxEmIJHY6Y/3zHFK6spo3sA4YQY/HkrLR8waJ4e4xlpnE4gick+79o6ZksuN9O
         nNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187062; x=1686779062;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sv+yQecMy8Kiy6/eLlgmBkcz4z4j3I7gtvLM9f5nuZA=;
        b=QcWXUy9zDoXIsL6IHovDVFBzO9r433zYWfojvdGjdrOMp2rzbhTyz0q+YUe3YdmFFK
         rLCA02zi2gz9F3vv2VvE/hr+8516tzY2nGXk6XaUHk5dEEQZjGd9+e4fUc0m1RNpxZ2+
         St+oXVeQhZSIocgSMoeaaD9n7scfBRXo08siaBWSWfziA4HtzVZi2DGxXQPWNp10Knbl
         16HmekUOsnQscUPpl8Z2IGcOa92imHYsRWaIJSTEw0+ofqVUQTuUbEAd8AzarUoZre8f
         6WMeEek19Oq3XxO9O5yENKsPhRrnPXdInaHteOimp6Lr6IiTn+LhCUu2srB4ll5nPjpp
         mRFw==
X-Gm-Message-State: AC+VfDwgrSnXFMttuAKNRSVa70oWF/JZ0ZNUzl2uba/Ih6TLHn52KWA4
        DnJeD5ozAG6bhYf2u2jfE35VjNr2dEPkKwPkBvoF
X-Google-Smtp-Source: ACHHUZ73OXqUCfasj6r5QUOOP+zFN4YmobWfYGxrxrfuJZmSYTzCvFhs96M3NCQX8gei3+l4nkPfC/1IBUgYFd5KQ8Bf
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:3aab:56bd:1f4b:d239])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a7ca:0:b0:561:834e:265b with
 SMTP id e193-20020a81a7ca000000b00561834e265bmr461362ywh.1.1684187062266;
 Mon, 15 May 2023 14:44:22 -0700 (PDT)
Date:   Mon, 15 May 2023 14:44:19 -0700
In-Reply-To: <13d6dd1095c6dcb8030b63b83635c760737b4163.1683875070.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230515214419.1445275-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 06/27] add: modify add_files_to_cache() to avoid globals
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
> The function add_files_to_cache() is used by all three of builtin/{add,
> checkout, commit}.c.  That suggests this is common library code, and
> should be moved somewhere else, like read-cache.c.  However, the
> function and its helpers made use of two global variables that made
> straight code movement difficult:
>   * the_index
>   * include_sparse

I was checking that add_filer_to_cache() did not inadvertently use these
global variables even after the refactoring, and it looks good. It's a
pity that we can't remove the USE_THE_INDEX_VARIABLE #define even after
this patch (other parts in builtin/add.c use it), but I couldn't see
any more usages of the_index in that function. There is no more usage
of include_sparse, indeed, as can be seen from the next patch (when the
function is moved to another file that has no access to include_sparse
declared in builtin/add.c).
 

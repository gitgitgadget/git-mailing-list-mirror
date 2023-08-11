Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB32C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbjHKVqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjHKVqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:46:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8625F2709
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:46:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d679709cdb5so667300276.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691790414; x=1692395214;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kGkEEnqT9dplGVe+tT/vyxpGXhLH/rd2dP4R7Ol/vq0=;
        b=1e7856/36ikOAiYBzOOqzZGlvddBVyeJ5Ao0Tu09NZ8vWSKmrl26mjBgkRFneWlH6T
         eASffCeJBZvsKKFYd3wqS9kQUbB+4m7JS27HDZEe0nxiqfBBcwMHBllV5GFTDEDhtllb
         yeLxEeusw7Ak00UAlz/anN33K57xfi2kr/PZRWquHW2BGffn3h3Mq8ZsGe0AA+8gjy3V
         0dQI/EgVwrFKnDeWgMa+THvx3IYSkVi7tlRnN/rSrtWDvHr6xziFx1WHElcn1qCwC07J
         xTQV/wVgEp9vtLg6ta86vqkV6DsA74tujrXZuyveEhDRf6VQV3vBFr3BL9h28ZbB8f9B
         PdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790414; x=1692395214;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGkEEnqT9dplGVe+tT/vyxpGXhLH/rd2dP4R7Ol/vq0=;
        b=UmvsYLBPk01PYLlWKtWB33ZFTFJRetVKH6QaoflCQ0jenlLoaIAada2CM+UetHCwFT
         2nXMbvDS8HL8dr8CSa8weDhROIICLKeF6FWfYTRoCMdESRTrs73rGkCzjk7dHnMIii6N
         jcxV7INT+pVjzS3ENquKqVu7wtGEuHpf7j3K3NPFcnu77tVvLDt/7LMyXlnhrYK3Zvvb
         V3bto4IX6B7TTLJd0blbr78G0CjMKZtMhba5x6uAXyJC/PkBXg3lEow4CjFv31p4yUrU
         whvXa5H12kOeNvLC8sCMlb7LAwnchhUcj2pbAwCTHC962Dqn0bRxHbvLoq/7fTp3+Bvx
         xkHg==
X-Gm-Message-State: AOJu0YxMMHqKZTzcNldakgOeN9cQpBlE2gSQA8Z/7UGtuprEUou+AZMo
        Bk3EFs5Vp6bd583n5kyR4UvfIXPfzbItPLjAVz+Z
X-Google-Smtp-Source: AGHT+IEyOaavLTJnbbJYQeKFm+h4f3C6y6a7EYOGbQbXCItR4sBFTIGwDFobwHGE1/v4/f75hL0+P76aYpNEqrkeCQbM
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4efe:1e02:1aef:3b66])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1584:b0:d10:5b67:843c with
 SMTP id k4-20020a056902158400b00d105b67843cmr57192ybu.4.1691790413821; Fri,
 11 Aug 2023 14:46:53 -0700 (PDT)
Date:   Fri, 11 Aug 2023 14:46:51 -0700
In-Reply-To: <e23a956401c5619bd46e8ec9b0e1df958cbcbfec.1691426160.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811214651.3326180-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 1/6] bloom: annotate filters with hash version
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> In subsequent commits, we will want to load existing Bloom filters out
> of a commit-graph, even when the hash version they were computed with
> does not match the value of `commitGraph.changedPathVersion`.
> 
> In order to differentiate between the two, add a "filter" field to each
> Bloom filter.

You mean "version", I think.

> @@ -55,6 +55,7 @@ struct bloom_filter_settings {
>  struct bloom_filter {
>  	unsigned char *data;
>  	size_t len;
> +	int version;
>  };

We might want to shrink the sizes of len (we have a changed path limit
so we know exactly how big Bloom filters can get) and version so that
this struct doesn't take up more space. But if other reviewers think
that this is OK, I'm fine with that.

Another thing that we might want to track is whether the Bloom filter is
a reference to an existing buffer (and thus does not need to be freed)
or a reference to a malloc-ed buffer that we must free. But both before
and after this patch set, a malloc-ed buffer is never overridden by a
reference-to-existing-buffer, so we should still be fine for now. (This
patch set does add a scenario in which a reference-to-existing buffer is
overridden by a malloc-ed buffer, but that's the only new scenario.)

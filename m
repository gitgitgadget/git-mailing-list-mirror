Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F8C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiBBV6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiBBV6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:58:40 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94976C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:58:40 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z131so587762pgz.12
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxbZu+pCtrheBhCr3lmNBUeok6c5doKud+aauhCUoDs=;
        b=hRHG5QlOv3Xl0Wp1DCb3r5B0eO48ShMVQpTWV4e2XKMmHSeTZKyqaER+S7O4VLBXz1
         P9veE/G2It5M4HzWr8bCM8shIpoxM0c/m//n9vlm8yzv0AydH/LSrpgnX3KuQIRJNizI
         3POXj9oUGF+QQFRk/KKv7hczwTsGD1vg8+RNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxbZu+pCtrheBhCr3lmNBUeok6c5doKud+aauhCUoDs=;
        b=eqFZ0UL+4QeQbQK3kDV3Za2nbtNX5ola3yzpn44/+C6AXLiEZ8nRo1RSVJSLAXNHQO
         yn4xvuZWmWLI113gAnSSNylVkjS4IQktAZX8Wpy9cl6fgZALgQi1xxd8m2i3tM2juIYH
         IRfqzMKxC4sRNqIzATDldnlPSAUvA7Dp4sPq71clIOub4c3S+fQ58888JKF8cMcfb3h/
         FWMj/08oqlo1DkmDlYaGLg7XQAlPByOPX7okVXjuC3Zm68Xu+fXWlF1cSTzU6MRrimyj
         qfy0T/G9C/Px0R2ke7dg0AumZTrpsyfVjTI7t1GMe4iGVZ6mCcZe/7CixnunOkWUPrjQ
         yE5Q==
X-Gm-Message-State: AOAM533g2f6lqq+isLvpuMfNxAkCqaC19n/eF0VOHdZGIDMRJhQIifzA
        lawXNngNZSmAgFJuREVpU3oo68+n3m+NGNE8+HnJrQ==
X-Google-Smtp-Source: ABdhPJzAGQ8ki1JB7IjI6wdAlINlaGoT415Ci4ilFDr9qlK1On5+fhaNDahHXL/vmsely80/bKkjclwyxiqwjRET+pM=
X-Received: by 2002:a63:5641:: with SMTP id g1mr1451618pgm.579.1643839119520;
 Wed, 02 Feb 2022 13:58:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com> <20220202185957.1928631-1-jonathantanmy@google.com>
In-Reply-To: <20220202185957.1928631-1-jonathantanmy@google.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 2 Feb 2022 21:58:28 +0000
Message-ID: <CACf-nVevXOSoGTLp4qK2c6HE60+pwotUS3p0+N_zia1+opAdXA@mail.gmail.com>
Subject: Re: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with
 expanded filter
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        me@ttaylorr.com, christian.couder@gmail.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 2 Feb 2022 at 19:00, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks - I think this is a useful feature. This is useful even in a
> non-partial-clone repo, to repair objects that were, say, accidentally
> deleted from the local object store.

I'd

> If it's acceptable to have a separate command to configure the new
> filter in the repo config (or to delete it, if we want to convert a
> partial clone into a regular repo), I think it's clearer to name this
> option "--repair" or something like that, and explain it as a fetch that
> does not take into account the contents of the local object store (not
> as a fetch that changes the filter).

I quite like --repair, since the implementation really has zero to do with
filtering or partial clones beyond that being my use case for it. Specifying
a filter, shallow options, or even using a promisor remote aren't
even slightly necessary for the implementation as it turns out.

And as you say, that makes it easier to explain too:

"fetch --repair will fetch all objects from the remote (applying any filters
or shallow options as requested). Unlike a normal fetch it does not take into
account any content already in the local repository and acts more like an
initial clone. Any duplicate objects will get cleaned up during subsequent
maintenance."

"If you want to update your local repository with a different partial clone
filter, use `fetch --repair` to re-download all matching objects from the
remote."

> I'll try
> to review the implementation by the end of this week (but other reviews
> are welcome too, needless to say).

Thanks!

Rob :)

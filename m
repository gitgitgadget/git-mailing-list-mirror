Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2CC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbhLURvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhLURvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:51:55 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1856C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:51:54 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x18-20020a17090a789200b001a7317f995cso2108819pjk.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Oze0W6hFU08fPav755yArEMa8FwAsKVZZoufxNAtr5o=;
        b=fTtOrjR8AGLYuyfhl/Tu5ACVZwNm2YucMc3HrfejDcjjTCDSvkP5UAlBtcvUayn9/v
         +tedpb68y/avQzzIVMM8YbgqrWdD6igVWaAh2QqFVsaAEpt8B8bsmwSlzDIaGRTxGZwx
         Ml+VLJ3VIuku4TkFaCuDnPPMtK3c4sLPWEvE7rENtuFuCR/ewxI8teO/i6LDPomTOpRK
         3spr/U8ma5uhN80vNB00WBM97UunNWmvxpz7hxG179d934Z6nVF8mZQAwAysvLr1tLl+
         pFjI6HCuXqj6og0BhzKqwMy9ZdDtBuD7WAUCzHvCwNY7gESzdMT+o9+5oizVmsj44OUI
         fo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Oze0W6hFU08fPav755yArEMa8FwAsKVZZoufxNAtr5o=;
        b=Relj2qQN0xEMojr4rK49Pxazp9sjKwUJGz/9uRmi7tZaVessc9JlFBzAK4uqrwpTUf
         eVxYPVHGjJJ/rsQiTCwxXhIX4neuCdhMinP74gBXjQIkKKJe1HFDD1Q6hZfBNyMHnp+g
         smIRqBObgQWzZUlhZs3Ro19I3lr4MAn+3O05noY+CbJzV7gahGdy2SG0mRmA9N3xqQO+
         U0PvmfSBwBLOoRh1NQO+n6MoOjSRRFex/R5DM3cXnYat0nfE8Sl4lmIAlYWewZflpjPf
         Dy30ftEq9Yt5C0Ms18GhbiKKM2RssGOJlykF2O8ZYzpYHWxUUg5iNKqUGchl164GtNGv
         lQYQ==
X-Gm-Message-State: AOAM531lNMhUn0+CNEKk2syWb5xLOYjdnIUU24qOMqTpmTmN3RMIvhgE
        gk6qoBH5OhUhLpyAz3ppsAxJfrVyk+yjEg==
X-Google-Smtp-Source: ABdhPJyF4SNfW4OVhJjNN1ZUGBsxqrfCfZg85fvTiVhpHQrj56+43rLExdn0UvUppbalrrWDGnkemMFTSDNOdA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8e85:b0:142:7621:e3b3 with SMTP
 id bg5-20020a1709028e8500b001427621e3b3mr4248210plb.84.1640109114314; Tue, 21
 Dec 2021 09:51:54 -0800 (PST)
Date:   Tue, 21 Dec 2021 09:51:52 -0800
In-Reply-To: <xmqqv8zisr43.fsf@gitster.g>
Message-Id: <kl6lbl19zw07.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211216233324.65126-1-chooglen@google.com> <20211220233459.45739-1-chooglen@google.com>
 <xmqqv8zisr43.fsf@gitster.g>
Subject: Re: [PATCH v6 0/5] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> v6 fixes v5's bad rebase; it was based off a merge commit in 'seen'
>> instead of js/branch-track-inherit. Since v5 is mostly a no-op, I will
>> also include a range-diff against v4, which is the last version that
>> anyone except Junio would care about.
>>
>> This version is based off Josh's js/branch-track-inherit v7. Because that
>> is not yet in 'seen',...
>
> Thanks.  js/branch/track-inherit has been using v7 since Fri Dec 17
> 15:47:47 2021 -0800, but unfortunately that was after the week's
> integration work and the 'seen' shown to the public probably did not
> have it.
>
> FYI at least since [*1*] was used to create 751363af (branch: add
> flags and config to inherit tracking, 2021-10-16), the topic
> js/branch-track-inherit has always been queued on top of f443b226
> (Thirteenth batch, 2021-10-14).  I try to keep the same base to keep
> things stable, unless there is a strong enough reason why we should
> depend on newer base commit.

Ah, I see, so it would make the most sense for me to apply the patches
on the the same base as you. I'll keep that in mind in the future.

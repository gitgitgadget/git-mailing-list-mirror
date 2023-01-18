Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF7C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjARQPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjARQOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:14:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB2A4DE22
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:10:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so2622055pjb.4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fa7LVlXeqzzfyya37Bt3LcZ0wTizZpYKAb24ztT28ec=;
        b=mp50nZCCmsOew4JRHvamjdjn/Qfb+2BG74FSfERja1+Iu2MPS6O9VWrI8x4K0W86tL
         9ztBPC9DKGymCwASgCxZBsJkkxD4ThSNKaUG+Xg9Q7g5FwuKeEsGDtN4efjqfBTnRtce
         huRJZBxCitd7o1p19u2p/3VbJnrAl0zVpYUINXjnby6WT/XzD7Mk/zp5ZJEWVtq7coX9
         AgBK424ytS5142QH/NH4sNarPAo3aEWsA+BRKOXg/NJqmecPooBspjSUolA0nmOlIz70
         M9XvcnAaE6FHfoonvdErCCy+c38HPR7rZBM8Jx2aOE18bpygcG2Y894ueC81Vo3QXRkn
         0MrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fa7LVlXeqzzfyya37Bt3LcZ0wTizZpYKAb24ztT28ec=;
        b=6Xa5tOWlaK4l7PbPuVEC8a9HUdTGn/pl7dfebNvqKK8FBlu3oBPFTsyQv+ju1jYfxT
         dAOiIuN3m2yBvxTGZsQ04RLodhQxyhYHuTC7Yv7RnJVwfYGDX20mKb2LmVuW+H6P3g5y
         2MBPeZHkxJpr1L1EfNkpvdS2jL6FtoOjJJtHVHcDiLHhopgY/gZsRH68rf6waB7I9JJh
         st3QPVHkAU+9u8jtVUuCHyzviJdlxlJ6nqqAiTzF12/HdK4+ryYGgrxL8Pf/jIjlvUMI
         UfTHAPjkEDxfmGi/byOuUj5J/wnOUUB8YSh4Y76nB7cCpncLsrrAvq2CYROCi7UO171z
         Hg+A==
X-Gm-Message-State: AFqh2kqbuJ5gzBsuwJ9tS9wKS/GKU497TnL/0p7cnohbPDo6tGu0reX6
        JsGZJCuhtBi08cTU+W+58Hc=
X-Google-Smtp-Source: AMrXdXtM/ii+Wl1cLcjGFD0fXkm1vII2K9+3rQP2JJzOUEHrjL383Tl2VcFgcbUpU7+x8z4MmmwTwQ==
X-Received: by 2002:a17:903:1381:b0:189:6457:4e14 with SMTP id jx1-20020a170903138100b0018964574e14mr7989745plb.8.1674058254963;
        Wed, 18 Jan 2023 08:10:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b00189a50d2a3esm10482444pla.241.2023.01.18.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:10:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout/switch: disallow checking out same branch
 in multiple worktrees
References: <20230116172824.93218-1-carenas@gmail.com>
        <20230118061527.76218-1-carenas@gmail.com>
        <xmqq5yd48hcb.fsf@gitster.g>
        <CAPUEspjmFJUjZmNBH=f_-TY3hYnOtgVjBY-YtWuo15eg3a+5cQ@mail.gmail.com>
Date:   Wed, 18 Jan 2023 08:10:54 -0800
In-Reply-To: <CAPUEspjmFJUjZmNBH=f_-TY3hYnOtgVjBY-YtWuo15eg3a+5cQ@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 17 Jan 2023 23:58:35 -0800")
Message-ID: <xmqqilh36cxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> the following is the way to override:
>
> $ git checkout --ignore-other-worktrees -B foo

My points were that (1) the option is way too unintuitive to
anybody, other than those who stared at the implementation of the
problematic logic for too long, and that (2) it wasn't mentioned in
the proposed log message or documentation updates.  If "--force" is
made to mean that, it might be easier to discover to the users, but
I have no strong opinion on that (meaning: there may be downsides to
allow use of "--force" to override this safety, given that "-B" is
already considered as a "forcing" version of "-b").

> `git branch` has no flag and will die even when `-f` is used

If "--force" does not force it, I suspect it should be considered a
bug.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3914FC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiATSIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 13:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiATSIr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 13:08:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0763C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 10:08:46 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a22-20020a17090abe1600b001b39929b5fdso4574946pjs.0
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vax+iXqRAMZZfHjEZBiTXifvwFKidnIvtAhN43Q2IZc=;
        b=CV7bUaaq1F4LsuLO9ao+ZGC+saQ5T1FdaU8taNM8lItVJa5CINBUN6ez4nf6R21GQA
         vkInaXDpRLXDWyVxsiZEFgoHuLQzfu9crtjaPh5McCSfn+L8itKB8MDdoG4DQBvrxrAf
         Nz8qLWBiB03omj7G2ExL1Y9NOh+Y8XB+AesX7KmXsMBM+B2lhehISgrJATm+NaRdeAAs
         vtAVC+g7pMu2K+FY5JVB87inpelRgfGrfl+lcsBEXxZNCkHF6rUK4r9L9Xxd3duOZjXV
         LcKPB+FEPL8RK9nxhV6mvfFWZWlEGhBPOrzJHaTEGej12nfh3krz5I9clhIx3vVg7hb+
         TFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vax+iXqRAMZZfHjEZBiTXifvwFKidnIvtAhN43Q2IZc=;
        b=EhQ+rl4U6qp+Z4tf5Apunhw6MNUUvEdHSdh6nQErb1Bw7U+KPvE+2GdNpfdqKXwqmj
         XYOVgM/U/5HZn3b8eBUJVbZbCRmyhheUyF8qEebEsj7CnNWpyHV7hfhEkhMcTe0dzKb7
         UCz3/lq8llvheyJxry3IbO6Zdj/qdFZQuDM6p+Tfk28dRxFnD46XztbK74bITDVBMo4p
         UhNe6a7yLXCHPS1xK9ukpZk9/h+YeUzaIB7djeb1SxrRDEoaJ8MiWZibuyqIXn8LzAK+
         UmxbP6bvbO98hNBCjB5xGUi+A+iJl2KIJZZppryPL2TmwrcHPtwQCYVE/Y2+hxWMd8xx
         iCOA==
X-Gm-Message-State: AOAM5306MPNI0w06g3OKdxOyScyQqSDa+N7YMOXeoo0rpiULpj6bEQLV
        CsrUiustw/Rw+TAGFcKSWTbDN7UCRXuKdyghNXba
X-Google-Smtp-Source: ABdhPJweTLXlhCEjBUUVe7s9oe3xs+KlgNsRbLxhAIPHY9TQGljHSD05WTAlLEFno02/7AML8ni0idtKc7d7AXaYwe54
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4d84:: with SMTP id
 oj4mr1228255pjb.0.1642702126196; Thu, 20 Jan 2022 10:08:46 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:08:43 -0800
In-Reply-To: <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
Message-Id: <20220120180843.3103044-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: Re: [PATCH v3 2/9] midx.c: make changing the preferred pack safe
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> The previous patch demonstrates a bug where a MIDX's auxiliary object
> order can become out of sync with a MIDX bitmap.
> 
> This is because of two confounding factors:
> 
>   - First, the object order is stored in a file which is named according
>     to the multi-pack index's checksum, and the MIDX does not store the
>     object order. This means that the object order can change without
>     altering the checksum.
> 
>   - But the .rev file is moved into place with finalize_object_file(),
>     which link(2)'s the file into place instead of renaming it. For us,
>     that means that a modified .rev file will not be moved into place if
>     MIDX's checksum was unchanged.
> 
> The fix here is two-fold. First, we need to stop linking the file into
> place and instead rename it. It's likely we were using
> finalize_object_file() instead of a pure rename() because the former
> also adjusts shared permissions. But that is unnecessary, because we
> already do so in write_rev_file_order(), so rename alone is safe.
> 
> But we also need to make the MIDX's checksum change in some way when the
> preferred pack changes without altering the set of packs stored in a
> MIDX to prevent a race where the new .rev file is moved into place
> before the MIDX is updated. Here, you'd get the opposite effect: reading
> old bitmaps with the new object order.

I think the main issue is the first confounding factor you listed above:
even if we didn't have the other confounding factor, that issue alone is
enough to motivate the entire patch set. Likewise, as Junio said [1], I
don't think we need to switch to rename() if we make the checksum
different, so the fix is one-fold, not two-fold. For what it's worth, I
switched back to finalize_object_file() and ran the tests, and they all
pass.

So I would simplify the commit message to just talk about the checksum
issue. (This is definitely not a blocker for merging, though - others
might find the additional context helpful.)

The code up to this patch (apart from the rename()) looks good.

[1] https://lore.kernel.org/git/xmqqtue54iop.fsf@gitster.g/

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E6C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 06:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiEPGHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 02:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiEPGHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 02:07:53 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C613420BF8
        for <git@vger.kernel.org>; Sun, 15 May 2022 23:07:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lb8-20020a17090b4a4800b001df6e0cee58so291987pjb.0
        for <git@vger.kernel.org>; Sun, 15 May 2022 23:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=N1MwLgMu9Pcc4LMq6cC9ggcH0UQn8F9zgNNnKN3A3Ek=;
        b=q+7pJCAZCIR8ezOZFJhV+sVvLlI6+5zcQhuXdHfUxsMnm4P6SiT4/6ya6t5V8YbcqM
         RGg86OmGtzxGJrDzszzEwBJm+LKyeOSZey5cCcwNO3HpyMKOXaFTfRtFio1XJckFctDK
         ZGuyd7E8lLZjcxRwQxgWud8Z+uuCeddyDoUikmWwTGCMxGYN4Gj2wI63Li85H2T6Q8L6
         SRGLZsQdBwITFZfkmvPT0hFKqxMZO5+TI4w1ODmaJbEmb5LU0kD3h6tiDl2HIMh/wSoi
         1xvE9P/T5g1jMNH4zuN0rFSqiTQUeqF+sJlmo5bZNczPjXaSBGQIRG+87Qw2m3MKNcQi
         B+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=N1MwLgMu9Pcc4LMq6cC9ggcH0UQn8F9zgNNnKN3A3Ek=;
        b=DYZhhGBFW9Rnw5sBK+uaixy5WZdxs8IzsegTR3uUAt/Q34I2SX4DynlTammkzSRHaP
         cqWHwVf37QjVvT43tWIWIFgpIsn62VBKs0R3mBFuZXQ58wKn2TWD2rqTLnlXHvTqU5P1
         MdEDUk0VcEUkrnWPY4WXJlGPWn2nM56mY2Nridu4/yQR0YPs4m4evY0N1qK1FKgcHY9f
         3em+1qSXAfGlTfDX3iZ7/Xu9yMSPZPK05JpBjTQIoKqV9zmY+dzPGyTIfzP2QqGcG+np
         CsrQ45mSA0fiJUzfU+wfdqeFiiPmuJokHilzQNiuigE/L//lVAKC/teUXVJUgpcLsk/f
         hRFw==
X-Gm-Message-State: AOAM530ZVO1Z5H1qq1j2kwxeaesoCwRieIPUq1G5h1zcUb/c6wVzcezR
        SotTcK24d0QTuu0hRsu/0Aw67GDaOCCdUCnP4xVb
X-Google-Smtp-Source: ABdhPJzmmJqYHopIQ73DqPilUD1vXTOlCNZRcC1AnPnA31rTSbOIQfDR8IA53dszVAE9VJbI5k2U+r/M0+s5KsU9/d47
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1251:b0:50d:f2c2:7f4e with
 SMTP id u17-20020a056a00125100b0050df2c27f4emr16007667pfi.72.1652681268205;
 Sun, 15 May 2022 23:07:48 -0700 (PDT)
Date:   Sun, 15 May 2022 23:07:44 -0700
In-Reply-To: <Yn+r4lPi8vNK/qFG@nand.local>
Message-Id: <20220516060744.1567449-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: Re: [PATCH 2/2] builtin/pack-objects.c: ensure pack validity from
 MIDX bitmap objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        vdye@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> Perhaps changing the parenthetical to be:
> 
>     (indicating that `want_object_in_pack()` should continue searching
>     for other packs containing this object)

This works, thanks.

> Yes, `want_found_object()` could have returned -1 before, but the only
> time when `*found_pack != NULL` and `want_found_object()` would have returned
> -1 is when given `--local` with at least one non-local pack.
> 
> I actually think it's possible we have a bug there, since AFAICT the
> pre-image of this patch would have left the non-NULL `*found_pack` alone
> but picked a copy of the given object from a _different_ pack. So I
> think this change inadvertently resolves that bug.

[snip]

> I think my reply above indicates why this change is necessary, but if
> we're talking about separate issues, let me know.

Ah, I was presupposing that the existing code works correctly. But yes,
this makes sense.

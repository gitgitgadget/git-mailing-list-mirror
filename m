Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D643C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 20:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357640AbiALU1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiALU1M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 15:27:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C712C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 12:27:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso3433301ybp.23
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oBSuopsDAEbZzOEpQk+9giO/FpR9m/KHmcqYvMoVYsI=;
        b=RWN2zpglwMGsgkOLw9s4XUxKcFqS7qhgB1eluBgHNjO7lZDjggLq4ZQE3/xY6mS0wk
         l2gKmX8nlIAO+GyYWVtlkzX+ZEpMe8cB6hYH5SmT+ojAVTTQj05iFGDRckWpd8RMkPzo
         PNgp0+daBgYeUIjS2ssRGo0m+vgyBVqdwDBiaBf9hfUxRbsFAmF/B4ofid/OaQvvb1y2
         AaAMjEG4hIO575r4BN8BsvqljluGxfWRJccO00TzGKOYLHbkTHwUxb7VHWKIjCBJpQ7P
         ryeu2Hke0qJtdrH0gfRZhQPO9C9JTe+K33HzrRQy+fWUFyhkJQfvidFPTxALJYbHhS3l
         Rujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oBSuopsDAEbZzOEpQk+9giO/FpR9m/KHmcqYvMoVYsI=;
        b=mKiEtr62t9s4wSZIT42X4sNzU6ZHCeT+iz9Uun+iPyTzWx2/nqOCxtNGnJZ2Z812z/
         2oAx8QHefuHZxt9EyuOELrGqBRG85zT/5bQZ0UmyyLBzU/h8uytWqGY1NnKyJ/zbB9V5
         W+vfYUmOj+KU1icZWAytENmzhDgvrw6BzY2t6haPsw4kBeh4p5m8QyHtZSZafkUPBc3K
         XqYwspj7tfuKeblFN0b7qFj1WaNMdqMgYQ/OCYjB1no5MI8Rlrqz7g0AhB4DWuWaHD7p
         zXticKH9P2i6p4cz/FAMcnGh4NS5Q9PUoLvs0il4RYqV+DqjYMtxaAZkYPYhN5Pm4mS1
         ucOA==
X-Gm-Message-State: AOAM532DYiyYtOYWg+dWWD2qtCYUoCCTbw6qQhG2bOgeyr/yyMP3SsQ5
        3gXmTeDYV07JAKdDr73knIJ4fff3VVi2L+dpqB3S
X-Google-Smtp-Source: ABdhPJws3KJiHxTjdQB+60jRkS/kBD55oC7BrJEJ1NFrFNKHwaPGvEwnJcwBljwFkw7gAGKaIKMEixOnGO1iTUKCepAA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1201:: with SMTP id
 s1mr2055424ybu.4.1642019231598; Wed, 12 Jan 2022 12:27:11 -0800 (PST)
Date:   Wed, 12 Jan 2022 12:27:07 -0800
In-Reply-To: <xmqq8rvku3bq.fsf@gitster.g>
Message-Id: <20220112202708.324762-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8rvku3bq.fsf@gitster.g>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH] packfile: avoid overflowing shift during decode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, marc.strapetz@syntevo.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Marc Strapetz <marc.strapetz@syntevo.com> writes:
> 
> > On 11/11/2021 02:58, Junio C Hamano wrote:
> >> Jonathan Tan <jonathantanmy@google.com> writes:
> >> 
> >>> diff --git a/packfile.c b/packfile.c
> >>> index 89402cfc69..972c327e29 100644
> >>> --- a/packfile.c
> >>> +++ b/packfile.c
> >>> @@ -1068,7 +1068,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
> >>>   	size = c & 15;
> >>>   	shift = 4;
> >>>   	while (c & 0x80) {
> >>> -		if (len <= used || bitsizeof(long) <= shift) {
> >>> +		if (len <= used || (bitsizeof(long) - 7) <= shift) {
> >
> > This seems to cause troubles now for 32-bit systems (in my case Git
> > for Windows 32-Bit): `shift` will go through 4, 11, 18 and for 25 it
> > finally errors out. This means that objects >= 32MB can't be processed
> > anymore. The condition should probably be changed to:
> >
> > +		if (len <= used || (bitsizeof(long) - 7) < shift) {
> >
> > This still ensures that the shift can never overflow and on 32-bit
> > systems restores the maximum size of 4G with a final shift of 127<<25 
> > (the old condition `bitsizeof(long) <= shift` was perfectly valid for
> > 32-bit systems).
> 
> Jonathan?

This analysis makes sense - not sure how I missed that. 0x7f (the number
being shifted) is 7 bits, so it can safely be shifted 25 bits.

The original condition of `bitsizeof(long) <= shift` works for 32-bit
but not for 64-bit (4, 11, 18, 25, 32, 39, 46, 53, 60) since shifting
0x7f, a 7-bit value, by 60 bits would result in overflow, so we still
need to subtract 7. I agree that the inequality should be `<`, not `<=`.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F3BC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLATL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLATLy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:11:54 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FACDC5E10
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:11:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u10-20020a17090a400a00b00215deac75b4so2880787pjc.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZyfbkQ/5GKHRAsLbfBvRQTxDlHGY1qa4rOYhMA8LD/A=;
        b=cDoVJ950mnj8l957PiQYeIAYU1OZ4LfKN807BXX1baqaYuXKSXRN2XvyGY5QNEMllT
         PP1BA1FJXRvQ+LOvh9aytRLOkjzweVVgZ/JixwC256jFtTD2Hv/b03Nkk6T6SgaOWGK1
         1Tq53xlskrGA0uhjFxPtqzeIcC51nXB4fg1tUnwII59+I1X9bj16EA+8VRYkaExdqDV+
         tR5URv1guQ1vAblvHJfdSBg4I++NtlLbYCEjzC6AHB/KWi45fpY851gOqE+QYeFLV4SQ
         gQLw0VbiVxpQpKm04K0LXpQz2xmc8VfcENs6QcO94+YL45u7qLcoVMe/CAwrDMtAta2X
         BMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyfbkQ/5GKHRAsLbfBvRQTxDlHGY1qa4rOYhMA8LD/A=;
        b=oczWShmSudJkI+9C4B72/xI6p86CnTal/wOnAGqduxzLW0NDMo/g4ay8WWOL20w5Ti
         pIhXpCuhZxI1GwVAH/F5y/IPSx6OsPXs8klMUOapCCaG65Kh5lwIWfFjQNkbaoz2/FoU
         0c+giESdCB93dKAFU74im3IMQ0Gzx64lwUc8iEsjCTKaWGmM3oFpwYqGR+QW5Slrvmam
         wS4J2oPfh6oOy9g22aaanhwFETqoto7IzczLkYEa3tcO7jQJRvgqBuhpz87D+0YMt3kV
         ZGnHgySWzMuSZ/GUm+WXVS7hcYdyBynBPchftY1+qgWAKMv0fPbxLGKEkjLEELaxV/Eg
         PpaA==
X-Gm-Message-State: ANoB5pm9YQATpcAk2iJqiAW9whhl6uny+zLFAY4yJms+zeiOXHbGVR79
        ZYC5nPFgG+4YQDn4A1bF83vBqNU4dpgaI1PPazTZ
X-Google-Smtp-Source: AA0mqf7KGVrDRh5vu93AoCjdEXoD16UXPBITSL/6idx2q8386Dwopo18yCa1lSzSXZBX2uKwGpS0NkZT7h7fVORurTeK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3941:b0:215:db2e:bb17 with
 SMTP id oe1-20020a17090b394100b00215db2ebb17mr72022980pjb.166.1669921912780;
 Thu, 01 Dec 2022 11:11:52 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:11:50 -0800
In-Reply-To: <Y4fFaoRFro2hNDdv@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201191150.3605771-1-jonathantanmy@google.com>
Subject: Re: [PATCH 4/4] commit: don't lazy-fetch commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> OK, so we know we want a commit object because we're in the
> commit-parsing function, so we just ask to disable fetching.
> 
> Two devil's advocate thoughts:
> 
>   1. What if we're wrong that it's a commit? If somebody references a
>      blob in a commit "parent" header, the "right" outcome is for us to
>      say "oops, the type is wrong" when we try to parse it as a commit.
>      But now in a partial clone, we might avoid fetching that supposed
>      commit and say "you don't have this object", even though we could
>      get it.
> 
>      I think I'm OK with that. Either way, the repo is corrupt, and
>      we'll have informed the user of that. The fact that this bizarre
>      and specific sequence of corruptions might not go as far as it can
>      to deduce the root cause is probably fine.
> 
>   2. Are there other places where we'd want to do the same thing? E.g.,
>      in parse_object() we might ask for an object (not knowing its type)
>      only to find out that it is a commit. But we have no idea if we
>      lazy-fetched it or not!
> 
>      I had somehow imagined your series would be hooking in at the level
>      of the lazy-fetch code, and complaining about fetching commits. But
>      that may be tricky to do, because we really don't know the type
>      until after we fetch it, and selectively removing an object from
>      the odb is quite hard. We'd probably have to tell the other side
>      "please, don't send me any commits", which requires a protocol
>      extension, and...yuck.
> 
>      By comparison, your approach is an easy win that may catch problems
>      in practice (and is certainly better than the status quo).
> 
> -Peff

Thanks for taking a look. Let me know if you think that the commit message
could be improved to cover these cases. Right now I think that e.g. "When
parsing an object believed to be a commit in repo_parse_commit_internal()"
instead of "When parsing commits" wouldn't add much value, but I might be
missing something.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38238C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 19:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiK3TIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3TIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 14:08:21 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2E620345
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:08:20 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 7so22806346ybp.13
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I6caMVaUeIaQOwOXfZBDjrUPtCecd0Ksx/Qbn6SOkxg=;
        b=dNZnK2Nv52yty8b+Ub5QQmf4Fi52RAIfnucZwMgxiCwyiNh+vRiqO6SgZuUh6P6pj9
         94W/c1v0MNQ7JEVAbfxhGR7Z/tJ1zZK6D9NOcc/Il3xGCQ9ECGhMbH599K5VK67dt/0B
         XHgAUzlXm6x3CIlAvakTYkl2lNV2CqeqRDKWAnoP7L7ZVe068ZfTAarKsL+ky++Nsnpp
         MMbX1PoW77SiOXAyQxW1utksxzNHf+d16IrCGWWdT4SdXXQhZcATMtOWX4hhHVhGpaZH
         EIl8FjlhXTRI0bk6wBTKRPAfs8yMYB3Ls8BgwrSqK7p3XDnozj6AdZrsI3tFGarJY2K0
         R56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6caMVaUeIaQOwOXfZBDjrUPtCecd0Ksx/Qbn6SOkxg=;
        b=bJk2S7phC2nceZJ+BfPB4PxSYJITgZf0PYqgf5jkLzEOEreSAR+laEGWEOYD859zLy
         Vm+sP3A8oRFUMKUHo6TAcXfUw0ur6KI/J5Hbntc2FhunHP+rv/6X79C4RRd2gn0NX7fC
         6+1iaGAFG9DZUwfWYf5CKZx6pVuv4U4N0IxWvT1E0gjRbv+uFPeReXUspV7KIY1SKEd1
         h/Cgow3LbYyJiSyWuWs/C+sTA+WXCoeQFwnE4Dg6QXVB+xBEfe9UJLXuHvxk27WHDiVK
         3+t7DAYUjl1SS392dIgbrzNU8wyrr8rkguX9EtwZ8apW2Th7MTBB0xc1sKchXqKvIryy
         Lm5g==
X-Gm-Message-State: ANoB5plgK4Kj2B3AErCiujWy5NSERwEfWzOQ1mfrbKgP5DQ6E9xQ2c/B
        c9AdsET0Fu8nq11fXnGUqa6P1fAivMhA31cTIGCeneaMTlzhMA==
X-Google-Smtp-Source: AA0mqf61/WSE/buqzB9+ibDyDzUF+fuD8o2TqSSBGYuquGiMGzcBbCxNhGZ6Z41M8YqXg67EmAOpX5hCfl/bAnqQUxk=
X-Received: by 2002:a25:34d8:0:b0:6f0:eb40:fca4 with SMTP id
 b207-20020a2534d8000000b006f0eb40fca4mr34087446yba.391.1669835299787; Wed, 30
 Nov 2022 11:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-5-calvinwan@google.com> <19f91fea-a2a9-7dc6-d940-cc10f384fe76@dunelm.org.uk>
In-Reply-To: <19f91fea-a2a9-7dc6-d940-cc10f384fe76@dunelm.org.uk>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Nov 2022 11:08:09 -0800
Message-ID: <CAFySSZBC5HbGQxtpsEL8_kxbogx0JX10DvMXJb9uotyQpg46Cw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] diff-lib: refactor match_stat_with_submodule
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for splitting this change out. I have to say I find the original
> quite a bit easier to read. If you're worried about the code added in
> the next commit being too indented perhaps you could move the body of
> the if statement into a separate function.

Then we're just swapping if statement depth for function call depth, which
seems even worse. I think the confusion comes from adding the "ret:" part
which is currently unnecessary so I can get rid of that this patch.

Thanks

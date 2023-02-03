Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6221C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 18:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBCSCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 13:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCSCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 13:02:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937BE1E5F4
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 10:02:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y19so6020478ljq.7
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qks0ALhZlk3m7Sy4wnhRXK/mKA9Aqz9eZd6mPhkt9xo=;
        b=Fa+N8xHzOzdj9mwgXZoQgFwaU6D3C6EeB3elafbGOVGCOVmCcA88lz6ROsiPvmYK9n
         S24NwcYfKzgxCiHkuokciWrIvMfIMgpRSzK1C6B2+aTkRvkL1tuwth+TtB1R4Sz10PL2
         F0b5tW4iXKi5/J+7QTzay/1TvIPQ5iqRFym+L9zcyCp5dPG2g5TKHcs/x0HKDMTG44Yl
         afRQZszL0bFKYrv7NFid8lke7XGSlolaYPpo1X9h4LPnmWX4HkU6rdgc633RVPljlFuU
         70Eb8ftrYZAN8REZqmyvXWlLHHUNgEYTVVoDoYi6ieRVrzKwBuw5QjNlXg5m9ZCTudWJ
         5I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qks0ALhZlk3m7Sy4wnhRXK/mKA9Aqz9eZd6mPhkt9xo=;
        b=NbAVQGd9H7jlbDV5KwsKoxEO/Ye9frCNEpMpwd/7FrXl8GoOrlB9j0Q6gF4dfL1t6Z
         s06XlbjLcrH1wNRF9nBA2u5dKP0BukfzJIjuIWmnu6fvFwmjzSjxzTp+qAft0KTtuTvn
         78uq1MwiB4sVBeafh7xNDbxh5JiYZvwmpsYwBb5I5HRC8P/9AmDeO76u5hTONhEjlwf2
         Bx0j/jvHdNDqdrzc80dUMIHVhK9V1qZDUndkt0EuRT3SGPQIuakMI+IlA/L1jDXX2yV8
         hQVppi/DxcXIWfQtlOWfE5QI9jsq2Hqn2RKB3kvP+VUCllME5orOtMOAzyA5E6Yt3Y6Z
         h+lg==
X-Gm-Message-State: AO0yUKU5FxwDd5FWcs3cTJ5sJt0Uc70q9wjMZKBKBqC+c+U3oKJLpSvP
        Eg2Q6uNomRwK1ck2fp/kvk+YiSl/slCcIk/69UYLW4ENVyQ=
X-Google-Smtp-Source: AK7set/Ji7sh9ebU4XU8S71UlJCxFELl/bUe8JQBZueoXmpbmzCNsamCvdzmx+VXsMR4FsatOe2pPyBljgr6KrhPKTQ=
X-Received: by 2002:a2e:9345:0:b0:292:8237:b9bb with SMTP id
 m5-20020a2e9345000000b002928237b9bbmr421066ljh.24.1675447368622; Fri, 03 Feb
 2023 10:02:48 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BHE=zGT_vPW8+TZn-wqmufhVdGQT-=LXoLQkto6TMrnrA@mail.gmail.com>
 <20230203174910.123441-1-five231003@gmail.com>
In-Reply-To: <20230203174910.123441-1-five231003@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Feb 2023 10:02:36 -0800
Message-ID: <CABPp-BHnXy+Hpv4y83znMxDGOTCZQfYhnDon=ehBDGOxAnW1vQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2023 at 9:49 AM Kousik Sanagavarapu <five231003@gmail.com> wrote:
>
> Now, I think I understand the mistake that I did. Even if it did work
> for one merge strategy, the code would not be good as the helper function
> is not doing what it is intended to do. In any case, I should have been
> more careful submitting the patch.
>
> On a side note, I think we can now close the issue #1156 on gitgitgadget? As
> with builtin/merge.c out of the way, the only other case is in revision.c
> and the use of the helper function there is inapproriate.
>
> Thanks for the explanation.

Yeah, it should have been closed back when
https://lore.kernel.org/git/CANsrJQd0v2V9H8HPkiH2179C1c-NOSTRRB8YXt8v6R0YAbFPDQ@mail.gmail.com/
was submitted.  But none of us caught it.

Also, gitgitgadget #1156 was opened because of my suggestion to do
this as a "leftoverbit", i.e. I was suggesting it as a micro-project
to new people.  I should have checked at the time that it was a valid
micro-project, but neglected to do so.  You merely came along and
started implementing what was suggested.

Anyway, the point of the GSoC microprojects are to make sure you are
familiar with how to format and submit patches to the mailing list and
respond; having the code you contribute in a microproject be accepted
is not required, just a bonus.  And you clearly managed to send the
patch to the list, had a correctly formatted commit message (short
summary with area and correct lack of capitalization, good
descriptions, signed-off-by), got the additional notes for reviewers
(very helpful!) in the correct spot, etc., so I still see this as a
successful microproject for you.  I apologize for not doing my due
diligence when I suggested it, and for us not catching that it should
have been closed when someone implemented the valid half of the
suggestion last year.

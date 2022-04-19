Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF46C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 09:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348355AbiDSJww (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 05:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350414AbiDSJwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 05:52:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F75013E39
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 02:50:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so31698412ejf.11
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ppg7X6mYRtnLdkdeuXPNYC8JDVmCT64sd/KWVWmP4E=;
        b=DVCkEEm+5YUXqL8tRinKYjjGP+OgODsWDtAaoira04W2TJ9A8gB7LAU/wAVQL43RlT
         v7CLvo0qKV0JhTCZft/EDgw88pBaPP0qlAtH/gpYqvsVdhyK4mOF6stwriSmhiVnyjdJ
         ykOoTUGrl5E+ARFIxJ3+f7wAmyYzGnEC8IIXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ppg7X6mYRtnLdkdeuXPNYC8JDVmCT64sd/KWVWmP4E=;
        b=0xaNMOsjEvc8fje47F/dtjwJtDGFu6HN3eDsVrohr0MV53XMmAVnp/Jr/d+ln6U3hF
         jd5GYV3frvwNQRl6BPEFUr4leuU4zh+P+W1Bekgh1TGWV2hPAT3FDAH5uzsNNUTIWx9E
         0qUwq90eeaUIBfSYoVPhNrdnU0mB/lN8Leg5u8F8iZ+zRvbOk6xFhG25LoPofhVzpWrz
         dNuIAb5TYMOAOxzhFATwawNdrDMzPzjQhn8NKKDFgdEPGiF7/rGyHBqgMCPhRW9ihWCQ
         CfFslYeAGSol+xS095xYifrDahV0ObbwVTM8JvAT6EEulJw+iOhsub3ancu8lugFxBPt
         CgOA==
X-Gm-Message-State: AOAM531ZhQilabBdkP5MgRnqBYGvNu87XYr6XJPLxG/ap0L7ht05+IFy
        rvSB73WVY7Eu7UmRKdxcpZcI0TOmN6lN3I1Rbzxvjw==
X-Google-Smtp-Source: ABdhPJyww5jQT9OA6bsNEtdz66G5NsKAqhEbIVwZdewLk8aXhmgAfR+ODlawVJcLc1YwE3hsQ675pYwGXCPi0K/pGyA=
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id
 nd41-20020a17090762a900b006da79534df0mr12514806ejc.316.1650361804880; Tue, 19
 Apr 2022 02:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
 <CANiSa6ipgk3dRJfOh6i1nL=QqtPTZ6n4ZheT+JowarMTOaeuDg@mail.gmail.com>
In-Reply-To: <CANiSa6ipgk3dRJfOh6i1nL=QqtPTZ6n4ZheT+JowarMTOaeuDg@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 19 Apr 2022 11:49:53 +0200
Message-ID: <CAPMMpog-=m2e9mgFMvUhHKLPPboqP1gkg5GkHJF2tswjp+P-1g@mail.gmail.com>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 6:25 AM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
> Consider this case:
>
>   X
>  /
> A---B---C
>  \       \
>   D---E---F
>
> If you now want to rebase E onto X, and then F onto E' and C, then
> Elijah's suggestion (and what my VCS does) will work correctly. If I
> understood Sergey's proposal, on the other hand, the utility merge
> would bring in the changes from D as well. Or, put another way, that
> algorithm is only useful for rebasing "internal" merges, where the
> merge commit is being rebased along with both (all of) its legs
> (again, if I understood it correctly).
>

FWIW, I don't believe this to be the case. If you rebase E onto X, the
way the "D side" of the merge will be resolved, on X, will be as a
combination of "Addition of X" and "Removal of D" onto the previous E
commit state. The secret sauce in Sergey's approach is the application
of a patch representing the "inverted change" to the "D arm" of the
merge base in the original merge vs the "new D arm" (which  happens to
no longer contain D and have X instead - I just have no better way to
refer to it).

I haven't understood or explored Elijah's suggestion (or your
implementation), but based on your description, it sounds like they
end up being equivalent in result, but maybe present any conflicts
differently (as a different patch applying to a different base). I
expect cleanly rebased merges to come out the same, and the same
situations/scenarios to lead to clean merges vs conflicts, but the
presentation of conflicts to likely look different.

That said, I haven't tested them both, I was just hoping for a
"current state of existing merge information reuse for merge-rebasing
users" summary, and it doesn't look like there's one available so far.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915F6C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 16:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiFBQ4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiFBQ4a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 12:56:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96141280B04
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 09:56:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 10-20020a250d0a000000b0065ca0e7be90so4585647ybn.17
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=1HQ58RSXY7ZXKL884uSUCrYjZ/+eA/vTPa5FntZTlIc=;
        b=GDDMlyQZMwKR68V7lZFtXgnN87mkpK1KvxabcAxnTUlCHiKeiSYjT1PnT/n6q0fZIw
         jX6G/zSG1X4nABGgYivBCCUky2blENO1VVEgz9zlz/WzIp+mNu+nDAKZRX9Kw/qoCq/K
         0boxVzWpmIYlzkt8HX4hVSM0zC5c3Jw8jh+ccC2zzUWQWvE/Ad0SMnfEY39JPD76uaCp
         GAbN63yfH3KQiIBjDk2qE6r2E7DcrdMbtUUhEnZayPJxWcD9XFGymw/PRde7YmROjrsV
         gVMbhrCjF6K947MLa/DAEH/UrE18tv6/taOV+GTBHIBZr4c5W7aoHPA+/tD0446Ihk7Q
         3tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1HQ58RSXY7ZXKL884uSUCrYjZ/+eA/vTPa5FntZTlIc=;
        b=4bcB0I7yqxaRHoT9EEXoxKRQkZLMtVQhALfGaBySzmXAUzQKIFTmQkqbbUTumBNUbf
         6ejOh+cb10Cikv5Vldia5wp/pI5uTvgb4v3KI805wnJ+fTalC+apfrgaGjx/1xAr3KI3
         pqpSFW4Jc7jAAmx60F8jjLltSrtortN5+6mYnN9BCTgte4ftvWj+WoIvYjgPtN2yPchY
         +MAOnLBHDlAbGvsGkLgBgvhzQaAxz2dMeKQXnbajB1WPggIk6WRQEtJbBAWLen/jRGCQ
         lQW+ImIpBRZI5w/P2AqHq7UCgzgcVQqLfFlxlbh9lbHM188IC/HcPgq8e6hDcAxSlbZn
         gMsw==
X-Gm-Message-State: AOAM531ocOznMreD7d52Jzx6a6W14RSUlfwmiKG086BgL0vHPx0Dpr0z
        t9xHFHp5zNfWogiW9CgIe+KH1qzzhiJZ2w==
X-Google-Smtp-Source: ABdhPJxvK8Wm4g9dUD7EDM89J2MpBKuvpQrF/7DD8PfahRZkvhggYGgQToE8LD2jITq3NLJhQWMahd9U/vVRJQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:65c3:0:b0:660:3691:34af with SMTP id
 z186-20020a2565c3000000b00660369134afmr6245605ybb.641.1654188987789; Thu, 02
 Jun 2022 09:56:27 -0700 (PDT)
Date:   Thu, 02 Jun 2022 09:56:25 -0700
In-Reply-To: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
Message-Id: <kl6lczfrdmx2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
Subject: Re: [PATCH v3 0/6] usage API: add and use a bug() + BUG_if_bug()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This series adds a bug() (lower-case) function to go along with
> BUG(). As seen in 3-5/6 this makes it much easier to handle the cases
> such as parse-options.c where we'd like to call BUG(), but would like
> to first exhaustively accumulate the N issues we spot before doing so,
> and not merely BUG() out on the first one.
>
> Changes since v2[1]:
>
>  * Fix up commentary in 1/6 to address Junio's suggestions, and
>    de-duplicate previously added commentary (just the one existing
>    comment in git-compat-util.h sufficed).
>
>  * The BUG() function itself now clears bug_called_must_BUG, as
>    suggested by Glen. This simplifies things, and allows "BUG()" to be
>    called after a sequence of "BUG()" instead of "BUG_if_bug()". That
>    pattern is now used in 6/6.
>
>    I pondered adding a message that BUG() would emit in that case,
>    i.e. to say that we'd previously called bug() and were now calling
>    BUG(), but left it. I think the result in 6/6 is better as a
>    result.
>
>  * Used "else if" in 4/6 and got rid of "break" to exhaustively log
>    errors.
>
>  * Got rid of a "below the fold" part of a commit message.
>
> 1. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20220531T164806Z-=
avarab@gmail.com/

I didn't look too closely at patch 1/6 (since I'm not too familiar with
the trace2 stuff), but everything else looks great :)

(not sure if this is enough to give a Reviewed-By)

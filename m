Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630E3CD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJJMuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjJJMuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:50:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C10FC
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:49:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a9f139cd94so934876566b.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942193; x=1697546993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0M6MXLyE63yIK3ZDq6juB7wIdHzjgIX0nFkj5cGY+U=;
        b=N5dUGSS96zDvRN8JXYN+ydUP4Be1K93dGMQD0ryATuCkH1SNSSGg9i754k1lB/qqVM
         BXPVLOCH7L53+krUyuvy6BMgOqTlp1U3Hlw7HamIc/7+AnDrWfxtBiEdd3No05wkNm3L
         UObyCTGPiXzwIv2q+I5t+f28ZQnP3RDVFj3/L2ryVRWzMJVvGjZ8NaNohG6vFQtjHidw
         KcQ16jtJkX0U5juyJPq5OAiMXCuWNTi5CqBGVZQAjnZSslhJp2+wg48xvE81AXsAtXcv
         g0GtelVqFkgsRMn74EsA66kUBeiSTF5WCPBgP9NEGiLTJdkNnCIcZnLZ58zSqb8avEw3
         So4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942193; x=1697546993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0M6MXLyE63yIK3ZDq6juB7wIdHzjgIX0nFkj5cGY+U=;
        b=k9C8PrNLW67nrU2gcyIbEEczisW4VcLD6yAmsX3rUjKb3D2aRtg5TBrhHfbGBW4Eng
         LGr9vWrweDn61TerIddnMOD+Zp81zAslMhZYG1FM9HlnAs1yADSrjpkOSOCabyQunwal
         AMb8/MzBgKDOUY1vSNF1J4qBmSIF9qJ72pbthDxs+v/J/xrNv4CVwgkleR7pc+JoxPqH
         QtL5AQjPh27/QcYJGLqxKCLr9LMgd35ayYn9lbMcMnSC3Vvr+6NaeCWQcoGj3Jm/UoD5
         veR7gjAdjCzXa1cRnKCxeyMUap6GEm/B8t9Pyr+a5Ci4v2z97rE/S3BNkaL6fTupHzBX
         Vssw==
X-Gm-Message-State: AOJu0Yw3MtfmcyTIdrzV9lJlLQfaDnbYQG13uUpWo3A82INFq4MtV0P2
        1wERj3nWhVHWF/C5WOqY4kKWagamePdTrO5bpRI=
X-Google-Smtp-Source: AGHT+IEaZoTDPoJZQcKuFLkPWq90LH2kznT1NPgETaOOv75dROrFJ0pmqOnHbEeE6f2eKlcncwkw2dOZP63YYzN/bro=
X-Received: by 2002:a17:906:209:b0:9a9:e5bb:eddc with SMTP id
 9-20020a170906020900b009a9e5bbeddcmr17411551ejd.16.1696942193257; Tue, 10 Oct
 2023 05:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-12-christian.couder@gmail.com>
 <03460733-0219-c648-5757-db1958f8042e@gmx.de>
In-Reply-To: <03460733-0219-c648-5757-db1958f8042e@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:49:39 +0200
Message-ID: <CAP8UFD0ck9GMGZve1SYY9_4dLbMzkdYUOF+WXQ7pdDPk02Rtxw@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] replay: use standard revision ranges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2023 at 1:02=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Christian,
>
> It is a bit surprising to see the manual page added in _this_ patch, in
> the middle of the series... I can live with it, though.

It's explained in the cover letter and a bit in some commit messages.

For example in the "Possibly controversial issues" section of the
cover letter, there is:

"
* when and where to add tests and docs: although t6429 has tests that
  are changed to use the new command instead of the fast-rebase
  test-tool command as soon as the former is introduced, there is no
  specific test script and no doc for the new command until commit
  11/15 when standard revision ranges are used. This is done to avoid
  churn in tests and docs while the final form of the command hasn't
  crystalized enough. Adding tests and doc at this point makes this
  commit quite big and possibly more difficult to review than if they
  were in separate commits though. On the other hand when tests and
  docs are added in specific commits, some reviewers say it would be
  better to introduce them when the related changes are made.
"

> On Thu, 7 Sep 2023, Christian Couder wrote:

> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git replay' --onto <newbase> <revision-range>...
>
> We need to make it clear here, already in the SYNOPSIS, that this is
> experimental. Let's add an `(EXPERIMENTAL!)` prefix here.

I haven't done that as other commands marked as EXPERIMENTAL don't
have that in their SYNOPSIS.

> > [...]
> > diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> > new file mode 100755
>
> Just like the manual page, I would have expected this test to be
> introduced earlier, and not piggy-backed onto one of the handful "let's
> turn fast-rebase into replay" patches.

This is discussed above.

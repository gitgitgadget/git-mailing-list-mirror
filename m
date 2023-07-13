Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28293EB64DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 04:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjGMEKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 00:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjGMEK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 00:10:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31100212D
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:10:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso492202e87.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689221420; x=1691813420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfY7RheRk08OQjDD/X5/c7DvBcI8cfN6xMLw1d9k/Xc=;
        b=l+R3G87jwaJ/kwEqnHtW282W+yKKntpo8ZLPLbdoyXfx6Sjb2s3DszZxAFRoRd3mSX
         4gjr0BjJNTFea5ykg7T4We4QO73NWhtoGdJgvNrnWHdtX1DrBc2dTspEjFn/7HdWl3UL
         zy1kI7/u7pxfH47QCM/LLeJbuLnZzcd/nuSGc7PSsti4pTRxDdG9h+qHJBMnXxb/TaTd
         XT980VDRLbZScKl1ZCuzzpxytimsU1ayYxn58Qu+arS6OmYDcbQUE10elPsM2tRQGUEH
         ZQ54zn5K8gc1u/JxfJB/z36VJfgvcrNx5t3A2S0fzpbTCmnd9b0E1hc6lJudQ8hfqPzS
         mShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221420; x=1691813420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfY7RheRk08OQjDD/X5/c7DvBcI8cfN6xMLw1d9k/Xc=;
        b=jfukJlCBbt63sWKARGDeTlRfdWmNwbAzr/tBgQ1otaCLQVdMNOM9xCY9mrDh5jlhY4
         wuZfKtMrnYW9kVYQJ2FeSJnAwGDf+Gf/arBVKTXlixyaYdX7ldoB2+BGbtRRVR24wdsr
         JMCacjtmCbMGXceOHlRo3QW6Wvy1w0zR62Au30mBWlGsDWVe+yO7S5qB2QZ9iYJ94/AU
         hTutyK5wrmYdhaPPVpDiMEYYc6Zy6WtHAIAKpISxLnBIplK4CrSysfUt61R/2bomzPj9
         E+kPq90x6fIuMFhBYU0alxJL2Jd0MWSeP2jgaZErZhfgiRk9F3llAHr37vzFu2rh1NRM
         pk2g==
X-Gm-Message-State: ABy/qLZuQHBw2JOClxODCl3bXNek49yPBTxh1LOFhZ2OgUmV9CK0gw/L
        WmzrNDOiUE1LsPHhDPcVALSfLjgg3+oAdJ8Z7YY=
X-Google-Smtp-Source: APBJJlGWWaCiLHYhaBbspUXgqoog+DyYa+bssssEzSTlJ+MTNo+4heEN11+nEugDUW9GXleyTd6HpXzkquZeEa3SDPQ=
X-Received: by 2002:a05:6512:1045:b0:4f9:cb8f:3182 with SMTP id
 c5-20020a056512104500b004f9cb8f3182mr175195lfb.25.1689221420013; Wed, 12 Jul
 2023 21:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-2-alexhenrie24@gmail.com>
 <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g> <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
 <xmqq8rbra9ti.fsf@gitster.g> <CAMMLpeQ2P+qQxo17dEdWhMHcmAfTiBoEifp2wUjWVrP+oGSzxQ@mail.gmail.com>
 <xmqqbkgl6f04.fsf@gitster.g> <CAMMLpeSwadTcd+z0-J1t=vUgz0wFiVaE5KaT-Wy1cckT3=fFGQ@mail.gmail.com>
 <xmqqsf9v2roa.fsf@gitster.g> <CAMMLpeTNMaVk7M2nLSJJzDMWPDVdyOr27Ae2-Usky5tW-dRqJQ@mail.gmail.com>
 <xmqqo7khupjh.fsf@gitster.g>
In-Reply-To: <xmqqo7khupjh.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 12 Jul 2023 22:09:42 -0600
Message-ID: <CAMMLpeR9yLA3zM0GfTMhuFa8HW5fDCRBN7Gnft6Mof59Tk7i0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2023 at 9:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Just to be sure that we're on the same page, when I said "I thought we
> > just agreed that we don't need to mention force-pushing..." and you
> > replied "I do not think so", were you only saying that you think that
> > changes to `git commit` are essential, or were you also saying that we
> > have not come to an agreement about whether to include force-pushing
> > advice in this message?
>
> None of the above ;-)
>
> With that "I do not think so", I meant that I do not agree with "I
> guess you're saying that we'd still be over-encouraging `git pull`"
> that was in your message.  In the message you were responding to, I
> was saying that the time the user runs `git commit` is not a good
> time for the user to decide how to eventually update the remote
> target, and it does not matter which one we encourage more between
> "`git pull [--rebase]` then `git push`" and "`git push --force`".
>
> I am fine dropping patch [1/2]; we would not be touching output from
> "git status", "git commit", or "git checkout", and "we should not
> talk about 'git pull' (or how the eventual remote update should go,
> for that matter) when we notice that the base of the user's branch
> has become stale" becomes totally out of the scope of this topic.  I
> think that we all are in agreement that [2/2] is the more important
> part of this topic, as it more directly improves the guidance for
> the end-users when their "push" triggers the non-ff check.

Thanks for the clarification. This all started because of the message
in `git status`, so despite it being the less important message, I
feel pretty strongly that that message does need to be toned down
slightly. There's also the problem of that message assuming that `git
pull` will do a merge when it can do either a merge or a rebase,
depending on the user's Git config.

I've already written a patch to suppress the irrelevant advice in `git
commit`, so I might as well send it. I'm hoping that we can agree to
make a few tweaks to these advice messages without going as far as I
originally proposed.

-Alex

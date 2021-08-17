Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E522C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F214060FD7
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 09:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhHQJOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhHQJOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 05:14:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA33C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:14:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h11so31788430ljo.12
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6AR2HaeAz9Jao2VSpydUnkjK0cVKE7Nlg9711gfdOTA=;
        b=HONGymUpFVGJHEzPFszfWtX+OLFUYd2SB3MvuxKo0heZnlREbSAunxP+tSJ85yij6m
         TBxaw93DJGFqClP3ev1mnklw+0k4XXmSvSKtZv/5kcydjzVNYXECuH1w7HDT/Yz5sfbO
         KEsYtm6+iya7qqrn4n+gmSGU6ztD/AUvzqoykSevFviVZ2NIZDASwb4Jb+sVYC0wf/jI
         tsGcPWzW7jkvhwmsxJYc/v7xUWoeIzBDyLe8FbL0nLn8LXTJGzapTvGOk+QKUu4YV07i
         9Ji7E9Ma0b3foO8th8CozDpZlDHGqUwmrnOrppDD7bpds1jQB0m/lWnWyrk5rtl3iedu
         n3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=6AR2HaeAz9Jao2VSpydUnkjK0cVKE7Nlg9711gfdOTA=;
        b=ZVPboAWZ6CpgUbFi0FdJu9ooUhjeKDKD4/ssDl+7wFf8tk5wppGnmi2khxsgCz8xl9
         F8Gg7qzSdUPtTo9FF9G5O0tfD1pLqkas+a7fb66L4kr3Q1c7saVgFtxI/5Q7oXj98OQL
         wrv8w5fkJX/n4VF1CTfPlyFAXuTD5ll7cg/BUnxshuGJpTnwBlVljuvpQmwyfTUiIU8Y
         fgDec1OUDocLm5DaE2WPfOQNZIM7Lp3++Y+frF0jbnviN04wdwb0lMcIbYzfoXxwdwNV
         cpkwho0WTj8yh243EGXiUdGOgJW2Q6SaTAucwIDpwC4FcmSt72zl2NoRfkRogOCaJ8Kv
         nibQ==
X-Gm-Message-State: AOAM533j2QwFKLHLel864r95qmpoUwjEYoQp8j29sKtCUKknCMKwAQRk
        23HGMsHLVbnls59iEnipzpI=
X-Google-Smtp-Source: ABdhPJzPXv1oJfNxHqDzQfCvspq/q44WK1V2md3lOk1zHnUPSmm5jaSNRuVpVTxyxpQG3CsHryz2tg==
X-Received: by 2002:a05:651c:39c:: with SMTP id e28mr2289213ljp.498.1629191639283;
        Tue, 17 Aug 2021 02:13:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e19sm165037ljj.28.2021.08.17.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:13:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <xmqqczqqihkk.fsf@gitster.g>
        <YQ2UFmCxRKNMOtrD@google.com> <xmqqeeb3hlcq.fsf@gitster.g>
Date:   Tue, 17 Aug 2021 12:13:57 +0300
In-Reply-To: <xmqqeeb3hlcq.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        08 Aug 2021 10:55:49 -0700")
Message-ID: <87a6lgl9gq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>
>>> For example, 1e20a407 (stash list: stop passing "-m" to "git log",
>>> 2021-05-21) that dropped "-m" must be reverted as well, no?
>>
>> No, that change is fine.  The "-m" doesn't have an effect one way or
>> another after this revert.
>
> Ah, we are saved by the fact that "--first-parent" was made to imply
> "-m", so a "-p" coming from the command line of "git stash list"
> would do "log --first-parent -p" that shows the patch we want
> without the need for "-m"... nice.

So, do I get it right that there is actually no reason to use "log
--first-parent -m" anymore, since the time the much older commit made
--first-parent imply -m?

If so, I'd object against this particular patch as the pros of patch
being reverted outweighs its cons, and the original patch never meant to
be entirely backward compatible in the first place, when it was
accepted.

Thanks,
-- Sergey Organov

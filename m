Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA8C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADB861242
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhEQM6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbhEQM6b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:58:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8508C06175F
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:57:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s25so7075377ljo.11
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=koP71ETOufqM5q5VOTA6nPny2iDcUEx3GWfGaYzNSA4=;
        b=VUwokh6UJIbwR9sGjN/wZArEVmPMw2f1D3/S4Mpv+NB9C1dB8joKOqiEcHFRqWrv/u
         /aUuLxU28V61WApbHL9QI1z8wLuQepuiMZgRnxa23SHYb/9vf2K0oykrnvDcW+jQJphn
         imEWu/aUjbDTy/wSbAguwS9wLzklUhS7LGuBecaWt4JESnzzQAXIIrJv3C8r+hjkmU7w
         whSxhfTqRqSp+BrVVwrjlYxMHG2DpasyxiBL+RGuj/5ViXvgWhJt7FCzbhJaWg2LFvhd
         SNld39Gb9/I7KwVx8xPWmExm/zEg8nlCB2zn8lLepW89QXA37njpw0+iR6hrhkpFHdAd
         eBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=koP71ETOufqM5q5VOTA6nPny2iDcUEx3GWfGaYzNSA4=;
        b=HO9Ttl7zVmn3umFcTy1wHTO1WWaTt5+0vc7XWwBN4z5n8dmvUDzKuQVHLnypb9FKO/
         IRlt3Cg+zgVb2hoYcdhev3bl/ys9yuScvbKSRYDs3iZV3P3J90g5s5XRpz49ZHIRDcoR
         mLzS42klL4eAx47a2/X6fK2MdfdZe6UELK36j7NuASHe3XrF/kIljQFEb8ym3bstDW3p
         b3eRUOOTtY6/78moJokV3kFYBoWdzFcQ8BHyGjedLh6B1JGmfB3jlaxNe5fIQKsQ2CfC
         q8PhT1Sr2MSJkfAO2DfSc2WxY2tlE0Ck3UFLR+9siPCyoHgo1ZTgsf+HYTvS4rr+qtie
         uDsw==
X-Gm-Message-State: AOAM5326g8bTs7K0Q8i+TheKx1LT8342KVs4BE2dAR5A+Da83gvWckP3
        ma9Lh21EOasWP0lD57MeM0opy4G5oBk=
X-Google-Smtp-Source: ABdhPJyDRTILFEoAyoIQzXZOtETFyNwXgmlUJI1/QowKWr7xnpBgCv3RGheBXepx8ZKWW65hL3x6MQ==
X-Received: by 2002:a2e:501a:: with SMTP id e26mr47730983ljb.260.1621256232945;
        Mon, 17 May 2021 05:57:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q66sm2906150ljb.3.2021.05.17.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:57:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
Date:   Mon, 17 May 2021 15:57:11 +0300
In-Reply-To: <xmqqo8dhool7.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 13:56:36 +0900")
Message-ID: <87eee5v7q0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>>> one side, and -m that did not imply -p, on the other side.
>>>
>>> After this patch
>>>
>>>   git log -m
>>>
>>> will start to produce diffs without need to provide -p as well, that
>>> improves both consistency and usability. It gets even more useful if
>>> one sets "log.diffMerges" configuration variable to "first-parent" to
>>> force -m produce usual diff with respect to first parent only.
>>
>> Please make sure that you clearly state that you do not blindly
>> force --patch output in the proposed log message.  Explicitly
>> mentioning that "git log --stat -m" would not give a patch but just
>> diffstat would be assuring.
>
> Also, avoid "-p" in the title.  "let -m imply diff generation" might
> be a good compromise.
>
> What --cc/-c implies is to show some kind of diff for merges
> (dense_combined_merges, combine_merges and !ignore_merges are the
> members of the revs field that controls how merge commits) and they
> ask for specific kind of diff is shown.  So "-c/--cc imply -p" is
> quite wrong (you never get straight --patch output for merges when
> you give -c/--cc---you get combined diff).  In a sense, you could
> say -c/--cc implies -m (i.e. do show some kind of diff for merges).
>
> Taken together, perhaps:
>
>     Subject: diff: let -m imply diff generation
>
>     The "-c/--cc" options to "git log" asks for merges to be shown
>     with patch-like output, implicitly enabling the "-m" option
>     (which is used to tell "do not ignore merge commits when showing
>     patches).  However, the opposite is not true; giving "-m" alone
>     does not tell "git log" that the user wants some form of patches.
>     
>     Make "-m" imply "we want some form of diff output", so that "git
>     log -m" would behave identically to "git log -m -p".  When the
>     user explicitly asks for what kind of diff output is desired,
>     e.g. "git log -m --stat", there is no need to imply anything,
>     specifically, do NOT blindly turn on the "-p: option to turn it
>     into "git log -m --stat -p:.
>
> or something like that.

While working on this, I've added more tests and explanations to the
next re-roll as I've promised, but I didn't change the subject nor did I
try to explain that much, as my original subject is consistent with
current Git documentation, concise, and straight to the point.

"<opt> implies -p" -- that's how current Git manual describes the
behavior, and that's how I described it in these patches. Whatever
"imply" actually means for -c/--cc, it now means for -m as well, and
that's the essence of the patches, so I stand for my original subject.

I think that if we realize that "<opt> implies -p" is not precise enough
description of actual behavior, it should be a separate topic of
documentation improvements, and doesn't belong to these series anyway.

Thanks,
-- Sergey Organov

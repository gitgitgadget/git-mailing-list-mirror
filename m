Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D88C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE57D6109F
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhEKU2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKU2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:28:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C40DC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:27:18 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p20so2794334ljj.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nQn8+8gAPeAc0KXko5qJjYpLgvigrH88V69wPuy/VqE=;
        b=RxgtQOYcrhQH4jNL6BVJqJMwWsOMaFA56MNA7YszNFxXOX4+2Au30HaH4bK9BnjwO2
         hzx9zSw0M6paMhl3gIbHGLM1wWbZkuL+68crp5xiwoxBNa+BJibZkOgG3jccjeu894ro
         V3hr+GMRldiKMA1XJl8ki88vEU/9UBfMEMj24qeSagB+xfFJBTDI1K5K80KmlD7hRmio
         /7revR9LGhhS4NWFxmwtnwQnF7EGf4vyv1SZNHe6T1EkMIiLfAAxVt2nXZ0KEcvsiSsT
         GWlZPhT+u7Xm6yVv0tIFTlYzcmm2d58wcgKxtqJwqWI6ICIwEAiqHZZcHZrGZtjg7eY+
         pO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nQn8+8gAPeAc0KXko5qJjYpLgvigrH88V69wPuy/VqE=;
        b=cAumA9c2WmSFRBq/lBjhoKo+/JLl8Tez8/OjSF7GCh1I9PfJpo+UpMSB2IfyoL0V8A
         +n971/Mr2831iZ6OsOTtXte2MjXw8/rcwEOE/SALyolga/UvFXEiqEdFLH/H5jRUznPu
         /2eyMt4eCfRG3QKGbjESPvyJvEnzHVO/Uodoz18fQSAJkivt4ov2EUBRnqX8ozjjQR6L
         UXJfgjnVdBv8qzd4UzWMLAr02pc9+3aYk5EBlk19BsWE4i5XcNenqPFsF/ZjoVeNx3pX
         cYI4U3d4E7gEoL31GY3fHOkHhQcJ6yqwFi+g3EdIPM27mf0S3hTZGGmA8y9fuA/kAwwR
         jrcQ==
X-Gm-Message-State: AOAM531xofOIheu+hvSyzGZO9VmoS86XdvR/w3+Un65YXua512zqGVn3
        QgcwYQumBwb/w7fW9A5Iqs3AljcpfHA=
X-Google-Smtp-Source: ABdhPJwX5Z2HpZ5RoWI4UoyHpC+3HYdxAOP0xLpMY3dUnDpdcp+Xqn0X5+Lbq5jFDqPa1lBzLmG6RA==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr27080595ljj.276.1620764836514;
        Tue, 11 May 2021 13:27:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x19sm2726605lfa.22.2021.05.11.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:27:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CAMMLpeTL9ZOuHLhqonFOwMu8yC9bETMVzkCZ__F2JsR=0umL3A@mail.gmail.com>
        <878s4lqfbk.fsf@osv.gnss.ru>
        <CAMMLpeR0eeM1droa3sxeToxw+8ACtJM3+3=SkWR9qrWbK_9sDQ@mail.gmail.com>
Date:   Tue, 11 May 2021 23:27:14 +0300
In-Reply-To: <CAMMLpeR0eeM1droa3sxeToxw+8ACtJM3+3=SkWR9qrWbK_9sDQ@mail.gmail.com>
        (Alex Henrie's message of "Tue, 11 May 2021 13:53:22 -0600")
Message-ID: <87v97pnhi5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Tue, May 11, 2021 at 12:46 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > On Tue, May 11, 2021 at 8:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Junio C Hamano <gitster@pobox.com> writes:
>> >>
>> >> > Junio C Hamano <gitster@pobox.com> writes:
>> >>
>> >> [...]
>> >>
>> >> > If we enable "some kind of diff" for "-m", I actually think that by
>> >> > default "git log -m" should be turned into "log --cc".  As you told
>> >> > Alex in your response, "log -m -p" is a quite unpleasant format to
>> >> > read---it is there only because it was the only thing we had before
>> >> > we invented "-c/--cc".
>> >>
>> >> Please, no! --cc has unfortunate feature of outputting exactly nothing
>> >> for a lot of merge commits, causing even more confusion than historical
>> >> "-m -p" format.
>> >>
>> >> The best default for -m output is --diff-merges=first-parent. Everybody
>> >> is familiar with it, and it's useful.
>> >>
>> >> > But that might be outside the scope of this series.  I dunno, but if
>> >> > there is no other constraints (like backward compatibility issues),
>> >> > I have a moderately strong preference to use "--cc" over "-m -p"
>> >> > from the get go for unconfigured people, rather than forcing
>> >> > everybody to configure
>> >>
>> >> I rather have strong preference for --diff-merges=first-parent. --cc is
>> >> only suitable for Git experts, and they know how to get what they want
>> >> anyway. Yep, by using --cc. Why spare yet another short option for that?
>> >>
>> >> Overall, let's rather make -m give diff to the first parent by default.
>> >> Simple. Useful. Not confusing.
>> >
>> > Honestly --diff-merges=separate is fine. Two weeks ago, when I started
>> > this discussion, I was trying to use `git log -m` and `git show -m` to
>> > find which merge commit introduced a particular change. Extremely
>> > verbose diff output would have been great for that, the confusing part
>> > was just that `git show -m` produced diff output and `git log -m` did
>> > not.
>>
>> This is not a case in favor of "separate" over "first-parent" as the
>> default for "-m", right?
>>
>> "Which merge commit introduced particular change" is exactly what
>> --diff-merges=1 achieves, so "--diff-merges=separate" was not in fact
>> needed, as I see it. Moreover, it could have produced wrong positives.
>> Looks like --diff-merges=1 is a better fit.
>
> I didn't know which branch the change came from. If the change came
> from the first branch, it would not have appeared under the merge
> commit with --diff-merges=first-parent.

The change in question either came from this merge, or it didn't. If it
came from this merge, it will be there in --diff-merges=first-parent
even if you have octopus merge and multiple parents, in which case it
will be cumulative change from all the side parents.

> But the change would definitely appear with --diff-merges=separate,
> which enabled me to identify the merge commit that included it.

The second part of --diff-merges=separate, that is absent in
--diff-merges=first-parent, shows the diff that this merge would have
made to the side branch, if you had considered the result of merge the
tip of that branch, and you didn't. This second part just makes no sense
at all when you care about changes to your files in any typical git
workflow, as far as I can tell.

> So yes, this is a case in favor of "separate" over "first-parent", but
> it's probably not a common enough scenario to demand keeping
> "separate" for -m.

To me it looks like it rather only shows how deeply confusing
--diff-merges=separate actually is. I'd just kill it.


Thanks,

-- Sergey Organov

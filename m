Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D2C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 06:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjDEGjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjDEGjb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 02:39:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854103588
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 23:39:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a11so36263456lji.6
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 23:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680676767;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mKoN3WWhMlWySGkf/JbQY1fQ9rOymxJ5NkWMMhzmXec=;
        b=M775ZWSPf7WHYPuBI2dh9FkzzuJIWdkTM8unMZTeReoiRCYFGbyQT1yqgZyBKDo5vq
         mG9xRBaZgoZQwbjGwh1qZpCPg9zslzhSc42lpVXqPG4si+WYHzyAGXApneOeCU4+fbgZ
         7x+jlbn4EEA3uB0BQyqgCAp17oaVA86ovkosgUSgRfU07hMK+0vDN+y/aml/i5KmyDAg
         9WVUkhA1J8GhPLRqHCvzPdwgs+2OYNBiMM3qcu7sHBhnrlV1CT/6FW3LVPfozUqbUsFC
         BsRK67M7lirxahfavLz0d/TgR9wO1Hf6H0EQYqleVxAS0G7ZdxruZNij7u16dBf08xMO
         YObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680676767;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKoN3WWhMlWySGkf/JbQY1fQ9rOymxJ5NkWMMhzmXec=;
        b=5SYRltiol3NOjkcSVNPG7YcpplsRwSj38phfZ77PXYgJuaP18th8E0We328dc3AiG8
         Bd9uuZDoLzxehjpWNTVR/IPXdiiGeYIouxlD3oeIH+3cFRuCG2k0T1XCj70alsl4nJ3F
         ezJci3t75K0N9h5zwur/jkeoecOqM/o7dBeK+Un7gDlzk+OnOPegJP/HvwBmmHzpTnHg
         ztUzZOKOm8pjzQJJbK9QPAatbWLthz3uEKbnm1xXayEwm8FkMfA77W668bQQo71cqGpW
         Ylgjfm2VvHsAEF98i7CgPBQ+PdQEF1wqNvtIsZKQcRbigkZtyic2Y+uKtrtw5hwgzUS/
         kjGA==
X-Gm-Message-State: AAQBX9d9YizB2UNg73p/bh0fsN+R+3w6DYCDas+rEUJ/Wf7a8hCFiofT
        cdO2DmK4n1dlneluAGE4gws3TWC4804=
X-Google-Smtp-Source: AKy350Y80ClKW/1SgApuSN/Azpyns5dNwFFWwcmL9Vl5gJsKBXnP4qGGVxPi4NTYJpkqusKQVLVglA==
X-Received: by 2002:a2e:920a:0:b0:29b:d4e6:cbaf with SMTP id k10-20020a2e920a000000b0029bd4e6cbafmr1468889ljg.33.1680676767106;
        Tue, 04 Apr 2023 23:39:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p12-20020a2e9a8c000000b0029e8a32964csm2704851lji.36.2023.04.04.23.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:39:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
        <87edp0ak45.fsf@vps.thesusis.net>
        <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
        <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
        <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
        <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
        <87lej7zhpt.fsf@osv.gnss.ru> <xmqq4jpv1pcj.fsf@gitster.g>
        <877curzb9u.fsf@osv.gnss.ru>
        <CAMP44s2od_=3p8+GF7tSBqQ0KsDaa4qVKXS66BS7L7BJadA_Xw@mail.gmail.com>
Date:   Wed, 05 Apr 2023 09:39:25 +0300
In-Reply-To: <CAMP44s2od_=3p8+GF7tSBqQ0KsDaa4qVKXS66BS7L7BJadA_Xw@mail.gmail.com>
        (Felipe Contreras's message of "Tue, 4 Apr 2023 16:14:46 -0500")
Message-ID: <87wn2qg7du.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Apr 4, 2023 at 3:08 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Sergey Organov <sorganov@gmail.com> writes:
>> >
>> >>> This kind of operation produces a new commit, so there's no such
>> >>> thing as a partial revert or partial cherry-pick, at least in
>> >>> terms of "things Git can do by itself".  But we, as humans writing
>> >>> programs, wish to *achieve* such things.
>> >>
>> >> So, why Git can't help us achieving it by supporting paths limiting in
>> >> (all) merge operations? There seems to be no absolute obstacles, just a
>> >> luck of support.
>> >
>> > I think there is no fundamental reason to forbid an optional
>> > pathspec to "cherry-pick" and "revert", given that a commit that
>> > results from either "git cherry-pick" or "git revert" is called a
>> > "cherry-pick" or a "revert" merely by convention and there is no
>> > tool-level support to treat them any specially at merge or rebase
>> > time [*1*].  It would make it harder to design tool-level support
>> > for full cherry-picks or reverts, but that is a problem for future
>> > generation, not ours ;-)  Allowing pathspec to "merge" and recording
>> > the result as a merge of two (or more) parents is an absolute no-no
>> > but that is not what we are discussing.
>>
>> If I got this right, you believe that "git merge" should never have
>> support for "partial merges", whereas it makes sense for cherry-pick and
>> revert? If so, I disagree. There is no reason for Git to strictly
>> prevent me from using the feature specifically in "git merge" (once it's
>> otherwise implemented), provided I do mean it and didn't do it by
>> mistake.
>>
>> Please notice that I can do it right now already (and I did a few
>> times), only with a more pain than necessary, and I don't see why this
>> pain is to be preserved (provided we do have the feature implemented in
>> the future). Besides, "git merge" is only a helper, and it'd be an
>> improvement if it'll be capable to help in more cases.
>
> This sounds awfully familiar to Mercurial's reluctance to support
> rewriting history. It wasn't the tool's place to prescribe what the
> users should or shouldn't do.
>
> If the user wants to do it, the tool should help him do it, not
> pontificate about what is heretic.
>
> The user is still going to do it, like with a rebase plugin on
> Mercurial, or with `git filter-branch` and then merge the result. All
> the tool is achieving is being annoying by not helping the user.

Yep, and I'm worried by such trends in Git as well. Looks like growing
influence of software development culture where the user is not
considered to be intelligent enough to make proper decisions by himself,
and needs to be thoroughly guided by the tool (designers) all the time.

Thanks,
-- Sergey Organov

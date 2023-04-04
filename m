Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04FC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 19:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjDDTkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjDDTke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 15:40:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC457C7
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 12:40:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g17so43766807lfv.4
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680637231;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A456QBBHf6Ng5S/1OOIHe2nmrAJm6PXC0wZ3aLAQyCY=;
        b=iZCA6z4IE8MRKp0zjQon/LjOonv3yaPfatPUaVIqQHMtj64CqNRa0OQxYNbe9/3Ez1
         j30u7kZd5AMHCbxqRrfcnXe+r89bjjFVj5cQO7jy8mEsoZQrZuNnnLgXtkT+Jsfdm+fi
         DBrbsvmgN/mTG23cLaontmWRPbtM7GBd3CEt8TseX97vpiYXydjMgv86lAIAnjf5Xv5J
         nYdligjzTo0SmX3uoR5hrLNgcS3t5tKhxN118BT8nqSCoDP1QOJEM2aWx9X65IdabAE8
         ad2ztpKFZyYeMjKfYhtp/AIua8KZh7py739OdcqxvK5LVhPd3tC2SoXaj4GSNFlcCWPn
         +rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637231;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A456QBBHf6Ng5S/1OOIHe2nmrAJm6PXC0wZ3aLAQyCY=;
        b=3Cgt6XM4FC9Qjwoq4pR2g4oPIBzsEHrgEsPT3bZMcA6tmyTop1OVlZikQC0mnw0eaB
         Vngps+Y3pmw02FrDSB8NN7uuCAWvMz2mgh1a06mN2XboBNQUATfq8mMnr4JBXln5OBOT
         2+NdKH+tC+h4KRs1FfcoPqId71h+Qjhj7QtV29CzCe5O6gdY0B5XieqOLw/BooVdnQ+i
         4tNj6Y2CrfBE+O27J4aRqQ+xN/KIniJVJJ9Ojz/wXbd/fGNiJgjnjppEYR4Obe02fBLP
         49R5YlwgYWt0rb58pwa+PxkFpl+sm2rxjBcajG+rt0UKJ9hBV2QamS+LKzqG4kJwQwDH
         B1OQ==
X-Gm-Message-State: AAQBX9dWd+K7O8zPzIxVrHav18wFLplZIErgbVO2axdZ0cKIabeY+1lI
        awLHe8Ol93OUkREiV/p8ybuplp6nyBI=
X-Google-Smtp-Source: AKy350b0+BkuT6K2/l9BGTX3+OWR0J8166MuOJHabG4ows3O7fmEuqYQjfaB4psazLyITgkkk8lwtQ==
X-Received: by 2002:ac2:5fe7:0:b0:4e8:5e24:29bc with SMTP id s7-20020ac25fe7000000b004e85e2429bcmr828781lfg.1.1680637230452;
        Tue, 04 Apr 2023 12:40:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e98c9000000b0029c88629125sm2499807ljj.114.2023.04.04.12.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:40:29 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
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
Date:   Tue, 04 Apr 2023 22:40:29 +0300
In-Reply-To: <xmqq4jpv1pcj.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        04 Apr 2023 11:20:28 -0700")
Message-ID: <877curzb9u.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> This kind of operation produces a new commit, so there's no such
>>> thing as a partial revert or partial cherry-pick, at least in
>>> terms of "things Git can do by itself".  But we, as humans writing
>>> programs, wish to *achieve* such things.
>>
>> So, why Git can't help us achieving it by supporting paths limiting in
>> (all) merge operations? There seems to be no absolute obstacles, just a
>> luck of support.
>
> I think there is no fundamental reason to forbid an optional
> pathspec to "cherry-pick" and "revert", given that a commit that
> results from either "git cherry-pick" or "git revert" is called a
> "cherry-pick" or a "revert" merely by convention and there is no
> tool-level support to treat them any specially at merge or rebase
> time [*1*].  It would make it harder to design tool-level support
> for full cherry-picks or reverts, but that is a problem for future
> generation, not ours ;-)  Allowing pathspec to "merge" and recording
> the result as a merge of two (or more) parents is an absolute no-no
> but that is not what we are discussing.

If I got this right, you believe that "git merge" should never have
support for "partial merges", whereas it makes sense for cherry-pick and
revert? If so, I disagree. There is no reason for Git to strictly
prevent me from using the feature specifically in "git merge" (once it's
otherwise implemented), provided I do mean it and didn't do it by
mistake.

Please notice that I can do it right now already (and I did a few
times), only with a more pain than necessary, and I don't see why this
pain is to be preserved (provided we do have the feature implemented in
the future). Besides, "git merge" is only a helper, and it'd be an
improvement if it'll be capable to help in more cases.

[...]

> But I do not think Chris meant to say "you should not expect such a
> feature"; what we heard was a reasonable explanation of how the
> current world works, and I do not see a reason to react strongly to
> such a statement as if you were unreasonably forbidden from doing
> something sensible.

Nice, so I figure I may allow myself to still keep a weak hope for the
feature, and thus stop being forbidden, even if not unreasonably, from
doing something sensible. ;-)

Thanks,
-- Sergey Organov

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C2C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 17:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444178AbiEFR15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444182AbiEFR1y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 13:27:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9906D943
        for <git@vger.kernel.org>; Fri,  6 May 2022 10:24:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so11394261pju.2
        for <git@vger.kernel.org>; Fri, 06 May 2022 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b24rrTRHy3YNTnRZ9gfn6qp7MHkvP0dRrKA/nsXc8Pw=;
        b=YQV6Xy/1IBaANXvbfad0nLLCAig2zkiOSavUd7pwu0SzYcmqc5x/tvpHxMWbzOS3B/
         1WRf6Mr9JadB/hxZCn6JA7wTzm0QapM/7N3duqkikAKwmxlk1tyHfa6AR3YRjEW0bkCa
         sWJBbg7RSy4au5xzNKiGKYiOEIgtuP1QcrckcXBfI1dZmqGTgzyEMnMiqTKR/nBQwLSO
         ht0oPXpx8RkUjHQprAlR11kkuMPl5J/TWuajv48/MJI1BGOgC9orgH4zeNsDZIkp8q2L
         rTJZo5G4nXT7/9KlVka/muAhjw499MeUzZsh3b0QmLycZzS1U7/yrH53qAzApbDMrygn
         Ervw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b24rrTRHy3YNTnRZ9gfn6qp7MHkvP0dRrKA/nsXc8Pw=;
        b=i+3j82IVjwGbrSxGKiKJbgVJV6mi+fR4pnrF82JYSu2IZvq2fHxRGe4cSOZrokojRv
         8LpM/kAo2B9AhpJfXIKPjZ9dEM5cocKEE/fb00tlOwHRbu1NNqL+uK94TgajCAAXwNfE
         8VNcmC/EDLLB93bCpcyb+UnkDkyjcv4Gsmw08sqdlwzmEe1q6/TjCYL/0MuxMMxu+Jd+
         CXvc1BpMVQ7R51ki+QJF8oEgg2/ObRQtoSvsWntqKINCXoFGq8BhzxV4EtUoBNFinzwF
         C9sSYF67cTmryTV6IH6sdzmddyAzn9Al531UN1mew2TlEBzFWSMM+hNp/75STwtwY1oG
         vIoA==
X-Gm-Message-State: AOAM531SuWZy2nBT6HwmdK8CIIQaRZIFFf3jwv7NjBIhAhhm4Tl9KC+N
        1sZQ2Uis2mCSCb7Gm8P1BRi1rR3SN/G4SPJlrTU=
X-Google-Smtp-Source: ABdhPJzy+J7OWG7z+7ngTJA1BlZYEQrqiDsDo5IJhqRD4LERiMg0HR+cnN5AMmHExCuV0eD0mhO1EHXeRGCRcibqVko=
X-Received: by 2002:a17:90b:3b42:b0:1dc:5cdf:5649 with SMTP id
 ot2-20020a17090b3b4200b001dc5cdf5649mr13446996pjb.239.1651857850544; Fri, 06
 May 2022 10:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
In-Reply-To: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 May 2022 19:23:58 +0200
Message-ID: <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        vascomalmeida@sapo.pt, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, May 6, 2022 at 10:15 AM ZheNing Hu <adlternative@gmail.com> wrote:

> I am thinking about if git can "pre-merge" multiple branches, which
> can check if merge
> will have conflict, but not to merge them actually, like a option `--intend`.
>
> I find "git merge-tree" can output merge result in stdout, which meets
> my needs, but it can only
> support two branches' merge.

Elijah (added in Cc) has been working on "git merge-tree" improvements
based on the new "ort" merge he developed. It supports merging 2
branches, but maybe there are ways to make it support more than 2.

> So I find git merge with more than two branches can use octopus strategy.
> What about git merge --no-commit? Which will not commit automatically,
> so we can check if they have
> confilct, and abort merge.

Yeah, I think that's what you want.

> I think it's not useful for git merge-octopus, because if we meet a
> merge conflict, we can't find
> MERGE_HEAD at all! How can we abort this conflict merge?

I don't know octopus merges much, but I think you should be able to
abort using "git reset" (maybe with "--hard"). If the merge was
performed using --no-commit or if there was a conflict, then I think
it should be expected that there is no MERGE_HEAD as no commit would
be created so MERGE_HEAD would have nothing to point to.

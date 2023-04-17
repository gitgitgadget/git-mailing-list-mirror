Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C2C77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjDQJrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQJrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:47:40 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D65587
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:46:56 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id h14so13229310qvr.7
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681724810; x=1684316810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL8F43hhCwDPjY574UxOFZJpHOIBww12iRaYp0h4I/0=;
        b=jExvKdllJsqyjugA3jOoSiRbzYTmdh2/17ivWrbFMB2gMjxgjIHfL29v6ZX22tQx09
         Dzs8YZvywq/40kDGMED3S8tmJE2nGAO2H9vYn6iU7xLkHB7PoEujJQtdPfyrYdl11UPu
         r0wwE8unxvpI84QArXvJFOLy6XaxcUAATSUBAYgqdUnyaH6jKONgSgcfpv1ed79ngcOu
         fAA/G1GANS2Qzc2ud8uxbsXiMO+DYgCxqUhxiiH8Dh9131HrPfiIpKlqnWMnLuZgXbpk
         PS2GO0/8A/xd6wsxmTZPT7tN6qmvFfJ9CSuTsY5cSifsbnJOxt3gvjmSprNEQq7ndbUD
         uENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681724810; x=1684316810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL8F43hhCwDPjY574UxOFZJpHOIBww12iRaYp0h4I/0=;
        b=NMQ9RkpVyjGiYobrIcIyB+aCVDZUISg0MUE+YY7OiwUPcxEU5ajv+paUM9MX8y0E3A
         a4HVve67/CTAtM2cap5JyJPFey3IpC8LNKw8l8VSy6Ygwddo59YNy4B+7Kg1unauJrIE
         lrpMdVga/siznvOxdfwlwzKSgqWM8xYxQPu2zxSo3PWEuxjlTcd2s1rNIgg5iDwDh2t8
         oO9S+2mv3bkpQzTrt2Ri44Z01M4F8YSdfPt+4aTT7IJihYdle+/2tt+0r4tMJWd0kO0+
         nbhORV2K0T8ZfHhxOXcK55nYqH1AwFGFf0n85XLEC43PFEj1KRSTPqM2zPLoG4JSnZuu
         LjXQ==
X-Gm-Message-State: AAQBX9dFVK2bAy4Vy/o/B/dFcw19vIbSHFYkPS1sgLTOtJuqdnKaYzAJ
        rODPVH9QtoSIhwkskeqY7d/LHqZvFYuAUaaMPGRf6h2oVxxO4A==
X-Google-Smtp-Source: AKy350bW5t4xg1i1ucyNWgBwBCQn0O4nECZRDpsvPu/vWvoI0op9nbIORAd4MGuNPoFrALiHs0Frncpx+Fj8AyxGB88=
X-Received: by 2002:ad4:5ce4:0:b0:5e8:e227:983d with SMTP id
 iv4-20020ad45ce4000000b005e8e227983dmr16479412qvb.45.1681724810111; Mon, 17
 Apr 2023 02:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJN3DWriXWYKyf+hJL+wZDCgwOZZsWRah=E8_HnKEWh1wcy4Ww@mail.gmail.com>
 <43997e66-4afb-562d-c06f-ec3d038f1988@web.de> <CAJN3DWpvh8uHnRFnaPgg8U6dW=3xP9YULBe-xfeTAg2SV7K+oQ@mail.gmail.com>
In-Reply-To: <CAJN3DWpvh8uHnRFnaPgg8U6dW=3xP9YULBe-xfeTAg2SV7K+oQ@mail.gmail.com>
From:   Gabriel Furstenheim Milerud <furstenheim@gmail.com>
Date:   Mon, 17 Apr 2023 11:46:39 +0200
Message-ID: <CAJN3DWoZcKP-Ft=fPvKeCgtGgfEGMrbSmfMaATjH_cuKRPbnpA@mail.gmail.com>
Subject: Re: Git bug
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case someone stumbles onto this. The right way to do it is:

git rev-parse --symbolic-full-name --abbrev-ref=3Dloose @{-1}

On Sat, 15 Apr 2023 at 11:00, Gabriel Furstenheim Milerud
<furstenheim@gmail.com> wrote:
>
> Sorry, my bad. I didn't realize that it worked based on commits. I got co=
nfused by git checkout -, which doesn't.
>
> Cheers
>
> On Fri, 14 Apr 2023, 18:07 Ren=C3=A9 Scharfe, <l.s.r@web.de> wrote:
>>
>> Am 14.04.23 um 11:41 schrieb Gabriel Furstenheim Milerud:
>> > Thank you for filling out a Git bug report!
>> > Please answer the following questions to help us understand your issue=
.
>> >
>> > What did you do before the bug happened? (Steps to reproduce your issu=
e)
>> >> repository in branch A
>> > git name-rev $(git rev-parse HEAD) --name-only
>> >> returns A
>> > git checkout B
>> > git name-rev $(git rev-parse HEAD) --name-only
>> >
>> >
>> >
>> > What did you expect to happen? (Expected behavior)
>> > It should return B
>> >
>> > What happened instead? (Actual behavior)
>> > It returns A
>>
>> Do you have a short recipe for creating the branches to reproduce this
>> behavior?  Here's my (failed) attempt:
>>
>>    # create repository
>>    git init -q /tmp/repo
>>    cd /tmp/repo
>>
>>    # create branch a
>>    echo a >a
>>    git add a
>>    git commit -q -m a
>>    git branch a
>>
>>    # create branch b
>>    echo b >b
>>    git add b
>>    git commit -q -m b
>>    git branch b
>>
>> With that done Git v2.34.1 gives me the output you expect:
>>
>>    $ git switch a
>>    Switched to branch 'a'
>>    $ git name-rev $(git rev-parse HEAD) --name-only
>>    a
>>
>>    $ git switch b
>>    Switched to branch 'b'
>>    $ git name-rev $(git rev-parse HEAD) --name-only
>>    b
>>
>> > What's different between what you expected and what actually happened?
>> > git rev-parse does not seem to update. Same is happenning with git
>> > rev-parse @{-1}
>>
>>    $ git name-rev $(git rev-parse @{-1}) --name-only
>>    a
>>
>> This is expected because @{-1} means the branch/commit checked out
>> before the current one.
>>
>> What does "git rev-parse HEAD" return for you in each case?  Do your
>> branches perhaps have the same HEAD commit?
>>
>> > Anything else you want to add:
>> > git version 2.34.1
>> >
>> > I recently migrated to ubuntu 22. In ubuntu 18 with previous git
>> > version is was working as expected.
>>
>> I guess you use LTS releases, i.e. jammy (22.04) and bionic (18.04)?
>> bionic shipped with Git 2.17.1 according to https://packages.ubuntu.com/
>>
>> Ren=C3=A9
>>

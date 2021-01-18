Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41ACC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD64B22BEA
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 15:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393231AbhARPBK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 Jan 2021 10:01:10 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:39892 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393088AbhARPAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 10:00:32 -0500
Received: by mail-ej1-f48.google.com with SMTP id g3so4705023ejb.6
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 07:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9NVrX2Q1PusHhpapSO7TLym3KegAVuW4A4d5Aj1hmA8=;
        b=jA/A4iCvR6gg5H1MGOQa127jJjucgYTJ0pY+z5Ja1BSMZSld/LBWdIXPZmfuVojRuR
         sLOo7ptKYwUNAB+xHROBZyZlQ22ebO73gRnulCexwumPE3CNSdvlkMnlFx0DK1fbz/Zw
         d2rVY6AmTfFAze7l/UO5I0/Q61K7odNh1PPtBfs30YM5LTt6Et7ODdlqXPz82PQAJ81b
         USrMgc6nxDrt/Hmzfb2xtAZbwdGHoIAPQP0CdEW8CJSi0uShJ8IDuJfatHWwkmPUkKfH
         O3j5JeZVTFbWms9cIJJBoiy0hdL2WIkssq8w7nRu+oTaX4x6CTWf19/STZd2/P+cf8XT
         kAjg==
X-Gm-Message-State: AOAM530oEH03nuEs7Ba3bnnEsEQ09DrRIUr/yYlI4z1x8UuMS+9oQ0oP
        vAIBkg5CNKhJYj8YVB8WIoUCM7lmKjzAIafiDdU=
X-Google-Smtp-Source: ABdhPJyKjYYzWafLXw24jNLHjpyswjiLQzlr+m2rbPXS7W8X90sC/KTpzxGBAAH48+ccimf2c8iZ5gszYnVv6Yzh7Sw=
X-Received: by 2002:a17:906:1ed6:: with SMTP id m22mr57663ejj.231.1610981989915;
 Mon, 18 Jan 2021 06:59:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
 <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com> <CAPig+cQBi7jdq64==U630Ht1YDcH+9komLNv-hZMnEhQ1Q-V9A@mail.gmail.com>
 <CAOLTT8QNhz4PrMhAt9y58n+-bEjeOE+xst8rzcg-x045Amw7iw@mail.gmail.com>
 <CAPig+cQr2kMNbhZgYn3e1V79Y5QnCbDKYzQnriEdae4FomK8Aw@mail.gmail.com> <xmqqo8hnkvwo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8hnkvwo.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Jan 2021 09:59:38 -0500
Message-ID: <CAPig+cRtpm=68GmHc_zjGaFX0q098-EpNfGH3AAk4uJfK7QH_w@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files.c: add --dedup option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 17, 2021 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Sat, Jan 16, 2021 at 10:48 PM 胡哲宁 <adlternative@gmail.com> wrote:
> >> Eric Sunshine <sunshine@sunshineco.com> 于2021年1月16日周六 下午3:13写道：
> >> >     test_when_finished "git switch master" &&
> >> >
> >> > Or you could use `git switch -` if you don't want to hard-code the
> >> > name "master" in the test (since there has been effort lately to
> >> > remove that name from tests.
> >> >
> >> I have little confuse about I can use` test_when_finished "git switch master" `,
> >> but I can't use` test_when_finished "git switch -" `,
> >> why？
> >
> > You may use either one. I presented both as alternative approaches.
>
> I am sensing a bit of miscommunication here.  You sound like you
> still believe either would work OK, but to me, it sounds like that
> the author claims the one of them does not work for him/her.

That could be. My eye glided over the code too quickly to notice that
it was using `git checkout HEAD~` followed immediately by `git switch
-c dev`, which means that `git switch -` would indeed not return to
"master" (in fact, it errors out).

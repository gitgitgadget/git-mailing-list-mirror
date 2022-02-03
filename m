Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C701CC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353508AbiBCSbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353509AbiBCSbL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:31:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD6C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:31:11 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c9so2863193plg.11
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5ZW5JOgd1oZQyyTjtvEOnr77cygQPkEGlMzP4sVa5DA=;
        b=hQACeH4gFsSa+YBOr9LQrzSO2Ll9LYNaI5ElKaiM4NPy7Cpr2z95EXgyt5P7ips0tc
         EAFl0MmfrPwBLpNZj6MOLQr9MB5R8QT0R0n0gsrZIb+26120y9xxfAjplu6jFejfzP/m
         X+FH6uZ1hTjlLOLLtcbyoNLg8D7BKmILnjNR56UFH8PsX+HjyFCUnqAk+fe71qYQb9Qr
         hEpI30cqlRaVSlrR6DXBeUbP3xOZtWQMvroZqkub7jyXwelSit8XYwOcRzodaEXibI/x
         3ogSpUDQwEdW6c82dwwP5jEM+FN8GaOmxlSLaTZXzcHutbbgrWIlEdF1yhNNXsBnKE6P
         eRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5ZW5JOgd1oZQyyTjtvEOnr77cygQPkEGlMzP4sVa5DA=;
        b=XV5+R3c4LhexYIMICDT8je/ZRr+26vXfASuTelh4Kt50GpWKuZiXAqq469ItOxodaI
         LVeiQKjZHRWrfGtTTwXCC1hW61mX+L2Wm0J0zRlEx9jwbIsmjvYgjpwku2RzAk8yzzUA
         FthmwVvWaviX1S4kFZSFygAzYldQFsTuSTHcSlG/Erl5GAzD37XYb61AIOGgqqkwK7cr
         UBPm/Ed6gLyJvuvjuqrxOiM65kf5mTXAHI4Jam+i/U9Bui9fBnIWaXMhh7Lrcp0+PhkO
         7W/Kjg41fZm6LxuqLgUwD5yemf5ik1zZmzD4p+dAkOBZmF8R98LYRytzdsHBST/g261b
         gLXA==
X-Gm-Message-State: AOAM530PL8HVnz+w/7ZiOqI32zhMxsNYCHp+CdzHaAbYvyK4L8cnNH7N
        t0SiYOeAyF1iTnczuPyPhOWz+6164Cg=
X-Google-Smtp-Source: ABdhPJyyBPBOmKCWfcGoTs3u9jDVJU9Ua42bxpM3nxe6RddnEwj9Wu4tLYZCQYr+vWwAIgnMPGcalg==
X-Received: by 2002:a17:90a:7f8d:: with SMTP id m13mr15229405pjl.70.1643913071302;
        Thu, 03 Feb 2022 10:31:11 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id q1sm10633473pjd.48.2022.02.03.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:31:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 3/3] t5312: prepare for reftable
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <b2c6e14c7e7752c9e42cb38372edc8971895932f.1643651420.git.gitgitgadget@gmail.com>
        <220201.865ypy9te7.gmgdl@evledraar.gmail.com>
        <CAFQ2z_OUqMx7WiTYHGrb5A0K1d_zNVTspM+6trw+u2rqRPjYwA@mail.gmail.com>
Date:   Thu, 03 Feb 2022 10:31:10 -0800
In-Reply-To: <CAFQ2z_OUqMx7WiTYHGrb5A0K1d_zNVTspM+6trw+u2rqRPjYwA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 3 Feb 2022 15:24:12 +0100")
Message-ID: <xmqqk0ebvm35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, Feb 1, 2022 at 10:19 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>
>> > -test_expect_success 'pack-refs does not drop broken refs during deletion' '
>> > +test_expect_success REFFILES  'pack-refs does not drop broken refs during deletion' '
>> >       git update-ref -d refs/heads/other &&
>> >       git rev-parse refs/heads/main >actual &&
>> >       test_cmp expect actual
>>
>> The setup for these is reffiles-specific, but it seems to me this is
>> something we'd really like to test with reftable rather than skipping it
>> entirely.
>>
>> I.e. the scenario described in the "we create..." comment in this file
>> is something that might happen with reftable too, no?
>
> That is tested in the 3 tests right above the ones I marked with
> REFFILES ('pack-refs does not silently delete broken loose ref'). The
> tests at the bottom check what happens if you have a missing SHA1 in a
> packed-refs file. The reftable backend does not have a packed-refs, so
> there is nothing to test.

Yup.  The patch posted looked good to me.

Thanks for writing and reviewing.

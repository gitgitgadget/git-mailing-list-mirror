Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FF7C48BE5
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 05:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA3560FF1
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 05:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhFSFwx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 19 Jun 2021 01:52:53 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:38429 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhFSFww (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 01:52:52 -0400
Received: by mail-ed1-f53.google.com with SMTP id t7so11365725edd.5
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 22:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j2CMrQtvbla7iMIyDIDHolpfGI4VYKHZdJVvuVhaqUk=;
        b=XdRptHPe/p3OJYup7VYiVyq25REsZw6ljohS5LCl4/H+o/IZluSXSG1Yk2CCvCkepM
         M4JLPHOEi+8eYgMX3pLFH0nYmeNJdXr3M5hegfIUNtjw3nkCYyf8kmawuHMq59J1lFaw
         TGTWYNHaUPKTvGYyAo/S1+nbni1N7/BZu9gEggbWjhVQ9I8z2/w6yBtqLJeQh8Fw31RF
         euyLJFGSZQ1boJNUTPpWNcn/y6aDjOcbjS2LEPxrtctFFVP/sokP0dKJCDPtlACJZ/v1
         /1pWsteIoPOVKF8CSDyY3k8kXbJ0YQXkYlkjrcrwfENOMbaDp55DIQSw2/nnvHwAy36O
         RPWg==
X-Gm-Message-State: AOAM531IWeTDoFENcPno4vnCTY64H4FcUkThnCGyUKGLF+3/tuI7ex8E
        IOoRNSY0baB106T/5u1EVFl5wWJgbKhdfJ22N+c=
X-Google-Smtp-Source: ABdhPJyy3M+fhsgvRa/wea5zBtpF2CvPsLHUo+WbzAVVLZp5yvyGt2Clp8YndhksJvsOqF5NFOGxwGACXSGvg+mEGaU=
X-Received: by 2002:a05:6402:151:: with SMTP id s17mr8906787edu.233.1624081840458;
 Fri, 18 Jun 2021 22:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210615172038.28917-1-congdanhqx@gmail.com> <20210619013035.26313-1-congdanhqx@gmail.com>
In-Reply-To: <20210619013035.26313-1-congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Jun 2021 01:50:29 -0400
Message-ID: <CAPig+cR7tUXB4=j3fGHN07=tPJ-skGb_6M7SExTq5eAH7FSwOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] t: new helper test_line_count_cmd
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 9:31 PM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> Change in v3 since v2:
> * --err was dropped entirely
> * --out is not an option anymore, <binops> and <value> is the first two
>   arguments that fed into test_line_count_cmd

When I read the previous version of this series, I found that many of
the instances where test_line_count_cmd() were used became quite
noisy, to the point that it was difficult to see at-a-glance the
command being tested. As an experiment, on top of your patch 1, I
crafted a patch which made `--out` and `--err` optional (defaulting to
`--out`). That helped reduce the noise level a good deal, however, I
still found it too noisy. Consequently, I crafted a second patch which
renamed the function to test_output_count(), and only then did the
noise level drop sufficiently that the command being tested didn't
entirely disappear into the background.

Since you've dropped the `--out` and `--err` options entirely, I
wonder if now would be a good time to shorten the function name, as
well, in order to further reduce the noise level. Since it now only
tests stdout (and doesn't deal with stderr), a name even shorter than
what I tried for the last version might be even better. So, for
instance, the name test_out_count() might not be too bad:

    test_out_count = 0 git ls-files -o &&

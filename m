Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5077C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E68420776
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv/SOtNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390043AbgJLT1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbgJLT1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:27:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934AC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 12:27:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so10468527wrv.7
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1ps0DPcEPp4su98jXzY5nJuOCnivt4ORTovpted/6U=;
        b=Uv/SOtNr8OSsB7MZ0Pcsg28mlWM8iUvaCsV42kLFano0BfKK7VJVYn/Udge2NRlORG
         CXe+jHBsW6UZ/yZ3TOH6LXJmsOAnZWeJuVeJ9g2ebUKFSjkgVW03NY02LAWiCsFfNLQd
         3BHEc5HBy4EoXg5oyHyX8PlaXpOwR5QkCzFj1CK9q0R8C6G4IyEDUI/MYzff1yI52Cdf
         RPGuVTmytSFRkAKVEyEEYVSn3ChBLopik9aW8jprfZlIKE57Le128OxWZKMCdTqWTPYl
         c27eZ7ex6YAPMaoNh2g/eDvt7rIdXW2sbaAG0QMtrb/fgqdPw5Rd/ERyRC8CZ3+1X37k
         qpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g1ps0DPcEPp4su98jXzY5nJuOCnivt4ORTovpted/6U=;
        b=b0h9guQkE5Qj8diyJSvngJcjCBQfgA5bxwo6fxrvREcimzB2Ict0sO9kY5nUxCiEtL
         c295bJvWtkEwhvsnM7XCCG1wbXhJfjVEhVNQLtqGfPUdQ6lY9lP1pXLjZNx5yFZuh6TT
         Pf27A9RZG+qHEb4BHSQhZbNnSfLZ4eS3mO1ANNLRWdw7xOVDhA0Z5ih7pe/elWOVfgCk
         ctIngWuUY1qwkbgYQEpiu6ETpgJ4s0Zxg5vyNKTrFK1fYSvXYfkVN4ItSUZhP0h789I4
         xyduNimThMZJIiKdVKkYXLL+yxavWSYqOJVeGm+g6Jg86/bMqTgz+ObFpTBmoYxF7MtI
         n6oQ==
X-Gm-Message-State: AOAM532i6C4HUVEYD6uYiBiQPkDL5I+1hYYNLA1ED9jWVoNc3KRBQhLu
        wY+dbudpYS0nqHAdBTSh1xk=
X-Google-Smtp-Source: ABdhPJwcZy+4hKq2iqg8R5CKzVpAnbg1YX0C81wqmYS5Lzo60cGyfpUrhyuZczpsugRfUUjrQxa1eg==
X-Received: by 2002:adf:9282:: with SMTP id 2mr30488219wrn.43.1602530821551;
        Mon, 12 Oct 2020 12:27:01 -0700 (PDT)
Received: from [192.168.1.240] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.gmail.com with ESMTPSA id h1sm23513356wrx.33.2020.10.12.12.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:27:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: fix gpg option passed to octopus merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20201011224804.722607-1-samuel@cavoj.net>
 <20201011225850.GA490427@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2010121233590.50@tvgsbejvaqbjf.bet>
 <6f650960-6b32-4be5-b909-86685c6ad5ea@gmail.com>
 <xmqq5z7fqt6k.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <865afe23-3e83-59a0-76ce-fee91f3fb554@gmail.com>
Date:   Mon, 12 Oct 2020 20:26:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z7fqt6k.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2020 17:56, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> In run_git_commit() we do
>>
>> 	if (opts->gpg_sign)
>> 		strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>> 	else
>> 		strvec_push(&cmd.args, "--no-gpg-sign");
>>
>> I'm not immediately clear why we pass --no-gpg-sign when
>> opts->gpg_sign isn't set ...
> 
> Isn't it because there is a configuration that the &cmd may honor
> that forces gpg signing all the time?

Yes you're right, so we should be passing --no-gpg-sign here if 
opts->gpg_sign == NULL, otherwise `git merge` will still sign commits 
when it is run by `git rebase --no-gpg-sign`

Best Wishes

Phillip

> 
>> but it makes me wonder if we should be doing
>> that here as well
> 
> Possibly.
> 

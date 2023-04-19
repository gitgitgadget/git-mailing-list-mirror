Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD07CC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 15:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjDSPlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 11:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjDSPln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 11:41:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE74658D
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:41:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b35789313so11852b3a.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681918901; x=1684510901;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWinrNP8hkUJSnfSM/GP4oiHG0LRi1ckFXZ6LxFO8F4=;
        b=oCKXCqfDEbMyDxHbd0X+xw7CmtTS8jzsn/p7aLNUSYQPW9WwjkYtH4OKxSDgqUVESY
         SaSrETN6k08d4bQY2cY5tWBZIwrt/sgNnxJwvOTnR2WzZKsNzLdGBa4xpFKC5bpz0/x1
         X2foq8muKtffZuWifrUk8GHofcCCYd5OEQTDLekh68oo5Xm9LEJtb/sC9BZM65A2ftR6
         vJF89QeCZsI2rwclJc6Z7hiCwicSAjylQl8Q1RpRZpYU5YeBrTWkjwUdmr4qFFJ9ja7d
         NH8o0gBIgbU2nLmU7vMyKkxBvtIiFLtdUWHElwuCM8olkzipJaGg8owjPukuPlhawz/j
         ByEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681918901; x=1684510901;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zWinrNP8hkUJSnfSM/GP4oiHG0LRi1ckFXZ6LxFO8F4=;
        b=GCxPGm0LplDWu9gRy7yxOot5cmjy/GTWo6oA5C8Lun9/l1qKCcKoDu2E/NiWX2N+2j
         MWEDpCeo/6KQrhpgR6/CjAVGOTL/hOhM4MuGhrp0mb0qHGAYnKR8SFIDszIzl5BLSn62
         LDdRjN7EhgR2hcaAh4+f0ADisFMj8ILPVK94jke1epok8KYXQnh5rOFSZuurhYdT8KNw
         SxzTGskGm8MTWXg/OkXjIs/HHbLGjYGAPd2UDAXPEnEqqWXd6vxtlRYUf8Wdk27uA+y7
         yFAAfzYdVEFzJsMJnEyzrnZDvsTzAgoMcKf59UBjyhR/cDf8Tq9LhiPX7t2husT/Ri1X
         WW2A==
X-Gm-Message-State: AAQBX9e5JR2PHv9gfceFaphrRD6R3cnXFf8KurejRh71I0zwkHFjEH5T
        J9sdHKE97wjdEnjc9feLswQ=
X-Google-Smtp-Source: AKy350agzdn38V9t9jHmVF+Zd4Wqmjqbzf5YcxjiIMJFaocOLAcrqBUXwcfFuPmJo9nEnjZDp3SB5Q==
X-Received: by 2002:a05:6a00:14ca:b0:63d:3a99:f9e0 with SMTP id w10-20020a056a0014ca00b0063d3a99f9e0mr3910986pfu.28.1681918900798;
        Wed, 19 Apr 2023 08:41:40 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id d3-20020a63d703000000b0050bc4ca9024sm10544706pgg.65.2023.04.19.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:41:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 2/8] t2400: print captured git output when finished
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
        <20230417093255.31079-3-jacobabel@nullpo.dev>
        <xmqq8reqkyfz.fsf@gitster.g>
        <olztmib77r35mx33a655obqpxui6coj74hfxoxfvcudnkpbqns@ixerneqaai45>
        <xmqqsfcxdu9k.fsf@gitster.g>
        <zyuwfbx5e57ly4ybfbnapbzbkw4ib5xbreu3nawkd4f5srhgfe@pwp4gw3hbgap>
Date:   Wed, 19 Apr 2023 08:41:40 -0700
In-Reply-To: <zyuwfbx5e57ly4ybfbnapbzbkw4ib5xbreu3nawkd4f5srhgfe@pwp4gw3hbgap>
        (Jacob Abel's message of "Wed, 19 Apr 2023 13:36:56 +0000")
Message-ID: <xmqqmt33angr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> On 23/04/19 09:23AM, Jacob Abel wrote:
>> On 23/04/18 09:34AM, Junio C Hamano wrote:
>> > [...]
>>
>> Ah ok I understand what you mean now.
>>
>> Would the following work? Since all we care about in `git worktree add` is
>> `stderr`, can't we just duplicate `stderr` to `stdout` while redirecting
>> stderr to `actual` so that in the event the git command fails, it's still
>> displayed in the output of `sh t2400-*.sh -x`?
>>
>> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
>> index 82091cbb1f..a8f734b1c3 100755
>> --- a/t/t2400-worktree-add.sh
>> +++ b/t/t2400-worktree-add.sh
>> @@ -327,8 +327,7 @@ test_expect_success 'add -B' '
>>
>>  test_expect_success 'add --quiet' '
>>  	test_when_finished "git worktree remove -f -f another-worktree" &&
>> -	test_when_finished "cat actual" &&
>> -	git worktree add --quiet another-worktree main 2>actual &&


>> +	git worktree add --quiet another-worktree main 2>actual 2>&1 &&
>>  	test_must_be_empty actual
>>  '
>>
>
> Ok scratch that. I tried checking this a bit more and it doesn't work quite
> as expected. I'll remove the `cat actual`s from the tests and if I can
> think of a better alternative, I'll report back.

While I do not understand what you are trying to achieve here, if
you expect both the standard output and error streams are quiet,
then

	cmd >output 2>&1

would store both to 'output' and test_must_be_empty can check what
is in there.

On the other hand,

	cmd 2>&1 >output

would store the standard output of 'cmd' in 'output' while sending
the standard error of 'cmd' to the standard output of the whole
thing.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08C9C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A52C6108E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhHYXau (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhHYXat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:30:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7ECC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:30:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q3so1612950edt.5
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5Nr9FLMnvIbYshDQkm5cL5KDa0jNL0Gf69i6rLLx5B4=;
        b=Sdfq8+6fQJ04QP9fqgzt7b5em2IWjy+hz/Mwwm84MXRqpGyHWSoYhXARyeMkT9gFxQ
         Orbm9mFblA9teVuhL+zbf8HLcBBlhVm6VmXQCmr3vmKT7qqfE9l/05BSAA2aNJ6zb/L4
         6N054m2w1T4epUc9XdWxd7oXOwVYAkSZCQlftjCB2BXWNnluo8z4e5vHcQDzd81VVYDW
         UTXX3WSTPZKzFs90O2jZWrSrxO4yvJmksJ1CKohmu72Cu6iADGHidGOU3KBq6VXSULWG
         n5zFA4cSAwBdReve6ifSs17PHKuB83CJsOYEhRR+4tzxpy8xni1sBNoBxZwDpDHSkK+P
         QMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5Nr9FLMnvIbYshDQkm5cL5KDa0jNL0Gf69i6rLLx5B4=;
        b=TKWxkHdONnOU1ZZuy7Hu1NtJpqmskwYGlhbqdOLZ7dR3CfGt6hN09xwQuXRZ0xr8w7
         G5ScqCFSe27NxN4evgUBueu+7CLV6jkeJymlFLdK40TI8xmCeGkEwJZph0ymTXr2iTyl
         t0PCLHlA058fgPXRSyr6/jojadGRTioF9SX9qp5+s98CKQmr1BOYBnUncu6owAuB4iF3
         GagGUfZ482dW15mqD4Q0vROD6h2kNVpO/qoePd5m47PdpTx1wmnrZRUFm7E2KEx2AaS6
         JD624mtYLfMVJa2Wc0Gf2uK7ME/p+ats1mO2NpktbZpPAWINORAxxVQ7rGuKY+FhDk73
         kIRw==
X-Gm-Message-State: AOAM533VUgnKXjgIIcFhrRTd0t7miY4BDDPo8sjAiV2dRjQLDJjSZ9oY
        VZNXwjUSoJ4Zv7Zh7gqDB08=
X-Google-Smtp-Source: ABdhPJxGbb1smJadlh3ZnkxygwvqjzgLLeh70QkgTh/u8P9pct65LsfGCace1A6i3/vXmrRx35GS3w==
X-Received: by 2002:aa7:c945:: with SMTP id h5mr1052758edt.350.1629934201688;
        Wed, 25 Aug 2021 16:30:01 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o19sm709142edr.18.2021.08.25.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:30:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with
 --force
Date:   Thu, 26 Aug 2021 01:28:00 +0200
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <xmqqr1ehgq8t.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqr1ehgq8t.fsf@gitster.g>
Message-ID: <87h7fdcdc7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> git branch only allows deleting branches that point to valid commits.
>> Skip that check if --force is given, as the caller is indicating with
>> it that they know what they are doing and accept the consequences.
>> This allows deleting dangling branches, which previously had to be
>> reset to a valid start-point using --force first.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Original submission:
>> http://public-inbox.org/git/52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de/
>
> Thanks.
>
>> +test_expect_success 'branch --delete --force removes dangling branch' '
>> +	test_when_finished "rm -f .git/refs/heads/dangling" &&
>> +	echo $ZERO_OID >.git/refs/heads/dangling &&
>> +	git branch --delete --force dangling &&
>> +	test_path_is_missing .git/refs/heads/dangling
>> +'
>
> This goes against the spirit of the series merged at c9780bb2 (Merge
> branch 'hn/prep-tests-for-reftable', 2021-07-13).
>
> Can we creat the dangling ref and test the lack of "dangling" ref in
> the end in a less transparent way?
>
> An escape hatch is to make this test depend on the REFFILES
> prerequisite, just like dc474899 (t4202: mark bogus head hash test
> with REFFILES, 2021-05-31) did, which may be more appropriate.

I'm not sure, but this may also be a good example of the sort of thing
that we should probably go beyond REFFILES with, i.e. is it even
possible under reftable to run into this sort of situation?

Not really a topic for this series, but something to make a mental note
of for the reftable topic, i.e. we may eventually want to edit the docs
etc. appropriately if and when the new backend is more mature.

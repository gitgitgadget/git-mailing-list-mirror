Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55504C4346E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0876820757
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gBOi323H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIUT1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:27:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56946 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUT1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 15:27:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20FAFF5177;
        Mon, 21 Sep 2020 15:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eh2S+hSpvkcflSwd51B9Gqkj090=; b=gBOi32
        3HITNrXhzm/bT+1X9DN+1/Hz3U/J8mQors7weX3ePkxpTBjG+QT4emVTB1oR8ckd
        rar93BrMzA83r3RnNE5jvEyLkPcslQBUcEkmJJdVxO9cEQzeg0UR+dYrNa2dRfrR
        E8EQQ1VVpDIKDK57kr0BOTDzI4OO30f8MDLHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JaXL2MICh7yMurHy7+7z7+erYZaY4TLj
        cBGV8ytUmNmjqa4HxB6c7qQfTQMgXFO1wDdiuTLro0stTmY62Jzse91pnTxCmsm/
        Cf7ur3Zsz4XW51m2EqUJSa4mqsZvmsXhFvgaTB+6tvR+GNm7Sl0AtdtX96nNztxQ
        nSEE7w1T9Y0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1939DF5175;
        Mon, 21 Sep 2020 15:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E2EFF5173;
        Mon, 21 Sep 2020 15:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
        <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
        <CAPig+cQNiB8nw-JwwFweHzeFYcozGA06pPKr=0N9Metp8PBbSQ@mail.gmail.com>
        <6da3752f-5e45-1381-b54c-64a81d642b72@gmail.com>
Date:   Mon, 21 Sep 2020 12:27:30 -0700
In-Reply-To: <6da3752f-5e45-1381-b54c-64a81d642b72@gmail.com> (Phillip Wood's
        message of "Mon, 21 Sep 2020 19:05:08 +0100")
Message-ID: <xmqqeemvexr1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ED22844-FC40-11EA-805D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
>>> @@ -713,4 +713,60 @@ test_expect_success '--dry-run --short' '
>>> +test_reword_opt () {
>>> +       test_expect_success C_LOCALE_OUTPUT "--reword incompatible with $1" "
>>> +               echo 'fatal: cannot combine --reword with $1' >expect &&
>>> +               test_must_fail git commit --reword $1 2>actual &&
>>> +               test_cmp expect actual
>>> +       "
>>> +}
>> These error messages are subject to localization, so you'd want to
>> use
>> test_i18ncmp() here, I think.
>> Same comment for other new tests.
>
> I decided to use the C_LOCALE_OUTPUT prerequisite and test_cmp rather
> than grep so I could check the exact output.

I do not think it is a good idea.  Dropping the C_LOCALE_OUTPUT
prerequisite and using test_i18ncmpw would be more appropriate.

A test run without GIT_TEST_GETTEXT_POISON will do the byte-for-byte
comparison like test_cmp.  It is only the poison test, whose purpose
is to catch commands that by mistake translated their messages, that
would want to mark a test that checks end-user facing messages like
this one as special with test_i18ncmp.

> ... I should probably check that nothing is printed to stdout in
> these tests

Perhaps, but that is not the point of "do we diagnose options thare
are incompatble with --reword?" test.


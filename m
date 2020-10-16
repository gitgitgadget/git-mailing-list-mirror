Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A801DC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DA82084C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NwJUy1Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392261AbgJPShA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:37:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57883 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392001AbgJPShA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 14:37:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB7E9FD1A2;
        Fri, 16 Oct 2020 14:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=79Lb+cVSNBVj
        9oXAmhWrhB/eW3s=; b=NwJUy1HwdnoE+iTdeL1ArRqWFllf4my7mX/UErrVfHYi
        72moIu6uOJ2/5EpG65prtD3xoh7BC1MTwhVIfP07xyLDE9yU7iSbdnnsvwbL0ENm
        MUkKDf/KVGunR1UJvNBhtdLBgI4Qx2Pjuz7FGkVPvH/u7hC/oqghMCp17QloNZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FCbnNs
        IAfrO04x/I9uLMbtXB0Emr/j88FQ88yvDK50RB2FKsRsMfXMYKxuNw+7qNF/Cuz6
        EHiyA/DE5TE3yX6cQkAd5WPiRncL7uiXSPbK4p+O7twcnO7nAtqIGaLF8zg8V1hm
        jv2sykpRL6TO/PCxO1sUSVptv1T6RUAAeT4MU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2B44FD1A1;
        Fri, 16 Oct 2020 14:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 127B7FD19E;
        Fri, 16 Oct 2020 14:36:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
References: <20200809060810.31370-1-sunshine@sunshineco.com>
        <20200809174209.15466-1-sunshine@sunshineco.com>
        <20201016001704.GA2937048@coredump.intra.peff.net>
        <CAPig+cSU=1GcQuqZab+0Vff_A-JmD59wEc3RMr3wDojpgRYUuw@mail.gmail.com>
Date:   Fri, 16 Oct 2020 11:36:53 -0700
In-Reply-To: <CAPig+cSU=1GcQuqZab+0Vff_A-JmD59wEc3RMr3wDojpgRYUuw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 15 Oct 2020 22:18:03 -0400")
Message-ID: <xmqqzh4maugq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 915D794E-0FDE-11EB-9B3B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Oct 15, 2020 at 8:17 PM Jeff King <peff@peff.net> wrote:
>> On Sun, Aug 09, 2020 at 01:42:09PM -0400, Eric Sunshine wrote:
>> > [...] Make it easier for test authors to discover such problems earl=
y
>> > by sanity-checking the arguments to test_cmp(). [...]
>>
>> This patch caused some interesting confusion for me today.
>>   error: bug in the test script: test_cmp 'r2/.git/HEAD' missing
>> which was somewhat unhelpful (or at least less helpful than a regular
>> test failure). The test in question does this:
>>         test_cmp r0/.git/HEAD r2/.git/HEAD &&
>> and expects to fail if an earlier step didn't correctly create r2. Is =
it
>> a bug or misuse of test_cmp for it to do so? I could see an argument
>> that it is, but I'm also not sure if there's a convenient alternative.
>
> I can see the argument going both ways as to whether it's a misuse of
> 'test_cmp'.
>
>> The best I could come up with is:
>>
>>   test_path_is_file r2/.git/HEAD &&
>>   test_cmp r0/.git/HEAD r2/.git/HEAD
>>
>> which isn't that great.

Hmph, I agree that the "both must be file" is a bit too eager and
ignores that "they must match, but the possible reasons they may not
include one of them may be missing" use case.

> =C3=86var ran into the same issue recently[1] and came up with the same
> workaround. Despite its good intention (trying to catch bugs in
> 'test_expect_failure' tests), this change[2] doesn't seem to have
> caught any genuine bugs (it wouldn't even have caught the bug which
> served as its inspiration[3]), but has nevertheless caused a couple
> hiccups already. As such, I would not be opposed to seeing the change
> reverted.

Sounds good.  Anybody wants to do the honors?

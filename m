Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721A6C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344F620714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ijFc2o5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0VhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:37:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52444 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgC0VhK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:37:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4EA455636;
        Fri, 27 Mar 2020 17:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dMhEciHOdIfi0spBqKtHQjvXs1U=; b=ijFc2o
        5h81LQ4G+fHjXpQLB+0GqiiesQOUzSOAoNq0dqYmnAh+x8Wdd6e4nohRq0q01HKT
        Wbd5wEqyn69JRIHqOC70szffv1JRYH9r9hcrRDYrYD+a8xDEL92bv4lcGOX+WS97
        StajRvKhU6DE+8VwARerVo6a0wPf/QpN2J61k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HhWCmLSbBUZkEZuSvwXcjXjvy3jVP/Ct
        nBjGzZMi3mgqFYVN8vW5hgXU0TUXl3mQVLvOr97bP3qB+lyRsFIsLHIcYhOt9oZ3
        xVm07bDsllaXXgFDGMwdCrK+BqgxO2AlY2bMx1dLVeAhY5aswuwNbO95moxf2ypz
        oHL4Fo9V2Zs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C37CA55635;
        Fri, 27 Mar 2020 17:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9D5B55633;
        Fri, 27 Mar 2020 17:37:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
        <20200326083519.GD2200716@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
        <20200327091004.GA610157@coredump.intra.peff.net>
        <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
        <CAPig+cT6CQsYyMR=-nAo7GD8mXAWyUWPrbTnCZ0nBs54Ah0PbQ@mail.gmail.com>
Date:   Fri, 27 Mar 2020 14:37:02 -0700
In-Reply-To: <CAPig+cT6CQsYyMR=-nAo7GD8mXAWyUWPrbTnCZ0nBs54Ah0PbQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 27 Mar 2020 16:24:13 -0400")
Message-ID: <xmqq1rpdfpj5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 195ABB2E-7073-11EA-8284-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 27, 2020 at 1:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Subject: [PATCH] t/README: suggest how to leave test early with failure
>> +       test_expect_success 'git frotz on various versions' '
>> +           for revision in one two three
>> +           do
>> +                   echo "frotz $revision" >expect &&
>> +                   git frotz "$revision" >actual &&
>> +                   test_cmp expect actual || return 1
>> +           done &&
>> +           test something else
>> +       '
>> +
>> +    Note that this is only possible in our test suite, where we
>> +    arrange to run your test <script> wrapped inside a helper
>> +    function to ensure that return values matter; in your own script
>> +    outside any function, this technique may not work.
>> +
>>  And here are the "don'ts:"
>>
>>   - Don't exit() within a <script> part.
>
> We use 'exit 1' to terminate subshells[1] inside tests.
>
> [1]: https://lore.kernel.org/git/20150325052952.GE31924@peff.net/

Yeah, I gave two alternatives, but the third one could be

       test_expect_success 'git frotz on various versions' '
           (
             for revision in one two three
             do
                     echo "frotz $revision" >expect &&
                     git frotz "$revision" >actual &&
                     test_cmp expect actual || exit 1
             done 
           ) &&
           test something else
       '

Anyway, that existing rule is not what I added in the rough draft
under discussion.  To clarify it, we'd end up needing "unless A, B
or C" that may be too complex.  I dunno.

Thanks.

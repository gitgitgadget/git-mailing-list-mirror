Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9261C4361B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A813220771
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 11:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438372AbgLLLNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 06:13:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60481 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438333AbgLLLNf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 06:13:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9879C968DE;
        Sat, 12 Dec 2020 06:12:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=49OPi8cNYK6SKs7/CjdFlONpNv4=; b=adGYUvyQ8Pm1w3Jtw4x9
        TDilioyrea9tstiuyqK4BzIo+FT4OtiX7AlHyZFIdqhdcLqe9X8cz0yqxGJKmP/o
        cvRU11X8xvBOhlumFHPnhfhcGCN1vS5hpaqkQiU29/YyB1INB668NWtfHt0fELGl
        Mxs8cRZ+zGwTBPzzVLHfg8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=v83feE3JpgsU5cZB3LbQ8jjigMCFow/KPG+8bbnyVRYZuw
        IIO+K6xfa0I0FqJDnl05PkJMPnEJ8jXT4mPZjHTYi0dQRWfwNE0ONR8hdKyHoFSc
        Wdu7gae2EHGuULtJ/3wX0n2BaqtESXoKu+GK4oPv4gKUoCzCzuGbgtcCbum5c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90EF1968DD;
        Sat, 12 Dec 2020 06:12:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D429968DC;
        Sat, 12 Dec 2020 06:12:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
Date:   Fri, 11 Dec 2020 18:11:44 -0800
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-4-felipe.contreras@gmail.com>
        <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
        <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com>
        <xmqqa6ujj3s4.fsf@gitster.c.googlers.com>
Message-ID: <xmqq1rfvgtvx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F947E3C4-3C6A-11EB-B5E7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  test_expect_success 'pull.rebase not set and --rebase given' '
>> -	git reset --hard c0 &&
>> +	git reset --hard c2 &&
>>  	git pull --rebase . c1 2>err &&
>>  	test_i18ngrep ! "Pulling without specifying how to reconcile" err
>>  '
>
> This used to make sure an attempt to rebase c1 onto c0, which can be
> fast-forwarded, would work fine, even though it used to give
> warning.  We should keep testing the same condition.  The
> expectation of seeing the warning is what must be changed, not the
> test condition (i.e. rebasing c1 onto c2 instead of c0)---you are no
> longer making sure that c1 can be rebased onto c0 cleanly.

Let's try to explain it in a different way.

The original author of this test cared that pulling c1 with --rebase
into c0 succeeds, and that it does not give the error message.  We
have no right [*1*] to say that scenario (i.e. "pull --rebase" c1
into c0) no longer matters without a good justification.  And it is
not a good justification to say that the current code happens to
behave identically whether running "pull --rebase" of c1 into c0 or
c2 so it is sufficient to test the operation into c2.  The test is
*not* about how the current code happens to work.  It is to make
sure the scenarios test authors care about will keep behaving the
same way.

Some tests may be expecting that pulling c1 into c0 would issue the
message, and that the command succeeds, and with the patch 3/3 the
outcome may become different, i.e. the command succeeds without
annoying message.  That would break the expectation of the original
test authors, and it is a good thing.  By recording a change to the
expectation, we can document how the new behaviour works better under
the same scenario.


[Footnote]

*1* That does not mean we must not care about other scenarios that
are different from what have been tested with existing tests.  If
there is new behaviour introduced by patch 3/3, it is prudent to
protect it from future breakage by adding a test that pulls c1 into
c2, if that case is not already tested with existing tests.  

I suspect we already make sure a non-ff merge gives the annoying
message while going ahead, so there may be no new additional test
required, though.

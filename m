Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEE1C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F276135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbhDLVWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:22:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55111 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbhDLVWe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:22:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FD4D119964;
        Mon, 12 Apr 2021 17:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eXsBMOZF5QRy
        J+Rf7pZupeS78OA=; b=PnP2yC/jr2u034q0LKbGwi+9M/iFPja7OQoBys5W13mV
        rRCLxXFZZNO4LegAkDlLkvStlLqmqGXLFm5sOUaJNx6I8vDs06Syy6dtAMu6urab
        VLBO40U5xMqUizCXeyICk7ude6vGIhAeKi28/xFsxYlb1aDX3mP+W6tGlWj52T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FwLZ5n
        8uUOS1J7O+f3+MpRcr1KErbDNU9+8Qi1zdklFO7P8gkeO7hJJz4aXxehyLJXDL3n
        7MRuWnpt2F247ukTsCLjiOkby0eQlhRVjA3TkXqU0OPpevf4sK0WlJvVMPUDlkW5
        oJ0Q4o+V3RhrRgRarqV3FPdL+Nme0L8Be6JwE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 194F5119963;
        Mon, 12 Apr 2021 17:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51AAB119962;
        Mon, 12 Apr 2021 17:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/16] test-lib: bring $remove_trash out of retirement
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-02.16-44223ae777e-20210412T110456Z-avarab@gmail.com>
        <xmqqo8ejcogj.fsf@gitster.g>
Date:   Mon, 12 Apr 2021 14:22:09 -0700
In-Reply-To: <xmqqo8ejcogj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        12 Apr 2021 12:06:20 -0700")
Message-ID: <xmqqo8ejb3lq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24D913EA-9BD5-11EB-AEA1-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> There's no point in creating a repository or directory only to decide
>> right afterwards that we're skipping all the tests.
>>
>> So let's partially revert 06478dab4c (test-lib: retire $remove_trash
>> variable, 2017-04-23) and move the decision about whether to skip all
>> tests earlier.
>>
>> I tested this with --debug, see 4d0912a206 (test-lib.sh: do not barf
>> under --debug at the end of the test, 2017-04-24) for a bug we don't
>> want to re-introduce.
>>
>> While I'm at it let's move the HOME assignment to just before
>> test_create_repo, it could be lower, but it seems better to set it
>> before calling anything in test-lib-functions.sh
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>
> I am not clear what the reasoning behind this change is.  Is it
> correct to say that the idea flows like the following?
>
>  0. If we do the $GIT_SKIP_TESTS check early, specifically, before
>     we create the trash directory to run the tests in, we do not
>     have to create and then remove it.
>
>  1. If we na=C3=AFvely do the above, test_done called in the "ah, the
>     entirety of test is skipped" case will try to see if the trash
>     directory exists and complain, so we need to add more code in
>     that test_done codepath to avoid complaints.
>
>  2. As a part of that "more code", we mark the fact that we created
>     a new repository with $remove_trash variable.
>
> Assuming that the above flow of thought is what is behind this
> patch, I think the patch is mostly sensible.

By the way, I did wonder if the call to test_done is even needed, or
if it is even ready to be called (in other words, the machineries it
tries to finalize like junit and HARNESS_ACTIVE are even initialized
yet).  I verified that calling test_done this early is fine with
respect to the call it makes to finalize_junit_xml, though.

> remove_trash needs to be cleared at the beginning, perhaps where
> store_arg_to and opt_required_arg are cleared, though, to protect
> us from a stray environment variable.
>
> Thanks.

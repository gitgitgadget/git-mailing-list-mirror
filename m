Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64B8C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9766524656
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LaX+2KGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAOSdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:33:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59699 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgAOSdD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 13:33:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B5182C5EC;
        Wed, 15 Jan 2020 13:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iA5Qoa+R8nW8
        jan3AnJ74gPgzfc=; b=LaX+2KGAaVlTCQcsEQR8Ewb3X4WJt9mBcswiofJntPhT
        03IteYHenyY0mVFWL5DE4962rs3CTFkZlaRmg5Oro639kimS/uP3aBTfet5K2M7/
        SC6WzH7luIJ6xSGRj7Rdn4wp9LhmqeTVUo9Rox8KWEmjXPXdoInVx3vOiiatF9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CC58Yx
        PjfcinKKAOHGkoZQPdGMvKKsJV6aL/0MaV1Pl5/6dh06Mygs3WENCjbMfOtzwdCD
        Mi/lIVrvWrG14GvyOMT0MC309SY3OMn5HPDlVP85s5Ckzu7iZm7RbONfELn8De46
        0VOPbQO/5tFKc986jcwfy36agMHxCLv/UCvEQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 268752C5EB;
        Wed, 15 Jan 2020 13:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 158EF2C5E5;
        Wed, 15 Jan 2020 13:33:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
        <20200113170417.GK32750@szeder.dev>
        <20200113183313.GA2087@coredump.intra.peff.net>
Date:   Wed, 15 Jan 2020 10:32:59 -0800
In-Reply-To: <20200113183313.GA2087@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 13 Jan 2020 13:33:13 -0500")
Message-ID: <xmqqblr4k1t0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 751C0CC4-37C5-11EA-9748-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 13, 2020 at 06:04:17PM +0100, SZEDER G=C3=A1bor wrote:
>
>> After looking into it, the issue seems to be sending data to the
>> broken diffFilter process.  So in that test the diff is "filtered"
>> through 'echo too-short', which exits real fast, and doesn't read its
>> standard input at all (well, apart from e.g. the usual kernel
>> buffering that might happen on a pipe between the two processes).
>> Making sure that the diffFilter process reads all the data before
>> exiting, i.e. changing it to:
>>=20
>>   test_config interactive.diffFilter "cat >/dev/null ; echo too-short"=
 &&
>>=20
>> made the test reliable, with over 2000 --stress repetitions, and that
>> with only a single "y" on 'git add's stdin.
>
> Yeah, I agree the test should be changed. What you wrote above was my
> first thought, too, but I think "sed 1d" is actually a more realistic
> test (and is shorter and one fewer process).

I am not sure what we are aiming for.  Are we making sure the
command behaves well in the hands of end users, who may write a
script that consumes only early parts of the input that is needed
for its use and stops reading, or are we just aiming to claim "all
our tests pass"?  I was hoping that we would be doing the former,
and I would understand if the suggestion were "sed 1q" for that
exact reason.

IOW, shouldn't we be fixing the part that drives the external
process, so that the test "passes" even with such a "broken" filter?

>> Now, merely tweaking the test is clearly insufficient, because we not
>> only want the test to be realiable, but we want 'git add' to die
>> gracefully when users out there mess up their configuration.

Yes, and I was hoping that we do not have to touch the test if we
did the latter.

> I really wish there was a way to set a handler for SIGPIPE that tells
> _which_ descriptor caused it. Because I think logic like "die if it was
> fd 1, ignore and let write() return EPIPE otherwise" is the behavior
> we'd like. But I don't think there's a portable way to do so.
>
> I've been tempted to say that we should just ignore SIGPIPE everywhere,
> and convert even copious-output programs like git-log to just check for
> errors (they could probably even just check ferror(stdout) for each
> commit we output, if we didn't want to touch every printf call).

Yeah, I share that temptation.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196FAC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78A764E89
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBRTcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:32:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51058 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhBRTD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:03:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D28E91088A1;
        Thu, 18 Feb 2021 14:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MfT411ixhJbi5srsk6pWH27n8w8=; b=LUSgZC
        M+f/oL8Zb805Meea5jtpUwYsKyVwNtw/+NO2vFuRpbyxTRe2u1ldZTiNpTTTKpH5
        0gO3ZaqzmhGCoguEdRrZJy+FOP5q/SA1iXTiuAMpuFHVF0zLXk7qv/9Yy+7Z9j/T
        3aV4ldvM+0t+7uQY8diIHKnL3I5nhe97VhbLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MY2dRxyhZMY+SarWq5ueOuSJWsdI+eqr
        N4U0nrZQ0gSsjx8U2+51YSkCpeml34ib62cHd4qZwQVIj92YbSWDS+03Lnl+L3QC
        U3nS0Wzj00ImukAfYwpW8NRUa+nwaUX9j817VaFPlq1aigMbqsY8Da3o6cQUCUY0
        Icb79igUoLg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC00C10889F;
        Thu, 18 Feb 2021 14:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 184E810889E;
        Thu, 18 Feb 2021 14:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
References: <cover.1613593946.git.matheus.bernardino@usp.br>
        <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
        <xmqqpn0yi9ii.fsf@gitster.g>
        <CAHd-oW6b0n7ezA-C8NuUOkHUSfM8TFLmkJtwwSRv7FRtbOWjsA@mail.gmail.com>
Date:   Thu, 18 Feb 2021 11:02:36 -0800
In-Reply-To: <CAHd-oW6b0n7ezA-C8NuUOkHUSfM8TFLmkJtwwSRv7FRtbOWjsA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 18 Feb 2021 00:07:42
        -0300")
Message-ID: <xmqqczwxgpwz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE1DE300-721B-11EB-97B7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> > +test_expect_success "git add -A does not remove SKIP_WORKTREE entries" '
>> > +     setup_sparse_entry &&
>> > +     rm sparse_entry &&
>> > +     git add -A &&
>> > +     test_sparse_entry_unchanged
>> > +'
>>
>> OK.  As there is nothing other than sparse_entry in the working tree
>> or in the index, the above two should be equivalent.
>
> I just realized that the "actual" file created by the previous
> test_sparse_entry_unchanged would also be added to the index here.
> This doesn't affect the current test or the next ones, but I guess we
> could use `git add -A sparse_entry` to avoid any future problems.
> ...
> Hmm, I think it might be better to test only `add -A sparse_entry`, to
> avoid adding the "actual" file or others that might be introduced in
> future changes.

Rewriting 'git add -A' to 'git add -A sparse_entry' may not be wrong
but it will invite "does -A somehow misbehave without pathspec?" and
other puzzlements.

If adding 'actual' or 'expect' do not matter, I think it would be OK
to just add it, but if it bothers you, we can prepare an .gitignore
and list them early in the test with a comment that says "we will do
many 'git add .' and the like and do not want to be affected by what
the test needs to use to verify the result".

> Oh, that is a problem... We could use `git ls-files --debug` and
> directly compare the mtime field. But the ls-files doc says that
> --debug format may change at any time... Any other idea?

The option is to help us developers; if somebody wants to change it
and breaks your tests, they are responsible for rewriting their
change in such a way to keep your tests working or adjust your tests
to their new output format.

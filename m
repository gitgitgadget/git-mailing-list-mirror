Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F03EC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 01:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F662071A
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 01:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QX2WKhbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKYBKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:10:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51629 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfKYBKy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 20:10:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E2DC89E07;
        Sun, 24 Nov 2019 20:10:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/jncJ/5oa5sx
        AicjYKYyYGMdlRI=; b=QX2WKhbRRBopn/++pHbFKOPGv61aKPDh8AaW2s50NJS+
        zvZhGIE6ECrhEDsNBX8fTQ+wIKl2UyAIIk/ITfg3D79C00IGuqN9RZ4qEHQjjEdH
        WQ1mmulAP5p9RfQUs1JJUETcTc9zsC3naPugFcnxtrlKUtWp/ICpYJ+HdPG5gvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RnhZID
        r/5Ig0USkDEIjnhzsIy2o7LnS2xnHxkSyVOwmmOdYIWlU/T3ybF6qiGBMyagah7p
        WwFm3ZWMgeqTVWZ7VSW0zct6Qn5wAO+T2eZFr6vgGuD4LgqfFFvJdE0ocyzevSBB
        md5n9rcKsDJXDYTEKTXEK0SA1MraUJKh1uWa0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65E5089E06;
        Sun, 24 Nov 2019 20:10:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B0D089E05;
        Sun, 24 Nov 2019 20:10:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer: don't re-read todo for revert and cherry-pick
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
        <20191123172046.16359-1-szeder.dev@gmail.com>
        <xmqqk17p280y.fsf@gitster-ct.c.googlers.com>
        <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com>
Date:   Mon, 25 Nov 2019 10:10:43 +0900
In-Reply-To: <8c21662f-6548-a46e-9c87-eb364355cb78@gmail.com> (Phillip Wood's
        message of "Sun, 24 Nov 2019 10:44:10 +0000")
Message-ID: <xmqqo8x0zros.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6928DCBC-0F20-11EA-8D35-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> -		} else if (check_todo && !res) {
>>> +		} else if (is_rebase_i(opts) && check_todo && !res) {
>>
>> It is a bit sad that setting of check_todo is not something a single
>> helper function can decide, so that this is_rebase_i(opts) can be
>> taken into account when that helper function (the logical place
>> would be do_pick_commit()) decides to set (or not set) check_todo.
>>
>> Unfortunately, that is not sufficient, I suspect.  Why did a47ba3c7
>> ("rebase -i: check for updated todo after squash and reword",
>> 2019-08-19) decide to flip check_todo on when running TODO_EXEC?
>
> I'm not sure what you mean by this
>
> This is what I had before I saw G=C3=A1bor's patch (the tests are prett=
y
> similar but I think we should check that the messages of all the picks
> are actually edited with --edit - that does not seem to be checked by
> the current tests)...

I first thought that unsetting *check_todo in do_pick_commit(), when
!is_rebase_i(), was a clean solution.  But sadly it is *not* a godo
equivalent to G=C3=A1bor's patch, because check_todo can be set to true
without looking at is_rebase_i() in pick_commits() [*1*].  To ignore
that setting where the variable's value is used, the hunk we see
above in the beginning of this message is necessary.

That was what I meant.  I think the "This is what I had before"
patch matches my "I first thought" version, so we were on the same
page and both wrong ;-)

Thanks.


[Footnote]

*1* I still do not know why a47ba3c7 ("rebase -i: check for updated
todo after squash and reword", 2019-08-19) sets check_todo to true
without looking at is_rebase_i().  If this unconditonal setting in
TODO_EXEC did not exist, I think your "This is what I had before"
patch would have been equivalent to G=C3=A1bor's patch.


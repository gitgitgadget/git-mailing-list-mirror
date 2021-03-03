Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0946C433DB
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7121964EDC
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhCCGlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:41:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56918 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841511AbhCCG3W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 01:29:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0976812F8CD;
        Wed,  3 Mar 2021 01:28:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b9RXFqCWTC1XgZRqt/oRzWloe6c=; b=HidNwR
        3ajxe25fPwBC/oO67COk/ed9XsaTd/ElClyx3rK2MaLebzwgOm8chEinnvBbCPMW
        rx+9RhEEHhR46e2j+/2mc/HyaqTiB9SFLpiBzCCRNqStzAnPQTbLsG96R8mgcXqZ
        R94H6qniJzsOaihsxF4QJK1dSWv9knU2HD0IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J6h13dkstUaHg0sLTI0niiOJnARkr3MO
        ieAKdVPTOOrJkjTtwUkzsL7j30ZtgJvWp8eX+JkD1eCPVL6XGGyvR8STGHJSw+U+
        0wtEUKGi7g8ziz7cq7T28685Lu/yi9FmIB7dP41SowPsPIUCzKEjCwyo/us8kfc3
        1Iwejn2JSP0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0150712F8CC;
        Wed,  3 Mar 2021 01:28:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D16512F8CB;
        Wed,  3 Mar 2021 01:28:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/6] t7500: add tests for --fixup=[amend|reword] options
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-5-charvi077@gmail.com>
        <CAPig+cTVrcWm8pJvnkP4gnWE6B8SKHENjvbAR7Do0ury-ArnaA@mail.gmail.com>
Date:   Tue, 02 Mar 2021 22:28:33 -0800
In-Reply-To: <CAPig+cTVrcWm8pJvnkP4gnWE6B8SKHENjvbAR7Do0ury-ArnaA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 2 Mar 2021 00:43:10 -0500")
Message-ID: <xmqqr1kwlpim.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEAFFCCA-7BE9-11EB-9A26-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 1, 2021 at 3:50 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>> t7500: add tests for --fixup=[amend|reword] options
>
> It's usually preferable for tests and documentation updates to be
> bundled along with the patch which makes a particular change[1] rather
> than waiting until the very end of the series and adding tests and
> documentation covering all the changes made by patches earlier in the
> series. As a reviewer, it is much harder to tell if the late-added
> tests and documentation updates are comprehensive since it's difficult
> to keep in mind all the changes made by earlier patches.
>
> When reading earlier patches in this series, I questioned whether or
> not certain features of each patch were going to be covered by tests
> or documentation updates, but I couldn't tell because those updates
> weren't made at the same time as the change about which I was reading.
> For instance, when reading the implementation of `--fixup:reword`, I
> was wondering if the documentation was going to be updated to mention
> that it would ignore changes staged in the index and leave the index
> untouched, and I wondered if and hoped that tests would be added to
> verify that the index was indeed left untouched. Over the course of
> many patches, it can be difficult to keep track of all the accumulated
> questions, which makes it onerous to review the final patches adding
> the tests and documentation updates enmasse.
>
> I'm not necessarily suggesting that you re-roll merely to incorporate
> the tests and documentation updates into the patches to which they
> belong, but it's something to keep in mind for future submissions.
>
> FOOTNOTES
>
> [1]: Once in a while a patch introducing a change is so large on its
> own that it may make sense to split tests and documentation updates
> out to their own patches which immediately follow the patch to which
> they apply, but that's different from delaying _all_ tests and
> documentation updates and plopping them at the end of the series all
> crammed together.

A good piece of advice.  Thanks.


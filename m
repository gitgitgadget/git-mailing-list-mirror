Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860CBC433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5E82064B
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iaLrOtqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439817AbgJQWe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:34:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62615 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439785AbgJQWe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 18:34:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC8299ADD3;
        Sat, 17 Oct 2020 18:34:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1edQCE6YYnH+
        UDq5bDSSIttaXmg=; b=iaLrOtqct2FEBr6rKzqGduhgnuy7w5Oax5T1mpfzMwP2
        e2xozD6h0C5OgvYWiB4Ktrv6pPgTDX6zR7Yi8Zg3jaZEGWkubQ24gBR0D+7UD74D
        62T7Q2sMC/JZDw8MBI8BQeriNr/crhOZTrvY8iSPIIvwhEV6qu9gdAGa2lGMi5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M5HXIr
        IkqB24RrIwyQYi1vphfF1dlUMTP8WBwCG4VQK2wPQL/15NYKGFKUyCd4Zd6QnO9c
        2tMr6QLWWZxqOs93Zrph6TrcVQdsXTPOQV6wlWOu/y9V1AiEm9IcOs+9xK+Rvud8
        Nd6kwiq0Lm5qx+jJsMWsXzkPum600pvUpHRZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3CAD9ADD2;
        Sat, 17 Oct 2020 18:34:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E2E29ADD1;
        Sat, 17 Oct 2020 18:34:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/3] sequencer: pass explicit --no-gpg-sign to merge
References: <20201013213021.3671432-1-samuel@cavoj.net>
        <20201013213021.3671432-3-samuel@cavoj.net>
        <xmqqd01jh17n.fsf@gitster.c.googlers.com>
        <20201017220224.o6fs5ukwqq7sqgrb@fastboi.localdomain>
Date:   Sat, 17 Oct 2020 15:34:23 -0700
In-Reply-To: <20201017220224.o6fs5ukwqq7sqgrb@fastboi.localdomain> ("Samuel
        =?utf-8?Q?=C4=8Cavoj=22's?= message of "Sun, 18 Oct 2020 00:02:24 +0200")
Message-ID: <xmqq5z788osw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E85A97DC-10C8-11EB-A5B2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

>> Now that we know that the root cause of the bug you fixed was
>> because rebase rebase with the default merge strategy for two-head
>> merges use separate codepaths from and all other rebases, I wonder
>> if it is prudent to also test the same cases this series adds
>> without giving "-s resolve".  That would exercise the other codepath
>
> I will leave that for someone else to tackle eventually.

We know that other codepath has been working even before this fix,
but tests are not about showing off what we fixed, but are about
making sure similar breakage won't be introduced by mistake in the
future.  Leaving it "for someone", when we know what the problem is
and how to solve it, is asking for the "evantually" not materialize
forever.

> As the number of very similar test is slowly growing, do you think it i=
s
> worth copying (or making more generic) the test_rebase_gpg_sign for thi=
s
> situation as well? We currently have 4 almost identical tests (counting
> the new one you suggested for v4). Just a thought, as it is simpler to
> just add it at this point. Thanks for the feedback.

That is a tough question.  Often, a generic test helper makes it too
easy to do a full matrix of tests and encourages us to overdo it,
which we probably would want to avoid.  I think what I've suggested
so far is a bare minimum combination for code coverage.


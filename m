Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F9C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9522083E
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dpz/SJK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbgKYV7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:59:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50527 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgKYV7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:59:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D75CE9F916;
        Wed, 25 Nov 2020 16:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lF6CDEprgbAL5uLJ5Y9qZ5IYoak=; b=Dpz/SJ
        K8wXgYxun+tq0G/V1MwqzAnZJ/+/ZHqTKMC8aqIbIOuP6Xf+UppB9uKXZJzKoB0G
        o23iRWDhKCq9YhDaFTqcvcdRpcWNbUVEJbBVmjPyNOQk9P3ZmX0uHNe+taPG8xyr
        TzmZN5ASoohYwg3SwF5A1sgJBLNgTx4qHRsKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D1lDCnWRbMuClx9W873Xj4dEaEbtmFU/
        aa6l8PGIfmu3LBndfV2aqBvrBjGWsxvTgNHhhdWBH516CcigA4brhecuy4XiSmUK
        6MqqgJ1Qt/zKy2aw2OoqevZfKeqGCpcG84Nz11BfWw6rh464qz+l+uj8Ugt4h1Mw
        q/RXZVOUwsc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD04F9F915;
        Wed, 25 Nov 2020 16:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50F769F913;
        Wed, 25 Nov 2020 16:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/11] Fix color handling in git add -i
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
        <20201117015149.GC19433@coredump.intra.peff.net>
Date:   Wed, 25 Nov 2020 13:59:50 -0800
In-Reply-To: <20201117015149.GC19433@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 16 Nov 2020 20:51:49 -0500")
Message-ID: <xmqqtutdcd2h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AE857D2-2F69-11EB-9ABD-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 16, 2020 at 04:08:21PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> Changes since v2:
>> 
>>  * The commit messages of patches 7/11 and 9/11 now stress why we want to
>>    align the output of the Perl vs the built-in version so slavishly: to be
>>    able to validate both versions against prerecorded output.
>>  * A typo was fixed in the commit message of patch 10/11.
>
> This version looks fine to me, and I agree is a good stopping point for
> now (the only thing I'd consider adding is a test for the funcname in a
> split-hunk header, but it would have to be expect_failure for now; it is
> probably not worth the effort to rewrite the perl version to behave like
> the builtin here if we think it's going away soon).

Will mark the topic to be merged to 'next'.

It seems that these days I am too quick and eager to take more
things in 'seen' than the rate at I can convince myself that the
topics are ready and accumulate too many topics in the "undecided"
category too fast.  I probably should slow down the intake a bit to
match.

Thanks.

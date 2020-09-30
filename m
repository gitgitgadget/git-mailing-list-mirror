Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEDC4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2520709
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KwHSKUts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgI3TJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:09:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58905 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3TJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 15:09:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2D4A90884;
        Wed, 30 Sep 2020 15:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dyMC5JYgaaM5x3ILyTuy9CWNf4w=; b=KwHSKU
        tshqiujjzfDoK0YDf6AsAQ/IgHEvdHH+qxtb2r50cG6z1wQJyPIWYUQI5A0xMGTV
        JvTVpROBYLFr4a+SWqUS4yAyHUbsbFo3ksQq9bS67/MrIEGqJdGOFMed4ov4/APP
        lKNocBS7QHzkQ5jsyQSri8kDPxFO+rVUw7THM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XAL+EKeLxsk04D8I1lQOc2vHqbHgjkgB
        iz5ptxdsf+c61C95odqfSzMTyXr3s9bcBcHS6SBKFiKL0nmEV8Kehtf/h8v2bbFn
        O0RSvk4MYrWPOvCYn6N6QqWcEhsOvs4Gq0Fe+Ii9Cc61tf5QP7uh9EYqCkxxa+Qq
        Fy4M4B7HM2k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FE5D90883;
        Wed, 30 Sep 2020 15:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22BE090881;
        Wed, 30 Sep 2020 15:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Karszniewicz <avoidr@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-completion.bash: stash-show: add --patch-with-stat
References: <20200928110517.24915-1-avoidr@posteo.de>
        <xmqqh7rhn3nk.fsf@gitster.c.googlers.com> <20200929213154.GA18321@HP>
Date:   Wed, 30 Sep 2020 12:09:09 -0700
In-Reply-To: <20200929213154.GA18321@HP> (Robert Karszniewicz's message of
        "Tue, 29 Sep 2020 23:31:54 +0200")
Message-ID: <xmqqo8lngjze.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B8CAA0E-0350-11EB-9F35-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Karszniewicz <avoidr@posteo.de> writes:

>> surprising experience to the end users.  For "show" alone, it may
>> make a lot of sense to complete "git stash show -<TAB>" and offer
>> "-p".
>
> Does git complete short options at all? I only see long options
> completed. (I'm also very new to bash-completion)

I wouldn't personally recommend it, but I did see a patch that added
support for one short option completion quite recently.  As long as
"--<TAB>" gets completed to often-used options, among which "--patch"
and "--stat" are included, it would be OK not to react to "-<TAB>".

>> In any case, it might make more sense to do this instead, and then
>> rethink what options make sense to these subcommands of "git stash".
>> I do not think patch-with-stat should be among them.
>
> So shall I do a v2 as per your suggestion and replace
> "--patch-with-stat" with "--patch --stat"?

I think Denton Liu offered a different suggestion; I didn't look at
and compare which direction is the better one myself, but an
approach that keeps the number of manually-maintained list of
options low is almost always a good approach.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743E820281
	for <e@80x24.org>; Mon,  6 Nov 2017 01:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbdKFBMn (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 20:12:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50730 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdKFBMm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 20:12:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5726B386B;
        Sun,  5 Nov 2017 20:12:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vdBGYMFCtGjI
        w+58A3++58zzqf4=; b=t751kWo/eeFFbYxED8NoHXdzkiu79lnfNwM/8Hjo1srn
        xYW18E1LUWl61Bn5L/2o8OiSg5gnk+gMRl+IQ6mLrWXM8fNhs/oeArPpYUbraHy/
        e0b8zauQu+JYjklooQkf+C9rzyGwFvf7wwXWTBV3dLjLjJi2/dJECRc/TBzXNo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pNR2eu
        7+xl1XcOZTdmKUYrFEmRFW1PulUoD4+1Ju2AmPmEGKlWrcxlJk6tq1ocKxNXOf5v
        OLxTG32DtfQkiqDGXuF4CKRQNu0aHsgu097/KYkFxJfO6R19zji89aRSx8k2yZGA
        HYhjOKxR2O51CAiVLm3HBt7FKuh5H1HKjyfqE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCD8CB386A;
        Sun,  5 Nov 2017 20:12:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CDA4B3868;
        Sun,  5 Nov 2017 20:12:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Re: reduce_heads: fix memory leaks
References: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com>
        <cover.1509908607.git.martin.agren@gmail.com>
Date:   Mon, 06 Nov 2017 10:12:40 +0900
In-Reply-To: <cover.1509908607.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 5 Nov 2017 21:26:29 +0100")
Message-ID: <xmqq60aoky5z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 961C25EC-C28F-11E7-8A33-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Since v1 [1], I've added a preparatory patch to UNLEAK some variables.
> That sets the stage slightly better for patch 2.
>
> Junio, you placed v1 on maint. Because UNLEAK is not in maint, this is
> based on master and maint misses out on this v2. If you have any advice
> for how I should (not) do series with UNLEAK in them, I'm all ears.

As far as we know, nobody reported that these leaks made Git run out
of memory while running merge-base and prevented them from getting
desired result, so it is not worth the effort to make (part of) them
mergeable to 'maint'.  I forked the branch from 'maint' only because
it was a fix and it was not harder than forking from 'master'.

If 2/2 (which was 1/1 in the v1) were fixes to a very grave error,
then I might have suggested to do the 2/2 on maint first and call
that topic ${some_grave_error}_fix-maint; then fork another topic
${some_grave_error}_fix at master, merge the _fix-maint topic in,
and then do the 1/2 on top.

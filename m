Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F2EC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E3320757
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tU3INyHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403815AbgJLQmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:42:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50346 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390257AbgJLQmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 12:42:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ADDA8BDF3;
        Mon, 12 Oct 2020 12:42:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jP/r3DKik0vMfap7AxZCdAQr30I=; b=tU3INy
        HJ6PtjervZyrfMW+vnYJdwJ22++RqAhtoJzyPXtyq97liNOdkaq5rI6gRVVkUE/n
        911P+v025nd07AUCt6Vhukk3yuY+z5HDa2H4dSpXaMdoQUgd+jZsE5bcfCTfipyi
        k1Dhs4TPI5HyAAmbrhCCgaALds8sZj+RMIvwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SOGxgpSLoS3uc1aCmDq8YpLd2V7jrPRG
        50oXuczLCMZD4p1K3eJ+R/L5UEX3IYpzlNo/9OW4e2cgxwr7BhGLGo4wH5uzNACR
        D5qIVNhbNCg35ApvduJUvMmTJocSJBGbnA8x61Ku1uz98Oucp2d9rQAf6uWc/j71
        XijgUBqZrZ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 525358BDF2;
        Mon, 12 Oct 2020 12:42:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4C388BDED;
        Mon, 12 Oct 2020 12:42:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
        <20201008014855.1416580-1-jonathantanmy@google.com>
        <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
        <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Oct 2020 09:42:37 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 11 Oct 2020 12:52:01 +0200 (CEST)")
Message-ID: <xmqqeem3qttu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFE81BB4-0CA9-11EB-9369-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> FWIW, the duplication is really tiny: according to
>>
>>  $ wc $(grep -l REFTABLE_STANDALONE *[ch])
>>
>> it's just 431 lines of code.
>
> The `merge_bases_many()` function has only 33 lines of code, partially
> duplicating `get_reachable_subset()`. Yet, it had a bug in it for two
> years that was not found.

It does not affect the current discussion, but what you are giving
is a revisionist view of the world.  The latter function came MUCH
later to do a bit more than the former.  The bug was caused by the
fact that those that added the latter neglected the responsibility
of maintaining the former to the same degree when new feature like
commit-graph were added to the latter.

The root cause was that the latter one did not share the code with
the former one when it was introduced.  That does make it appear
similar to the situation we have at hand with duplicated utility
functions.

> How much worse will the situation be with your 431 lines of code.
>
> Even more so when you consider the fact that you intend to shove the same
> duplication down libgit2's throat. It's "triplicating" code.
>
> So I find the argument you made above quite unconvincing.
>
> Ciao,
> Dscho

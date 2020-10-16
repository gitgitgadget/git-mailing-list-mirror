Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9BEC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7737520878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0gC/tR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393408AbgJPUPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:15:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51433 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393382AbgJPUPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:15:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3D2CFDCC0;
        Fri, 16 Oct 2020 16:15:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j+2VeKXAdbikvtn2Vq5gMt1ElD0=; b=k0gC/t
        R4jX4dkcqrc2DDy4vEEADHmTNJbBSeIQ2uVs5AG6IYwUSLl1Dc0Iz334tT8zpDGV
        I5ZUW9G6ZR9Ac3MMKGEFCke2F0x66y2cQrCc5ASLCSUd+jCja6UkUQJonrQPQuQO
        adXsxd+LhO/0PEKcvX+755OSKeBhyN4zfwq60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wotg7MvYk2wW64hLTqOP3kdMNhXHFCln
        J4D0RcCZ9jE2Tamny9HFvjcy5pGUvz89gWYSXMwerQ6mXcdtqop0T1CCwqiDQy/5
        5dfxSW1/j4WuSodZQpOWVFq4f4Pm8qrwXs8R16CIe47G/lklxRBGazzWMNKb0B+d
        5CsHHVlBDiM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE189FDCBF;
        Fri, 16 Oct 2020 16:15:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE28FFDCBE;
        Fri, 16 Oct 2020 16:15:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
References: <20201012234901.1356948-1-samuel@cavoj.net>
        <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
        <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
        <31ce457b-e71c-0ca0-e5be-a9aebb9cf785@gmail.com>
Date:   Fri, 16 Oct 2020 13:15:24 -0700
In-Reply-To: <31ce457b-e71c-0ca0-e5be-a9aebb9cf785@gmail.com> (Phillip Wood's
        message of "Fri, 16 Oct 2020 14:40:00 +0100")
Message-ID: <xmqq8sc6apwj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5503CD3C-0FEC-11EB-90E4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> What is "natural" is subjective but what is the default config is
> not. If test scripts set random config variables and assumes that they
> will be ...
> ... cleared how are new contributors supposed to figure it out? If each
> test starts with the default config it is much easier to reason about
> it.

If this were a test script with many tests, all of which depend on
starting from clean slate wrt the configuration variable space, and
if you are adding just one or two tests that wants to run with
configuration variable in effect, the story would be quite
different.  For example, I would think it would make a lot of sense
in <20201014232517.3068298-1-emilyshaffer@google.com> to use
test_config instead of "git config" as it is clear that leading 100+
lines of tests run with the default configuration, and it is sane to
expact that later tests that may be added in the future would be the
same.

Look at the test script in question again and notice that it is
about seeing behaviour with the single configuration variable set to
true or false.  Using test_config would still signal the test pieces
that use it do depend on the shown setting of the variable, but it
does not help at all the test pieces that wants to see what happens
when there is no configuration.  Explicitly using "git config" and
"test_unconfig" actually would _help_ reviewers who only looks
between the pre- and post- context lines that are affected by the
patch, as they do not have to know or assume that "normal state is
nothing configured" (which needs to be verified by seeing all the
existing tests that are not shown in the patch use test_config to
clear the setting when they are done).

All of the above would be obvious once you think about it, I'd
think.

Thanks.


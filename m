Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29396C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CCE2084C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GSTsNGSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410434AbgJPQhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:37:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60570 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408856AbgJPQhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 12:37:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FD3F91424;
        Fri, 16 Oct 2020 12:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f4i7TUaqr/zwIpVRztai5N4cMlw=; b=GSTsNG
        SFsmBlVypao2DJ4nBUyoO9Jp6TR+un2wSW6eWA5nkNp0Mdh42L0+hurTKMQsl0WR
        FexjPiaTu2JUlS+IsFQpVx4fT43mP2CRhCpGf3RgoiW3Bc0pOyJ5CmaX/mpLoDeD
        SwLWekzp2X8mrk29MIe4PUnCdYVQYjN9VsWcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GySWAqJIq0/pvlWdeUiXYFzSxoIoJWc6
        EXcwHnZf9MvdkRw2BZHQCMkm+t8FBu/ZZvf7AC0R7kUj4aqZjLjYLyVG65wp021h
        2uIpNEVBfROCx0YlPMK8clHNVuubBBVIfMb05ZwBDmzEQXzn/XDp7scU03dj2VDY
        FR6uhMdXcYQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1766991423;
        Fri, 16 Oct 2020 12:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 933E191422;
        Fri, 16 Oct 2020 12:37:51 -0400 (EDT)
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
Date:   Fri, 16 Oct 2020 09:37:50 -0700
In-Reply-To: <31ce457b-e71c-0ca0-e5be-a9aebb9cf785@gmail.com> (Phillip Wood's
        message of "Fri, 16 Oct 2020 14:40:00 +0100")
Message-ID: <xmqqy2k6cejl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEEDF0A4-0FCD-11EB-B973-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... Reviewers that only read the patch without loading up the
> test file in their editor have no indication that the test should be
> clearing the config variable.

It is not a review if the code being updated is not checked for
sanity in its own context, is it?


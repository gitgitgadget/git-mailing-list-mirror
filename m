Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7561F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756224AbcIGRoi (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:44:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65355 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752301AbcIGRoh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:44:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95B9D3B9A9;
        Wed,  7 Sep 2016 13:44:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p3yMFVyRVcy4
        mUb0QwnuxT3SEcM=; b=mKEDLxGGPnxdRrZz1Dm8buPxOuhL/2HBFYzRkUWevTui
        HdhemwZtRZmGXFNONMTKk8lKSnsKwOUbPSR96J1zoDW9BjnvVqupy2bo17X1pVLb
        K8RVs1CvkOQW9fDH5CAG2leXtMHSke8DDYaiyzpGzObgXnfcFYKb+51J4Yj9xMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oRR2Zg
        nsZsb1cdk3jiJSjkZxh2hC04hCNnMeIgOZ0LAuevWH+1Y9OuSp1M0nOhm+wWBcLs
        42G6NavKfHSOrZ7ZNJ487QLZH2Sujds1r+FKSM6n7n+knrIDMKqirKmOjwnoynhV
        1atabz753fE2QRixymaQDAe5tzhFgfGz1wRgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CEC83B9A8;
        Wed,  7 Sep 2016 13:44:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 111953B9A6;
        Wed,  7 Sep 2016 13:44:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] compat: move strdup(3) replacement to its own file
References: <89725a44-8afa-1eb1-732a-23b1e264616c@web.de>
        <alpine.DEB.2.20.1609040941210.129229@virtualbox>
        <6926b39c-4448-c463-33f7-d9eae841c635@web.de>
Date:   Wed, 07 Sep 2016 10:44:31 -0700
In-Reply-To: <6926b39c-4448-c463-33f7-d9eae841c635@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 6 Sep 2016 17:40:49 +0200")
Message-ID: <xmqqfupbob9c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD8CB9A4-7522-11E6-A623-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Well, OK.  I think the missing point is that the original nedmalloc
> doesn't come with strdup() and doesn't need it.  Only _users_ of
> nedmalloc need it.  Marius added it in nedmalloc.c, but strdup.c is a
> better place for it.

Thanks.  I'll add these lines like so:

    Move our implementation of strdup(3) out of compat/nedmalloc/ and
    allow it to be used independently from USE_NED_ALLOCATOR.  The
    original nedmalloc doesn't come with strdup() and doesn't need it.
    Only _users_ of nedmalloc need it, which was added when we imported
    it to our compat/ hierarchy.

    This reduces the difference of our copy of nedmalloc from the
    original, making it easier to update, and allows for easier testing
    and reusing of our version of strdup().

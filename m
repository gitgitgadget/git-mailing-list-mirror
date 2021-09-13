Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122BC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D0A60F4C
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbhIMD3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 23:29:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61704 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhIMD3b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 23:29:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D392F15A4F2;
        Sun, 12 Sep 2021 23:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=qiSz4og6LzSqRF87g25/M6iUL
        4xKg+kgUiigCI9/qz4=; b=BoWoBhiOL6M5z+Rwp+Wl1EfMKR/KTxRCMVVkUOuTK
        VvMAzGx79RMFnAY97sUiXqsNMOos746P0ILa47DKCj/IqlDtxNfkNxP+TXO6spxz
        qHWcFpKk8vwbH37O73YjBvFLQ7bn2VDxiddGEnKrwQB+YFAdhaFZxsk/qarp0GaG
        wo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC58515A4F1;
        Sun, 12 Sep 2021 23:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24AB715A4F0;
        Sun, 12 Sep 2021 23:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 1/4] git-submodule: remove unused is_zero_oid() function
References: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
        <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
        <patch-v3-1.4-62b3a5881c9-20210911T111435Z-avarab@gmail.com>
Date:   Sun, 12 Sep 2021 20:28:11 -0700
Message-ID: <xmqqr1dtgnn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A0507E60-1442-11EC-B1AD-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The is_zero_oid() function in git-submodule.sh has not been used since
> e83e3333b57 (submodule: port submodule subcommand 'summary' from shell
> to C, 2020-08-13), so we can remove it.
>
> This was the last user of the sane_egrep() function in
> git-sh-setup.sh. I'm not removing it in case some out-of-tree user
> relied on it. Per the discussion that can be found upthread of [1].

I am OK with losing sane_egrep because it is not about a usefulness
we can give to our users based on our deep knowledge on how Git works;
it was rather based on our experience having to deal with silly choice
GNU grep made about coloring that made it unpleasant to use in scripts.
The users shouldn't have to depend on us for such a thing.

But I am OK either way---the whole topic is more or less "Meh" to
me.  It is hard to draw a line between a collection of pointless
churn and a generally useful clean-up, and I am having a hard time
deciding which side of the boundary this falls.


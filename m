Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACFEC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 05:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FB961038
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 05:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJRFkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 01:40:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65049 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRFkS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 01:40:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15A5C1479AD;
        Mon, 18 Oct 2021 01:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=nAq556L3emZHmbvz3kB63Ve2t
        mAT+acNRXChnC3epP0=; b=XQ6m5IUUyt6KFBrFZoAa7mATL9ghQLHXQ4rRF5nLr
        VJnm4wSKM+m7S9DU2xRE03GZU9aEqk/ncdLTWY5Uk1GpoH2+Qf2+RwSn3NkmcwVu
        PbVUBaaZjaIBSNXy7OxkGP9bS5BZpIqZ2XzT5OYXrgeGmMdrfcDcjiF4f/c1CXVJ
        zk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 019081479AC;
        Mon, 18 Oct 2021 01:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 514291479AB;
        Mon, 18 Oct 2021 01:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     milan hauth <milahu@gmail.com>, git@vger.kernel.org
Subject: Re: force deterministic trees on git push - exact sort-order of
 filenames
References: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
        <87ilxvd3uw.fsf@evledraar.gmail.com>
Date:   Sun, 17 Oct 2021 22:38:04 -0700
Message-ID: <xmqq7deazydf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9145FA5E-2FD5-11EC-8C13-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I suppose there could be more strictures in the fsck code to allow for
> that use-case, but still make some things that are mere warnings now
> hard errors (or "fatal").

There is a group of configuration variables fsck.* to let you pass
specific types of errors go without erroring out on them, and also
fsck.skiplist lets you ignore errors on specific objects, but both
need to ask people on the other side to flip them on.

I'd imagine that hosting providers can make it self-service for
repository owners, though, but if they employ shared object store
across repositories, it might become a bit cumbersome to implement
correctly.

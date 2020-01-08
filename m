Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C392EC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970982067D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h/vhunUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgAHRSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:18:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60967 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgAHRSf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 12:18:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B66A97D6B;
        Wed,  8 Jan 2020 12:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+K8DVOSyAetZyV0YBit3XYDdbkY=; b=h/vhun
        UxY5Q8jt6Rh8YNj8KH2s5nlhxsJTtI9IIFpfp+llPnuXFXX4ttELvG3pXMhNiVhl
        huuEt7Kj87I/A4fDwKuM4kdgR0qHY6deju4hwWWCg0Ixb4wkzyeJPg2jSCUErZg5
        5WuMS5j27JNTiDExZBgf2XB61GSEmEltnPOsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DYY4WCRMkwSgWYS9BRqhB09M1osF3dmC
        I8CuUSS3vAJ940df9RQ1ucuDRQGWYqicCD1u4psmJuThTQC05rtB8fKYEDqXOpUD
        6/u2Kaqnh8qB1v+nZo1b4qHHt7HZbmoe38XDGkk/deEkJoRanETynXpuFKwWmdX0
        ASl2P/BE+KY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91E3097D6A;
        Wed,  8 Jan 2020 12:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B042C97D69;
        Wed,  8 Jan 2020 12:18:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 10/15] rebase: add an --am option
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
        <8f2fa083-114a-011f-1480-ae0ebd67d814@gmail.com>
        <CABPp-BEoTb6LVXThEM4zoKxVOnzBNs7y-Mk+oFbb6BUzCo3RHg@mail.gmail.com>
        <xmqqy2uj3u3q.fsf@gitster-ct.c.googlers.com>
        <9ac52ef1-c1cb-45aa-178a-ec5a282bd761@gmail.com>
Date:   Wed, 08 Jan 2020 09:18:28 -0800
In-Reply-To: <9ac52ef1-c1cb-45aa-178a-ec5a282bd761@gmail.com> (Phillip Wood's
        message of "Wed, 8 Jan 2020 14:32:56 +0000")
Message-ID: <xmqqmuax3lzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E443CD98-323A-11EA-A09F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I view this change in the default backend as similar to the rewrite in
> C in that it is an implementation detail we're changing that should be
> transparent (and beneficial in terms of performance) to the
> user. There we provided a configuration variable but not a command
> line option to control if it was used or not.

Do you mean things like GIT_TEST_ADD_I_USE_BUILTIN?  I think it is
OK to have such an escape mechanism to allow people to opt out of
a new reimplementation until it matures, but I do not offhand recall
doing so with config.

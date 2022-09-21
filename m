Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EBC6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 17:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIURwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 13:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIURw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 13:52:29 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8059E0E4
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 10:52:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C2B3140750;
        Wed, 21 Sep 2022 13:52:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j51g7TSqLLYn
        nMn9Mdj3SCLZKrrpRVTNg4DpGEkOtqk=; b=xnsABbc3nfPywWz2RtdVEtZX1Q7y
        l89Qdh/6K7oDcN2wegosYM7nFLR802wiPKVma0Y6z4Qu7q3HBUv3d/XBfMTSlpj9
        NJDZdGe1SocwlAy0dkKg4oC1A/Qgnn7PwktnMw95ibwY5BQZ2r09JuPp2jp0ycjY
        xqqgLCT6Hjml9ak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 233EC14074F;
        Wed, 21 Sep 2022 13:52:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 842DF14074E;
        Wed, 21 Sep 2022 13:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2] t/Makefile: remove 'test-results' on 'make clean'
References: <20220920105407.4700-1-szeder.dev@gmail.com>
        <20220920201619.40972-1-szeder.dev@gmail.com>
Date:   Wed, 21 Sep 2022 10:52:23 -0700
In-Reply-To: <20220920201619.40972-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 20 Sep 2022 22:16:19 +0200")
Message-ID: <xmqqv8pg399k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 263BC11A-39D6-11ED-A391-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The 't/test-results' directory and its contents are by-products of the
> test process, so 'make clean' should remove them, but, alas, this has
> been broken since fee65b194d (t/Makefile: don't remove test-results in
> "clean-except-prove-cache", 2022-07-28).

What I find more disturbing is this is part of "leak check" topic,
and I see no reason why we need to futz with "make clean" rule in
the makefile while extending SANITIZE=3Dleak support.  We really
should yell louder when we see topics that tries to do too much
"while at it" and reject them to minimize the risk of introducing
this kind of breakage.

Will queue.

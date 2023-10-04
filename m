Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217C8E7C4EC
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 18:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbjJDSYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbjJDSYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 14:24:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B315FDD
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 11:24:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48D921C0E78;
        Wed,  4 Oct 2023 14:24:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7kmmA+6mGL2u
        x25Ve7ihVbBYLpp950+NfN5lDSWz3JQ=; b=hmDeYLvETmdEJdeO0Zu6285kEofp
        QncttTWBe7ufymq4RGn1ME+b5G9m6rKNszAdSguoUGN/OtCPaiUnzIwClE8c1rGV
        WEhHpvHO+FQbsJoo+fn1VcdZw1KM8NBPg1/AOgu4M53QoPFFQZs3gT5z5d9O9Rpv
        xGQw2Ojdb6VR95Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4063E1C0E77;
        Wed,  4 Oct 2023 14:24:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2C761C0E76;
        Wed,  4 Oct 2023 14:24:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <20231004194046+0200.353534-stepnem@smrk.net> (=?utf-8?B?IsWg?=
 =?utf-8?B?dMSbcMOhbiBOxJttZWMiJ3M=?=
        message of "Wed, 04 Oct 2023 19:40:46 +0200")
References: <20231003082323.3002663-1-stepnem@smrk.net>
        <xmqqwmw3wgeo.fsf@gitster.g> <xmqqjzs3wer0.fsf@gitster.g>
        <20231004113413+0200.161419-stepnem@smrk.net>
        <xmqqbkdes6lf.fsf@gitster.g>
        <20231004190140+0200.740775-stepnem@smrk.net>
        <xmqqttr6pavh.fsf@gitster.g>
        <20231004194046+0200.353534-stepnem@smrk.net>
Date:   Wed, 04 Oct 2023 11:24:10 -0700
Message-ID: <xmqqpm1up7p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 371DA566-62E3-11EE-B291-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> The $PWD inside the test is the trash directory, though, so that's not
> the problematic $PWD with a trailing slash any more, so I guess this
> problem can't really happen in a test that follows the '. ./test-lib.sh=
'
> (which does cd -P "$TRASH_DIRECTORY") convention?

Yeah, after the dot-include of test-lib.sh returns, everything
should be safe.  What happens inside test-lib.sh (and worse yet,
inside future versions of that file) before that "cd -P" is what
the extra-carefulness protects against.

Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E79BC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1687206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aor0j+kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLITAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:00:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52265 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfLITAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:00:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C09F20F47;
        Mon,  9 Dec 2019 14:00:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rsfB64hPmFsYh4mZ95z9Wfo+/Sw=; b=aor0j+
        kzTu2r4XuDJUhz6EBO8STarPDpQCMvzfsuMhSciHw2xT4V0a6ahX86Xiqq1hgS0I
        tk6ufi13MEEqajEBkep56YYrYAfeUE/7vPvipbwCbE00zZK4qCRf07Oc3yfpsE1N
        CndOrpm6Aq/sNFJSJ1InVruRYeBfHA+hi9G4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=szzt4U8Xs2BkJ9OlBEqHc9MBlIRPXu7I
        hvnn4HpKalxCb9ei4S319IMZQ8OLmCF0Ob7HICsAHb1ALdINjB/A8KTELyCu+X6d
        mBthXA5O1yc4Pv78VcKUGkXiOdBlt2cGwcI99N21jOWJzNsMJcK8H7Nl4+ZMCay6
        QJM5Grm80eo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 626D720F46;
        Mon,  9 Dec 2019 14:00:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BED5920F45;
        Mon,  9 Dec 2019 14:00:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
        <20191115180319.113991-1-jonathantanmy@google.com>
        <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
        <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com>
        <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com>
        <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet>
        <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
        <20191209061853.GA38588@coredump.intra.peff.net>
Date:   Mon, 09 Dec 2019 11:00:32 -0800
In-Reply-To: <20191209061853.GA38588@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Dec 2019 01:18:53 -0500")
Message-ID: <xmqqy2vluxwv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D80DEF2-1AB6-11EA-9C42-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Now I would _love_ if somebody else dug into the topic enough to
> understand all of the ins and outs, and whether what they're doing is
> sane (or could be done better). But barring that, these patches have
> been battle-tested for many years on GitHub's servers, so even if we
> just take them as-is I hope it would be an improvement.

Sorry; it wasn't my intention to ask accelerating the topic
forward---it was just to see the current status to adjust my
expectations.  And you could have stopped at the end of this
paragraph but ...

> Fortunately I have some other work to do that I would like very much to
> procrastinate on, so let me see if that can summon the willpower for me
> to review these.

... I'd love to see us benefit from this ;-)

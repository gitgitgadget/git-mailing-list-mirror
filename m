Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E7FC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiF3VDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiF3VD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:03:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E02E08B
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:03:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25F2F1A8DB8;
        Thu, 30 Jun 2022 17:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vzh0TXMw0mbC
        vlmme4wur7fLr+FsPDmjrPJBK5oxlcw=; b=qFSa4QwCBMGSAj5WPWKgScrHh/DV
        JvU6jRyhHJJTQ9zepNzsRi2B2XD8D6ph3AApdu4PdXmRsr5L+e8mqEhjbYkgy0VQ
        dTxwZF9UP6y9RuILOkQxDwQ3w+M6al0vFlT47wxLdHtWrvzteVQeYSiHawIZ3Opb
        BAYyNfcUX8dKJH0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F3E41A8DB7;
        Thu, 30 Jun 2022 17:03:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6DF71A8DB6;
        Thu, 30 Jun 2022 17:03:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stewart Smith <trawets@amazon.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --no-validate-email option
References: <20220620004427.3586240-1-trawets@amazon.com>
        <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net>
        <220622.864k0dmzl9.gmgdl@evledraar.gmail.com>
        <YrJm6KactXg4elvD@tapette.crustytoothpaste.net>
        <220630.868rpee6d3.gmgdl@evledraar.gmail.com>
Date:   Thu, 30 Jun 2022 14:03:22 -0700
In-Reply-To: <220630.868rpee6d3.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 30 Jun 2022 13:18:55 +0200")
Message-ID: <xmqqzghtdftx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1420734A-F8B8-11EC-AFB2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm suggesting that we replace our own validation with that of the SMTP
> server's, yes they're don't 1=3D1 correspond, but I think the part of t=
he
> Venn diagram of where that matters is too small to worry about.
>
> It has the advantage of side-stepping issues with not having
> Email::Valid, as well as those cases where we're being overzelous about
> RFC validation, but our local SMTP is willing to try to deliver the
> mail.
>
> It's not like authors of MTAs haven't heard of that character limit, bu=
t
> they're also aware that that certain parts of the spec are loosely
> enforced, and that trying delivery is often better than rejecting a mai=
l
> out of RFC pedantry.

I am not sure if that is a healthy direction to go.

If a local outbound relay is written with the knowledge that it will
never be talking to the SMTP at the final mailbox directly, I would
expect that it may not implement any validation at all, relying on
the "next hop" smarthost to reject anything invalid it throws at it.

So...

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B41C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 22:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiBYWsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiBYWsf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 17:48:35 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFCD7EA25
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 14:48:02 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 521D918D8AF;
        Fri, 25 Feb 2022 17:48:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CtHOqcdzbqeJ
        mbtVx8mTvjFvcj7/P7n+jeNNINJ9NJg=; b=f2Aro/BjcVLS4tRemQufdyk1kQwW
        vg31cxgNskC67jC6SRO/bAi90Xao1LQdEBgTC+iDS1+KhnTxzRAnpaQrvNZeSegC
        hxY4XihB8JPTO6h51TBdsSt6X6syv2YLhYOKVeYuYuECTIzC/0AWAmOODoWW3DZm
        swfcaGJveFiZjis=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48F1A18D8AE;
        Fri, 25 Feb 2022 17:48:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC81618D8AB;
        Fri, 25 Feb 2022 17:47:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/9] Makefiles: add "shared.mak", move
 ".DELETE_ON_ERROR" to it
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 14:47:58 -0800
In-Reply-To: <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:04:28
        +0100")
Message-ID: <xmqqwnhi8swx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB4B1736-968C-11EC-9CB0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 6f0b4b775fe..d378ec22545 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,3 +1,6 @@
> +# Import tree-wide shared Makefile behavior and libraries
> +include shared.mak
> +
>  # The default target of this Makefile is...
>  all::

Continuing with the theme of [1/9], this change to Makefile gets my
firm NAK.  The first two lines MUST stay to be the first lines.

Otherwise, a mistaken patch that adds rules to shared.make will
make the first of these rules, not "all", as the default target.

Just move it below to the third line or so and you'd be OK.

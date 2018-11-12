Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE7E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 03:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbeKLMyz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 07:54:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62040 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeKLMyy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 07:54:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADD7F3E0B5;
        Sun, 11 Nov 2018 22:03:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ech/o12Mtb6B6O2l1IsSwF4q2qk=; b=kHpPtr
        S5QiT9Dlyj2pnYW2+2rSoBGX7Iebqdk5W3onydKXSiTNs7L2iTmq4+U5dTrrZa9M
        RkXyy56jagzaWk8lEp3LbNLPf3ADmJZTUa/Ij9weKYsfIrV7AkQOcOobGhCvToZU
        JlR4WZAT+CqB1+Wo1tHQqP8/mmSDCK4AwBX9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vES2IZlC18+qQm1mUuKhajnKmP2xUEcQ
        sxC0Q5FO6mrOlqBektD0MToGtkuKK4Bpw4fegevp1r5FJmDOEsiaPt40TTPmZByy
        l9w3/y3QguFIH/Jpi4oGOt6TkL8ndpn9/j7rh7F6BtkuriHc4n6nIeq+qHyAHLUU
        rRY6ZZ2SSms=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7B373E0B4;
        Sun, 11 Nov 2018 22:03:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 64D343E0B3;
        Sun, 11 Nov 2018 22:03:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, gitgitgadget@gmail.com,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
References: <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
        <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
        <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
        <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
        <20181107204142.GA30078@sigill.intra.peff.net>
        <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
        <20181107220320.GA8970@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet>
        <CACsJy8AdRqKKFFO80p8jdMGaH6+Pj833nUEd7Xe6SWLQB=80UQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1811081639210.39@tvgsbejvaqbjf.bet>
        <20181109101918.GC7410@sigill.intra.peff.net>
        <CACsJy8BzbEnXMRw6kB1rg+WMfu2wwJZWkAtVate98CZRSY_dLA@mail.gmail.com>
Date:   Mon, 12 Nov 2018 12:03:43 +0900
In-Reply-To: <CACsJy8BzbEnXMRw6kB1rg+WMfu2wwJZWkAtVate98CZRSY_dLA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 9 Nov 2018 17:16:41 +0100")
Message-ID: <xmqqr2fr3skw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91842FA4-E627-11E8-B115-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> FWIW I don't have any preference, as long as the variable can still
> have a name (that is not a symbol).

Same here.

> A side question regardless of syntax. What do we do with
> %(unrecognized name)/foo? I see three options
>
>  - expand to empty, so "/foo"
>  - keep it and try the literal path "%(unrecognized name)/foo"

Neither of these is good for future proofing purposes.

>  - somehow tell the caller that the path is invalid and treat it like
> non-existing path, even if there is some real thing at "%(unrecognized
> name)/foo"

Another thing to worry about is how to spell the real thing that has
such a funny name, perhaps by escaping like "%%(unrecognized
name)/foo".

And from that point of view, "~runtime-prefix~/foo" (i.e. what J6t
started) may make the most sense, as I do not think we need to
support a username that ends with a tilde by introducing a quoting
convention.

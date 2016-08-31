Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671051F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759532AbcHaUSB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:18:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52126 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759482AbcHaUSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:18:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D46C3BF92;
        Wed, 31 Aug 2016 16:17:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V50byFBPzpedBHMr7DXxp16Ls4M=; b=kZMtXz
        Wr7467BBt+v+lEtHz6/F7LQ0i1CJdjwk7hBqSkQDVkfw5NiJwZ6VlRRKxkz86zsO
        am0ULh/bujEnuSi58ujAsA0sBPip8dliIf3DqmbyKmLspyF74hW5eEp6VX9CctM5
        ewGePWdpGxby3kZBihdUxK+35cBekgAVys+nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qE7DVpi3buYK68yjnC9Nk2gd6CAIKY/u
        KkLW8CzsCjbePQHlMnwPQJBaQYLPtor8OoKuPfRV6z6uZumavDlfRvnn4oU6IKbn
        LOyWzGlEiF33nysuAaWJiMCTz9G/DypkY4MbahGZQyWyQCeg+/qs8ZJi/B8jT6L+
        D0H6XsDDhtE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 243D03BF91;
        Wed, 31 Aug 2016 16:17:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9184B3BF90;
        Wed, 31 Aug 2016 16:17:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] cat-file --textconv/--filters: allow specifying the path separately
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <d9e9d8b111efd161986aee32bb3ae0baec0dcf34.1472041389.git.johannes.schindelin@gmx.de>
        <xmqqinuqqcor.fsf@gitster.mtv.corp.google.com>
        <xmqqwpj6owgg.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608312133150.129229@virtualbox>
Date:   Wed, 31 Aug 2016 13:17:56 -0700
In-Reply-To: <alpine.DEB.2.20.1608312133150.129229@virtualbox> (Johannes
        Schindelin's message of "Wed, 31 Aug 2016 21:49:57 +0200 (CEST)")
Message-ID: <xmqqinugzo97.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0262E924-6FB8-11E6-9B7E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, I do not want to hold this patch series up just by being
> stubborn.

Peff and I disussed this further in the thread in which the message
<xmqqa8g2qcf3.fsf@gitster.mtv.corp.google.com> appears, and agreed
that it does not matter that much either way.

The comment to [v2 2/4] would be more important than this one, I
would think.  What should happen when a blob that is not ISREG is
given to filter_object()?  Giving a symlink contents as-is without
filtering would be OK.  Erroring out saying "regular file blob
expected" just like the function reacts to non-blob is also OK.
Just being silent and not doing anything is probably not.

Thanks.


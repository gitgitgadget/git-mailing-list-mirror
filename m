Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8F5202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 03:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdJBDtO (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 23:49:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52688 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbdJBDtN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 23:49:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 128659361D;
        Sun,  1 Oct 2017 23:49:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HGF2nEeJO6/P
        /cOUbKBKOaEQSFo=; b=fmM8phZhY5oOAt719A/lXUxy04kBV/OO03N+G29pus6y
        dvEyTUryq8zs/gwGw9UtC06P16AGuai1FKsOQiaHhj+Lq0vUs8ANK+VJIyAj7B71
        uJIy7BsSPajRKAqv2f1Py+ibnZ21p9C5VSKV0QPQbmjvPA2x3BBNAwHSnoEMqQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uF176j
        0U8k8P+c9jd9p0lNcLChzR8vImsP/oPp2rhr/AHSc2WKd+IgKJScDEQDlZ2kVHdN
        BLvDZy4U/5wDOC+vwUfiXrzYo/Sb3mPcfuJzmLvxcbjbqenz6nDe5cduvyxEljgv
        Kvu5MKWmoVQP1NsQX77IAsfanLuilzPTZj54g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A5CF9361C;
        Sun,  1 Oct 2017 23:49:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80AED9361B;
        Sun,  1 Oct 2017 23:49:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/11] read-cache: require flags for `write_locked_index()`
References: <cover.1506862824.git.martin.agren@gmail.com>
        <d912e33a1395ff25c1496715d0a537858daa885a.1506862824.git.martin.agren@gmail.com>
Date:   Mon, 02 Oct 2017 12:49:11 +0900
In-Reply-To: <d912e33a1395ff25c1496715d0a537858daa885a.1506862824.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 1 Oct 2017 16:56:10
 +0200")
Message-ID: <xmqqd166qkeg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A74A3376-A724-11E7-8E14-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> ... Instead, require that one of the
> flags is set. Adjust documentation and the assert we already have for
> checking that we don't have too many flags. Add a macro `HAS_SINGLE_BIT=
`
> (inspired by `HAS_MULTI_BITS`) to simplify this check and similar check=
s
> in the future.

I do not have a strong opinion against this approach, but if
something can take only one of two values, wouldn't it make more
sense to express it as a single boolean, I wonder.  Then there is no
need to invent a cute HAS_SINGLE_BIT() macro, either.

"commit and leave it open" cannot be expressed with such a scheme,
but with the HAS_SINGLE_BIT() scheme it can't anyway, so...

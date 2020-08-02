Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F7AC433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 20:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD78320722
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 20:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sZ7d21gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHBUDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 16:03:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51175 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHBUDO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 16:03:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61E0E6FDC7;
        Sun,  2 Aug 2020 16:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9/64BHUGbvRJ
        kQTB51Fj97DvPU0=; b=sZ7d21gf/XHlRMo+kFmsR0AS1jkkYJamMWK4+jPtVyvT
        ugio6fnTxWpIlPcTL9OHcZRhfFJzdhLE/D7Jcou3HCwHyI+CmKlOysp5kGlIePN9
        MEL1pRNnkPwpn/b/PhSE83iTY3zL+fG0I659QOua/gNWzucIr93TcY0ieFtxuMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QVr+G+
        8CwKmCyhYx/YPSWQxa3QdPszY4+l8q5U+RKWq4xApouJ7L+RiKGa/Qx6gW5+AHLM
        AldQf+qxR/U4yOoNCgIlNjJAVCywLz1S38zzHo1IRqUEDo78JvMqxCT+q/Yb4OWA
        mJ+/KIQSnB6ZXNowGfQ1cPQvvcRnCgQTVbI4w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B5AF6FDC6;
        Sun,  2 Aug 2020 16:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4E1C6FDC5;
        Sun,  2 Aug 2020 16:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [RESEND PATCH] bisect: use oid_to_hex_r() instead of memcpy()+oid_to_hex()
References: <632682d5-e343-c069-f4b4-0451072d54d2@web.de>
Date:   Sun, 02 Aug 2020 13:03:10 -0700
In-Reply-To: <632682d5-e343-c069-f4b4-0451072d54d2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 2 Aug 2020 16:36:50 +0200")
Message-ID: <xmqqzh7crf29.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3166B776-D4FB-11EA-B17F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Write the hexadecimal object ID directly into the destination buffer
> using oid_to_hex_r() instead of writing it into a static buffer first
> using oid_to_hex() and then copying it from there using memcpy().
> This is shorter, simpler and a bit more efficient.
>
> Reviewed-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---

Thanks.

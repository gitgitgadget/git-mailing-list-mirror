Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5DC1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbcLUUrO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 15:47:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55056 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750864AbcLUUrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 15:47:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CF92591AA;
        Wed, 21 Dec 2016 15:47:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FocSAWjtvGt77ShrBGgn3ysZttY=; b=q7bfZq
        Fapk0iqlfwsJ5l4AFY7yuJ9fsnZSIiJ9pbGaUWwnIyCQhxxJj5azBuzHYBZXi/bF
        SM2i4lXx00kOl1D6TVOucOTiURuzV36AwCie7qUBpNgjejTpog0chcyD833g7u06
        WHc4v3Bor4oHKPvcxsaZBtW9fHYevuAcE+YtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WuzX1aBvgzztneq4uNNDxci8h73YQcJC
        MeAkDTmR4jMwnfjCfeT3RMLnQes3iH3KHpY17XGXoisLvTQzP9rFwkKT/jSBiqwe
        Q/EDDN6zcQgpR/Tih6fbFTmHziTx4Bmhi91r4uWe9lKShe3CMrKRmzikhMWQ3aQb
        MsBohklK+Qw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74418591A9;
        Wed, 21 Dec 2016 15:47:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9B7A591A8;
        Wed, 21 Dec 2016 15:47:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] string-list: make compare function compatible with qsort(3)
References: <c7bac0b7-c555-162f-7880-0355831cee48@web.de>
        <xmqqy3z9i24x.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Dec 2016 12:47:10 -0800
In-Reply-To: <xmqqy3z9i24x.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 21 Dec 2016 10:10:54 -0800")
Message-ID: <xmqqd1glhuwh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5BD4228-C7BE-11E6-A2FD-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do agree that non-reentrancy is an issue that is worth solving,
> though.

I sounded overly negative, but I do not think of any way other than
this patch to solve the reentrancy issue without using qsort_s().
Between the two, my preference is still the latter, but I could be
persuaded, I would guess.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCE1207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 03:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164452AbdDXD3Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 23:29:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54345 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164442AbdDXD3O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 23:29:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3DBA813DB;
        Sun, 23 Apr 2017 23:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V70levIB2y/MEFHAyACaskfz+Mw=; b=rlJWA3
        X5ydy5iF5H20gGZYDs3BZAyUsa/iSgQ0dk/j5Jhzeu2fKB3k4qySFv1zVDoNERtq
        pXnUpAaplpOdDs+VShQipq4H5XuI+2AJ2Lt7QdCjIj64aw/8XpL2iD9CrhrpMzRQ
        gW40GGxrU2o/0AjAOq1cc9D6/8esIwQP8yEYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cwwBAbxFqyoMGsGSoW6UAa1IKYa4U3C5
        qsSR5Ngrhypo6eItu/rmpRciKlwKKEbpBlw7lmVB1I3eK2wCuoaPWclox9owS0Zq
        Sga7u7XlZCY6h0h9A8xjLY1IYFLnwdiAxdQf7RNzbIMo2+Fvmj7AnvfvX+fNnj8q
        PqF+TZj8J5g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBC21813DA;
        Sun, 23 Apr 2017 23:29:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40224813D9;
        Sun, 23 Apr 2017 23:29:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 0/9] Introduce timestamp_t for timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
Date:   Sun, 23 Apr 2017 20:29:11 -0700
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 21 Apr 2017 12:45:00 +0200 (CEST)")
Message-ID: <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F5EA838-289E-11E7-A3DA-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes since v3:
>
> - fixed the fix in archive-zip.c that tried to report a too large
>   timestamp (and would have reported the uninitialized time_t instead)
>
> - adjusted the so-far forgotten each_reflog() function (that was
>   introduced after v1, in 80f2a6097c4 (t/helper: add test-ref-store to
>   test ref-store functions, 2017-03-26)) to use timestamp_t and PRItime,
>   too
>
> - removed the date_overflows() check from time_to_tm(), as it calls
>   gm_time_t() which already performs that check
>
> - the date_overflows() check in show_ident_date() was removed, as we do
>   not know at that point yet whether we use the system functions to
>   render the date or not (and there would not be a problem in the latter
>   case)

Assuming that the list consensus is to go with a separate
timestamp_t (for that added Cc for those whose comments I saw in an
earlier round), the patches looked mostly good (I didn't read with
fine toothed comb the largest one 6/8 to see if there were
inadvertent or missed conversions from ulong to timestamp_t,
though), modulo a few minor "huh?" comments I sent separately.

Will queue; thanks.

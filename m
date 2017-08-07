Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7AE2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 22:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbdHGWWF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 18:22:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65394 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751743AbdHGWWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 18:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0DDAA6682;
        Mon,  7 Aug 2017 18:21:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g5sSKOhB7GldALk88qaFlrB3zjw=; b=eqewOu
        qNMzPY0aNaMzcVfSBX+P1eY6r9/9aPqNyBNyBqv1M5hTXrRnm9gYidS7ctck3dAw
        jEjQov6MbxJoFu8KiMdp/McVXh4iK6TYPBNT3kRVQ119ag1iyLJrNRp6qsDV78oE
        JhIZw1NBt28V1Mmh9va+5AXF6/CLf/vylHcIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oOCPl7OyR0iEKF/LNieaUEOuU7PDadZF
        F8WmOjgsv8ZXbKzBb1Hk2FtedER/+bUu7t/zU+sNYzm0dwISy52GMlMoEyCjA7Oe
        2a/B1peiqeYOWYsqOnmRM83P5oCiXYxFsyP6/Z8sYgiWacVFNbBtq5B8XTh7HOzG
        bfR22OZ8RYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7833A6681;
        Mon,  7 Aug 2017 18:21:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 430C0A667F;
        Mon,  7 Aug 2017 18:21:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] imap-send: add wrapper to get server credentials if needed
References: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
        <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com>
        <fdd74c52-7d9a-b12e-2e1f-524479201701@morey-chaisemartin.com>
        <CAN0heSqVmrFwP7LdjDJmH0JivoCc+DhGtUiTSBs=8nTppzG79A@mail.gmail.com>
        <20170807194257.jrdmpvoseauz37uc@sigill.intra.peff.net>
        <a4761418-0464-baa1-b415-836f33503eb8@morey-chaisemartin.com>
        <20170807200724.6pdfkmrrmmkdmmb6@sigill.intra.peff.net>
Date:   Mon, 07 Aug 2017 15:21:55 -0700
In-Reply-To: <20170807200724.6pdfkmrrmmkdmmb6@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 7 Aug 2017 16:07:24 -0400")
Message-ID: <xmqqd187nhmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D273B270-7BBE-11E7-A487-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 07, 2017 at 09:55:56PM +0200, Nicolas Morey-Chaisemartin wrote:
>
>> > On the other hand, if we're hoping to get rid of this code in favor of
>> > the curl-based approach, then it's not worth spending time on
>> > cosmetic refactoring, as long as it still behaves correctly in the
>> > interim.
>> 
>> Looking at the code, it seems the tunnel mode always uses the legacy imap approach.
>> This would have to be ported to curl and stabilized before dropping the legacy code.
>
> Urgh. That's an important mode, I'd think, and one that I have a feeling
> curl may not be interested in supporting, just because of it's
> complexity. And even if they did, it would take a while for that curl
> version to become available.
>
> So maybe the idea of deprecating the non-curl implementation is not
> something that can happen anytime soon. :(
>
>> In the meantime, it might be worth doing a bit of cleanup.
>
> In which case, yeah, it is definitely worth cleaning up the existing
> code. But I also agree with you that it's worth making sure the curl
> version behaves as similarly as possible.

Thanks for guiding this topic forward.  I agree with all points you
raised in your reviews.

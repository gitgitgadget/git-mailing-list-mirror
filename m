Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C40C1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbfJYClA (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:41:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55572 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390411AbfJYClA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:41:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3EF922B9D;
        Thu, 24 Oct 2019 22:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aFnQ6KLPN+8qXc4B2/OIrJtMPIY=; b=iNwYx+
        vwgml5ySOiFAKHIrUiL6D0Wi2x7cLiTekkUYffpcEjYqQYYS+/dBdvOFjGPJPDDc
        nC2TcdvfckzvnTorOSySUodF7+nLxhKR/mTFDugjB91U2pBYPsVHUhJLoNNpFmV2
        eLQhxziFkhsspM7VfwFDaJiNSkAVhxNyxmDvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DfURc8SoStEZgJf2w3AcNTOHV2e3rmVp
        mbd0X8TdXGNdDqvtB+wD0mAHiOUYw94fa2qLTDyzl8+L5Pib3PW/xlLEUCAM+c50
        CRycGvJdOpnq91fJHvq4KAqYlBA5MxeSScsLVCPSKKLZaZxaWwu1wbqvz1VrP6+0
        ft+qLnYjC1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B6C22B9B;
        Thu, 24 Oct 2019 22:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52B8822B9A;
        Thu, 24 Oct 2019 22:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
References: <20191024092745.97035-1-mirucam@gmail.com>
        <20191024114148.GK4348@szeder.dev>
        <20191024181344.GD12892@sigill.intra.peff.net>
        <20191024204500.GG9323@google.com>
        <20191024205100.GB30715@sigill.intra.peff.net>
Date:   Fri, 25 Oct 2019 11:40:57 +0900
In-Reply-To: <20191024205100.GB30715@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Oct 2019 16:51:00 -0400")
Message-ID: <xmqqr231eedi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E004F7C0-F6D0-11E9-851A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I think one path forward could be:
>
>   - add path_exists(); this will work the same as file_exists(), but is
>     a better name. Keep file_exists() for now, but put a comment that
>     new calls should use path_exists().
>
>   - use path_exists() in builtin/clone.c, ditching its custom
>     dir_exists()

Both are of immediate value ;-)

>   - (optional) start converting file_exists() calls to path_exists(),
>     after confirming what each call wants (just files, or any path)

That is of lessor urgency but the result has a good documentation
value.


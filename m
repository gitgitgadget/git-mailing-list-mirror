Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A65202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 01:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbdJQBNh (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 21:13:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54441 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753983AbdJQBNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 21:13:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09B94B6350;
        Mon, 16 Oct 2017 21:13:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J2obHYWEBEZJUYIiDV/P1lmo1Yc=; b=gTtcJb
        Pb0ThRR//P4I6OXpzO4/ct91voq7ixfm4Eb51ZglZ8oJmZe64AfH2Vb0iWYWbJH8
        EPnUPSYfU4hTIunfHur4s7C6ROF9PFfWJXz+6soOorus2TYMGcDah91EUkmr9KnR
        /BO/mrFLxoZWCyBKGOtDMPQ/DbE2VWGWzl5xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NhxuTt4QHBrjW0FoBvJFy4/vsExB2tM7
        wuresc3loqpZwKWPeJGcR2eI7BtDor6uTXmvXFX78w9KAJX0X/f6EEKeGJ6KwfP8
        /2LofQS94Mmgm4qa7XiO5T6hlaioABluuTLGZMrna+ZYmCnv+YvP0gaJtP5ZaNdx
        FsMJmL5VDM4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00077B634D;
        Mon, 16 Oct 2017 21:13:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A51BB634B;
        Mon, 16 Oct 2017 21:13:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Joris Valette <joris.valette@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Consider escaping special characters like 'less' does
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
        <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
        <87zi8sxvkg.fsf@linux-m68k.org>
        <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
        <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
        <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
        <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
Date:   Tue, 17 Oct 2017 10:13:34 +0900
In-Reply-To: <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Oct 2017 18:13:24 -0400")
Message-ID: <xmqqk1zur2yp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 662F8D54-B2D8-11E7-B766-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Alternatively, I suppose we could just always escape in
> add--interactive. I'm trying to think of a case where somebody would
> really want their diffFilter to see the raw bytes (or vice versa, to
> show raw bytes produced by their filter), but I'm having trouble coming
> up with one.

Your patch below only implements the "tame the raw bytes that come
out of their filter", which is quite agreeable.

> I.e., something like this would probably help your case without hurting
> anybody:
> ...
>
> I can't help but feel this is the tip of a larger iceberg, though. E.g.,
> what about characters outside of the terminal's correct encoding? Or
> broken UTF-8 characters?

Hmph.  If you use it as a "built-in" that is a fallback for
diffFilter, i.e. use it only when the end user does not have one,
then users can override whatever wrong thing the built-in logic does
so... ;-)


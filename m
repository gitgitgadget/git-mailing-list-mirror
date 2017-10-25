Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5921FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 01:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdJYBWM (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 21:22:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54746 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751870AbdJYBWM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 21:22:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61D0DA9E7E;
        Tue, 24 Oct 2017 21:22:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FNmS0mtc/PRLLV6bsZLQGkR2gsk=; b=dX0eYS
        V2/C2ouBR/dBymFYibTlbFC4/ssM6R7qYM2iY+WXrCcxm2IFxVCTfaV42mRk9OvM
        5oxlasWUsFvq1y0zDwC7ClKnW3jEs0Of/5vIaeBqamKxXpgD5OR5RcKmnkZS7rKe
        IRgmQUk3Qyl2jYkZc461T3eLB7Yb5iWJTYWIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GIYnDtZlhQCXPrOZOdEGzYFrG8z7Gaac
        ySxBlMDVFUnHi51mtkP9NooX73sWfpfnCa9nDbOyObhPFaIypIe0bO3LjArlhPMv
        iec4qtAOD9px9eDZr57/p+7LFOcYzFeAKR4BpdMrzh4xtlp9eG+XFreTsPid2uwN
        r1yM7DhUCt0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 594C9A9E7A;
        Tue, 24 Oct 2017 21:22:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB0C6A9E79;
        Tue, 24 Oct 2017 21:22:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [RFC] protocol version 2
References: <20171020171839.4188-1-bmwill@google.com>
        <xmqqbmkxkpn9.fsf@gitster.mtv.corp.google.com>
        <20171024183557.GB79163@google.com>
Date:   Wed, 25 Oct 2017 10:22:09 +0900
In-Reply-To: <20171024183557.GB79163@google.com> (Brandon Williams's message
        of "Tue, 24 Oct 2017 11:35:57 -0700")
Message-ID: <xmqqwp3kja2m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECA7E02A-B922-11E7-912B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> I actually have a reasonable guess why you want to have a separate
>> delimiter (which has nothing to do with "optional delim can be
>> omitted"), but I want to see it explained in this document clearly
>> by its designer(s).
>
> Jonathan Tan suggested that we tighten flush semantics in a newer
> protocol so that proxies are easier to work with.  Currently proxies
> need to understand the protocol instead of simply waiting for a flush.
>
> Also I've been told the smart http code is more complex because of the
> current semantics of flush packets.

I think the above two are the same thing ;-) but yes, "flush" in the
original protocol were used for both "I am truly finished talking;
now it is your turn" and "I am done with one section of what I need
to say, and a different section now begins; it is still my turn to
speak".  The need to handle the latter makes smart-http quite ugly.

Thanks.

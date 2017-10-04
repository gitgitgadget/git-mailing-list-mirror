Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABE220281
	for <e@80x24.org>; Wed,  4 Oct 2017 08:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdJDIsJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 04:48:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50176 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751736AbdJDIsH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 04:48:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDC8B985CA;
        Wed,  4 Oct 2017 04:48:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sxXmOFCrrQSYgfZSu8vptDFrC3w=; b=v6fBgS
        M3dmV6fd4+ZrE5J9PVvtnjUZsA/LiYkVQg/QEiq+a3NvMSZq0oWZQ63hKgTGgZL6
        KUCRXFeh/950JjM2ZU2bgKlheXY0vZHeuszBQxFZTg6ogIZX3szhriSttw/LhDKM
        iSsh1Y/R6vwF3FxL2EGJC/Y9sslrOEowMrOW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FDvJLomh3Hjdqmhfqmx568Q9fBog9Bln
        V9YpE/RogiH4vvW0IReWMe8naq6sP7DFA6M1d6dZs9WzcXCw+gbR9ha2UwfhxkxF
        q1y7IhNXI3drvIKSuaYUaLrD8W8RAGl02LKwEuxiuS3pG2nECsr3rMCE0pZIFTDE
        KlkZbCO6KzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1026985C8;
        Wed,  4 Oct 2017 04:48:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13539985C4;
        Wed,  4 Oct 2017 04:48:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] oidmap: map with OID as key
References: <20170927221910.164552-1-jonathantanmy@google.com>
        <20170929225422.81467-1-jonathantanmy@google.com>
        <20171002234848.GG5189@google.com>
        <20171003063119.iht5kl7zsiuxpaqz@sigill.intra.peff.net>
        <CAGf8dgKtwdT912CaARdjYnSAd2m7mmdOzM=OGCUupw80snrd_w@mail.gmail.com>
        <20171004074547.56ks2efcr7cbldbq@sigill.intra.peff.net>
Date:   Wed, 04 Oct 2017 17:48:04 +0900
In-Reply-To: <20171004074547.56ks2efcr7cbldbq@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 4 Oct 2017 03:45:48 -0400")
Message-ID: <xmqqmv57b8or.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD591C14-A8E0-11E7-996C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 03, 2017 at 05:29:01PM -0700, Jonathan Tan wrote:
>
>> At this point I decided that I prefer the thin wrapper, but the "light
>> touch" (struct oidmap_entry, oidcmpfn(), oidmap_get() only) still
>> better than the status quo.
>
> OK. I can certainly live with that. And worst case, I suppose, is that a
> caller wants some underlying hashmap function and we just have to extend
> the oidmap API to include it. It's not like we're adding new hashmap
> functions willy-nilly.

OK, I think I can live with that, too.  I'll tentatively mark the
topic to be merged to 'next' but give it for a few days so that
others can stop me.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50ECD215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbcJLVow (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52958 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750922AbcJLVov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DF8A46A60;
        Wed, 12 Oct 2016 17:38:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Ia//eBZNz4059Bg9rpuv4FxiaE=; b=Rfzu5u
        KWpylKlpmdBSjJfsWO/4+fuaEjijq6CuEaYvU7YMvWxPBwk2Z0iD9OqdA6o0El0Z
        65mg0xyI3dFgU9iwJPYnQ29m+VGruoqodcOMy33aHfcZTe6oLMZNxI5UJ4719xkh
        Tpu/NDTAXSKxp0LKPOdNqGXpR42r8Yb9UNpjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WgdK10r9Xx9u89oafIVewiuDS5zLnVnD
        bovevqsvddzJdshwo2N9sOFPNLHXO92JBk2Ggs0ABTJAcTe7o0yhSjNdJewIkPZs
        pVULmjZZNTMdez7yEigO70EeXjCy358PPCTfXaOLtLISRw5Tuyeci4nBY5jDav6R
        6sqHQZKRkjI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6495F46A5F;
        Wed, 12 Oct 2016 17:38:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D323746A5D;
        Wed, 12 Oct 2016 17:38:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        bmwill@google.com
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
        <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org>
Date:   Wed, 12 Oct 2016 14:38:10 -0700
In-Reply-To: <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org> (Johannes Sixt's
        message of "Wed, 12 Oct 2016 22:07:03 +0200")
Message-ID: <xmqq8ttt2qpp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D43B8DA-90C4-11E6-8191-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Sigh. DCLP, the Double Checked Locking Pattern. ...
> I suggest you go without it, then measure, and only *then* optimize if
> it is a bottleneck. 

That comes from me in earlier discussion before the patch, namely in
<xmqqeg3m8y6y.fsf@gitster.mtv.corp.google.com>, where I wondered if
a cheap check outside the lock may be a possible optimization
opportunity, as this is a classic singleton that will not be
deinitialized, and once the codepath gets exercised, we would be
taking the "nothing to do" route 100% of the time.




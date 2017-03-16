Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2B0202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 01:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdCPBYW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 21:24:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53225 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750788AbdCPBYV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 21:24:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B58267C52D;
        Wed, 15 Mar 2017 21:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8i9Tjbk9UkgBa2lAzh26oYepZMo=; b=UwtdMf
        z2C+LQVCvL9mum8bR+SGqIiLz0imwdMOy75y9j5dBsAQa3QSjs6NARYRHFiHIiee
        iK1eLi/7kmNCNP7hufrh77Bc9ZWoL+PeEblsKaEsJ0kK+5sVkQZzh6jkJYAm14VS
        ktSCQRR8RBbc8TSWA7FOCCb9cdhQM9nSwgytc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DvcVy+I5DBAxvLROefadhaxnlm2tW6ck
        Bz6FiqaUBi2QLeEww8Oxiifs+qM3cBa7yBVQ+dNk9xBUIekoXlSoSXBEEl5jrsAU
        qB0GlpaNujkUCOFQ5p2QApPOW5DbTOYE63AIBr4n4wk6TVFqJbyjA0h0Vkmg9l3B
        B0AYzRqTsYA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF0EE7C52C;
        Wed, 15 Mar 2017 21:24:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2352D7C52B;
        Wed, 15 Mar 2017 21:24:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb_pack_keep(): stop generating keepfile name
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
        <20170315213024.jjhikkgwuhev27ec@sigill.intra.peff.net>
Date:   Wed, 15 Mar 2017 18:24:18 -0700
In-Reply-To: <20170315213024.jjhikkgwuhev27ec@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Mar 2017 17:30:24 -0400")
Message-ID: <xmqqzigmc8u5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4702F668-09E7-11E7-BC0A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The odb_pack_keep() function generates the name of a .keep
> file and opens it. This has two problems:
>
>   1. It requires a fixed-size buffer to create the filename
>      and doesn't notice when the result is truncated.
>
>   2. Of the two callers, one sometimes wants to open a
>      filename it already has, which makes things awkward (it
>      has to do so manually, and skips the leading-directory
>      creation).
>
> Instead, let's have odb_pack_keep() just open the file.
> Callers can use odb_pack_name() separately to generate the
> name. This simplifies the callers, and lets us drop any
> buffer-size limitations.

That's sensible (and all the others made the resulting code much
more pleasant to the eyes).


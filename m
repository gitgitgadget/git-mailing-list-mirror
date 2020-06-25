Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9945C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD30204EC
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 21:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tjlOamL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405957AbgFYVWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:22:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59269 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405932AbgFYVWn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 17:22:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E0D8E51F2;
        Thu, 25 Jun 2020 17:22:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dayS21EiGJxX
        uCSPPEDITRpM7bI=; b=tjlOamL+/Bl0VI3JFWxt01PFcXwQQhVaC7uZDZUZHwkm
        ZmZogn/7rhBV3Xwul+vcXxf/FSlMWuPzpnJL4gXpWLiF7GUWNwjbKu32PQcGc8CG
        O3kP2bWA89jjDjPJCTjuXgahOtutgZw0KawKSVuqzJLdr31T7pmi+WNWnMd4PQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rtU4GJ
        X2nUh+djL+AoQqCJzN3s5ZELAVKAqdGD5i6qUm+LQNAttvf4BHb+VOYIBXPD068m
        xhqTZ+dlEKZirg+tYeP2/8AIBDRJm3k2OYgTT9bdjsYLlbZgKgswXWHo4Wlj01W2
        jasi7ccyxWM9NU2XuThPO9czXJFr6qfT8ao2I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9678AE51F1;
        Thu, 25 Jun 2020 17:22:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCA06E51F0;
        Thu, 25 Jun 2020 17:22:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/11] fast-export: allow seeding the anonymized mapping
References: <20200619132304.GA2540657@coredump.intra.peff.net>
        <20200622214745.GA3302779@coredump.intra.peff.net>
        <20200623152436.GA50925@coredump.intra.peff.net>
        <20200625194802.GA4028913@coredump.intra.peff.net>
Date:   Thu, 25 Jun 2020 14:22:37 -0700
In-Reply-To: <20200625194802.GA4028913@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 25 Jun 2020 15:48:02 -0400")
Message-ID: <xmqqa70q4z8i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF12D744-B729-11EA-82DF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   [09/11]: fast-export: allow seeding the anonymized mapping
>
>     - the option is now called "--anonymize-map", and the word "seed"
>       isn't used in any user-facing documentation
>
>     - incorporated Eric's documentation suggestions
>
>     - --anonymize-map without --anonymize now triggers an error

The changes compared to the v1 here looked sensible.

>   [10/11]: fast-export: anonymize "master" refname
>
>     - minor adjustments to handle change of option name
>
>   [11/11]: fast-export: use local array to store anonymized oid
>
>     - new in this iteration; this address the gcc-4 warning that G=C3=A1=
bor
>       mentioned. I prepared it on top since I think we'd eventually wan=
t
>       to revert it once we decide that compiler is too old (and I'd be
>       perfectly fine to declare that it's so now, and just never apply
>       it at all).

Sounds like a sensible way.

Let's merge it to 'next' soonish.

Thanks, all.

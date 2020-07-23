Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD53C433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F5420781
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gKPxKSut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgGWBlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:41:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63617 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBlg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 21:41:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A89276543F;
        Wed, 22 Jul 2020 21:41:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fi10bMG35yPkVBZZDgyTyavnXUY=; b=gKPxKS
        ut7Y3pya+sV7E+7vd1/2aloP1F5gbGX6R99FADMeffv8TNldVvwkxdMWenLk9FKZ
        Gl31nptJxUEraPtSbWomyKix0iA1UDZytIc4xlh1Fp9HC3Tnuo16suGspxX8TAA+
        exbjE7blr4UmQQYcKMwaYhHmcTftffrP4Bta0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jm2nelGATz84lgKMittkHmKDoLXFDN17
        38MQEbZ9lvzA7sePSaRgKE3dW6OTStz6306mIxxT1NO2A3aOECw9oiL0EDv6rvq2
        G0vhUGCyWtHmXLBFnEhnHcn3jiSWez4wTbb3ZiBl3SzD/W1H7O8iSegWXwA9JCi/
        ajYVnVlsM70=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A00426543E;
        Wed, 22 Jul 2020 21:41:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26EF66543C;
        Wed, 22 Jul 2020 21:41:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
References: <cover.1593720075.git.me@ttaylorr.com>
        <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
        <20200715100043.GG11341@szeder.dev>
        <20200715105521.GB3262157@coredump.intra.peff.net>
        <20200720200739.GB91942@syl.lan> <20200722091758.GJ11341@szeder.dev>
        <20200722201531.GA59352@syl.lan>
Date:   Wed, 22 Jul 2020 18:41:33 -0700
In-Reply-To: <20200722201531.GA59352@syl.lan> (Taylor Blau's message of "Wed,
        22 Jul 2020 16:15:31 -0400")
Message-ID: <xmqqft9j3t4i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3F6725A-CC85-11EA-900C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> If this die() were to show the same fancy error message as in the ERR
>> packet, then it would always make it to 'git clone's stderr in the
>> tests, so the tests could reliably check that 'git upload-pack' died
>> for the expected reason.
>
> Beautiful idea. I changed this in my fork, and I'll send it to this
> thread after 2.28 is out, since I don't want to create a distraction in
> the meantime.

Thanks.  

As long as everybody understands that "distraction" will immediately
gets backburnered when a regression relevant to the upcoming release
is found, however, I think performing work as usual is a good thing.
After all, we often find glitches in the current code by trying to
build on it, in addition to using it.


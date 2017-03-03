Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C65B20133
	for <e@80x24.org>; Fri,  3 Mar 2017 23:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbdCCX2w (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 18:28:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752345AbdCCX2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 18:28:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B98D66815C;
        Fri,  3 Mar 2017 18:22:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tGa/TM8kGMG9vXorl5y6tpBVF/Y=; b=Ym8+L/
        puTKRNPfb9JaAV5fyY7SELkpx5vdIe7xbHdtz3UKPfI80EYoaYEogY70crMbs4lO
        Oz5zRwqr3GHPJ5EPX/s6y1ZoX0YYxdmrUm/0rEkwskSteF4hsMHHL2Dx7I17vYg9
        9JKcZF+LBZ7a32oBx/Ztp8aFDHosuVVGiBr0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sg+Tj6kI/2DYuyzoCdGby2lyXfPi2QrO
        /8U6xyFuZf621Ok1Cf/YS3BeBQLlYmWE2vhg4D8fNlHPvMZtTlYE2ibwnwtXPUKj
        nG39lt0Tq/H+e9WmBbH0h5xuq6ia5ref/vStc01nuvaF9ON0XT21eToHBzAlmqIa
        UTNkbyK9EFc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1B0B6815B;
        Fri,  3 Mar 2017 18:22:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 114CD68159;
        Fri,  3 Mar 2017 18:22:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sschuberth@gmail.com,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
        <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
        <xmqqlgsm9q2i.fsf@gitster.mtv.corp.google.com>
        <20170303222215.vwulypicszoh2hds@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 15:22:19 -0800
In-Reply-To: <20170303222215.vwulypicszoh2hds@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 17:22:15 -0500")
Message-ID: <xmqqlgsm6j4k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 402EE640-0068-11E7-9E77-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Heh. I had no idea we had FREAD_READS_DIRECTORIES. I think Duy and I
> reinvented it in another thread. ;)

You two were not alone.  I was planning to reinvent it before I went
to bed last night and then found it already was there this morning ;-)

> I agree that may be worth setting on Linux (though note that we _do_
> ignore other stdio read errors in the rest of the code path, which may
> be something we want to address).

Yes, we need an error check on fopen() in git_config_from_file()
regardless.


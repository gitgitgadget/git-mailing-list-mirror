Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D6CC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A2F6198D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhC1BgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:36:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54012 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1Bfv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 21:35:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 128A7B8188;
        Sat, 27 Mar 2021 21:35:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AQ+vp9dw9ZEe
        NXqb9zNt5OWsLjE=; b=dV3QFKFUBaWj/+hGYMZ2gZiXwXPXd/dgrRfCDjanUlkb
        g1fKnpsmpsvUR7RWMeykut1iYVYuEjWDU91crXcPXyr80OHY+7ixzTojyckLHR8q
        eSDcisWilmRf00ocXHIw0DIUMpbj8gNyipZ2m4XhnUJjOTqaLkE0p9IcEUY+B2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mn2ghW
        RSYP63r6lTUSUvhLpM5PiCNQSOytng1nqg6mEkEWuWD2CFsFahRoKeKexswp7rfr
        TShh/HgwsZGcbVU1ppgmLFE4r/t2MHMtKzqRQAxymBjGnJ1YAn8Ln1qlptkF++bu
        DI9u4ElTBcldtWeYXGArleup8+SdRzJLYHEzA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECD76B8186;
        Sat, 27 Mar 2021 21:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60724B8185;
        Sat, 27 Mar 2021 21:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc lint: fix bugs in, simplify and improve lint
 script
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
        <YF2+4I4rH9CQ1A2F@coredump.intra.peff.net>
Date:   Sat, 27 Mar 2021 18:35:49 -0700
In-Reply-To: <YF2+4I4rH9CQ1A2F@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 26 Mar 2021 07:00:48 -0400")
Message-ID: <xmqqk0psoya2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED81D6A0-8F65-11EB-8188-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 26, 2021 at 11:36:49AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>>  lint-docs::
>> -	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
>> +	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
>> +		--section=3D1 $(MAN1_TXT) \
>> +		--section=3D5 $(MAN5_TXT) \
>> +		--section=3D7 $(MAN7_TXT)	\
>> +		--to-lint $(ALL_TXT)
>
> This is probably bikeshedding, but I would have expected the invocation
> to be:
>
>   link-gitlink.perl \
>     $(HOWTO_TXT) $(INCLUDE_TARGETS_TXT) \
>     --section=3D1 $(MAN1_TXT) \
>     --section=3D5 $(MAN5_TXT) \
>     --section=3D7 $(MAN7_TXT)
>
> I.e., list each filename only once, with the previous --section giving
> the expected section (and if before any --section, then expect no
> section).

Makes more sense than the presented patch.  Optionally "--section=3D"
could be used to cancel the section that was previously given.

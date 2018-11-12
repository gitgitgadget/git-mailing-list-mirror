Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3784E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 10:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeKLUT1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 15:19:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62341 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLUT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 15:19:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 519AE1049DF;
        Mon, 12 Nov 2018 05:26:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OnD8qDoJ7G01
        +2LU4+hawr6AgzE=; b=v1MDJl428/5+CKKD/JJxNGlE/6WQE7kCO3FNOboPiPBu
        bkPW86mB63ybpopoEXHC28IugLzygoHRY87lnkFkYbnxNntWXDctX/6/jSF1qw1o
        cQvF+tI4CO3bFZqTDSST55BYRvLhupyQztEGZKG4oVqSZ/4KaQpXMJ3G+MwzKJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DQL+Ub
        Y+1Ztw51D+t9QFGDe29WNdZvIlIsqsjSCr2G6POI05kZocE0Ad16kBd5m17d/b7j
        QFD5a9s0hW0GviCaXTWXUlDI2+lEjmGxoT5SJ/P/W1rvewlmN0eFA+p3e8MGo0F5
        eeqogIQ0MbccpzPn52Whfld7EJWBQTxQDSFWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 491251049DE;
        Mon, 12 Nov 2018 05:26:51 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD0381049DD;
        Mon, 12 Nov 2018 05:26:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <875zxa6xzp.fsf@evledraar.gmail.com>
        <20181111095254.30473-1-pclouds@gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
        <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv>
        <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
        <87o9au39s7.fsf@evledraar.gmail.com>
Date:   Mon, 12 Nov 2018 19:26:49 +0900
In-Reply-To: <87o9au39s7.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 12 Nov 2018 10:49:44 +0100")
Message-ID: <xmqqk1li1thy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77969404-E665-11E8-A226-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> What I'd add to your list is:
>
> * Some projects (I've seen this in the wild) add e.g. *.mp3 or whatever
>   else usually doesn't belong in the repo as a "soft ignore". This is
>   something we've never recommended, but have implicitly supported sinc=
e
>   the only caveats are a) you need a one-off "git add -f" and then
>   they're tracked b) them being missing from "status" before being
>   tracked c) the issue under discussion here.

Or only selected "*.o" (vendor supplied binary blob) kept tracked
while everything else is built from the source.

I do not know who you are referring to "we" in your sentence, but as
far as I am concerned, it has been and still is a BCP recommendation
on this list to deal with a case like that.

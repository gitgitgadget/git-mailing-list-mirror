Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C12A1F45F
	for <e@80x24.org>; Thu,  9 May 2019 04:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfEIEYc (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 00:24:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50531 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIEYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 00:24:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EBD0157ED7;
        Thu,  9 May 2019 00:24:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hlP9VKRJMIrz
        CCAQEx4/Hn8Zgu8=; b=NDyiF4zGHMsP9n0aBTIzyrAdFOyxtmBs50GrLXvN51NW
        biJ5K1a4Ip1BvDwkNZOOfwZ9yiYlXXD9j4VPq1OXkvRnlLEWaDFM11LNSRDuxar5
        22VYLtxPI9w6f1NwoSivy5FN0FeOXs5m8bnxb5L2LMLd/EB0Tg9ZhVJgMwGWWNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nLI/cb
        vOZFJVIQG/kzUpZvn+7s7atjiplOzsxEPEH/aEAgl8m6DUYyMEopD21w1Ld+hLOM
        S56qVTmDf63knT2CskjT2u+QYILu3EIkqGrSM9KSa3pCecl/ZYQclueAJKhw5aSO
        vGS8b93JJ/yqMexXh8ztwEDdbR1Lpi/nCZMZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 468F8157ED6;
        Thu,  9 May 2019 00:24:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E4B2157ED5;
        Thu,  9 May 2019 00:24:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190312031303.5tutut7zzvxne5dw@dcvr>
        <20190312104954.GA2023@sigill.intra.peff.net>
        <20190313015133.n7f7lyujnlwfytre@dcvr>
        <20190313145417.GA24101@sigill.intra.peff.net>
        <20190314091254.nescpfp3n6mbjpmh@dcvr>
        <87zhoz8b9o.fsf@evledraar.gmail.com>
        <20190410225721.GA32262@sigill.intra.peff.net>
        <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
        <20190504013713.GC17551@sigill.intra.peff.net>
        <87a7g2iuem.fsf@evledraar.gmail.com>
        <20190504132346.GK14763@szeder.dev>
        <87o94chfaa.fsf@evledraar.gmail.com>
Date:   Thu, 09 May 2019 13:24:25 +0900
In-Reply-To: <87o94chfaa.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 08 May 2019 22:17:33 +0200")
Message-ID: <xmqqd0ksfe6e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 549BF370-7212-11E9-B991-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, May 04 2019, SZEDER G=C3=A1bor wrote:
> ...
>> And don't forget that the commit-graph progress bar still prints
>> nonsense :)
>
> I'm inclined to just wait until Derrick's refactorings land post-2.22.0

Fine by me.  Thanks.

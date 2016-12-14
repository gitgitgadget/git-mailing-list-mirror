Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286391FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbcLNRg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:36:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60415 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753453AbcLNRg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:36:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB82955199;
        Wed, 14 Dec 2016 12:36:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q3+fRQ3tuebq
        xN7F/H4JUPPJRhE=; b=CF/BZbUycZle8w/ZcSNKiKG3rtMTsnoEoKM/FUAazPW5
        o6dTaQw1htIpDRxVmnZT8OSaXo+eJke2xbpTmk65pov1GbGDf8oNceBH4pARb1uW
        AMMfDQY0jrWZheUmMCMhWN6SV3kfgkgpPQ4/1wNAQivjQtz1gaF4e37ck6uom0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WClytn
        Jgb7a6i6QPPtrTCep5GgazYX4szSSG6aCxzUFc+cx09qYZVqgcFoqVIQeMmHC61U
        0CdD66lZ5fTIYiwt4IqXdfgVy25M/4iniRLeBuv4lAVkGc61TcC2+3XkzIdLbqNd
        3WLtrsEHyirEfk2F75UuzQDXt8ckOmQe3ocVo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3D0755197;
        Wed, 14 Dec 2016 12:36:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 447A155196;
        Wed, 14 Dec 2016 12:36:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv2 0/7] Fix and generalize version sort reordering
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
        <20161208142401.1329-1-szeder.dev@gmail.com>
        <20161214170852.bzh5pyl4bov6rwbt@sigill.intra.peff.net>
Date:   Wed, 14 Dec 2016 09:36:36 -0800
In-Reply-To: <20161214170852.bzh5pyl4bov6rwbt@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 14 Dec 2016 12:08:52 -0500")
Message-ID: <xmqqzijyxviz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DDD82F42-C223-11E6-BF65-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 08, 2016 at 03:23:54PM +0100, SZEDER G=C3=A1bor wrote:
>
>> > With my patches it looks like this:
>> >=20
>> >     $ git -c versionsort.prereleasesuffix=3D-pre \
>> >           -c versionsort.prereleasesuffix=3D-prerelease \
>> >           tag -l --sort=3Dversion:refname
>> >     v1.0.0-prerelease1
>> >     v1.0.0-pre1
>> >     v1.0.0-pre2
>> >     v1.0.0
>>=20
>> And when there happen to be more than one matching suffixes starting
>> at the same earliest position, then we should pick the longest of
>> them.  The new patch 6/7 implements this behavior.
>
> The whole approach taken by the suffix code (before your patches) leave=
s
> me with the nagging feeling that the comparison is not always going to
> be transitive (i.e., that "a < b && b < c" does not always imply "a <
> c"), which is going to cause nonsensical sorting results.
>
> And that may be part of the issue your 6/7 fixes.
>
> I spent some time playing with this the other day, though, and couldn't
> come up with a specific example that fails the condition above.
>
> It just seems like the whole thing would conceptually easier if we
> pre-parsed the versions into a sequence of elements, then the compariso=
n
> between any two elements would just walk that sequence. The benefit
> there is that you can implement whatever rules you like for the parsing
> (like "prefer longer suffixes to shorter"), but you know the comparison
> will always be consistent.
>
> It would also be more efficient, I think (it seems like the sort is
> O(nr_tags * lg(nr_tags) * nr_suffixes) due to parsing suffixes in the
> comparator). Though that probably doesn't matter much in practice.
>
> I dunno. I think maybe your 6/7 has converged on an equivalent behavior=
.
> And I am certainly not volunteering to re-write it, so if what you have
> works, I'm not opposed to it.

I also had worries about transitiveness but couldn't break it after
trying for some time.  I find your pre-parsing suggestion a great
one, not from the point of view of performance, but because I would
imagine that the resulting logic would become a lot easier to
understand.



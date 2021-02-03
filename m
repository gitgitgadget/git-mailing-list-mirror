Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F479C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201DF64F93
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBCTng (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 14:43:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60245 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBCTne (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 14:43:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A294910C601;
        Wed,  3 Feb 2021 14:42:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jniq0B+ALcMg
        4D6FCSNR4UOQLfk=; b=f/NkaVmZU8nZfKzvmS5MOG4apim9UVAJVy1kEnfhrkSJ
        zSKVSc57nbQ/+qxIEU6+oNjiXWsCWb82TslwA9ocmexwNvQ7mRCMEoXw4g84LFJ3
        3t0i1rCwyGdKZGK1cKegbhpXmjwBjPLIFOUlBtKgcVymgtzyCKTd0cSZffAO96U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=d/7zcB
        q8dz/z92HgiNimdDg5+I2QLtXPN5LEj0xTjR6eA1sgxRtdQuT2Ls0O2hDc61gJsx
        dsFOyiAzZuCi0CXUxkY7teCCOaTJOC1uVe4ZxFV6DHjGZLicmaIWdIniWckVTYmo
        n7A0ggqREn6ZbpLggmVC/0rWVk0+Vme66/LLg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AEC910C600;
        Wed,  3 Feb 2021 14:42:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBFE910C5FC;
        Wed,  3 Feb 2021 14:42:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 19/25] pickaxe -G: set -U0 for diff generation
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210203032811.14979-20-avarab@gmail.com>
        <874kitdy6r.fsf@evledraar.gmail.com>
Date:   Wed, 03 Feb 2021 11:42:48 -0800
In-Reply-To: <874kitdy6r.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 03 Feb 2021 15:26:52 +0100")
Message-ID: <xmqqy2g5aqfb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF78401A-6657-11EB-BE84-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I since discovered Junio's f01cae918f (diff: teach --stat/--numstat to
> honor -U$num, 2011-09-22) (as an aside we have no test for that
> behavior).
>
> I haven't looked carefully, but I don't think we'll have the same issue
> here, as pickaxe currently doesn't care about whether something is on
> the + or - line, when briefly looking at the diffstat edge cases it
> seems that's what differs based on -U<n> for the diffstat.

With -U0 or different <n> in general, the matching between preimage
and postimage may become different, and both -U3 (usual) and -U0 may
express the same change "correctly" from the point of view of a
program like "git apply", but humans would see them as different
patches, and "diffstat" that counts number of +/- would give
different results.  The patch IDs may also be different.  The old
commit was to pessimize the logic (because we do not need context
just to count +/- lines for the purpose of diffstat) to match human
expectations.  They expect "'diffstat' must be counting 'diff -p'
output" and we were counting "diff -p -U0" instead, resulting in
different numbers.

With internally using -U0, the updated "pickaxe -G" is likely to get
the same complaints: "'pickaxe -G<token>' found this commit, but in
the 'git show' output, the token does not seem to be affected".

You'd respond to "try 'git show -U0' and now you'd see the <token>",
but again that is probably breaking human expectations.

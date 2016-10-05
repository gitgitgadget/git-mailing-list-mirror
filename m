Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372041F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbcJERBx (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:01:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59235 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbcJERBw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:01:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AABD42285;
        Wed,  5 Oct 2016 13:01:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=St5MidcfO61x
        7DBH4FCmVEf7GKY=; b=L/TOLtDYJKYP59fnts1USxVGDRJYCvRrBrCFflplSzwC
        cxRTwphocB5MLelP6R6w+OA8UoQoH/t1Bb7IBFYisi/hXiWc+LSZT14oj+HSuOII
        zDu1JhqlSVpIO405hD759IGh9biP5HeGfunxKSoJwR63TsI8hRLP88x1EAoFAPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FwcnRN
        kvAuBDDStMZJqK60nCKuPFWiZJjcgImUes54ERbMJpe7hTWQvrDVACV74PzVbBQO
        peagtP3CVBNPL3FF2FMpwc1yLsbqE0p8IE/LG4U+xkFiMPRZkwAX/kSAKuLEu+W9
        fSqVWqvd132QEZAUYjh8dGPWD5ErGj9fxICHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4313A42284;
        Wed,  5 Oct 2016 13:01:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A91AA42283;
        Wed,  5 Oct 2016 13:01:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Cc:     Jeff King <peff@peff.net>, Leho Kraav <leho@conversionready.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
        <20160907151251.30978-1-szeder@ira.uka.de>
        <20160907151251.30978-6-szeder@ira.uka.de>
        <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
        <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
Date:   Wed, 05 Oct 2016 10:01:48 -0700
In-Reply-To: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 05 Oct 2016 03:33:53
 +0200")
Message-ID: <xmqq4m4qrapv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 68A13300-8B1D-11E6-B27F-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> And a final sidenote: sorting based on the longest matching suffix
> also allows us to (ab)use version sort with prerelease suffixes to
> sort postrelease tags as we please, too:
>
>   $ ~/src/git/git -c versionsort.prereleasesuffix=3D-alpha \
>                   -c versionsort.prereleasesuffix=3D-beta \
>                   -c versionsort.prereleasesuffix=3D \
>                   -c versionsort.prereleasesuffix=3D-gamma \
>                   -c versionsort.prereleasesuffix=3D-delta \
>                   tag -l --sort=3Dversion:refname 'v3.0*'
>   v3.0-alpha1
>   v3.0-beta1
>   v3.0
>   v3.0-gamma1
>   v3.0-delta1

Assuming that gamma and delta are meant to indicate "these are
post-release updates", I think a mechanism that can yield the above
result is fantastic ;-)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414EC433E2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B812A619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhC3XhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:37:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52175 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhC3Xgy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:36:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23A71B09B4;
        Tue, 30 Mar 2021 19:36:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KJRxD6bsz0qb
        ZiZLO1MDP5fMFJA=; b=CcmwLWh2/BJd3Wq//fzEauWktOxwzCDeAHfHS2y23dL0
        OPfZd4D/ueCg8DOkGWak8dHE+cDtl/UNlS74MS1gwDqrU+FyOp2zg0dk3Sim7X4u
        YVtKqLqwU1Q7rMoECkiaXh0PirW85PbeX8/wmXbbSoQ8oUBVI0qXewd4D8b/nqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XFV3+i
        8thYyW4pqLG1jdwjTkHmg6mJTzTPsWE74PPQ2NbpNsi29DT8TBJT06GD0vAS1eWD
        QE6/CDXYdVwLENmTuX2IZBgt7r4MDY8z3WuC1dcvj4x54e8Y58wCWrBwUvj1HKG+
        8TlASSXogGrM7AMBLuXxLwCYGwJJpAjEqiXEg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AE95B09B3;
        Tue, 30 Mar 2021 19:36:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A47FB09B0;
        Tue, 30 Mar 2021 19:36:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 09/22] pickaxe: die when -G and --pickaxe-regex are
 combined
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-10-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:36:52 -0700
In-Reply-To: <20210216115801.4773-10-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:48 +0100")
Message-ID: <xmqqwnto9pt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEE7DF3A-91B0-11EB-8B2C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When the -G and --pickaxe-regex options are combined we simply ignore
> the --pickaxe-regex option. Let's die instead as suggested by our
> documentation, since -G is always a regex.
>
> When --pickaxe-regex was added in d01d8c6782 (Support for pickaxe
> matching regular expressions, 2006-03-29) only the -S option
> existed. Then when -G was added in f506b8e8b5 (git log/diff: add
> -G<regexp> that greps in the patch text, 2010-08-23) neither the
> documentation for --pickaxe-regex was updater accordingly, nor was

s/updater/updated/;

> something like this assertion added.
>
> Since 5bc3f0b567 (diffcore-pickaxe doc: document -S and -G properly,
> 2013-05-31) we've claimed that --pickaxe-regex should only be used
> with -S, but have silently toileted combining it with -G, let's die

toilet?  tolerate?

> instead.

Hmph.  I've always hated that -G can only take regexp and users
cannot ask for a fixed-string match.  It may not be a bad idea to
keep this as-is, as that would leave the door open for those who are
motivated enough to later introduce --no-pickaxe-regex, so that
-G<string> would naturally work with combination with it.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA3C4332E
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB28664E99
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351530AbhCDBDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58984 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355486AbhCDA3H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:29:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87012BF6AF;
        Wed,  3 Mar 2021 19:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E0Ywu8TcwpDG
        S4hM+D8EkKXwjzI=; b=xNMixKLc2bVjF1JPhJjOoYd21IAvcs67H8+FyTqHNxtC
        wnTTODYnSbliNTK+SQ67sHiU8jv2SB7VXY9XDSV+w8CJhUBC6uuqoWXbWqPmel6X
        uiKEzfhrP0XWOeQFQ2UO7319ntLP0mcacC40WhLEhaflPtAGtGnsusy/2VtGnjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=O0XjWD
        8x7Zhwa79slz5dxKwCIXBrbVSXCv3Sy5C305pH+vJtvRyzKXE/lsOsT2slSNohyN
        G1qeYQdOgIIh4EkoHNdLIr23OMz5ZMbh9smMB371OaOtCmPBJBRrHY2V4ROEaDOH
        S1uvO7QCLmRdpauAk00YGByQtBmyuGYUA18tg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FD73BF6AE;
        Wed,  3 Mar 2021 19:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E502BF6AD;
        Wed,  3 Mar 2021 19:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 10/10] grep/pcre2: move definitions of
 pcre2_{malloc,free}
References: <20210204210556.25242-1-avarab@gmail.com>
        <20210218000728.13995-11-avarab@gmail.com>
Date:   Wed, 03 Mar 2021 16:28:24 -0800
In-Reply-To: <20210218000728.13995-11-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 01:07:28 +0100")
Message-ID: <xmqqczwfhidz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88625D5A-7C80-11EB-B445-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the definitions of the pcre2_{malloc,free} functions above the
> compile_pcre2_pattern() function they're used in.
>
> Before the preceding commit they used to be needed earlier, but now we
> can move them to be adjacent to the other PCREv2 functions.

Yes, much nicer.


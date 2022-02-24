Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC12C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiBXTy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiBXTy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:54:28 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7325D6D7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:53:57 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4EAD127760;
        Thu, 24 Feb 2022 14:53:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/i7wC8JiAtzWR98G7o+k2NuJRI7mqhGwN5/1rp
        GkM50=; b=NRTG5SPNTSQsoLKXMkQUWMso9DzCMtIBnqzu0YtqypXBIxXLCE8f43
        ZW17eVl+/npvrV7riNoti+IYF+PsNPDcJXK9SkvqlkwSHizfjTQ5oC5zqmWDNQbK
        s8gsdnieykRCvFMFjaCABR55JLn6J0PeXLVqXIn2Jclt9QhLp6owI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D823212775F;
        Thu, 24 Feb 2022 14:53:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40E6012775E;
        Thu, 24 Feb 2022 14:53:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 00/12] c99: use more designated initializers
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2202242017590.11118@tvgsbejvaqbjf.bet>
Date:   Thu, 24 Feb 2022 11:53:55 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202242017590.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 24 Feb 2022 20:22:13 +0100
        (CET)")
Message-ID: <xmqqsfs8kpm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 801AC962-95AB-11EC-A1A3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is probably a bit premature given that we still are treating the
> C99-isms as weather balloons. The idea was to keep things in an
> easily-revertable state for at least a couple of major versions.
>
> The referenced changes are only in core Git as of v2.34.0, and we are not
> even half-way through the v2.36.0 cycle.

The proposed commit log messages need updating.  By refering to much
newer commits created by the same author, instead of the beginning
of the official weather balloon experiments, it created an unnecessary
confusion.

Read the CodingGuidelines document.  Everybody knows what it says by
heart by now, right? ;-)

   . since mid 2017 with cbc0f81d, we have been using designated
     initializers for struct (e.g. "struct t v = { .val = 'a' };").

   . since mid 2017 with 512f41cf, we have been using designated
     initializers for array (e.g. "int array[10] = { [5] = 2 }").

I do not think doing this in early 2022 is still premature.

I hate to having to deal with such a tree-wide churn, though.  I'd
rather see "let's do this only on quiescent part of the tree a small
bit at a time" like on imap-send.c but not involving anything known
to be actively touched, like ref backends.

Thanks.

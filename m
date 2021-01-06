Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D19C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1C322E03
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 00:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbhAFArD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:47:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55533 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhAFArD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 19:47:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2286110E39D;
        Tue,  5 Jan 2021 19:46:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ZH+fb9Rs/07EztAyAQO1OUMgs
        qE=; b=NIJx4QJ3LBsYMVOEg3XftyPdPszhDudJ5XRnAynmPKH6txa8hmk/YZ+6c
        nppuhq/70WQp0SuYgAwODPuaQSge8IS+9SOZSbtXmH6GJnfobHORZmEdYQODNtRO
        4j/UDRrwPkAsnElo/tdevPbQnhY5YY0LNT3qj/v5qFyxXwrd/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=tEZMB+PE6kN0+36IHSv
        LCjrG4l2xI1xD+OjUWuqHmuktG/gi/lGuUoB+vhZIUMBII0TFR5MSCwA7GM01l+P
        3YnS0F/awArMipRStKGGxdELMoSYCrfgOZ/g5lcc7VGJxjLksXKsxJV256fcqG13
        ihOvYAfUs5yN81KnzMV4DrmQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AB6F10E39C;
        Tue,  5 Jan 2021 19:46:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 641A810E398;
        Tue,  5 Jan 2021 19:46:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] mailmap: use case-sensitive comparisons for
 local-parts and names
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
        <20210103211849.2691287-5-sandals@crustytoothpaste.net>
        <87czykvg19.fsf@evledraar.gmail.com>
Date:   Tue, 05 Jan 2021 16:46:16 -0800
Message-ID: <xmqq8s96yjs7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 969B209A-4FB8-11EB-8711-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Jan 03 2021, brian m. carlson wrote:
>
> We just have to worry about cases where you're not all of these people
> in one project's commit metadata and/or .mailmap, and thus mailmap rule=
s
> would match too generously:
>
>     "brian m. carlson" <sandals@crustytoothpaste.net>
>     "brian m. carlson" <SANDALS@crustytoothpaste.net>
>     "BRIAN M. CARLSON" <sandals@crustytoothpaste.net>
>     "BRIAN M. CARLSON" <SANDALS@crustytoothpaste.net>
>
> Is that really plausible? In any case, neither of these two patches mak=
e
> reference to us already having changed this in the past in 1.6.2 and &
> there being reports on the ML about the bug & us changing it back. See
> https://lore.kernel.org/git/f182fb1700e8dea15459fd02ced2a6e5797bec99.12=
38458535u.git.johannes.schindelin@gmx.de/
>
> Maybe we should still do this, but I think for a v3 it makes sense to
> summarize that discussion etc.

After reading the old discussion again, I am not sure if this is
worth doing.  To many people, it is a promise we've made and kept
that we treat addresses including the local part case-insensitively
when summarising commits by ident strings.

I'd really wish that this series were structured to have 5/5 early
and 3&4/5 squashed into a single final patch.

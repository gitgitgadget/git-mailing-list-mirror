Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC853C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA97610E9
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhIPVAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:00:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60432 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIPVAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:00:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A846BD847C;
        Thu, 16 Sep 2021 16:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZNpoQhLnpKQO
        WNwvunQDhCJWmsrCo7DGfggYTHIx1EU=; b=eQNPq4u3RaVLYjSHNaqfPgMhmIvF
        C2LVg59+xGwb/B95LZpcZa4l5FH+Zt86wexBCFKgWrc8ncoXv9H1Re202jXmUCnf
        Q1D6nPQN3bmLzUd+8J/b78r63O7eQ7izDXUgk7vOPfqwAr2zKHezQ/3ESIHWt6lD
        A4YIGP0a+oTFZ/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EC0ED8479;
        Thu, 16 Sep 2021 16:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AFD3D8478;
        Thu, 16 Sep 2021 16:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>,
        Andreas Gruenbacher <agruen@gnu.org>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH 2/2] diff: --quote-path-with-sp
References: <20210915223316.1653443-1-gitster@pobox.com>
        <20210915223316.1653443-3-gitster@pobox.com>
        <87ee9ohnqd.fsf@evledraar.gmail.com>
Date:   Thu, 16 Sep 2021 13:59:15 -0700
In-Reply-To: <87ee9ohnqd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 16 Sep 2021 11:06:42 +0200")
Message-ID: <xmqq35q4texo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F40223BA-1730-11EC-8C1A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Sep 15 2021, Junio C Hamano wrote:
>
> [CC-ing Andreas Gruenbacher who's currently active in GNU patch
> development, and Paul Eggert at his current address, in case he's
> curious about this blast from the past.
>
> Both: The full context for this proposed change in Git is at
> https://lore.kernel.org/git/20210915223316.1653443-1-gitster@pobox.com/=
]
>
>> Long time ago, we had a discussion with GNU patch/diff maintainer
>> and agreed that pathnames with certain "difficult" bytes needs to be
>> quoted to ensure the resulting patch is machine parseable in an
>> unambiguous way [*1*].  Recently, we saw a report that found that
>> GNU patch is unhappy with our diff output for a path with SP in it
>> [*2*].
>
> It would also be good to mention 4f6fbcdcf96 ...

Ah, I didn't mean "this is the single message to understand the
issue".  The reference was meant as "you need to read the discussion
that starts around here", which you apparently did ;-)

There is another message that is much more relevant that does not
appear in the thread (and I do not know its message ID), where Linus
came up with a way to parse the "diff --git a/... b/..." line, or
the first "--- a/..." and "+++ b/..." lines, and learn the pathnames
on the preimage side and on the postimage side unambiguously.  I think
that discovery led to the current implementation.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74601F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbdHIRUD (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:20:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62056 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752517AbdHIRUB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:20:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00682940E3;
        Wed,  9 Aug 2017 13:19:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1OSyZcGqM69P
        W82QnIrcsoFr+TQ=; b=RKTZSiNeRpE3rC+shtx4I14n8x80hoAfBd8w8MRrMjY6
        wPQRVcD5+bLI36Asd9DmRHEDEaYCP6YrRahkzyUxvSE8Zm/0XMtD4Ote6lvabvR5
        jSeUa8A/3+HlVWMadigPiVD+e6WT3LIRc7HOzWeu0Oz80RnQ/wrJCFIdubtU0G8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i6LZz5
        yDbjgLFpazEKmL2/DfnRZCKSOJQK1KpXXcyx54kzRTC88XhUhkcXZn4f5rNIMSGI
        1kIbBAX5OR3PnI7O/uU8LHEJ9GeHTuMNtbsraRK18K5dUs7/78rsGngrHTwrpq70
        FUWgFv9iWZRZ0Kvn4uAxuj6Km5zE8e5Cw4HMg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBD10940E1;
        Wed,  9 Aug 2017 13:19:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65611940DF;
        Wed,  9 Aug 2017 13:19:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
Date:   Wed, 09 Aug 2017 10:19:57 -0700
In-Reply-To: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 9 Aug 2017 08:21:47 -0400")
Message-ID: <xmqq60dw7j5u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8311F48-7D26-11E7-B97C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Parsing trailers out of a commit message is _mostly_ easy, but there
> area a lot of funny corner cases (e.g., heuristics for how many
> non-trailers must be present before a final paragraph isn't a trailer
> block anymore).  The code in trailer.c already knows about these corner
> cases, but there's no way to access it from the command line.
>
> This series teaches interpret-trailers to parse and output just the
> trailers. So now you can do:
>
>   $ git log --format=3D%B -1 8d44797cc91231cd44955279040dc4a1ee0a797f |
>     git interpret-trailers --parse
>   Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
>   Helped-by: Stefan Beller <sbeller@google.com>
>   Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>   Acked-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>

Thank-you, thank-you, thank-you.

The above example made me wonder if we also want a format specifier
to do the above without piping, but it turns out that we already
have "log --format=3D%(trailers)", so we are good ;-)

> I considered a few different approaches before deciding on
> what's here:
>
>   1. The output format is actually the normal "key: value" trailers. I
>      considered something more structured like JSON. But the "key:
>      value" format is quite easy to parse, once it has been normalized
>      (finding the trailers, unfolding whitespace continuation, etc).
>
>   2. This series introduces several orthogonal options which can be use=
d
>      together to achieve my goal, when there could just be a "parse"
>      mode. Since interpret-trailers is plumbing, I reasoned that the
>      individual options might still be useful apart from each other (fo=
r
>      instance, you could re-normalize existing trailers while writing
>      your new ones from a commit hook). I did add a "--parse" for
>      convenience and to help point users in the right direction.
>
>      For the same reason (and so we could build on other orthogonal
>      features like --in-place and --trim-empty), I decided against
>      having a separate command like "git parse-trailers".
>
>   [1/5]: trailer: put process_trailers() options into a struct
>   [2/5]: interpret-trailers: add an option to show only the trailers
>   [3/5]: interpret-trailers: add an option to show only existing traile=
rs
>   [4/5]: interpret-trailers: add an option to normalize output
>   [5/5]: interpret-trailers: add --parse convenience option
>
>  Documentation/git-interpret-trailers.txt | 17 ++++++++
>  builtin/interpret-trailers.c             | 34 ++++++++++++---
>  t/t7513-interpret-trailers.sh            | 73 ++++++++++++++++++++++++=
++++++++
>  trailer.c                                | 65 ++++++++++++++++++++++--=
----
>  trailer.h                                | 12 +++++-
>  5 files changed, 180 insertions(+), 21 deletions(-)
>
> -Peff

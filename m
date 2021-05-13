Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BCC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE9660FEE
	for <git@archiver.kernel.org>; Thu, 13 May 2021 22:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhEMWCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 18:02:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61898 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEMWCA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 18:02:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 673FE1337E1;
        Thu, 13 May 2021 18:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mGzyS3bkNLxy
        DXOv/5IRKJBweqRpZa/B24V50F/b+uk=; b=JBSibQOj//had2ginOptQQGiUabm
        2wlqKw/VMBHnvLqKqERBB12EE9MKFL5/8zjYI8+S7qXN1rV1Q+zCiw/hYn5xn7b8
        OPwQ/utM+T6gj5Q753WbfSopTBjSx2xPpBo0vtBpO4/7THIZBwulf4EpuK1iHwM6
        R45/uCzD/S9cYf4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 601211337DF;
        Thu, 13 May 2021 18:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 221031337DB;
        Thu, 13 May 2021 18:00:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
References: <cover.1620928059.git.martin.agren@gmail.com>
        <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
Date:   Fri, 14 May 2021 07:00:45 +0900
In-Reply-To: <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 13 May 2021 20:17:42
 +0200")
Message-ID: <xmqqzgwy8faq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABFB7E2A-B436-11EB-B68D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Asciidoctor renders 'git cat-file' with the single quotes.

I somehow find this sentence a bit hard to grok.  Do you mean
"instead of typesetting them emphasized, the two-word phrase is
enclosed in a pair of literal single quotes"?

> It's somehow
> tricked by the single quote in "srcref\'s" earler in the paragraph. If
> we drop the backslash, we'll regress with AsciiDoc. Let's just rewrite
> things a bit to avoid "srcref's" entirely.

I also was puzzled by this one and the previous "cat-file" thing,
mostly because I couldn't tell if this is an unrelated problem that
happens to be around the same single-quote letter, or somehow
happens only because the single-quoted 'cat-file' was nearby, until
I checked the patch text (and it seems that this is "here is another
problem around apostrophe").

> Add backticks for monospacing around these refs and command invocations
> while at it.

I have no problem with this particular rephrasing from "srcref's
value" to "value of srcref", but forbidding possessive "'s" from any
future documentation is troubling.

> -. A colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
> -  value and store it in dstref" in fetch and push operations.
> +. A colon `:` is used as in `srcref:dstref` to mean "use the value
> +  of `srcref` and store it in `dstref`" in fetch and push operations.
>    It may also be used to select a specific object such as with
> -  'git cat-file': "git cat-file blob v1.3.3:refs.c".
> +  'git cat-file': `git cat-file blob v1.3.3:refs.c`.

The proposed log message did not explain why you wanted to avoid
double-quote pair on the "cat-file" line.  Is this meant as a
workaround for the "single quotes are shown around git cat-file"
issue?

Thanks.

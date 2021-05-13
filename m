Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ABFC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386D8611BF
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhEMUgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:36:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59963 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhEMUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:36:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFD96B6068;
        Thu, 13 May 2021 16:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aiHNbqSa9awx
        +YAICnUewakaeZT3SqOglYxzdI0y1fM=; b=U4r/nW82PUE0SbT2580rdW0CwP14
        +JQM57HBUqgMakLuYDoGmPY7UYBLJr7LGv+kqx1f1l4Jfol/JLJlBtPcgFoHpYFE
        dlT1GuYBAZwaWjUJ7zyFbLj6fWlALsPrxjXxDspQwjfxzYAbnGe4oEc1bF6uWQyg
        O9BarmynEWmFj6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8377B6066;
        Thu, 13 May 2021 16:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C368B6065;
        Thu, 13 May 2021 16:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
References: <cover.1620928059.git.martin.agren@gmail.com>
Date:   Fri, 14 May 2021 05:35:11 +0900
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Thu, 13 May 2021 20:17:39 +0200")
Message-ID: <xmqqsg2q9xts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B76D80B6-B42A-11EB-B334-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> These patches reduce
>
>   ./doc-diff --from-asciidoc --to-asciidoctor --cut-footer HEAD HEAD
>
> from ~1200 to ~1000 lines. It's the usual mix of things where one or th=
e
> other of the tools renders something less well, or where we're doing
> something odd in the source and we just happen to notice it in the diff=
.
>
> My ulterior motive here is to have a smaller doc-diff when I post a
> patch to switch the default to Asciidoctor (with xmlto), so that it get=
s
> a bit easier to reason about. But if everybody gets prettier docs,
> that's also good.
>
> Some of these rephrase wording such as "other peoples' commits" to avoi=
d
> that apostrophe at the end of a word. I'm hoping those rephrasings don'=
t
> regress the quality of the text -- if they do, I'll be happy to try
> something else.

It is sad, but we really should try "something else", unfortunately.

I do agree with the "motive" very much---even though condensing it
down to plain text before running comparison already loses too much
information, doc-diff is the only tool we currently have to
effectively review regressions in rendered document, and the
proposed transition cannot be done safely with confidence without
being able to vet the differences.  I am happy to hear about 17%
reduction already, but the requirement to rewrite things like "other
peoples' commits" is a dealbreaker.

I am not so worried about the existing text you rewrote in these
patches.  I however do not want to see asciidoc(tor) dictating use
of a strange dialect of English when we write new documentation or
update existing ones by imposing rules like "you are not allowed to
use apostrophe-es to express possessive, and instead use 'of'"; it
will become a continuing burden for anybody who writes documentation
for us.

A typesettig rule like "instead of double-dashes --, use {litdd}" is
an acceptable way out.  At least that wouldn't constrain what the
final product that gets delivered to the end-users can say.

Thanks.

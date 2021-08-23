Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D316C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7279A61056
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhHWSLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:11:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61256 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhHWSK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:10:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CC911475A7;
        Mon, 23 Aug 2021 14:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1bqth37shqO6FZsH+CHywy8y+3QnnID4quDDF8
        KFnOI=; b=P78KWjd9dKkGvMNUtXiOHz9QI53CyEE0z9ONuEMl7CjZLceWiC0nKU
        DzwN9BUET+EZKisqrwuy9bfFf1rjjsa4sUz0TrxJsc1mWhU7El+7kpFTjmkFR+wW
        PHcKin7tRHrafpyCGTMnCaaoSZCF3ghu3JWRJkh6PkVwJYGcNqmog=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 752A01475A6;
        Mon, 23 Aug 2021 14:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A10F51475A5;
        Mon, 23 Aug 2021 14:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Maksym Sobolyev via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Maksym Sobolyev <sobomax@gmail.com>,
        Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: [PATCH] Make ident dynamic, not just a hardcoded value of "$Id".
References: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com>
Date:   Mon, 23 Aug 2021 11:10:11 -0700
In-Reply-To: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com> (Maksym
        Sobolyev via GitGitGadget's message of "Mon, 23 Aug 2021 16:41:58
        +0000")
Message-ID: <xmqqa6l8qbgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CB89AA8-043D-11EC-A74B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Maksym Sobolyev via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Maksym Sobolyev <sobomax@sippysoft.com>
>
> This allows ident to be something like $FreeBSD$ so it provides matching
> functionality for repos migrated from CVS / SVN.
>
> This works by allowing ident to have a parameter, i.e.:
>
> * ident=MyCustomId
>
> In .gitattributes.

I would have expected that, just like cvs uses its configuration
mechanism for LocalKeyword, this would belong to the .git/config
file.

The attribute mechanism is inherently for stuff that you would want
to specify per-path, so the "do we do keyword expansion for this
file (yes/no)?" is a good match to be an attribute, and that
question is what the original 'ident' attribute asks.

I do not think "what keyword do we want to expand as if it were
$Id$?" is a question we want to be giving different answers per
path, and it does not smell like a good match to be an attribute.

By allowing a potentially separate values for

    *.txt ident=FreeBSD
    *.cc  ident=OpenBSD

this gives long rope to create a mess to the users.

I also think that the ident expansion is overrated, and have a
feeling that we should discourage its use, not encourage it, but
that is a separate story.

Thanks.

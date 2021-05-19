Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4707C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E6460FF0
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhESXaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 19:30:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61257 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESXae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 19:30:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D573B8534;
        Wed, 19 May 2021 19:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J4QGFu4sIQZs5MxEeFPJm+n0NtK/G4waF91b06
        Zrcgk=; b=NmEaE4tYp+0LLmWwvocEtlIJItHBt+eCFKnZuBFvKkFlTdtum5F0f/
        e5SycTMWvV3lhpB6Tgtr6IzOgETe5VKTzR6kT4WR0RxCmtF/AvA5wD8zanA28V0A
        QamXIQvhdgEPOybhad1Fpc3y6t3ZpyUJRdjdhqZPVxmSeGWEY7NYQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75F9FB8533;
        Wed, 19 May 2021 19:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F175BB8531;
        Wed, 19 May 2021 19:29:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
        <xmqq4kf7cmaj.fsf@gitster.g> <xmqqzgwzb7ad.fsf@gitster.g>
        <CABPp-BGERNLKbLA_r7i7+r+v7YK6xT00_5n9ebESb2SzLhC0Cg@mail.gmail.com>
        <xmqqv97nb51b.fsf@gitster.g>
        <681aefe15af98f6758f28544b96bc2eca90642f3.camel@scientia.net>
Date:   Thu, 20 May 2021 08:29:12 +0900
In-Reply-To: <681aefe15af98f6758f28544b96bc2eca90642f3.camel@scientia.net>
        (Christoph Anton Mitterer's message of "Wed, 19 May 2021 19:56:53
        +0200")
Message-ID: <xmqqr1i2wbef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04FEB84E-B8FA-11EB-8FA4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.net> writes:

> Hey there.
>
> I think I found another case of an unbound variable:
>
> Completing e.g.:
> git commit --[press TAB]
>
> gives:
> $ git commit  --bash: GIT_COMPLETION_SHOW_ALL: unbound variable

It seems that OMIT_SPARSESTATE would have the same issue.

	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&

all coming from afda36db (git-prompt: include sparsity state as
well, 2020-06-21).

But I think we have already seen the fix in 5c0cbdb1 (git-prompt:
work under set -u, 2021-05-13), which may or may not appear in the
upcoming release.

There still are unprotected mentions of GIT_PS1_SHOWUPSTREAM even
with that fix, though.

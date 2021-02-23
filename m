Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9BC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B5064E5C
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhBWT4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:56:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51599 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBWT4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:56:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A320EBC7DF;
        Tue, 23 Feb 2021 14:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pRpvg+XkjmZj1fZYCWi1n/27M8M=; b=GNQk5v
        RxVf3tThoR/dKOZcUTl88vWZzlnug7qmj4Sgx/l5CTt70ggSzX5pGic2BYJwGwvC
        hdi9IkS/X/rwpzkxfSnkcLucXiAYa2Tu4hyGfe2m4Ly/6qPezaINUTSk5mHg/f8g
        mpmShwVXHb6lTZ+dOHXI3RWfEYFBY8ePcWmR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TZtMfS62ay0qKsmtf9tAifIfAkV8psfq
        EzjoqkR1ZwQBITGVY0LPmJrvRFMKHZO7D7qxz+WnDkflgFV8LOEyaW5WjHKhSMIK
        Y9ReYbDX0WpGzogmMYfRZoT+OjpyK8sBd5/ARNIb7lT1z0oIka188oVUSGWT72sn
        pmV99+rFyxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98CA3BC7DE;
        Tue, 23 Feb 2021 14:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 179CFBC7DD;
        Tue, 23 Feb 2021 14:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH 0/6][Outreachy] commit: Implementation of "amend!" commit
References: <20210217072904.16257-1-charvi077@gmail.com>
Date:   Tue, 23 Feb 2021 11:55:22 -0800
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Wed, 17 Feb 2021 12:59:06 +0530")
Message-ID: <xmqqeeh61rv9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10AC2680-7611-11EB-BFFD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> This patch series teaches `git commit --fixup` to create "amend!" commit
> as an alternative that works with `git rebase --autosquash`. It allows to
> fixup both the content and the commit message of the specified commit.
> Here we add two suboptions to the `--fixup`, first `amend` suboption that
> creates an "amend!" commit. It takes the staged changes and also allows to
> edit the commit message of the commit we are fixing.
> Example usuage:
> git commit --fixup=amend:<commit>
>
> Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
> ignores the staged changes and only allows to reword/edit the commit message
> of the commit we are fixing.
> Example usuage:
> git commit --fixup=reword:<commit>

We used to have only --fixup that was meant to squeeze in minor
corrections to the contents recorded, and it kept the log message
of the original commit intact.

Now we have two other ways, --fixup=reword that is meant to correct
only the log message while keeping the contents intact from the
original, and --fixup=amend that is meant to allow users to do both.
They are nice additions to our toolbox.

While trying to use the --fixup=amend myself to "touch up" somebody
else's work today, another thing that we did not discuss so far came
to my mind (sorry, if this was discussed and resolved in your
previous discussions with other reviewers).  What should we do to
the authorship?

For the original --fixup, it is reasonably obvious that the original
authorship should be kept, as the intended use case is to make a
small tweak that does not change the intention of the commit in any
way (and that is why the log message from the original is kept), and
with --fixup=reword, it would probably be the same (the contents
were written by the original author alone, and the person fixing-up
is not changing only the log message).  So these two have a
reasonably good default model for the authorship information for the
final outcome: the original authorship should be kept (of course,
the user can easily take over the authorship later with "git commit
--amend --reset-author" perhaps run as part of "rebase -i", if the
contribution is significant enough to deserve the transfer of the
authorship).

But I am not sure what the default behaviour for the authorship when
--fixup=amend:<commit> is used to update somebody else's commit.  I
think it is OK to leave it to whatever the code happens to do right
now (simply because I have no strong reason to vote for either way
between keeping the original and letting the amending user take it
over), but I think it should be documented what happens in each
case.

Thanks.




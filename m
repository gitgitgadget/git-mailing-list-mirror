Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C85C432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A910C61038
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhG1RSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:18:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59222 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhG1RSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:18:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EDD6D8D35;
        Wed, 28 Jul 2021 13:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hNUA37tNam2HHLsXqRAOvghEAxnUhvaYG7bwdR
        kCZr8=; b=uQBK3FJXfrLn3ELJ6oWRpOieUQb7tUaFsaGbkvpG+xlGkokkvUWqi0
        9V5M+ky8hkjEz6VEAi8xqR2GxZ6uUCcFjJWaCn1JPz5uJpw8qYye3ko/rvQZp0ug
        fwjkX+Rwyjd76QIgmlNfdHXlZ4QZArCdC0vOLZklc2gNj10vr6hDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75C4BD8D34;
        Wed, 28 Jul 2021 13:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08A4ED8D33;
        Wed, 28 Jul 2021 13:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: [PATCH v2] pull: introduce --merge option
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
        <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
        <xmqqeebregns.fsf@gitster.g>
        <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
        <xmqqwnpcdu1w.fsf@gitster.g>
        <CAMMLpeQ-Qpct4TX__KVuCyjbgxtB49qTMRHYc9R9-o0cRu4MuA@mail.gmail.com>
        <610038c0e1056_8fd52084a@natae.notmuch>
        <9e8f1c87-cd08-e1a2-fd5d-713cb0590049@aixigo.com>
Date:   Wed, 28 Jul 2021 10:18:10 -0700
In-Reply-To: <9e8f1c87-cd08-e1a2-fd5d-713cb0590049@aixigo.com> (Matthias
        Baumgarten's message of "Wed, 28 Jul 2021 09:44:20 +0200")
Message-ID: <xmqqv94u9x2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8C04758-EFC7-11EB-B1F9-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:

> Add to Felipes list:
>
>  * git switch -m
>
> and maybe git cherry-pick -m where -m does not mean "merge" itself but
> is used to determine the parent of the merge (when picking merge 
> commits) to base on.
>
> Other examples of where -m has different meaning than merge:
>
>  * git am -m (message-id)
>  * git branch -m (move branch)
>
> I would rephrase the question as to what would I expect `git pull -m`
> to do, if I had never heard of it before. In the case of
> fast-forwarding and rebasing trying to add a merge commit message with
> -m would not even make sense. Only in the case of trying to create a
> merge commit by issuing git pull this would make sense. So if we could
> agree on that being not the most used scenario, I think -m would be a
> great short option for --merge.

I am afraid that you are misinterpreting what I said, comparing
apples and oranges, and drawing a wrong conclusion.

When I said "-m" would not fly well as a short-hand for "--merge" in
the context of "pull", I didn't mean "nobody would think 'm' stands
for 'merge'", and I didn't mean "more people would think 'm' stands
for 'message' more than 'merge'".  The reason why I find it
problematic is because it can be ambiguous.

When we step back and think about your "switch -m" and its synonym
"checkout -m", we realize that these commands fundamentally never
take "--message", as there is no place to record such a message
(they do not create a commit after all), after they switch to a
different branch while carrying the local modification forward by
performing a (possibly conflicting) content-level merge.  That is
why we can give their "merge" operation a short-and-sweet "m"
without confusing our users.  So contrasting "switch" having "-m"
that means "merge" with "pull" that can conceivably take both
"merge" and "message" is not a comparison you can draw useful
conclusion from.




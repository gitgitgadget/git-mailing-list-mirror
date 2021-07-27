Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C5BC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09D760F51
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhG0AtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:49:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57252 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhG0AtA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:49:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38A4CDFC41;
        Mon, 26 Jul 2021 21:29:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0yizijmprQF4I1ULbNS/qwyFJD0qLi240tk05x
        RiiYs=; b=VXw90YUE7e/ufFIDR8P93BBto9VIwqekJ39e7gDPNADVMXM4I0tomu
        3eEka4JrvH+U+HoFn+g/RP1FUtCw9cV7Zs2M4s6qm0T07SupcT6sdmYToB1FoEkO
        zWfj0bJK552aHiDXRAdncbcn6myUgX/Tst0Hv6GCM0ilR2hfAPApc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31042DFC40;
        Mon, 26 Jul 2021 21:29:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B37A4DFC3F;
        Mon, 26 Jul 2021 21:29:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
References: <87o8awvglr.fsf@evledraar.gmail.com>
        <20210720214809.3596513-1-jonathantanmy@google.com>
        <YP9Z+pDT6eZtlJhi@google.com>
Date:   Mon, 26 Jul 2021 18:29:27 -0700
In-Reply-To: <YP9Z+pDT6eZtlJhi@google.com> (Emily Shaffer's message of "Mon,
        26 Jul 2021 17:57:30 -0700")
Message-ID: <xmqqczr4fsso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15682F3E-EE7A-11EB-B858-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I think this is a pretty important point. To me, the ideal flow looks
> like this:
>
>  - I clone some repo, planning to just use the source code. I ignore the
>    hook prompt.
>  - I notice some bug which is within my power to fix. I have forgotten
>    about the hook prompt, because I was having so much fun using the
>    source code in the repo.
>  - I 'git commit' - and 'git commit' says, "Did you know this repo
>    suggests installing a commit-msg hook? You can install it by running
>    'git hook install pre-commit' and run it by running 'git commit
>    --amend --no-edit'. You can audit the commit-msg hook by running 'git
>    hook magic-audit-command-name-tbd'. You can hide this advice <typical
>    advice-hiding advice here>."

Devil's advocate in me says that delaying this until the last
possible moment will make people *not* look at the hook's contents
and just say "yes".  After all, you have been working on a task and
reached one milestone (i.e. you are now ready to say "commit"), and
you want to start recording your thought process before it slips
away from your mind.  To many of us non-multi-tasking types, it is
one of the worst moment to force switching our attention to a
secondary task of vetting project supplied hooks---rather, I'd say
"Oh, I work for project X and if these hooks are supplied by project
X, it is good enough for them, and it must be good enough for me".

> That way I don't add privilege (tell my computer it's OK to execute code
> I didn't look at) until the very possible moment.

So this smells a wishful thinking to me.

> MOTD approach also makes it hard to *update* hooks when the maintainer
> so recommends - would be nice to have something baked in to notice when
> there are new changes to the hooks, so we hopefully don't have
> developers running hook implementations correlating to the date they
> most recently cloned the project.

Interesting.  Every time you run "git commit", the command will
check the existence of remotes/origin/suggested-hooks, compares the
installed .git/hooks/pre-commit with a blob in the tree stored
there, and tells you to update if they are different?  Or perhaps
the installed hooks record from which blob their contents came from,
and perform a three-way content level merge to carry local changes
forward?

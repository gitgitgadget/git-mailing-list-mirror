Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFFEC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2A124677
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVhISJad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1URU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:17:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54598 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgB1URU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 15:17:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A34CBE05B;
        Fri, 28 Feb 2020 15:17:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VjJOaw25ICOLq6GKwhel3lIUnMg=; b=RVhISJ
        adWpJowoXVL5kXHsMKfP3Fsa0ouw0sduHBPpqb/OU7BTkT7d4gjY57E+Kvelq6Ug
        dKDfPbsoAyVncao0cyGCA+5x/EMnmGNLmHrR9V0nEoQVvgkxqUc9FGZ1RYp8477p
        PHWxsQdWn37KznLBoYmgDrwCfSciFZhFfhLkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ioiuzAQguYI6cJUB77c1kjrjuQYa429v
        WqFYK193ZBJl4RIpJZbQ7TOtQ59cfPAPcYwz+VlewuMpWH7OyXWr/gVXv1r/pM50
        VrxBvAaoSrtCYAuOPTZWjDA5QTlESugTNJAkgP8eDjA0N6/9ORjmmJuoxiWk0YE4
        QAD01i5+R+k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72A94BE05A;
        Fri, 28 Feb 2020 15:17:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99962BE058;
        Fri, 28 Feb 2020 15:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Why does `pull.rebase` default to `false`?
References: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
        <CABPp-BGrwNf9p6Ayu=A4CF9ydww8tQfvzFqFO1rNm-QG55yG6w@mail.gmail.com>
Date:   Fri, 28 Feb 2020 12:17:10 -0800
In-Reply-To: <CABPp-BGrwNf9p6Ayu=A4CF9ydww8tQfvzFqFO1rNm-QG55yG6w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 28 Feb 2020 10:56:34 -0800")
Message-ID: <xmqq8skmeabd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E166ACE-5A67-11EA-A641-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Feb 28, 2020 at 10:17 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> ...
>> I'm sure there are edge cases that explain why the default is `false`,
>> but I'd argue that it is likely a case of the minority concerns
>> becoming an inconvenience for the majority of users.
>>
>> Thanks in advance for any enlightenment!
>
> The default of pull.rebase being false makes a lot of sense for Linus
> or any of his lieutenants, or any one else in an integrator-like
> workflow.
> ...
> We may want to do something similar with pull.rebase (only let it
> succeed if it's a fast-forward by default, otherwise require the user
> to set pull.rebase first?), but I don't want to have to think through
> the details or work on such a transition -- I'm just commenting with
> some thoughts that might help you understand the current state.  And
> others probably have more details than me.

While it is true that it would make no sense for integrators to
rebase (in fact it would be a grave sin for them to do so), I do
not think the choice of the default has much to do with it.

Whether you keep your work on topic branches, or you only work on a
single thing at a time and use master for it, an individual
contributor who is working on a project (be it small or large) can
do 'pull --rebase' on each topic branch to keep up with the updated
upstream, but it quickly becomes unpleansant once the topics start
to get interrelated.  And at that point, leaving your 'master' clean
and only run "pull --ff-only" there, and after doing it once,
rebasing your multiple topics locally on top of the updated upstream
(or your 'master', which is a clean copy of it), would start to make
more sense.  And once you start doing that, the only 'pull' you'd do
would be 'pull --ff-only', and at that point the default value of
pull.rebase no longer matters.

Sarcastically put, setting pull.rebase=true may become a way to
ensure that a newbie stays a newbie who does not learn to juggle
multiple related branches, because only the simplest thing becomes
easier with the setting.



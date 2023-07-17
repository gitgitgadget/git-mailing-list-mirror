Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5491EEB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjGQQhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjGQQhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 12:37:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645A9A9
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 09:37:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F193F1D2E0;
        Mon, 17 Jul 2023 12:37:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=b112jPGJegGV
        YRswV3m65ThMkHyJjELNOy/81BOAwM0=; b=U2r9e++o5oZwD6ArzyWe0WfthZ+y
        sTwnowe30GZL1CHDxvvOTHsyjztwxyUqWmgP9emrov7tNaeRAN4NnvvRS9gdk4R0
        EmLhN6ddU3dT4ATzi9CUouy/fW32x3VCoh7a2QxVr532OhFYyk0KYmR08kTjoNj1
        +oGMWZq8qSheUy0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB3021D2DF;
        Mon, 17 Jul 2023 12:37:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92E781D2DC;
        Mon, 17 Jul 2023 12:37:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     nick <nick@nicholasjohnson.ch>, git@vger.kernel.org
Subject: Re: Git Privacy
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
        <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
        <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
        <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de>
        <xmqqsf9njmc9.fsf@gitster.g>
Date:   Mon, 17 Jul 2023 09:37:45 -0700
In-Reply-To: <xmqqsf9njmc9.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        16 Jul 2023 19:36:22 -0700")
Message-ID: <xmqqedl6ijdy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 42AF4274-24C0-11EE-947A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Not sure why there is no command line option for the latter, hmm.
>
> For two reasons.
>
>  * While using the GIT_AUTHOR_DATE environment variable is perfectly
>    adequate (after all, we did not have the option before Git 1.7.0,
>    released in Feb 2010), overriding the author time with "--date"
>    had a good reason to exist, unlike the committer timestamp.
>
>    Imagine you were relayed somebody else's changes, not via a
>    format that is kosher and acceptable by "git am", but somehow
>    managed to reproduce in your working tree.  If you also have
>    learned when and in which timezone the original author made that
>    change, you'd want to have a way to record it.

The point here is that tweaking the author time has a general
utility that is wider than "I want to use a timestamp that is
disconnected to the reality"---in fact, it is quite the opposite.
The above example is using the option as a tool to record what
actually happened in reality and not about using a fake time at
which nothing related to the resulting commit happened.  That is why
I said that it "has a good reason to exist".

Contrasted to this, the committer timestamp is about when the commit
was created, and there is no need to have an easy access from the
command line like "--date" option does to tweak it [*].  It is
updated to the current time when you "commit --amend" for exactly
the same reason.

> I think the existing two environment variables are very good place
> to draw the line.
> ...
> Needless to say, such a "privacy enhancing `date` command" can be
> used outside the context of Git, too.  My point is that it is not
> within the scope of this project to add an internal implementation
> of such a command and drive that from a command line option or a
> configuration variable.

And I still think this is a reasonable way forward.  We have offered
two environment variables for their use and it is up to them to use
it when driving "git" binary from their environment.  Anything more
is a distraction to this project, I would think.


[Footnote]

 * As long as your system clock is reasonably accurate that does not
   need constant tweaking, that is.  If not, you have a more serious
   problem than tweaking the string on the committer line---none of
   the timestamp based heuristics like "make" not rebuilding things
   unnecessarily would be broken on your system.

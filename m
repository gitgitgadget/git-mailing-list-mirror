Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F8C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E693208FE
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkWCo/pP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbgJMFcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 01:32:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63952 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgJMFcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 01:32:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF0306D2AC;
        Tue, 13 Oct 2020 01:32:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zlQxNA1ZYCSIMg6eR+ESaZRbqYM=; b=CkWCo/
        pPFC9UvbzefhmSlE6EXY+dN7TgVvdQbcarv2ldzlj85awrwUstnmDjxcrcMPFscT
        38QXmcHTZ27Czskgewkzkne5AMufQCPuHYp6d8Xvi1TDsV5t5NP6byKpSuWJ+f3D
        qpjlgEEv6XVm0CNRmywL4TESpcnpASwxK2sPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ObcNwiYprazDYE8Nqy7l5M8flHBZX4cM
        PxC11Bml3Oocc/ZxAqy0lZF1P3MJXjwXz3oB92gYH6YOLbGHWR/Gc5LxfWTlK+b/
        V/rPk/h3q+97Kv6oHQP1bVyJk+RkhnBlkJqpq0pCszo6V2B1pZwhUbMzD2P6odTs
        /r9UMk8YqC8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6BCC6D2AB;
        Tue, 13 Oct 2020 01:32:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45C416D2AA;
        Tue, 13 Oct 2020 01:32:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Deepak Patankar <patankardeepak04@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to Verify the Git Credentials supplied by the User
References: <CABmmNJOGBdEO+AT0_8dSwmFxomFE7A5x354+YgfxiU5N+mOroA@mail.gmail.com>
        <xmqqsgajpcan.fsf@gitster.c.googlers.com>
        <CABmmNJOCJEpGwz3hxYsKO=xwx_rrVv5_QcZuS_=gUZH9bM0G2A@mail.gmail.com>
        <CABmmNJMzs=BOYEv_pUaA3NbNkn_HhyOj_VoYeWSKzz138OCZkQ@mail.gmail.com>
Date:   Mon, 12 Oct 2020 22:32:13 -0700
In-Reply-To: <CABmmNJMzs=BOYEv_pUaA3NbNkn_HhyOj_VoYeWSKzz138OCZkQ@mail.gmail.com>
        (Deepak Patankar's message of "Tue, 13 Oct 2020 10:54:15 +0530")
Message-ID: <xmqqsgailmhu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73314BBA-0D15-11EB-8B79-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Deepak Patankar <patankardeepak04@gmail.com> writes:

> I can use the "ls-remote", "push --dry-run" command you suggested, but
> I have a use case which I don't know how to solve.
> The above commands require a repository. In our application, the user
> can give the following details
>
> Git Details:
>    Account URL:  https://github.com/OpenPrinting
>    UserName: deepakpatankar
>    password: ***********
>
> In this case, we don't know the repo name. At this step, I just know
> the account and the credentials of the user, later on
> the user will provide me with the repo name to which he wants to sync his file.
>
> Since I don't know the repository, I cannot do "git fetch" or "git
> push --dry-run". Can I check this credentials with some
> logic or git commands?

You'd have to go outside Git, as our transport layer is only about
talking with existing repositories.  You cannot even create a new 
repository using Git native methods.

You may need to find a method that works with GitHub account (note
that I am not even using the word repository here, instead saying
"account") and such a method would likely have to involve GitHub
specific API, but it probably would not work with other hosting
providers.

I also would imagine that even at GitHub, one may want to use
different authentication info depending on which repository one
accesses, so the "there is a single User with a password at this
hosting site" data model might turn out to be insufficient, but
that is outside the scope of Git proper.



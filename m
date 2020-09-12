Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD677C433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 00:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909FF221F0
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 00:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xd9Kmqsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgILAwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 20:52:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55100 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgILAwG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 20:52:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBB1EEE88F;
        Fri, 11 Sep 2020 20:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SjDQ4WsxR7GzOhQNznZHzbRJC54=; b=Xd9Kmq
        sanoskaIcy1v/y5BjxkVdWNzvbAc0Ulgo1JSu+emvS4dnkczCl18GE6HC4f75S2u
        6v7pP2aeJJ21/koChgEJk/E289o7yXLx9/GJulodbQOSrMjXbBxA1hPb8eQ3/y4q
        dFrHLWI+y9cXG8aABF5tgv58O7y8qL2oF4aTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SLyi5cA9QvTTpERUxcvcgHIPTewlJqHW
        WUPVevL7/xFlcqgqypojkX9UN8rUPd7QVGLPVsfyqJXYZo0vFiJpIukCcUqKwnd0
        l7SE8Szd9GrJEUh4d/SQFObxY6PcLWXeL4KEMONy66YXJULFZFhg+L5Do0qJTJtj
        IVCCEaHhqVs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E453CEE88E;
        Fri, 11 Sep 2020 20:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 377F6EE88B;
        Fri, 11 Sep 2020 20:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Tom Rutherford <tmrutherford@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, chris.torek@gmail.com
Subject: Re: post-checkout hook aborts rebase
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
        <xmqq7dtlt080.fsf@gitster.c.googlers.com>
        <xmqq3649szs8.fsf@gitster.c.googlers.com>
        <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
        <dc9b58c4-96f1-2270-406b-781f8d0a4f22@gmail.com>
        <99BE0DDB-C248-4781-A715-2517A977372B@gmail.com>
Date:   Fri, 11 Sep 2020 17:51:57 -0700
In-Reply-To: <99BE0DDB-C248-4781-A715-2517A977372B@gmail.com> (Philippe
        Blain's message of "Fri, 11 Sep 2020 16:25:28 -0400")
Message-ID: <xmqqeen7n7f6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29D4A62E-F492-11EA-BFFF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> On a slightly related note, I noticed that that part of the documentation is not 100% exact. I states:
> "Further, both backends only call the post-checkout hook with the starting point commit of the rebase, 
> not the intermediate commits nor the final commit."
>
> but I noticed that in an interactive rebase, the post-checkout hook *is* called for commits
> marked as "edit", when the rebase stops to edit them (I haven't checked if it's called when the rebase stops
> for other reasons, like conflicts.)
>
> Maybe we should tweak the wording of the doc  ?

Yeah, we should do either that, or fix the code and make it not to
call the post-checkout hook so aggressively, as suggested during the
discussion.

Thanks.




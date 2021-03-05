Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF78FC43381
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DA7650AC
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCERxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:53:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63577 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhCERxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:53:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6AD511F6DB;
        Fri,  5 Mar 2021 12:53:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZJtwGP4frXHunJJhR3lZB/bOKvA=; b=lBFByk
        cwhnKRR40L6aIsscsmwucWujPIglw4x5uv9zJJhdbX3KSUp1MJfVPTk812dkq7nO
        og7x2Hmbod7aXrl5IHdSkscI8dazatMNxKLiw9KQZbumxu9aAiSVzHvnVPGppXTw
        y5DO1SBseyFfXnuqweVq+m8CfeHgFqFDLtgIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NV9d6xibSe2MIrW8Y3rRXPm3m65bteir
        4J/mSDwLwkYX7Eh5QLcNccn2rns/6n3WGHXzkHBFJyVgpoikAQjSU8DwUNLs3fHA
        kC6OmQx6oaO67zxaiCqqFx6+btYyUUl1mcfgVqDaEI/g5szB85VOd5mTSKv8kHZ+
        Rn782s/x3tQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF8F511F6DA;
        Fri,  5 Mar 2021 12:53:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EFD6B11F6D3;
        Fri,  5 Mar 2021 12:53:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
        <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
        <YED1DmLWd+ciySNa@coredump.intra.peff.net>
        <xmqqa6riejyp.fsf@gitster.c.googlers.com>
        <xmqqtupqbij4.fsf@gitster.c.googlers.com>
        <YEHzmIOYgRtI1Ak1@coredump.intra.peff.net>
        <YEH5AUxgFxWTxb6u@coredump.intra.peff.net>
        <CAPx1GvfXO9Xd+9Fqp-M13WUUNWVtemWm__O4N5WUk7=s4up1Gg@mail.gmail.com>
        <449a73be-52e3-8363-b771-959f8114e3a0@jeffhostetler.com>
Date:   Fri, 05 Mar 2021 09:53:03 -0800
In-Reply-To: <449a73be-52e3-8363-b771-959f8114e3a0@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 5 Mar 2021 12:33:11 -0500")
Message-ID: <xmqqczwdbi80.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A38A2EA8-7DDB-11EB-A46A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> The original problem was that chdir() is not safe in a multi-threaded
> process because one thread calling chdir() will affect any concurrent
> file operations (open(), mkdir(), etc.) that use relative paths.
>
> I think Adding a fork() at this layer would just create new types of
> problems.  For example, if another thread was concurrently writing to
> a socket while we were setting up this new socket, we would suddenly
> have 1 thread in each process now writing to that socket and the
> receiver would get a mixture of output from both processes.  Right?

cf. https://pubs.opengroup.org/onlinepubs/9699919799/functions/fork.html

The fork() function shall create a new process. The new process
(child process) shall be an exact copy of the calling process
(parent process) except as detailed below:

...

 * A process shall be created with a single thread. If a
   multi-threaded process calls fork(), the new process shall
   contain a replica of the calling thread and its entire address
   space, possibly including the states of mutexes and other
   resources. Consequently, to avoid errors, the child process may
   only execute async-signal-safe operations until such time as one
   of the exec functions is called.

So, probably not.

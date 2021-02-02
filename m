Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65472C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED1A64ECB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhBBF0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:26:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50711 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhBBF0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 00:26:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D872F10A99D;
        Tue,  2 Feb 2021 00:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nGaDFxtDtsIliXEr45v3bcJVjsY=; b=Q6taR9
        Qhoy+pk8pVMBY43EgyrXuUqDhdAH5xj4DRpqlQzawZPssOLDgTe7johhHqFRzaxi
        JzNBLiK1He2SELwaiwuPQA7bGfzqiT1Xd6hXzX8qavdXsLa/YqM1wezIH3VCX9Wk
        IN9oY+zxJAlXJgxiUplqLvKM4pqCSJaLuxKuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bPNpcjqtxtmYmoUk8W9FRHO5Lsxu+zhe
        lCb36FS3i71bIuCp9zVy8C/JjVkiZOzY5Q5eEtHMZcbeOxgotKyVq6wT8ZEL6Y3m
        IutV66PgcLBsJ5+qHUxtpbFvKt8ZlzvO3VXR3luTb1FppzAD/IPhcGQoGPrr9uuh
        aYWLBVDqT98=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D110810A99C;
        Tue,  2 Feb 2021 00:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1318610A98A;
        Tue,  2 Feb 2021 00:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
        <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
        <87czxjomn8.fsf@evledraar.gmail.com>
        <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
        <87wnvrefbv.fsf@evledraar.gmail.com>
        <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
        <87tuqvdy1b.fsf@evledraar.gmail.com>
        <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
Date:   Mon, 01 Feb 2021 21:25:52 -0800
In-Reply-To: <xmqqo8h3hybf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 01 Feb 2021 20:45:56 -0800")
Message-ID: <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ED5F278-6517-11EB-95F5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sorry, but you still have lost me---I do not see if/why we even care
> about atexit codepath.  As far as the end users are concered, they
> are running "git" and observing the exit code from "git".  There,
> reporting that "git" was killed by SIGPIPE, instead of exiting
> normally, is not something they want to hear about after quitting
> their pager, and that is why the signal reception codepath matters.

(something I noticed that I left unsaid...)

On the other hand, "git" spawns not just pager but other
subprocesses (e.g. "hooks"), and it is entirely up to us what to do
with the exit code from them.  When we care about making an external
effect (e.g. post-$action hooks that are run for their side effects),
we can ignore their exit status just fine.

And I do not see why the "we waited before leaving, and noticed the
pager exited with non-zero status" that we could notice in the
atexit codepath has to be so special.  We _could_ (modulo the "exit
there is not portable" you noted) make our exit status reflect that,
but I do not think it is all that important a "failure" (as opposed
to, say, we tried to show a commit message but failed to recode it
into utf-8, or we tried to spawn the pager but failed to start a
process) to clobber _our_ exit status with pager's exit status.

So...


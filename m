Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8D621F4C0
	for <e@80x24.org>; Mon, 11 Nov 2019 02:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfKKCXE (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 21:23:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55718 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKKCXE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 21:23:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B4753DA48;
        Sun, 10 Nov 2019 21:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t2ha5B3+O0Gc
        2dKvgtY1yrzg2vc=; b=RXR7Ct6EegiUqA56+5eUJcrn0P54vE0qabYa2z9S6yc4
        FJmZKAEH2hdBtM4pAdP/zvhedl8pKEZJ41vXcSl6d2FXsGhxzKOOYzL8bcnqHULb
        Cdpy1F63w2MH1+Krxes6bq3EXeTZtHP7LDFWmNcjNEFfY4Z5Ylb4CnjBe9ylk9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=feUTIw
        rodLgcovlFbUcw/aChvqZ0Dno4wJbf+SWVWQ3rJMNEkYSyc365GshOdDPq+LL/cG
        dDaDmQAYgF0WtLlqggHz9ZZw8BzlsymFPOTnhlZzdizitEx75Zz2sAd9E8uQnKDz
        BxsI5VDVZ3pZnrftYSuxY9O/Kuq4Y59n8uPTU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 740B83DA47;
        Sun, 10 Nov 2019 21:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7AB93DA46;
        Sun, 10 Nov 2019 21:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?R=C3=A9da?= Housni Alaoui <reda.housnialaoui@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Sometimes unable to lock the index during pre-commit hook
References: <CAE0unxyojHVWP4aM3C+DdMYORmcoCuq-0wwLGjE8ok6dLj_E8w@mail.gmail.com>
        <xmqqpni0jioq.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 11 Nov 2019 11:23:00 +0900
In-Reply-To: <xmqqpni0jioq.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 10 Nov 2019 16:26:29 +0900")
Message-ID: <xmqqtv7bi22j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F6C9D02-042A-11EA-B518-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> R=C3=A9da Housni Alaoui <reda.housnialaoui@gmail.com> writes:
>
>> Are pre-commit hooks expected to be able to manipulate the index?
>
> Hooks are described in githooks(5) manual pages; we may want to
> clarify what is not allowed, but back when most of the entries were
> written, the stance was that anything that is not explicitly allowed
> there is forbidden.
>
> In general, a pre-<something> hook is a way to inspect (i.e. look
> but not touch) what is proposed to be done and veto it by exiting
> with non-zero.  It is not expected to change the state of the
> repository in any way.
>
> The code does not necessarily enforce it, because it is costly to
> take a snapshot of everything (including the index, the working tree
> files, the files that are untracked, the objects in the object
> database, etc.) before calling a hook and ensure that the hook did
> not touch anything.

Actually, we do accomodate for the possibility that pre-commit hook
may muck with the on-disk index there days, even though the original
design intention was not to allow random changes there (see ll 960-
in the same file).

So it seems that if we hold the lock necessary to refresh the index
for too long, it may be an option to move the code that unlocks to
somewhere earlier in the callchain.  prepare_index() however returns
different on-disk index file (the real thing when making an as-is
commit, and a temporary one otherwise), and the unlocking rule may
be different, so some restructuring of the code might become
necessary before that can be done.  I dunno.

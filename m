Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD24C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC382087C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y6dMZeML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgH0R2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:28:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50213 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0R2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:28:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15529F5519;
        Thu, 27 Aug 2020 13:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+DPMgaZ1sOeVfplc1oVi/L5z56w=; b=Y6dMZe
        MLD9C6BinLJZ5zhAw+1WKHEIqIsNXcyR/tmwsShhNgY5TWRg0tv0LZXosFQnJpT9
        wxG+nnxc6hzko4i8ZPZBK3WPL/oN+ZBIumZMjLinE7F6hjd6tDpqjt5YQwzl+XF2
        cHz1xH07H+Ssx78lTWTVzg4prv4CIjEK2dtR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cBXE6ZgPzxh316fEeKV7JvdrT9OdqcxV
        CR/iewKwZwM0ztcvysh+7knSDrb46zY5MALSJfWw/iIu4R8ej7TNdI0aLTlF6C/K
        ApG4oMoHaySK/9Hjr2h3I/PrQUXyO3310xy3+c7fydtoq9bBNzMsnr/AUBgNCiPt
        8BdEEt/NW2E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EB80F5518;
        Thu, 27 Aug 2020 13:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DDBBF5515;
        Thu, 27 Aug 2020 13:28:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Tom Rutherford <tmrutherford@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: post-checkout hook aborts rebase
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
        <xmqq7dtlt080.fsf@gitster.c.googlers.com>
        <xmqq3649szs8.fsf@gitster.c.googlers.com>
        <CABPp-BF=ydfHE2XqN4L9qfeAg3AZL9yNJhs4rykGj0baT1Eh6g@mail.gmail.com>
Date:   Thu, 27 Aug 2020 10:27:58 -0700
In-Reply-To: <CABPp-BF=ydfHE2XqN4L9qfeAg3AZL9yNJhs4rykGj0baT1Eh6g@mail.gmail.com>
        (Elijah Newren's message of "Thu, 27 Aug 2020 09:27:52 -0700")
Message-ID: <xmqqd03cq9r5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A79B9176-E88A-11EA-BE90-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Aug 26, 2020 at 5:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > ...  If "git rebase" or whatever
>> > command wanted to place files and the index into some state by using
>> > "git checkout" command, and if the post-checkout hook mucked with
>> > the state in such a way that contradicts with what the "git rebase"
>> > command wanted them to be in, it is not surprising the hook's behavior
>> > broke "git rebase"'s operation.
>>
>> Having said all that, I actually think that "rebase" shouldn't be
>> invoking "git checkout" (and its equivalent) internally when
>> switching to a specific version, in such a way that it would trigger
>> any end-user specified hooks and allow them to muck with the working
>> tree and the index state.
>>
>> I haven't checked the actual implementation of "git rebase" for
>> quite some time to be sure, but we have lower-level plumbing
>> commands that are not affected by the end-user hooks for exactly
>> that kind of "build higher-level commands by synthesis of
>> lower-level machinery", and it is very possible that what we are
>> looking at is actually a bug that needs to be fixed.  I dunno.
>>
>> Thanks.
>
> Yes, and I think we should also make rebase stop invoking "git commit" too.

Note that I didn't say we should make it stop invoking "git
checkout".

We could invent a mechanism that disables all the hook invocations
and other customizations [*1*] (done e.g. via the configuration
variables) for internal use of the Porcelain commands, and use it
when "rebase" invokes Porcelains like "checkout", "commit" as its
implementation detail, for example (some "invocations" I think
bypass the run_command() inteface and instead done by directly
calling the implementation detail of "checkout" and "commit", but
the principles are the same).

[Footnote]

*1* of course, it becomes a balancing act to decide what kind of
    customizations are OK to honor under such a mode.

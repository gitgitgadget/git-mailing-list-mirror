Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9FC352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 05:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B9820873
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 05:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="naUSN3VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgBMFEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:04:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50116 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgBMFEh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 00:04:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DC0BA82CB;
        Thu, 13 Feb 2020 00:04:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v2bg1mAoYxeXe8L93yqHXVchUyg=; b=naUSN3
        VH6YjtAo6kA3VOTgZrhcqe8K1RW86xXT7eUZogVwZi6zGvuqGykYIzs9W1ckggKc
        WSfO0Vk/uXgWqG46p6XI4Bgm+8nlcYBOPmRkMnU5cgzHx5EjsOYPszV2vx+aDFcx
        dm9b54WkQbNkqUEgaReH/6w7q5aHGdueMcavM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dSlXAvj3mWV+xB6ZcUXXxxMrtnxzzJHR
        ui3v4T/grmbjwBTP9Y5ncJRNs8cWeMX+y7/6dqDya6ULUoAKbq3DepHQ8ct3oRjB
        Cz4LnaLGSf/PAXqP0zeiptxJUaYWCrn7YBn2+FLmLyKrHjTZmYXckJg60YxpA/Pa
        DwZzN79t3rU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 164F6A82CA;
        Thu, 13 Feb 2020 00:04:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4657EA82C9;
        Thu, 13 Feb 2020 00:04:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] [RFC PATCH] stash save/push: add --index-only option
References: <20200212235033.782656-1-eantoranz@gmail.com>
        <CAOc6etbkMJf9qSNMU4fD4KeHE6NuMRUuQf_cBos_oxuYwaaeAA@mail.gmail.com>
Date:   Wed, 12 Feb 2020 21:04:30 -0800
In-Reply-To: <CAOc6etbkMJf9qSNMU4fD4KeHE6NuMRUuQf_cBos_oxuYwaaeAA@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Wed, 12 Feb 2020 17:52:59
        -0600")
Message-ID: <xmqqblq3t6w1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 522F3384-4E1E-11EA-AA6F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> On Wed, Feb 12, 2020 at 5:50 PM Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>>
>> Allow git-stash to save only the content of what's in staging area.
>> No working tree files (unstaged or untracked) will be added
>> to the stash nor will be modified then the opreration finishes.
>>
>
> Sorry for the double tag. This is not fully completed code. Wanted to
> know if the community thinks it's something worth developing and if
> I'm heading in the right direction in terms of the code that I'm
> hitting.

I am not sure if you explained how useful the "feature" being
proposed is, which is a very important skill to exercise to entice
readers to start reading and helping your code.

Why is it useful to be able to do this?  It is unclear at least to
me.

By the way, per "git help cli", the name for this new option that is
more in line with the rest of the system would be "--cached"; it
would tell Git to work only on the data in the index (as opposed to
the working tree files).
.


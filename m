Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41918C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8DA64EA4
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhBHW3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:29:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64368 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhBHW3J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 17:29:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FA48B0F5D;
        Mon,  8 Feb 2021 17:28:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=InE1BGv/vMookLlBc2HWgSgzkgY=; b=He7Srr
        C574n4zAIsOQ++hu37zP0fMC4MPHEM8xpqP24HxwBhr5RXL/oHrJSKQoQYogYlWN
        eZUZvvM3YMWaFW2ETkolZz1AlIGaaynM+vxawgy9SsRsifKZhKeYTST5cllz7fQx
        riNcOF55KY9dEOzTn2QvWrwEe2H0A64etgmLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oOU/wSAhu+rokVpki5aWDTsnJm546xQN
        DPW6bgbpbkXOFtXWO8yPfST3PGtQe79/tIUBrdFYyn96ZoBNouxW1pLIkH8RsI5E
        F7NUZoKvWnlHCxuB9nj7PMfDFeyKLca4IopL+jihCE4bdp7EVDepH1u9UFH9t9kb
        vGh5qefMCPk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15BC3B0F5C;
        Mon,  8 Feb 2021 17:28:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6ED27B0F54;
        Mon,  8 Feb 2021 17:28:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v8 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1612557937.git.jonathantanmy@google.com>
        <xmqqmtwh9ghf.fsf@gitster.c.googlers.com>
Date:   Mon, 08 Feb 2021 14:28:20 -0800
In-Reply-To: <xmqqmtwh9ghf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 06 Feb 2021 10:51:56 -0800")
Message-ID: <xmqqczxa42kb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3348A3A-6A5C-11EB-A6B8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Peff sent a review (which I don't see in lore.kernel.org/git, but I do
>> see it in my inbox); here's v8 in response to that.
>>
>> As you can see from the range-diff, there are just minor changes to v7
>> (wording in documentation and a memory leak fix).
>>
>> Jonathan Tan (3):
>>   ls-refs: report unborn targets of symrefs
>>   connect, transport: encapsulate arg in struct
>>   clone: respect remote unborn HEAD
>
> Queued and pushed out, but with vger.kernel.org seem to be delaying
> messages randomly, I'll hold off for a few days before merging them
> down to 'next'.  To me this version looks good (at least good enough
> to cook in 'next' and details can be tweaked incrementally).

A few days have passed; let's merge it to 'next'.

Thanks.

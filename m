Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E5C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C6C239EF
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbhAUWT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 17:19:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51022 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbhAUWTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 17:19:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B1281069D7;
        Thu, 21 Jan 2021 17:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vWCa1+/eFaRFizuBWdKmY6SKEZY=; b=g4ye9q
        ZPljSph4kYqaErH1voZT4ruzEH9+3V7y6qypoE46ek6Ym4dff2J/S+bxXA/YU89U
        t7CKGvGifgI03+WFcsWV+gRY9kyYzquz6Abca+Ki1QTGGkS973hQvjhbf+Wt4tQf
        SttLlo/f9RZni6HdXuR4BpDElUUWRrwUUS9Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XHmgVWQzzQM1h3d2sMF2fUocjZBMJ6Zj
        pIiLFCLkaaiKwI/Vkj3gcOsQ1TIWXTzK6ep3MJHowLRRTocCO9r2L6wi8jvYz+oj
        0k+NJQ4zbACQFw4vi9KSq8QmbDrOEFC494mykrUygXDm1D53417DKFgZVPWWbwcB
        qaRRnvzSwI8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 739141069D6;
        Thu, 21 Jan 2021 17:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 794B91069D0;
        Thu, 21 Jan 2021 17:18:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 6/7] worktree: teach `list` to annotate prunable
 worktree
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
        <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
        <20210119212739.77882-7-rafaeloliveira.cs@gmail.com>
        <xmqqo8hjc6jx.fsf@gitster.c.googlers.com>
        <gohp6kr1me1g3r.fsf@gmail.com>
Date:   Thu, 21 Jan 2021 14:18:29 -0800
In-Reply-To: <gohp6kr1me1g3r.fsf@gmail.com> (Rafael Silva's message of "Thu,
        21 Jan 2021 16:09:49 +0100")
Message-ID: <xmqqsg6uaq8a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 981FB34C-5C36-11EB-A0AD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> Junio C Hamano writes:
>
>> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
>>
>>>  Documentation/git-worktree.txt | 26 ++++++++++++++++++++++++--
>>>  builtin/worktree.c             | 10 ++++++++++
>>>  builtin/worktree.cc            |  0
>>>  t/t2402-worktree-list.sh       | 32 ++++++++++++++++++++++++++++++++
>>>  4 files changed, 66 insertions(+), 2 deletions(-)
>>>  create mode 100644 builtin/worktree.cc
>>
>> What's the h*ck is that .cc file doing ;-)
>
> Oops. I accidentally created and committed this file.
>
> Re-rolling ...
>
> Side note (joke): I wasn't trying to add C++ into Git codebase :)

Yeah, I know ;-)  I've already removed the empty file in my copy,
but it seems you are getting other useful input, so it probably is a
good idea to remove it on your end, too.

Thanks.

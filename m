Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C83CC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA0821D91
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xdhvqR+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIJVJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:09:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51283 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgIJVIY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 17:08:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9AA0E0F2A;
        Thu, 10 Sep 2020 17:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WYfmyl+/YIU8JX0Or6b89TWkU8k=; b=xdhvqR
        +wh1R9bhxgemceVpoXmqylpQA2JL17YVFkQIHrWOZUgWTF43S0PJXVblAfCj6brs
        jGdQ8HmszVZ24Ne7XIyNIK8jAImGkeUjOHzJOBlzpwrKxq32dbUgPWAZsxD2c1Af
        8zqCnOLRU3iIj0czNxn7pWaXrQ1PVNptn3RRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SfrbHvPuadpRqByXKT7NHYO/ubOzmKd0
        P2EZarYRgW39eqEyJS8IACmadqXXIGRi7zgAy/i3KEQlduQVw+AAfezpo7dM3s4f
        03PYMcD1LvoVBiLTDnrClaO5AqpSE2XhGOhPW3S1injPp/2sXEGH7wU37qz9BmbG
        egBSa0WrpS8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2401E0F27;
        Thu, 10 Sep 2020 17:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03004E0F24;
        Thu, 10 Sep 2020 17:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] worktree: simplify search for unique worktree
References: <cover.1599762679.git.martin.agren@gmail.com>
        <8383c246f8c23e61dedd69d6e69c72d51fd6b469.1599762679.git.martin.agren@gmail.com>
        <CAPig+cT_VvOiKBCC=E_P0R8SXkoWPVUxxOOLovOmr8N377YNdQ@mail.gmail.com>
        <CAN0heSrUWiZ_xar3G5rZG-c=8OVp5-eByS6rMXOw9wfTA8kmbA@mail.gmail.com>
        <CAPig+cQ871p8+oQdBBY=ebDdjDWfa5NvEMroitEmk4Db8DfLvA@mail.gmail.com>
Date:   Thu, 10 Sep 2020 14:08:08 -0700
In-Reply-To: <CAPig+cQ871p8+oQdBBY=ebDdjDWfa5NvEMroitEmk4Db8DfLvA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 10 Sep 2020 16:01:57 -0400")
Message-ID: <xmqq363ppcg7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAFB5C04-F3A9-11EA-A6C4-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Thanks for commenting. I found the original trickier than it had to be.
>> It spreads out the logic in several places and is careful to short-cut
>> the loop. My first thought was "why doesn't this just use the standard
>> form?". But I'm open to the idea that it might be a fairly personal
>> standard form... If there's any risk that someone else comes along and
>> simplifies this to use a `nr_found` variable, then maybe file this under
>> code churning?
>
> Maybe. Dunno. Even with the suggested function comment, I still find
> that the revised code has a higher cognitive load because the reader
> has to remember or figure out mentally what `found` contains by the
> `return found;` at the end of the function.

Judging from the phrase "standard form", I have a feeling that
Martin thinks that the updated code is more intuitive (i.e. "we see
another one while keeping the one we already found, so we know there
is no unique answer").  I do not claim that would be the standard way
and using a counter clamped to 2 is substandard, but I find the code
more readable with the patch than the original.

Even though it helps somewhat that the counter is named "nr_found"
and not "nr_match", I found it a bit awkward that the counter in the
original pretends to count all the answers, yet does not really
count all of them and stops at 2.

I agree with Martin that this would probably be subjective.

Thanks.



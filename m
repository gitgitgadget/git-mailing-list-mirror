Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFE5C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhLTT4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:56:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59652 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhLTT4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:56:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0EF816F7D9;
        Mon, 20 Dec 2021 14:56:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lI6DbpFbd8+jbprF2V6qy6WdjcmNzSbJ/0/Ybf
        2Z5c0=; b=NDGCCK9WP/dlE7UCInG/9yyXaHhm9UaI9tf5Q03aQ/6CwxvNXUhTQ9
        sLNwZwO9AKetpovpyy5uWjWsarNU02u1dQi32SI1rr03Nu+tacgGICFZx66OWOhz
        M7MG47/1cT7alJzM7Ye6diF27BYw/VkFNHOkTdrQfmnCxZuWuF2hI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA71116F7D8;
        Mon, 20 Dec 2021 14:56:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 593B016F7D6;
        Mon, 20 Dec 2021 14:56:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] builtin/fetch: skip unnecessary tasks when using
 --negotiate-only
References: <20211207192925.67680-1-chooglen@google.com>
        <20211217000235.68996-1-chooglen@google.com>
        <xmqqilvm24bb.fsf@gitster.g>
        <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 20 Dec 2021 11:56:30 -0800
In-Reply-To: <kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 20 Dec 2021 11:37:07 -0800")
Message-ID: <xmqq4k73vymp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED4981EC-61CE-11EC-9823-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> By the way, do not move the check about the number of negotiation
>> tips from the original location.  That check, or its location, have
>> nothing to do with what you want to do in this patch, which is "do
>> not gc or update the graph file if we are not fetching".  It is
>> better to leave unrelated changes out of the patch.
>
> Ah, I see that it's not easy to tell whether or not the behavior is
> correct after that line is moved. I'll avoid doing this in the future.
>
> I still think that it is cleaner to move the negotiation_tip.nr check.
> Should I do this in a follow-up patch?

I am not seeing what makes it cleaner to have it early or at the
current position, but with "It is cleaner to do tip.nr check early
because ...", in a separate patch, it may become obvious.  But let's
not do it in this patch.

> I hope Jonathan can chime in to confirm whether or not users want/need
> to invoke "--negotiate-only".

Yeah, I knew that this was "internal implementation detail", but
then perhaps we know that a sane developer who knows what they are
doing will never write combination of it with recurse-submodule
option?  If so, we'd catch a notice developer breaking the system by
having a sanity check by detecting it as an error, no?

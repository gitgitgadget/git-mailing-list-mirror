Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EEAC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3722250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jh0NGY0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgHEWLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:11:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50528 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgHEWLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:11:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDF90E01C7;
        Wed,  5 Aug 2020 18:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qOw6U/zQsCx/UO7nDb8ZximbHMM=; b=jh0NGY
        0XvmA1UZ/gLvE810RVJEoO6uzl5oD7xhWCilB+35erUMKnW3+LN1FnDVV2kSzAUA
        1GoDeBP9dfPq6xQzKasw+iY+updv1d4GkCsKkyftKdYJNGRG6hbOOUdSG+CC0cLz
        wBO2EMoYrkkUwuoSFarbPs7lYd6/wX8xbmJxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZwIB3XCS126SqiTPt9vYjP3ne+/hzVP/
        syQ7b/JHjSCNTyOV7mhbDjaa2MLb0AP+pttjYpPKf+TiMADGowT+X15CB6681wPi
        9iVskefqjCa0aJQlk9pqH6tKUE6CXNtOZ2GhrfVoY83SMbLDVyWRaIslrvUie1pD
        +rYWJYepk0I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6A8BE01C5;
        Wed,  5 Aug 2020 18:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 893D3E01C4;
        Wed,  5 Aug 2020 18:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 2/7] fetch-pack: allow NULL negotiator->known_common
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1596590295.git.jonathantanmy@google.com>
        <401227c2220b6b45d80e21b52e29b6821ca139f9.1596590295.git.jonathantanmy@google.com>
        <xmqqk0yconyw.fsf@gitster.c.googlers.com>
Date:   Wed, 05 Aug 2020 15:11:05 -0700
In-Reply-To: <xmqqk0yconyw.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Aug 2020 13:08:07 -0700")
Message-ID: <xmqqpn84n3pi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FB4ACBA-D768-11EA-9B8D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> In a subsequent patch, a null fetch negotiator will be introduced. This
>> negotiator, among other things, will not need any information about
>> common objects and will have a NULL known_common. Teach fetch-pack to
>> allow this.
>
> Hmph, both the default and the skipping negotiator seem to put NULL
> in known_common and add_tip when its next() method is called.  Also
> they clear known_common to NULL after add_tip is called even once.
>
> So, how have we survived so far without this patch to "allow this
> (i.e.  known_common method to be NULL)"?  Is there something that
> makes sure a negotiator never gets called from this function after
> its .next or .add_tip method is called?
>
> Puzzled.  Or is this merely an optimization?  If so, it's not like
> the change "allows this", but it starts to take advantage of it in
> some way.
>
> 	... goes and looks at mark_complete_and_common_ref()
>
> The function seems to have an unconditional call to ->known_common(),
> so anybody passing a negotiator whose known_common is NULL would
> already be segfaulting, so this does not appear to be an optimization
> but necessary to keep the code from crashing.  I cannot quite tell
> if it is avoiding unnecessary work, or sweeping crashes under the
> rug, though.  
>
> Is the untold assumption that mark_complete_and_common_ref() will
> never be called after either mark_tips() or find_common() have been
> called?

Shot in the dark.  Perhaps clearing of .add_tip and .known_common in
the .next method was done to catch a wrong calling sequence where
mark_complete_and_common_ref() gets called after mark_tips() and/or
find_common() have by forcing the code to segfault?  If so, this
patch removes the safety and we may want to add an equivalent safety
logic.  Perhaps by adding a state field in the negotiator instance
to record that mark_tips() and/or find_common() have been used and
call a BUG() if mark_complete_and_common_ref() gets called after that,
if enforcing such an invariant was the original reason why these
fields were cleared.

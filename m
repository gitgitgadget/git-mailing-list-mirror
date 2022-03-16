Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D5C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 22:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352432AbiCPWHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbiCPWHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 18:07:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174ADC30
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 15:06:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA5A417830A;
        Wed, 16 Mar 2022 18:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4qhMcGJ8QESfl82hyyPJNiQsXPajzpOZNOC9D9
        iDWs4=; b=SyhnRdf08u0jt1RrCP8qxGM+El0uQgVRFcwEv627QsbiwC3c1KEtr4
        CaHA/nQA2PRFNSb6lNtmfaUaN2hIG+a4ToTTZoohzGjqSrTjEfylmEfeXtBKeh01
        iayKWMw6OxJjigKDQhkXLFpNOMvH4AXiKKadeN/eXuYIFluBqEK2Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2EF5178306;
        Wed, 16 Mar 2022 18:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29B60178304;
        Wed, 16 Mar 2022 18:06:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220304005757.70107-1-chooglen@google.com>
        <20220308001433.94995-1-chooglen@google.com>
        <xmqqr17dp8s9.fsf@gitster.g>
        <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqfsnrkkhd.fsf@gitster.g>
        <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq4k46nae4.fsf@gitster.g>
        <kl6lzgly4vz3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6la6dplfts.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 16 Mar 2022 15:06:12 -0700
In-Reply-To: <kl6la6dplfts.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 16 Mar 2022 14:58:55 -0700")
Message-ID: <xmqqfsnhk0x7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B20F8F6-A575-11EC-8991-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Glen Choo <chooglen@google.com> writes:
>>>
>>>> To clarify, does this opinion of "don't use config values that aren't
>>>> copied into .git/config" extend to in-tree .gitmodules? Prior to this
>>>> series, we always read the in-tree .gitmodules to get the config - the
>>>> user does not need to copy the settings to .git/config, but we don't
>>>> pick a commit to read .gitmodules from.
>>>
>>> I think we do, but I also think it was a huge mistake to allow
>>> repository data to directly affect the behaviour of local checkout.
>>
>> I'm inclined to agree.
>>
>>> Fixing that is most likely outside the scope of this series, though.
>>
>> Agree. Thanks!
>
> I thought that this would have been the end of the discussion, but after
> reading <xmqqa6dpllmc.fsf@gitster.g>, I guess I had the wrong impression
> (oops).
>
> If I am reading everything correctly, we both agree that it's not
> good to read _any_ config values from .gitmodules (even if it's
> in-tree), and that we should clean it up outside of this topic. So for
> this topic to be merged into 'next', is it enough to say that I will fix
> this behavior in a follow up topic?

At least we should remember that is something to be fixed.  It may
not be you personally who addresses that issue, though ;-)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D393CC43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957C961029
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDTSrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 14:47:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57538 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhDTSry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09FD613646A;
        Tue, 20 Apr 2021 14:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0BqRDogos8YmnN0VVwv1YksimmQ=; b=ENOvXH
        XphFZYniYEDqugdjFskHP71SA1IR8imdkgajlEf0T5f36nYQEtgDD9b6e5N392jS
        iaVGUcAt1eAWkD2JZMrPileDq8zRtyDUelfqrZF8NqJEQF8YS2bdqHi8Grzzb2/B
        y0NvwvsfE9ZjxrR+sK6HI3AXSfIro34TOUdnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D53RL+XZUwm2dxvLlMQK+3ZXOUYAhTjy
        c49OOSJzMtp+tKaD5TtTasdWtva6JY8x1//U7xGdhC/siVozqi1KiOY5fPl/emJt
        6ROovThAApf/MfIbb8b3TQRLhaVjJc3amFXS6myf4RsXK1ExLaOlhWSu2FkjCF+i
        cI1lkhXujZk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02038136469;
        Tue, 20 Apr 2021 14:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 22282136468;
        Tue, 20 Apr 2021 14:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 01/28] refs: ref_iterator_peel returns boolean,
 rather than peel_status
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
        <8103a80394aefdd4e8b5061dfbb6a6199fe5fcae.1618832276.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 11:47:18 -0700
In-Reply-To: <8103a80394aefdd4e8b5061dfbb6a6199fe5fcae.1618832276.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        11:37:29 +0000")
Message-ID: <xmqq35vk7pzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D62C1C9E-A208-11EB-AE89-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Before, the cached ref_iterator would return peel_object() output directly. This
> led to spurious differences in the GIT_TRACE_REFS output, depending on the ref
> storage backend active.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c               | 2 +-
>  refs/ref-cache.c     | 2 +-
>  refs/refs-internal.h | 3 +++
>  3 files changed, 5 insertions(+), 2 deletions(-)

A few observations.

 * The ref_iterator_peel() is defined to "Return 0 on success." in
   refs/refs-internal.h and implication of the missing mention of
   what is returned on failure is that it can give any non-zero
   value back, and in this project a failure usually is signaled by
   returning a negative value.

 * If the trace output cares that all non-success trace entries to
   look identical, I wonder if that layer should be the one that
   normalizes "0 is success, any other value is failure" into "0 is
   success, 1 is failure" (even though I find a positive 1 used as a
   failure a bit odd).

 * refs.c::peel_object() is defined to return "enum peel_status"
   which is not even a simple yes/no.

    PEEL_PEELED = 0
    PEEL_INVALID = -1
    PEEL_NON_TAG = -2
    PEEL_IS_SYMREF = -3
    PEEL_BROKEN = -4

   The comment in refs/refs-internal.h about "Reference interators"
   suggests me that ref_iterator_peel() is supposed to be a moral
   equivalent of (recently gone) peel_ref() which was a thin wrapper
   to still surviving peel_object(), so I expect ref_iterator_peel()
   to allow the caller to differentiate various failure modes.  And
   as a way to debug into a running system, I am not sure if losing
   the distinction in the trace output is even desirable.

packed_ref_iterator_peel() does use !!peel_object(), but I have a
feeling that that is what should be fixed and not the other way
around.

I haven't seen a good justification given to help convince me that
this is a good change (and I presume it is, as I trust you or any
other contributores enough not to knowingly make the system worse),

> +/*
> + * Peels the current ref, returning 0 for success.
> + */

And if it does make sense to squash the peel status down to "bool",
then the comment should mention the single acceptable value for
failure, not just "0 for success" which implies "different negative
values depending on the nature of failure".

>  typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
>  				 struct object_id *peeled);

Thanks.

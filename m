Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED26C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD4220753
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qAJf/VdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgELXW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:22:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64959 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgELXW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 19:22:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95772D4C0C;
        Tue, 12 May 2020 19:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fihYxXS5IDzPQg8L42bnCsfvvsY=; b=qAJf/V
        dGwerskxXCQH3d1xjdOIaShnOOru6kBMF+uRn1vLaneYDjFrpnUAnacPXSfIEWMp
        f/kiUizhqvLLtbGn0U5LYS0amwy7rXFGSR7seiodePC+bR7jN3a6fTkGyWzH157r
        NTUX51zw9lTAB2RLfGg6fXrsL0naVcll/lQnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fy4XeZvMYzCfY8M4Idgu0L9OJcubfMtM
        AIm0z4QMbNgbwhB9oSd9ZhgbupWTyEsw85Z1pnYutIRdY2dW7SNwAzy2OM3qyqvj
        dBK/hDOdeVSbrupJ6+8CSQjDzy4IXA108bsJfWnAmDUrj9OuCzBiBTW/oH8s8zYo
        Bpml6woKXwc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C790D4C0B;
        Tue, 12 May 2020 19:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2338D4C0A;
        Tue, 12 May 2020 19:22:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH v2 2/4] config: load the correct config.worktree file
References: <cover.1589058209.git.matheus.bernardino@usp.br>
        <882310b69fd3df0acc6823a2c73bbe1801d9f6c4.1589058209.git.matheus.bernardino@usp.br>
        <xmqqlflyqocl.fsf@gitster.c.googlers.com>
        <CAHd-oW4J4LVo3HPj-8WnRAOXOhxaLS8v3_SW2kOTO+SFuPas=A@mail.gmail.com>
Date:   Tue, 12 May 2020 16:22:51 -0700
In-Reply-To: <CAHd-oW4J4LVo3HPj-8WnRAOXOhxaLS8v3_SW2kOTO+SFuPas=A@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 12 May 2020 19:55:17
        -0300")
Message-ID: <xmqqmu6cagc4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80C0431C-94A7-11EA-A841-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> Can we add a test or two to protect this fix from future breakages?
>
> Sure! There are already a couple tests, in the following patch, that
> check this behavior *indirectly*. As we recurse into submodules, in
> grep, we try to retrieve the core.sparseCheckout setting for each
> submodule (which is stored in the subrepo's config.worktree file). The
> said tests make sure we can get this setting, and they indeed fail
> without this patch. But would it be better to also add a more direct
> test, in this patch? I think we could do so by adding a new test
> helper that prints submodules' configs, from the superproject, and
> then testing the presence of per-worktree configs in the output.

Sounds like a plan.  Yes, checking by observing how grep that
recurses into submodules behave is doable but is indirect, and if
any other subcommand that may want to do the recursion will have the
same issue that gets fixed by this patch, it's better to ensure that
the fix applies to any subcommand in a more direct way.

Thanks.


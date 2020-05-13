Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F82C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7836C206F5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2sfXeeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgEMARK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:17:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60524 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgEMARJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 20:17:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 690865BF2C;
        Tue, 12 May 2020 20:17:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hrLZquschmkjyFhXpDPFjDSJfhE=; b=F2sfXe
        eLDOBi+QDG+qcPbJWq0zlqlDfvbGskmirNifxFuuSKwKciVsEKpILQg3XenCZ2Mu
        gfhi5QvOI/ZfDT5MO0UZSKr0PvJqTf4XiVur7g23Sna08yk48V+zn76zYzy4wpPn
        8fXGIdEx8JEyGzc/kxiLk6u1jje1U+I4r0UYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ey2Oui800Crtm1MgLt8wPDKyBj7fvHRe
        YgpDQLn3COQQMmblbJzqjCD4GSAAED/r0m7Z6cWmweyGitZxh2rRKCE18QYTjoMx
        gtjmEMbuGoOC6ErpbehRH+YC5cNU4w7lAmkj+hScT/oMwwPR//y5RsEzJOqOII8B
        atQsm3phrHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F0055BF2B;
        Tue, 12 May 2020 20:17:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB4935BF2A;
        Tue, 12 May 2020 20:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
References: <cover.1589058209.git.matheus.bernardino@usp.br>
        <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
        <xmqqh7wmqn7k.fsf@gitster.c.googlers.com>
        <CAHd-oW4k-9ZHQJcqEUqzxw0YShPWCaG61=v4wyBvXte2sSTV5g@mail.gmail.com>
Date:   Tue, 12 May 2020 17:17:06 -0700
In-Reply-To: <CAHd-oW4k-9ZHQJcqEUqzxw0YShPWCaG61=v4wyBvXte2sSTV5g@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 12 May 2020 21:05:18
        -0300")
Message-ID: <xmqqsgg4wuwt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1445BBCE-94AF-11EA-B3E8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> The idea behind not skipping gitlinks here was to be compliant with
> what we have in the working tree. In 4fd683b ("sparse-checkout:
> document interactions with submodules"), we decided that, if the
> sparse-checkout patterns exclude a submodule, the submodule would
> still appear in the working tree. The purpose was to keep these
> features (submodules and sparse-checkout) independent. Along the same
> lines, I think we should always recurse into initialized submodules in
> grep, and then load their own sparsity patterns, to decide what should
> be grepped within.

OK.  

I do not necessarily agree with the justification described in
4fd683b (e.g. "would easily cause problems." that is not
substantiated is merely an opinion), but I do agree with you that
the new code in "git grep" we are discussing here does behave in
line with that design.

Thanks.

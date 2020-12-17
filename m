Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761ECC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E1823432
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLQBdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:33:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63558 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQBdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:33:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A8FF101131;
        Wed, 16 Dec 2020 20:32:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ujvC5UOzFMb50K6wGw4hhvGDEAQ=; b=ZqI3w/
        ZbloKOR4GJvQTsW1URr+RjO3VxR8fqVCf0TYIGGhpUmvW0MbXQJ3RZ39DKqW/C82
        39UBoSTWp+MpF2g8c4O+zc8cA47AhBjYl6Jj5eMRHm62ihwxFDPl+YqU4/Y87gf6
        lepeN2NCQs0OXGMXeOh+boy+P08r1aOfa/uak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VKX0taF15SUGZv3aY5zxqMYPk0ezWkrl
        MsgSNfmLeukxpCjoIYazgRz3Dc9qZ+fj2i9vhiblRdebYMvcZZbVoNDWFygKw5lg
        QMt+7iL1+53l4rd5vytWRbMmpxIvGjb2kDfI5xHyOkScHIehRWK+dxkGH0Zz1tXB
        +el1Byn9Slc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83080101130;
        Wed, 16 Dec 2020 20:32:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1F2010112E;
        Wed, 16 Dec 2020 20:32:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, felipe.contreras@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/3] ls-refs: report unborn targets of symrefs
References: <X9pQjHrRQQqB6AFI@coredump.intra.peff.net>
        <20201216235443.1674103-1-jonathantanmy@google.com>
Date:   Wed, 16 Dec 2020 17:32:50 -0800
In-Reply-To: <20201216235443.1674103-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 16 Dec 2020 15:54:43 -0800")
Message-ID: <xmqqzh2dz071.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C75EC120-4007-11EB-AEFA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Firstly, this allows a staged rollout in load-balancing situations
> wherein we turn on "allow" for all servers, then "advertise", so that we
> don't end up with a client that sees the advertisement but then sends
> the follow-up request to a server that has not received the latest
> configuration yet.

If this were the _first_ capability we are adding to the system, the
above makes quite a lot of sense, but I do not recall any existing
capability that can be configured this way.  How would one deploy a
set of servers that gradually start allowing fetching unadvertised
but reachable commits, for example?  I am not saying that the "I'll
accept if asked, but I won't actively advertise" is a bad feature; I
just find it disturbing that only this knob has that feature.

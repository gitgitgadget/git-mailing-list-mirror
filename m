Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B51C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE61E61130
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhIPF3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:29:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52116 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhIPF3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:29:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC578D22D1;
        Thu, 16 Sep 2021 01:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ISZv5SOtToJt
        WXyYHKE9OXeJPkJbBnDG/nKbpuLd7XI=; b=bMwd5dQBy5YM3NsiK7NUCb/3+Zc4
        6BS7yC0ddRf/txorj17aEoXKoxCYKI0EDRGmVdKZQvpQSEuXcfUbVAuw0pVxgOK2
        fd53f/EPAb8JRNUjGQwfQFle2fNUbgH5M0UrgYurYPDGIc73tcRLhMj+vsEsNJzO
        x1oC8RniusieDgk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C53A4D22D0;
        Thu, 16 Sep 2021 01:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59033D22CF;
        Thu, 16 Sep 2021 01:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/2] tree-diff: fix leak when not HAVE_ALLOCA
References: <20210916023706.55760-1-carenas@gmail.com>
        <20210916023706.55760-2-carenas@gmail.com>
Date:   Wed, 15 Sep 2021 22:27:58 -0700
In-Reply-To: <20210916023706.55760-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 15 Sep 2021 19:37:05 -0700")
Message-ID: <xmqqpmt9um1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DADEAB6A-16AE-11EC-8D8C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> b8ba412bf7 (tree-diff: avoid alloca for large allocations, 2016-06-07)
> adds a way to route some bigger allocations out of the stack and free
> them through the addition of two conveniently named macros, but leaves
> the calls to free the xalloca part, which could be also in the heap,
> if the system doesn't HAVE_ALLOCA (ex: macOS).

Nicely spotted and analyzed.  Thanks.

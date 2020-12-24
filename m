Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68935C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EED722512
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgLXABZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:01:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56603 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLXABZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 19:01:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78B859A8FA;
        Wed, 23 Dec 2020 19:00:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k4ID2ZKTVslBnozUcUx3EfB3wPc=; b=V/66wj
        Rbf1XvX/Py54AsKkRnW68LKN058mxksbzsjkV8qMuFLHoCx4VXi62HbZPMKEb3O7
        IOB21lBhnCT/Hczje44Al2iMwbu3E6fVnj/4RZopb3dcrwRYjOHRDgrb9wNzrnQG
        r8BRQPPSHnFYhiAKQPtd86LpvgyX0BI+9iGSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qyRioD57MV6I0yfJ8SAu0QJfobjPz1VV
        amJSD2a7nWq7ftaePw6fzrKyNL9vG2pMYVOiCRiGHG5g6hgjNQ+ss0rjIe8s0cRE
        tGEJbBtNF5tu0XiOERiQw+R89EYivUJXYhZPYmVo9KxWjwL8oB6ZXbPgE6SsUEKq
        6GN+fd+f7NM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D99A9A8F9;
        Wed, 23 Dec 2020 19:00:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C88F29A8F8;
        Wed, 23 Dec 2020 19:00:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/2] negative-refspec: fix segfault on : refspec
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
        <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
        <xmqq1rfijpyf.fsf@gitster.c.googlers.com>
        <CAN8Z4-VQJsXWmJPNg0Fdu98csK7ZQ0yDNzxPqRhsbuw9CUJjnw@mail.gmail.com>
Date:   Wed, 23 Dec 2020 16:00:41 -0800
In-Reply-To: <CAN8Z4-VQJsXWmJPNg0Fdu98csK7ZQ0yDNzxPqRhsbuw9CUJjnw@mail.gmail.com>
        (Nipunn Koorapati's message of "Wed, 23 Dec 2020 23:56:01 +0000")
Message-ID: <xmqq8s9o5aza.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 101B293A-457B-11EB-8F5B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nipunn Koorapati <nipunn1313@gmail.com> writes:

> Is this something we want to merge into the 2.29 maint branch?

Eventually by backporting, but a fix typically goes to the current
development track first so it would happen after 2.30 is finished, I
would think.

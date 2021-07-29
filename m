Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469F2C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 01:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE1760C51
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 01:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhG2BGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 21:06:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52429 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhG2BGX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 21:06:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23DF0DBF62;
        Wed, 28 Jul 2021 21:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pDqLxngP0dE8E4UhRwW9zjHJsgIx0zZT9n36C3
        ysj7Q=; b=UvbFV5ugnA7dKh4ICr0FhY2Aqbmzf6CPovA8HYwKZ9gXg+9t3H6/wG
        Fcv71Yv275J19cs3aOVi6UPyXKha1Zd9xJrupdlnfAV3dmssytb9ZK7H61fqzMSY
        BjDP1GG/RI9BERqX4fPY9At8Pf1pE5Km+RUpixQpSXWw8gw3zdp8Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BB3DDBF61;
        Wed, 28 Jul 2021 21:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D773DBF60;
        Wed, 28 Jul 2021 21:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH] ll-merge: teach ll_binary_merge() a trivial three-way
 merge
References: <20210728024434.20230-1-jerry@skydio.com>
        <xmqqh7gfawlt.fsf@gitster.g> <xmqqeebi9vd0.fsf_-_@gitster.g>
        <CABPp-BFh3uV9-X8iaKHA771TUneBDYmOKU5+5y9XsE-11UL7tQ@mail.gmail.com>
Date:   Wed, 28 Jul 2021 18:06:20 -0700
In-Reply-To: <CABPp-BFh3uV9-X8iaKHA771TUneBDYmOKU5+5y9XsE-11UL7tQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 28 Jul 2021 17:49:13 -0600")
Message-ID: <xmqqczr26i9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F76FF32-F009-11EB-A7FE-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> It appears that try_threeway() in apply.c is already computing the
> OIDs of the blobs involved, so it looks like the full content
> comparison is unnecessary even in the apply --3way case.  If we moved
> the trivial-merge check to that function, it could just compare the
> OIDs rather than comparing the full content.

Yeah, if we trust merge backends and only fix "apply --3way"
codepath, which I actually am OK with, I agree that it would be
vastly simpler and nicer to do it in try_threeway().

Thanks.

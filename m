Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B262C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 16:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF81C206D4
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 16:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dSp4AwAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgFVQum (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:50:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50463 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgFVQum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 12:50:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B9C35A825;
        Mon, 22 Jun 2020 12:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ry+UKVkdI26IL1TVRYc7/0CzqGY=; b=dSp4Aw
        AZno6fbJyMhykxacNy7AFIp9G1U6pqVleCb8MUIFF27OqYBTQf5mb53ugBZquSU7
        fvpD/sjQ5tOH4eERsQyntsTiYdR5u515MpvSoXTtgS8nBiLJhJxziUpTH8cR9t7C
        XL7zyy4MtZzgEq0H4IiajpY2AZUEUQJta1NoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LOMvZ+cUyv501h+EzholM91SVt9f/rH8
        IxJG/UVOf2yQLFzIO1XP2TfeF9UsRzRsNVqkgvTYAysQvgWbWL8ArmnubKkM0x9j
        IG5NhQm35jyd+XMjGkylM+KxeMGu06Z3NqnC1e73KLlHv2ZSqRyneJjhXPIPDx1P
        XM3he6emItg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12E7F5A823;
        Mon, 22 Jun 2020 12:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E55A5A822;
        Mon, 22 Jun 2020 12:50:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Matthew DeVore <matvore@google.com>,
        Eric Wong <e@80x24.org>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 00/14] SHA-256 CVS and SVN patches
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
Date:   Mon, 22 Jun 2020 09:50:41 -0700
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 19 Jun 2020 22:39:33 +0000")
Message-ID: <xmqqbllbdoym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81F4960E-B4A8-11EA-8D1E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I recently sent out part 2/3 of the SHA-256 work and then I realized
> that I hadn't built with the CVS and SVN adapters.  So this is part
> 2.5/3 (or, to be pedantic, 3/4).

OK.  It seems that at least the early test-only parts depends only
on what is already in 'master' (there are uses of "test_oid algo"
and "test_oid rawsz"), but let's queue it on top of 3716d50d
(remote-testgit: adapt for object-format, 2020-06-19), and merge the
part 2 to 'next' soonish.

Thanks.

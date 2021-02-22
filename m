Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DCC433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F162164E32
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 21:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhBVVdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:33:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60703 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhBVVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 16:33:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66C91104771;
        Mon, 22 Feb 2021 16:32:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SXE/Vu3sA32IEvc8n1Ym/cs/ojE=; b=UG9K+G
        3vNfwfJoJQ0BkpVo13RaT3w68oKb5/SVKDWQ6ftt2HbmFyW8l+Y4XkekczRyGRJ+
        adrlk/Z3D8NoZoSMyN845z/RD0uDElgP8UI44e4RZS8HCzGzgHJ9m11Ua+TO2lxh
        Vn9PD9NY1ED2tR19nU+TInuGFCi7py6JYRhuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lI+99wxYsWpF6BmYvXpMi4kmaOnLCI4f
        5wM2lkZ590V7q1zhgtKYUJWIumRPBjn2pvDiXLSRLP/8qpQtARQjM05qjvUivQMJ
        v/BBCIy6JdwBkO0UXTWvf8ZYtWCvneeK8lasKxpsyO4RdT8Cn+iiwXbIwpaP+M1l
        hXqUMO6gauk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6023A104770;
        Mon, 22 Feb 2021 16:32:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99DE910476E;
        Mon, 22 Feb 2021 16:32:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
References: <xmqqzgzza0a1.fsf@gitster.g>
        <20210222200146.1393467-1-jonathantanmy@google.com>
Date:   Mon, 22 Feb 2021 13:32:44 -0800
In-Reply-To: <20210222200146.1393467-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 22 Feb 2021 12:01:46 -0800")
Message-ID: <xmqq8s7f7pqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8145DC36-7555-11EB-96BC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I guess the idea is to have a push that does not start with a ref
> advertisement, therefore making everything more modular?

Yes, making things modular and reusable would be valuable---if the
fetch side were already structured like I dreamed in the message you
are responding to with a separate 'negotiate' service, the RFC patch
would have looked much nicer.

I am also interested in seeing was not to require a new connection
for an extra roundtrip.

Thanks.


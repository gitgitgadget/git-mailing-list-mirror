Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A579FC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3406D20709
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aiABv2yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHRWcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:32:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62840 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHRWck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 18:32:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2AB17BDBE;
        Tue, 18 Aug 2020 18:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FpUITwhEfB3T2J+HkARUURfYhDU=; b=aiABv2
        yflFM1fFjLWvlkZpArobvtxty7F8p4bb5HfeRvVy2zrjehQ+t5C8Yx40qpf3YuxT
        k+OJVvcY20nuoUQOpD3wl7cKsdL9zkuBLJy13BZK+0l/PYgDCutYJ7Y7iK/yny/C
        t9uaBJkblcAqTEp4xZNRFE51BXf8qdpNCd2uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NzNUb2Lrx6WZy7ILeUzvLDpuEiMSoe/A
        fhTLkXoRVcLTNwX+GJCLHdqRfEQX2Uuz3jJKhFKEzJxFVZv1cTQb+5zqIxFGVYcr
        8+Qt7lHLvcBVb3QBC//XNO0TU3+ajMWVA/Bw5dRVHVnL6ZNQeCW9/hO1TmrqCmxF
        qVKPrwHYZK4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAD057BDBD;
        Tue, 18 Aug 2020 18:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 416847BDBB;
        Tue, 18 Aug 2020 18:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 0/7] Lazy fetch with subprocess
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1597722941.git.jonathantanmy@google.com>
        <xmqqimdfybh5.fsf@gitster.c.googlers.com>
Date:   Tue, 18 Aug 2020 15:32:36 -0700
In-Reply-To: <xmqqimdfybh5.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 18 Aug 2020 12:56:22 -0700")
Message-ID: <xmqqk0xvwpob.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7CD3AA2-E1A2-11EA-9C30-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> These patches are based on jc/no-update-fetch-head, once again.
>
> FWIW, that topic no longer exists (it has been swallowed by
> Derrick's maintenance topics).  As that topic is not near 'next'
> yet, we might want to kick the patch out of it into a separate
> jc/no-update-fetch-head topic again, base this series and also
> maintenance topics on top of it.

So, I've recreated jc/no-update-fetch-head on top of 'master' and
then rebased these patches on top (which required some adjustment
due to argv-array -> strvec API rename).

t5300 stops passing at "[6/7] promisor-remote: lazy-fetch", which
I haven't looked into details, but the topic is queued near the tip
of 'seen' for today's integration cycle.

Thanks.



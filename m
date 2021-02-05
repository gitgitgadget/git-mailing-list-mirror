Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCB2C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC0A64F95
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 05:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhBEF0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 00:26:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57424 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhBEF0k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 00:26:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E010B7CA7;
        Fri,  5 Feb 2021 00:25:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rw9zA/QQBWZQBn/j5G43ogA6gC8=; b=NRFFTb
        3mR9BEgXZTd51a1G1AMTyUVdLBl79vX6yMIAh4EZuDVDkOTZHmulm5Il5GwlDf7v
        INAKVgFQ1VlshTyJWe3V2bPfKx05CG1yJqrHqg7qTD/wyuRVJFcJ1lDJaMHNPKVd
        Yv3CxQJdEOovF+2n6NeJh/3t8qwJc2qYibmck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NDrOFPDN4J9QyN+t5/A22j+DYF5yjZe+
        JKy5YNkjTand+5ll1JSpzq/2BlSzlkin+HGQr3ukxArueR7dcRFhaJPqniKwqvUR
        qi4mD9rp+kl9btB7cVv9KEjZM+cRt2Nad/VOQ6B2OwbAqybmiEJ2u3CjH7YHV5Fq
        cio775BPymw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32F77B7CA6;
        Fri,  5 Feb 2021 00:25:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AABB8B7CA5;
        Fri,  5 Feb 2021 00:25:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1612493309.git.jonathantanmy@google.com>
Date:   Thu, 04 Feb 2021 21:25:57 -0800
In-Reply-To: <cover.1612493309.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 4 Feb 2021 20:58:30 -0800")
Message-ID: <xmqq5z372ihm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A03C120E-6772-11EB-8D91-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> For what it's worth, here's v7 with advertise/allow/ignore and by
> default, advertise. I think that some server operators will have use for
> this feature, and people who want to disable it for whatever reason can
> still do so. The main disadvantage is complexity - the server knob that
> server administrators will need to control (but between a simpler
> allow/ignore knob and a more complicated advertise/allow/ignore knob, I
> think we might as well go for the slightly more complex one) and
> complexity in the code (but now that is constrained to one function and
> a few global variables).
>
> As you can see from the range-diff, not much has changed from v6.
>
> I've also included Junio's suggestion of tightening the promise made by
> the server (when the client says "unborn").

This looks reasonable overall, especially with the feature turned on
by default, we'd hopefully get reasonable exposure from the get-go.

Let's mark the topic to be merged to 'next' soonish, unless people
object.

Thanks.

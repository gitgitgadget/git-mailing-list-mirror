Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3BDC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B13220717
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 19:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AedDH2lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLPTJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:09:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58443 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLPTJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 14:09:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DDEB95AED;
        Mon, 16 Dec 2019 14:08:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bZoKOshwY1hI3D7r+nGg3tOjp3o=; b=AedDH2
        lh/2x0yF/RAkdrrB9n2dw3bqT1cqSIJeTPEGyPtw8zx5enSND7CEWZbgbbQ7aLHC
        DeSPPMcyOUfMVTIZOAXH72EkE5EQkjefDjPMgFxRQkxAXE7QncqsKU5ZwVU4/hJx
        iBJifQJLgfWiie6YlGn6F7EBOcZCk8LfSjPWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K9+kVcFIM8b2jdMjZo/pQH/ZkTQVSMjK
        ng5wfxY981esh+cxQDo1YGODXHP9/SqdptOqNSzOJLw9idVllkj8XIDXURZ5ODw6
        eqF9Gt++RXCxGMTeBQlhvmGCPi7u3IrmBBE8Q4ptVP6Yan3x7sxVl31KCeCYa0uT
        qQgE6+jN+6U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9783095AEC;
        Mon, 16 Dec 2019 14:08:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B879795AEA;
        Mon, 16 Dec 2019 14:08:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy] [PATCH] bisect--helper: change `retval` to `res`
References: <20191216111246.5190-1-mirucam@gmail.com>
Date:   Mon, 16 Dec 2019 11:08:54 -0800
In-Reply-To: <20191216111246.5190-1-mirucam@gmail.com> (Miriam Rubio's message
        of "Mon, 16 Dec 2019 12:12:46 +0100")
Message-ID: <xmqqh820jdfd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 822FF240-2037-11EA-A610-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> Convert of variable `retval` to `res` make `bisect--helper.c` 
> more consistent.
>
> Now, 110 ocurrences of `res` in file and zero `retval` occurrences.

And why is this a desirable change, not merely a distracting code
churn?

IOW, are there other changes that build on this change that benefits
from the fact that the variable that holds the value to be returned
is always called "res" after this patch gets applied?

FWIW, I actually think "retval" would be a more appropriate name for
the variable that holds the value to be returned than "res", but it
is not worth the churn either way---I see this more as "once the
code is written one way, it is not worth wasting bits and brain
cycles to change it" kind of issue.

Unless there are other valid reasons to do this change, that is.

Thanks.

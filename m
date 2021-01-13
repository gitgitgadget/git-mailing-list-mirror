Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B6FC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 02:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D8E22EBE
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 02:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbhAMCP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 21:15:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57062 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAMCP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 21:15:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEFD01029FE;
        Tue, 12 Jan 2021 21:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R6dGFHKNF2CcYE8KAjRcS98SUVs=; b=v54cq+
        N9DOeBMuovYB9fulfyBVpcKyIAJxdgU5KVUT0sGT7Fk83Ax4r3qyRfbc86euNLw+
        BV453Vc1yZab7NMB2tsFmC1w3Y237f36rVUZrqL/ZG5t/YQoBAwlAdDW/c8M5EAH
        /fxmrqnGlDnNPdA0ccJaZBeXWDktrR2+n9bCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IKF15aXR1Y3YmNsuzRoQduPvvYRETDdp
        OUtX62ARDm2s69auMYZCyWDIFlWo6pLl7gokkWPPCOo/pVKgiRwBaQdqp1MZUKZv
        oNGPDz70OsjoWmWcaLdTxfmBj0oEK2eDR6mppXpKx+fOXVITVwgCweXOVxhbJa+x
        uyeX8bPC0ck=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7FD11029FD;
        Tue, 12 Jan 2021 21:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 323541029FB;
        Tue, 12 Jan 2021 21:15:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
References: <cover.1610129796.git.me@ttaylorr.com>
        <xmqqk0shznvf.fsf@gitster.c.googlers.com>
        <X/5ER+ml/MhDjROA@nand.local>
Date:   Tue, 12 Jan 2021 18:15:11 -0800
In-Reply-To: <X/5ER+ml/MhDjROA@nand.local> (Taylor Blau's message of "Tue, 12
        Jan 2021 19:52:23 -0500")
Message-ID: <xmqqft35ziog.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B4888AE-5545-11EB-824F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Did you want to queue these two topics separately?

Unless it is a reasonable amount of certainty that the bottom topic
will not have to be rerolled, I'd rather not to have separate topics
on top of each other.

It is tedious and error prone, having to rebase the old iteration of
the top topic on top when a new iteration of the bottom topic comes
out.  I'd rather see that the top one get rerolled whenever the
bottom one gets rerolled to make life simpler.

Even in a single topic, I would encourage people to put the
foundational and preparatory work early so that we can make them
solidify before review really gets to later parts of the series.

And when a series is structured like so, it is perfectly fine to say
something like:

    Here is a new iteration of the last 7 patches---the early 13
    patches are the same as the previous round, so reset the topic
    to bb6414ab (packfile: prepare for the existence of '*.rev'
    files, 2021-01-08) and then apply these 7.

if you do not want to send all patches in a nontrivial series when
it gets updated.

Thanks.

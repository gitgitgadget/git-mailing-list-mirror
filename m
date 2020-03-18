Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46772C4332D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 23:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AF820768
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 23:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IirDPHNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRXj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:39:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58683 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRXj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 19:39:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C05A8BD844;
        Wed, 18 Mar 2020 19:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4WYQGT9wr30nOCJ/wiEN0Bqq8TM=; b=IirDPH
        NFA/JY+3YppL/JT2t+gzhTOe+WpAZv1l6wdMIw04fRrOwbbF8nMzHYsRTBTYyqyb
        N5Y4dPXwUbXDz7HNtortIrorHm6F9GUWaplidPuvH/h41Pw+w7Lq7cCpeqP2K9DS
        WwE3Vs5q7Vy0W4tNNW6vW1zhMbIdL7nDOqUxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Of3kTc5dMfgj1FGZ0yIWoQP2Au/twV0v
        LbTUhtZTE/BshwbJ9g2dO3BUUnScixLbh6YmU4GG2Bpbg12+bDx3mvvEZVoTL5Kl
        8LUWiSnZhECZ99s0pAj0Oeu09qMN4mpA5UDRRogU6q6QgQCfTUA8Tji/aYiU+pWE
        NZDjPZMrnZM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8D35BD843;
        Wed, 18 Mar 2020 19:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 122DABD840;
        Wed, 18 Mar 2020 19:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
References: <xmqqpnd9fql0.fsf@gitster.c.googlers.com>
        <20200318192821.43808-1-jonathantanmy@google.com>
        <xmqqd099fnfm.fsf@gitster.c.googlers.com>
        <CABPp-BGSvT9zu1xjHUPHBQ3jEktZ56O=m6VNH2v0E-RcfBN_tw@mail.gmail.com>
Date:   Wed, 18 Mar 2020 16:39:52 -0700
In-Reply-To: <CABPp-BGSvT9zu1xjHUPHBQ3jEktZ56O=m6VNH2v0E-RcfBN_tw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 18 Mar 2020 13:41:23 -0700")
Message-ID: <xmqqsgi5dygn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4B8C578-6971-11EA-8B4F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> 4) Jonathan provided some good examples of cases where the
> --keep-cherry-pick behavior isn't just slow, but leads to actually
> wrong answers (a revert followed by an un-revert).

That one cuts both ways, doesn't it?  If your change that upstream
once thought was good (and got accepted) turned out to be bad and
they reverted, you do not want to blindly reapply it to break the
codebase again, and with the "drop duplicate" logic, it would lead
to a wrong answer silently.

So from correctness point of view, I do not think you can make any
argument either way.


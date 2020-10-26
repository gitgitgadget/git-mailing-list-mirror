Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A6C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5955D2076A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XcKrBCGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789890AbgJZSdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:33:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65060 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784970AbgJZSdv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 14:33:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFE3F90B1B;
        Mon, 26 Oct 2020 14:33:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ayJwBliB2toAhco51Ak17PHJAg=; b=XcKrBC
        GlHppW/voEVAHlyjJsRCgVchh0MC7HEIDOzGP+ePSNA70+1YzGDuGzkFze7rBI9R
        FwMFPDJ4pMJqNs438q7Fe+BdV+hlCDXQQs6I8xHnYYMTxzjmDEBwBJkSop2mnbfa
        edug8n5mj45FWCPRty1II64WsuKG/jPxu2pjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RGpAVohnAfTF3m9Kbsp+tcOkCOWQ/nyV
        cyFMabQCVLHHi1Dyn2QcGJ/n6VVx5elouNBt8Omar1CcNZe7O2fbWQm6WuMmAsi1
        5xq0ctkWgOh4DAI/glAMZLMmUGvRuJAOx42/CTvAkdLGO+fFrnJ888xBXAsXqCGk
        hRJOVVlrB0s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B788990B1A;
        Mon, 26 Oct 2020 14:33:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 479A190B19;
        Mon, 26 Oct 2020 14:33:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] Work around flakiness in t5500.43
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 11:33:47 -0700
In-Reply-To: <pull.753.v3.git.1603728555.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 26 Oct 2020 16:09:13
        +0000")
Message-ID: <xmqqh7qget10.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9919F38-17B9-11EB-9F38-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> It seems that this test became flaky only recently, although I have to admit
> that I have no idea why: the involved code does not seem to have changed
> recently at all. It should have been fixed by 
> https://lore.kernel.org/git/20200506220741.71021-1-jonathantanmy@google.com/
> , but apparently wasn't completely fixed, despite what I said in that
> thread.
>
> Changes since v2:
>
>  * Dropped patch 3/3 because it was only intended to be defensive
>    programming, but turned out to be too hard without layering violations.

Thanks, the remaining two look identical, so let me preserve the
timestamps by just dropping the tip one from what is queued, instead
of queuing these two patches.


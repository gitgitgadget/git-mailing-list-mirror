Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B394C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25B20578
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uyvk5Zp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgBKRGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:06:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53330 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgBKRGm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:06:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43B60429C7;
        Tue, 11 Feb 2020 12:06:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z7+ESFqJs0lOk1A0kQJ7G7JFBG8=; b=Uyvk5Z
        p1CVeOuBEooJL1t9LJvi62ZG8gh8pSSOK4nQtesA4Ao9skuermgbMy7NHn6QBfQP
        wvabSCm41O2ynxUwUVHXcG+43dgTYUsfByS4d22ZB9HBWaRUVvgDamL56o3DYao7
        oZzMCasSa7OuvWjvFmGcbUAZQ922xWAsCD4Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HHSntxmLmtGFXbzLmHFlyktKLw7RtkQi
        AeCPiSmPL/YyhH1jqHg60NlAljSxoUJobmAMmmK0MjfIZrvzZWaisBLtpXeF1w81
        Nco+0Qub8qsmtrnfn7H3s2WOXehyoGUyUwBvni3u0NtXrMPQsZpLZ0gsGSvqK5CM
        qQVTPaUrAw8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C121429C6;
        Tue, 11 Feb 2020 12:06:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 988A4429C5;
        Tue, 11 Feb 2020 12:06:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/4] Sparse-checkout: Add subcommand and Windows paths
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 09:06:39 -0800
In-Reply-To: <pull.546.git.1581433344.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Tue, 11 Feb 2020 15:02:20 +0000")
Message-ID: <xmqqimkdvysg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF101EDC-4CF0-11EA-9A45-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on ds/sparse-checkout-harden.
>
> The sparse-checkout builtin currently lets users modify their
> sparse-checkout file with the all-or-nothing "set" subcommand. It may be
> easier for a user to expand their sparse cone using a "git sparse-checkout
> add <pattern/path> ..." subcommand.

Makes sense.  

I suspect that people may get greedy and start saying "now we can
add a new directory (say, Documentation/) without repeating what we
already configured, I want a way to add a new directory without some
of the paths in that directory (say, Documentation/ but not
Documentation/technical/)", but that won't happen until people can
use "add", so let's take small incremental steps, and addition of
"add" is such a good first step.

Will queue.  Thanks.

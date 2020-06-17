Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05276C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F43212CC
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tfGhI4v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFQSXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:23:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51364 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFQSXt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 14:23:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83F01E7993;
        Wed, 17 Jun 2020 14:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FJp4B9MUtYoy0uqi+Ac4Qw68Wnw=; b=tfGhI4
        v3cvBTuHrdp+GMHVrw8gSlGX4nb4C1Cng2658zmR7CYEoGo0R0ztlC/G+CejKcqM
        Y/xgmGsb1C+TWvEu29PghA028vUlJ0PrszXwjsTDVlWULMV6IlZjzqQ2M2vJHTfJ
        0y2XCmvDaI9+7qkXH6FZc5yKltIDzHIYIRYWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ayi9w7Yz573q77/g39eDj79/GTd6s34t
        cw3lC95pVmTDtwaFhRdRC18kkFlQwGdPu1rj2eMdqq6UJnE+7JpRbh3XEvvk5rMN
        oz9QCBN03ZLtUYHwYu4sX7UWIjOoe/xsB2+EsHjE05O1C2e0FZLv7t7loP7XqUKz
        psK2a23pEzs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76026E7992;
        Wed, 17 Jun 2020 14:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5D62E7990;
        Wed, 17 Jun 2020 14:23:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the main branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
        <20200616130456.GF666057@coredump.intra.peff.net>
Date:   Wed, 17 Jun 2020 11:23:43 -0700
In-Reply-To: <20200616130456.GF666057@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 16 Jun 2020 09:04:56 -0400")
Message-ID: <xmqqeeqdv9e8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADB7158A-B0C7-11EA-A671-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure if this check_refname_format() is valid, though. IIRC we've
> had issues where "ONELEVEL" was used to check a branch name, but misses
> some cases. The more full check done by strbuf_check_branch_ref()
> actually creates the full refname and checks that. It also catches stuff
> like refs/heads/HEAD.

Yup.

I actually am in favor of removing special casing of a single branch
done by fmt-merge-msg and fast-export --anonymize, so this may not
matter.

We still need a mechanism to allow users specify the default name to
be given to the first branch "git init" creates and used by "git clone"
as a fallback name when it cannot infer what the other side uses, though.

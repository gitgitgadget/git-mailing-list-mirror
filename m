Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C5C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A2A20768
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 16:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XOMlQoRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgFVQfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:35:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52528 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgFVQfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 12:35:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A3BE63EB6;
        Mon, 22 Jun 2020 12:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jG90aYnm8Bq8ti1jqanAAHtYZ8Q=; b=XOMlQo
        Rh9LljfPsbk9vSBekEVY6dSix+OuGbiG4cWo1k8N/cTZDN+3PKarTiNEwNnRC7L7
        1WbpG/kgssHLoFbyojHbR5NVXKhfqyu94qOPklB2SG1ADaq1kxTveWr7kNFdy9Um
        xcWLcTcUxHiSQw40yRSx/dyB8aPOll1aNxUIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j8moClvvAFJSTRN7QDlVPrDHx/+P7uF1
        80NC6Z+r+gkbZZXwX8tFWsLD/o2PVsaflbEqnU18m9hinnWN4eSLn3ojKqQhel1I
        W1xCVJu9nkoRqpyZOlxO8CbtcZLQQ+yEgV1cksksp+CK/+fBGTcEcwNh0MMebK0/
        sRJTXps+dZs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3341A63EB4;
        Mon, 22 Jun 2020 12:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B725363EB3;
        Mon, 22 Jun 2020 12:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/3] git-prompt: include sparsity state as well
References: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
        <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
        <d99202f8e1443f517b16811b7d2ba2593898e9d0.1592716887.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 09:35:34 -0700
In-Reply-To: <d99202f8e1443f517b16811b7d2ba2593898e9d0.1592716887.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 21 Jun 2020
        05:21:27 +0000")
Message-ID: <xmqqk0zzdpnt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65703436-B4A6-11EA-9FBA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
> ...
> The reason for showing the "|SPARSE" substring before other states is to
> ...
> The fact that sparsity isn't just cached metadata or additional
> information is what leads us to show it more similarly to the
> in-progress states, but the fact that sparsity is not transient like the
> in-progress states might cause some users to want an abbreviated
> notification of sparsity state or perhaps even be able to turn it off.
> Allow GIT_PS1_COMPRESSSPARSESTATE to be set to request that it be
> shortened to a single character ('?'), and GIT_PS1_OMITSPARSESTATE to be
> set to request that sparsity state be omitted from the prompt entirely.

Nicely explained.  It somewhat feels a bit overkill to have two
(i.e. compress vs omit) knobs---the other "semi-permanent" state
that may be of interest but could become too noisy only have one
knob that toggles between showing a short-and-non-intrusive sign
and not showing anything at all with GIT_PS1_SHOWSTASHSTATE, and
that smells like a better balance to me, but I dunno.

Thanks.  Will queue.

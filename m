Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B7CCA479
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 20:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiFAUrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiFAUrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48AB1FA4C3
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 13:40:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0B2A13C601;
        Wed,  1 Jun 2022 16:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=726F7OFcqq+QK/EDy6PZh3hDxPvxg3ZCwY4zzx
        mL8Ek=; b=M2wdywYd6hGcEjZmCMD7a8x+L5a+FcUj7v4yO4g5f6wtaBy8w80JZJ
        Zk/kh2Yp9CgPHQqmG/lyCA3x93Z7SfEzfDeXd7MT72gbZkguLjOqo3a3N5wxOuu7
        3DqOt9DBhkQacdXNqkXp+JhK9+QAIQDq0dP6znVrJyJhbTKs1ClWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4E3E13C5FF;
        Wed,  1 Jun 2022 16:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 771B313C5FD;
        Wed,  1 Jun 2022 16:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated warnings
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
        <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
        <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Jun 2022 13:40:06 -0700
In-Reply-To: <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 01 Jun 2022
        01:16:13 +0000")
Message-ID: <xmqqtu94qfrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05F587C6-E1EB-11EC-97BB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In the case of the credentials in a URL, the existing test demonstrates
> this per-process limitation: 'git clone' runs 'git-remote-curl' as a
> child process, giving two messages. This is an improvement over the
> previous six messages.

Do we call the valid_remote() helper on the same remote many number
of times?  Unless the duplicates appear by such a "stupid" reason, I
am not sure if this is a good idea to do this deduplication.

Especially if we know we cannot do the deduplication across
processes.

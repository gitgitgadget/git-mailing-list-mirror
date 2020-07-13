Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E2AC433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E362137B
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 22:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MjqwgXaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGMWtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:49:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57952 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGMWtD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 18:49:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 517BBCF45B;
        Mon, 13 Jul 2020 18:49:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4RZ20y/LihLPbsqgL16+sfBWk2E=; b=MjqwgX
        aDWTypMAAmgFVyRd5RJVfn8uOhWXqw9YOzcCm9C5SNJqiNKuejcsEGfGPMGLF2s2
        yaYq5GjoSgnjJnUynKiQ2GbGEL+rdepjjWN1mOc/fy3Y7j8FiLkxmTpy2b1iE/Wb
        INvsFynOEY4jv8LZ2hFvuFTCjFqbKwweWfDtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O0wtjh5v5li7fOoiHaW1FiqKpifCjBIJ
        pfxWqpwTGQXiRx2cNVBPnDwfA5smJK16ny+8KL7lBjuQHOLfV+GGHZlfrS35ZGuw
        u/K/26XuXZ6bM0+QgNhS5jIc+P9TFLKZtT8lwrZH96KnhdjaHXhE/71Dyh2js8lH
        oNXvGclJ/Fo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A2B6CF459;
        Mon, 13 Jul 2020 18:49:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84EA8CF44D;
        Mon, 13 Jul 2020 18:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] setup: warn about un-enabled extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
Date:   Mon, 13 Jul 2020 15:48:58 -0700
In-Reply-To: <pull.675.git.1594677321039.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 13 Jul 2020 21:55:20
        +0000")
Message-ID: <xmqqh7ubm3ol.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B01C6A2-C55B-11EA-B650-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     I did actually run into this today. One of my pipelines is configured to
>     clone a bare repository, then set up a sparse secondary worktree. This
>     used to work, but all of a sudden, the git config --worktree
>     core.sparseCheckout true call failed because I'm now using v2.28.0-rc0.

I guess a few people were independently hit and then approached the
same issue from different angles?  If so, can you two compare notes
to help us all come up with a single good solution, preferrably by
-rc1?

Thanks.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE4DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 15:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355106AbiDLPrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351267AbiDLPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 11:47:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D0DF25
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 08:45:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89985191123;
        Tue, 12 Apr 2022 11:45:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gxfxUll8oOm4uidWEsu57jwfj+R5LzV3cd2t4j
        AqRIQ=; b=RZCgzhYR5SOi3bu7GhP0DdTTKRTC2NIOwEWpDlS3T2t5TGStoevmak
        Qj2devCQEa2ZzvXdFnSXNwpoNZzww13oGMQLrpUbb9VeS2GL2SAfDTYXEtz48SW6
        t5EuI65XSXkHzK2q97fdFawslwYdW2/vp/KhW8INUvo8EHPLrMKFg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 819FB191122;
        Tue, 12 Apr 2022 11:45:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1FDF191121;
        Tue, 12 Apr 2022 11:45:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com
Subject: Re: [PATCH 4/4] object-name: diagnose trees in index properly
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <99c09ccc2406e4f54c620bd7fb2d1205386e23a6.1649349442.git.gitgitgadget@gmail.com>
        <xmqqlewaerqd.fsf@gitster.g>
        <1f027d22-9c5c-7ccf-37e7-611d67de7cfd@github.com>
Date:   Tue, 12 Apr 2022 08:45:20 -0700
In-Reply-To: <1f027d22-9c5c-7ccf-37e7-611d67de7cfd@github.com> (Derrick
        Stolee's message of "Tue, 12 Apr 2022 09:52:45 -0400")
Message-ID: <xmqqlewacnlb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FD7461E-BA77-11EC-A7AF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The reason for test_sparse_match instead of test_all_match is because the
> error messages change depending on the existence of the path in the
> worktree. For example "git show :folder1/" in the test script would have
> this output difference:
>
> + diff -u full-checkout-err sparse-checkout-err
> --- full-checkout-err   2022-04-12 13:35:51.430805689 +0000
> +++ sparse-checkout-err 2022-04-12 13:35:51.430805689 +0000
> @@ -1 +1 @@
> -fatal: path 'folder1/' exists on disk, but not in the index
> +fatal: path 'folder1/' does not exist (neither on disk nor in the index)

Ah, because naturally folder1/ would not be on disk if it is outside
the sparse cones?  Makes sense.

Thanks.

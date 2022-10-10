Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8396C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 21:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJJVIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJJVIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 17:08:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4D6B8C4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 14:08:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB4731CD22F;
        Mon, 10 Oct 2022 17:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+V0+oMrDdGmY5XQBnKmItKxguY5M3ZAJveCYNh
        wvqEk=; b=vHEhmjhLEne+2Cygk+NhIuo94rhyMrUvE6cS/pgRWNxWsBxd7dw4EF
        54wZVeB7LNq+mIFLLcL1XVomGkYGasLosxBGX0+VSagphnLCWZX+L74wLUr+srch
        CUySJZz4fUDSNdQJHwFAJR6HPMtkcPMCFsW3OV4sS9Blmw57OtMVc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3AFD1CD22E;
        Mon, 10 Oct 2022 17:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE3591CD22B;
        Mon, 10 Oct 2022 17:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 14:08:07 -0700
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Sun, 09 Oct 2022 14:37:26
        +0000")
Message-ID: <xmqqilkr1j60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A44EEF10-48DF-11ED-B98E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
> Windows and Mac OS.
>
> This patch set builds upon previous work for done for Windows and Mac OS
> (first 6 patches) to implement a fsmonitor back-end for Linux based on the
> Linux inotify API. inotify differs significantly from the equivalent Windows
> and Mac OS APIs in that a watch must be registered for every directory of
> interest (rather than a singular watch at the root of the directory tree)
> and special care must be taken to handle directory renames correctly.

I am seeing occasional breakages of t7527.16 that does not seem to
reproduce reliably.

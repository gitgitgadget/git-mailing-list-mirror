Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D2C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiHVQHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiHVQHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 12:07:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C626326C8
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 09:07:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBB1D132E39;
        Mon, 22 Aug 2022 12:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xXJcCgDvj8A5zHmZDgPdkkRAvMJO2XXRuMtQCr
        /1ReA=; b=PjX/F+uAwpuV53jLe5woH0rEecFgYDgXBkoovB496qGhr8Wu4X4SMu
        YBxnVVwDv2kKq5zo3cI7DijOXnKnt1emAD8IvKgSdwRHpVRbcp5AwKEFms2ZahHh
        ZYdXRfKGA7K3GSreWW5Z0ha4c814zSBfbiaiZax1envaH10wQXMfA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE833132E38;
        Mon, 22 Aug 2022 12:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B43B132E37;
        Mon, 22 Aug 2022 12:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
        <xmqqsflqlfjq.fsf@gitster.g>
        <092oq98r-39q3-4s66-0n0p-r77po7pq8275@tzk.qr>
Date:   Mon, 22 Aug 2022 09:07:31 -0700
In-Reply-To: <092oq98r-39q3-4s66-0n0p-r77po7pq8275@tzk.qr> (Johannes
        Schindelin's message of "Mon, 22 Aug 2022 15:22:36 +0200 (CEST)")
Message-ID: <xmqq35dofeik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87567E9A-2234-11ED-ABE7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Eric: To investigate, you will want to reproduce the problem on a macOS
> machine. If you have none available, you could create a temporary branch,
> heavily edit the CI definition, and push it to GitHub. And by heavy edits
> I mean something like this:
>
> - Remove all non-macOS jobs from `.github/workflows/main.yml` (that means
>   removing all but the `regular` job, removing all but at least one
>   `macos` matrix entry, and removing the the `needs: ci-config` and
>   corresponding `if:` line.
>
> - Edit `t/Makefile` to define `T = t7527-builtin-fsmonitor.sh` instead of
>   running all the tests.
>
> - Edit `.github/workflows/main.yml` so that the step that causes the
>   time-out has a chance of timing out much sooner (and the subsequent
>   steps then have a chance to upload the relevant logs):
>   https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepstimeout-minutes
>
> If this does not shed any light into the issue, please let me know, I have
> a couple more aces up my sleeve.

Thanks, both.

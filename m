Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86264C04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA4A2071E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u0xwnFHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLIWYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:24:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59159 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLIWYr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:24:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1583E22CC2;
        Mon,  9 Dec 2019 17:24:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=04c8za1EoyNz+jHli8DxnyA3gqE=; b=u0xwnF
        HewrqMEg8D4WsO0oEO5t8HK2Dpl/emJmPibSRxedinzFetoSPZBqn2IRirCwYKvW
        yUYyR2d5Pzvz/uKP/9RBmVWNh9iOuPLNNBQbxuhpw0Vhvhol2whZZHUwjZaVHzpp
        sSRk55+KD7LksQQPE9gmNUDLdfCI4JZ2Q31Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JbikLIe3psTLEpifYcfTCIg2ZHzPryVl
        nTYp6YIDs3w26SkauSbWAZhtA6IMLXJgx0D7hzTVMehraqXXZBPpTNB8GHeZh47G
        O446ncRqVcMfevd1wof3Qa9kC9fgA1Mv07z0Nr2Td+s+bQFCU8pPAIghfxSaDULy
        xkwxQg2GVc4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D0E722CC1;
        Mon,  9 Dec 2019 17:24:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B9AB22CC0;
        Mon,  9 Dec 2019 17:24:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH 3/3] git-p4: [usability] Show detailed help when parsing options fail
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
        <2a10890ef76697dbdd67b4c416077726100f88be.1575901009.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:24:43 -0800
In-Reply-To: <2a10890ef76697dbdd67b4c416077726100f88be.1575901009.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Mon, 09 Dec 2019 14:16:49
        +0000")
Message-ID: <xmqq5zipt9w4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B376640C-1AD2-11EA-A968-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> When a user provides invalid parameters to git-p4, the program
> reports the failure but does not provide the correct command syntax.
>
> Add an exception handler to the command-line argument parser to display
> the command's specific command line parameter syntax when an exception
> is thrown. Rethrow the exception so the current behavior is retained.

Makes sense, I guess.

I forgot to mention this, but from the titles of all three patches I
would probably drop [usability] thing and downcase the first verb,
e.g.

    Subject: [PATCH 3/3] git-p4: show detailed help when parsing options fail

if I were writing these patches.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C951C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiB1RRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiB1RRU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 12:17:20 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128970CE7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:16:41 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F7CF181F81;
        Mon, 28 Feb 2022 12:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=028T/ZIvDB2lwcnSMzMdXqkEw8S0dc1RteE6Qb
        i6n7o=; b=MRJN6rFKBN/9WD+2j3bAsDPJWhTLUDziZaOh1u2oQ5m80mWaFnFyCL
        PctiFFLlKa05VHI3NaRe4p3prpOuuVaPLm0nEr36yo2mxksrddAcqKwlmlTzaaXp
        /FndW115K/8eHYUtftS3kJ83Y986kjxp0ACaOc8HBrt+S6wxUlrLw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09838181F80;
        Mon, 28 Feb 2022 12:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 830CF181F7C;
        Mon, 28 Feb 2022 12:16:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] worktree: add -z option for list subcommand
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
        <xmqqh78mesj6.fsf@gitster.g>
        <CAPig+cQF3y64bPN8h4XvAYGX-g0LZedh-cAM+JLKdW_DPAWJaw@mail.gmail.com>
Date:   Mon, 28 Feb 2022 09:16:37 -0800
In-Reply-To: <CAPig+cQF3y64bPN8h4XvAYGX-g0LZedh-cAM+JLKdW_DPAWJaw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 28 Feb 2022 03:35:09 -0500")
Message-ID: <xmqqwnhe3o96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 306E6448-98BA-11EC-A9F9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Unless the original wasn't using quote_c_style() correctly and
>> wasn't quoting its output, that is?
>
> That's the case. It is impossible without this patch since `git
> worktree list --porcelain` does not call quote_c_style() for the
> worktree path; it only calls quote_c_style() for the lock reason.

Yuck.  That's an outright bug that we should fix.  I do not think it
makes "-z" unnecessary, but those who want to read from non-z output
cannot sensibly do so with funny letters in their paths with today's
output, and as long as quote_c_style() tweaks the output only when
funny letters need to be quoted, those who are reading from today's
non-z output will not be hurt, so let's fix that first or at the
same time as we add "-z".

Thanks.

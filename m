Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760EDC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJNVMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJNVMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:12:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF281C5E1E
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:12:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC1FA160AF2;
        Fri, 14 Oct 2022 17:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a4GDnWM9BB2nDnmdQEvxjj2ncSiW7c4K5G4Vkn
        Km/HA=; b=xRM2lS2NlBG1BPrjwR8axlchNK/1xvS5rbJZ0wpRu31gyWKFR2NRfT
        RE9XFWOCsn363aIkKlCJRykaOQvCWz49vzXobT0P1u077iS0QED/7zbFTHaZSSql
        qa/POAjl0yg8g7d5bO3TsNfOcBwxgd0R3aKV6Be5JbOY1UUi7dK3o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4ACD160AF1;
        Fri, 14 Oct 2022 17:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 350C2160AF0;
        Fri, 14 Oct 2022 17:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v3 3/7] builtin: patch-id: fix patch-id with binary diffs
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 14:12:33 -0700
In-Reply-To: <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
        (Jerry Zhang via GitGitGadget's message of "Fri, 14 Oct 2022 08:56:40
        +0000")
Message-ID: <xmqqmt9y6rem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC0F1CA8-4C04-11ED-BB87-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jerry Zhang <Jerry@skydio.com>
>
> "git patch-id" currently doesn't produce correct output if the
> incoming diff has any binary files. Add logic to
> get_one_patchid to handle the different possible styles of binary
> diff. This attempts to keep resulting patch-ids identical to what
> would be produced by the counterpart logic in diff.c, that is it
> produces the id by hashing the a and b oids in succession.

I thought I saw that a previous step touched diff.c to change how
patch ID for a binary diff is computed to match what patch-id
command computes?  Now we also have to change patch-id?  In the end
output from both may match, but which one between diff and patch-id
have we standardised on?

Puzzled...

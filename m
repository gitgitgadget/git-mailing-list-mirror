Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC198C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 17:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiJNRNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiJNRNc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 13:13:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5ECDBE79
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 10:13:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41E481C328A;
        Fri, 14 Oct 2022 13:13:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7iqBgoE422wNLDsx3aKwn16g0QR/RdH5bDrfPn
        iU71g=; b=brPTPTMC9Ms7PRwzRRVHDg9xaI0LD7oYqPGM2ZjAu8RZhpcsWmmXEd
        qHWvfcp6toG1NdpXNGyesReTUyXXQ0ZsEBSIFkfoGu4cdzxyQe8nFI4rCuPxjYTh
        l69kxuDvc9zTTjMnnVJp3McCD+n8WXIVamZIAqOIB0+9y/SxjLbRU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 263FD1C3289;
        Fri, 14 Oct 2022 13:13:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 567C71C3286;
        Fri, 14 Oct 2022 13:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v3 3/7] builtin: patch-id: fix patch-id with binary diffs
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 10:13:27 -0700
In-Reply-To: <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
        (Jerry Zhang via GitGitGadget's message of "Fri, 14 Oct 2022 08:56:40
        +0000")
Message-ID: <xmqqa65y9vm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85420B96-4BE3-11ED-8619-C2DA088D43B2-77302942!pb-smtp20.pobox.com
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

It is sad that we have two separate implementations in the first
place.  Do you see if it is feasible to unify the implementation
by reusing one from the other (answering this is not a requirement
for this patch to be looked at)?


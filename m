Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9917DFA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJURhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJURhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:37:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA926552B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:37:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7418F15A88C;
        Fri, 21 Oct 2022 13:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wTA291TdHrFnG8P7Jm/MRYU02W/dJsSgnbL+uI
        R+Vts=; b=UUy+cTWHmkZy/wmJI5I4e//Rq2BvQU8nSLgM1F5q7QFNeW3HNFZi9k
        BChwhZkb6NugusaINA6OPPepD9+fK6/qM2183TnwjQPXb4DJ/gzJwZBSCqPx8lSI
        6iGxrqvPn/96bsLdsPZ3t5X2f7Z2tbSNRNfCRjlODlsLKrD1mrMFI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5436D15A88B;
        Fri, 21 Oct 2022 13:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6606015A88A;
        Fri, 21 Oct 2022 13:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 3/8] rebase --merge: fix reflog when continuing
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
        <2c965f4b97c1773abc6b844b87fa64c5d6d1524c.1666344108.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 10:37:03 -0700
In-Reply-To: <2c965f4b97c1773abc6b844b87fa64c5d6d1524c.1666344108.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 09:21:43
        +0000")
Message-ID: <xmqqk04tm62o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FACDC480-5166-11ED-88D4-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... This
> introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
> in pick_commits().

Is it just the matter of freeing previous_reflog_action after you
call setenv(), or does it take much more involved changes?

> Both of these will be fixed in a future series that
> stops the sequencer calling setenv().

If it gets fixed in a future step in the same series, that is a
different matter, but if it is easy enough not to deliberately
introduce a new leak, we'd prefer to do so.

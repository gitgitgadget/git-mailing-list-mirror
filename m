Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1847C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6856604DC
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhHIVP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:15:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55684 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhHIVP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 17:15:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BA75D060F;
        Mon,  9 Aug 2021 17:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2FTq6Y+pyrjISCDSgtyz8clpBAl+M9dDkyTyWS
        ndDRU=; b=K8qvqjgP0kUV8IuxOpcGQsNPZ3Z+QufMMW2+PSjcmh7Evh36EXWqb/
        vrg3F4AMY7fiVijt0neI16u58YzmhhOzNbWO/pMwEHuCge24Y+QxRiywtfF3o4Cb
        T2am3zCuaqOqDj43Is3LsY6H7rIzYpKAP+GmWEeZCG469YD5U4WtQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1FA4D060C;
        Mon,  9 Aug 2021 17:15:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E68BD060B;
        Mon,  9 Aug 2021 17:15:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v4] clone: update submodule.recurse in config when using
 --recurse-submodule
References: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
        <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
Date:   Mon, 09 Aug 2021 14:15:05 -0700
In-Reply-To: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com> (Mahi
        Kolla via GitGitGadget's message of "Mon, 09 Aug 2021 19:11:45 +0000")
Message-ID: <xmqqzgtqe2w6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEA3207A-F956-11EB-8D15-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mahi Kolla <mahikolla@google.com>
>
> When running 'git clone --recurse-submodules', developers might expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules. Set 'submodule.recurse' to true when 'git clone' is run with '--recurse-submodules'.

Please wrap overlong lines in your proposed log message to say 70 or
so columns.

Some developers might expect, but wouldn't some others want to see
this not set to true, but want to recurse only into some but not all
submodules?

Is it possible to avoid changing the behaviour unconditionally and
potentially breaking existing users by making it an opt-in feature,
e.g. "git clone --recurse-submodules" would work as the current
users would expect, while "git clone --recurse-submodules=sticky"
would set submodule.recurse to true, or something?

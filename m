Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E465C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 06:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiHCGDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCGDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 02:03:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB53C1707A
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 23:03:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93729131387;
        Wed,  3 Aug 2022 02:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kYaQr48CxJqlrgk08mduK8AkcgX0FvnNFQp/so
        SM7jk=; b=oBnPOhhwrwCRqa/KkVQUr6zssp4rNV7AUFu1SV+X0TyJzLakB3UoEl
        2mBFA62YsTy9cgbOjCBCiZURuuI5YwRImtSTwSzN6/zEDK1WIMVqxLleK+3vaAg8
        AY4tk9RR39VXWu/naFbAYfPATifadAx6ZzaSLZR2ZJbxW/tFzLz1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88882131385;
        Wed,  3 Aug 2022 02:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6343131384;
        Wed,  3 Aug 2022 02:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 01/10] refs: allow "HEAD" as decoration filter
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1659122979.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 23:03:06 -0700
In-Reply-To: <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1659122979.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 29 Jul 2022
        19:29:30 +0000")
Message-ID: <xmqqedxxeued.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F23F673C-12F1-11ED-A22A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	if (prefix) {
>  		strbuf_addstr(&normalized_pattern, prefix);
> -	}
> -	else if (!starts_with(pattern, "refs/"))
> +	} else if (!starts_with(pattern, "refs/") &&
> +		   strcmp(pattern, "HEAD"))

Perhaps leave a needswork comment to remind us to later consider
covering all the pseudorefs like MERGE_HEAD, CHERRY_PICK_HEAD etc.?

>  		strbuf_addstr(&normalized_pattern, "refs/");

Style:

If you plan to add more code to the bodies of this if/elseif, then
have {} around all arms.  Otherwise, let's lose the {} around the
body of "if (prefix)".



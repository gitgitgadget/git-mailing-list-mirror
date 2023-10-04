Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0DCE8FDC1
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 00:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjJDAUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 20:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbjJDAUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 20:20:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C8DA9
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 17:20:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF5ED199BAB;
        Tue,  3 Oct 2023 20:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VAMj0gHIq2j+t5hp2E9UQtFm8hkcTtFFoeNAuq
        AAzzc=; b=Iy6MSItoBqClT7KqW70bhra+l3pgyR4U49/zunkujAFHXZ3SblB4jq
        +KY3/0zXVo6W/5kuLosugEeyoOSi7QG41plIMSgD/b4KVXjnFXrHyFZuMgQqXbGO
        6bWIm25BrSh/DPo3nsu5lQLJeRdib+oEOYpWC7WjzCAhBw6H7PvHM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6823199BAA;
        Tue,  3 Oct 2023 20:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49C1E199BA9;
        Tue,  3 Oct 2023 20:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] t7419: Actually test the branch switching
In-Reply-To: <20231003185047.2697995-3-heftig@archlinux.org> (Jan Alexander
        Steffens's message of "Tue, 3 Oct 2023 20:50:44 +0200")
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
        <20231003185047.2697995-1-heftig@archlinux.org>
        <20231003185047.2697995-3-heftig@archlinux.org>
Date:   Tue, 03 Oct 2023 17:20:43 -0700
Message-ID: <xmqqedibutk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBB47FF2-624B-11EE-BF3A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jan Alexander Steffens (heftig)" <heftig@archlinux.org> writes:

> Subject: Re: [PATCH 3/6] t7419: Actually test the branch switching

"Actually" -> "actually".

> The submodule repo the test set up had the 'topic' branch checked out,
> meaning the repo's default branch (HEAD) is the 'topic' branch.
>
> The following tests then pretended to switch between the default branch
> and the 'topic' branch. This was papered over by continually adding
> commits to the 'topic' branch and checking if the submodule gets updated
> to this new commit.
>
> Return the submodule repo to the 'main' branch after setup so we can
> actually test the switching behavior.

Nicely spotted.

> diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
> index 232065504c..5ac16d0eb7 100755
> --- a/t/t7419-submodule-set-branch.sh
> +++ b/t/t7419-submodule-set-branch.sh
> @@ -11,23 +11,28 @@ as expected.
>  
>  TEST_PASSES_SANITIZE_LEAK=true
>  TEST_NO_CREATE_REPO=1
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

And it is good that this variable is used to prepare the test for
both kinds of CI runs that use 'main' or 'master' as the default
branch.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC5C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A9161131
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhIVXIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:08:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59231 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhIVXIT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 19:08:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D4DAEAB10;
        Wed, 22 Sep 2021 19:06:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rYOSnwvxCCRuuOaPrt6t1dH1xBllKPmM0UC9tC
        z+v44=; b=iTzt+dnpoTtk6RdsYmNdhLYbTr6qjRWNoV5GYscw0ODLRlPgOGitZx
        Koy0D9YbazE9RpF0BjugmV7DxcA6apiGx2vCbVg1Bv2sbd/5/DxZY4BKY2iLGCmL
        Azl70rrLnksIQkMEXrG+D1HmdPjA1O/aqLPBcxNDC6KwmAxg/M2pM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34AB3EAB0F;
        Wed, 22 Sep 2021 19:06:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96A21EAB0E;
        Wed, 22 Sep 2021 19:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 02/14] t1092: behavior for adding sparse files
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <c7dedb41291ed6ff48dd9b9b9814e3040f4fa92c.1632159937.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Sep 2021 16:06:46 -0700
In-Reply-To: <c7dedb41291ed6ff48dd9b9b9814e3040f4fa92c.1632159937.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 20 Sep 2021
        17:45:25 +0000")
Message-ID: <xmqq35pw5hx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C323F098-1BF9-11EC-9A2E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add some tests to demonstrate the current behavior around adding files
> outside of the sparse-checkout cone. Currently, untracked files are
> handled differently from tracked files. A future change will make these
> cases be handled the same way.
>
> Further expand checking that a failed 'git add' does not stage changes
> to the index.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 886e78715fe..3fb764f5eb9 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -187,6 +187,16 @@ test_sparse_match () {
>  	test_cmp sparse-checkout-err sparse-index-err
>  }
>  
> +test_sparse_unstaged () {
> +	file=$1 &&
> +	for repo in sparse-checkout sparse-index
> +	do
> +		git -C $repo status --porcelain >$repo-out &&
> +		! grep "^A  $file\$" $repo-out &&
> +		! grep "^M  $file\$" $repo-out || return 1

Is addition and modification very special, as opposed to other kinds
of changes?  Is the reason why we say "we do not want to see
addition nor modification" here because there is no concrete X that
we can say "we do want to see X" in various callers of this helper?

I am also wondering, if this is asserting that $file is not added to
the index, why we are using "git status" and not "ls-files", for
example.  Wouldn't

    test_must_fail git ls-files --error-unmatch "$file"

be a more direct way to do so?

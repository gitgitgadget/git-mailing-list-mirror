Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03979C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA0D613CD
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhDTSJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 14:09:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63960 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhDTSJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 14:09:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42676B81CE;
        Tue, 20 Apr 2021 14:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O48XavJpeOAUZgcwb/QpEs0e53w=; b=MkmYVO
        CB5aLXRGUKpadhVfYS5PPLM+oTy7hsT9u53H10ZSJsj8lnn5SnfPu6bvJLD9gy46
        4+IVm4A5Q6QcujhE7GhhncSq4e3Fu6geJzaATDqiLtzOFS49gBsuQolorAm3NoYj
        MduAtOcLykdZgu3DDacrh8d8rU717DUGg3QPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vCkc1ymzHrlTbOlkMc1MWtZT/lZFD+5M
        JxrXG0KH4DJnSoED29QD1Ui4pS2QvPaNL64/nHc4Ify0EvstvGgW5sVgNtTizOro
        u9hyCTJOG62TCxUIyR/Q9tc/E+4rFfK+6DS/6C2/hUYO0uyCtSo50PIrpzu72q8E
        tVmA3Jrj0fc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 393DCB81CD;
        Tue, 20 Apr 2021 14:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA93FB81CB;
        Tue, 20 Apr 2021 14:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     trygveaa@gmail.com, git@vger.kernel.org, mirucam@gmail.com,
        pranit.bauva@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH] test: add test for git bisect skip with --term* arguments
References: <20210418151459.GC10839@aaberge.net>
        <20210420123435.35936-1-bagasdotme@gmail.com>
Date:   Tue, 20 Apr 2021 11:08:55 -0700
In-Reply-To: <20210420123435.35936-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Tue, 20 Apr 2021 19:34:36 +0700")
Message-ID: <xmqqa6ps7rrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 789E2F18-A203-11EB-BCB4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> NOTE: this patch is not intended for integrating into git.git, but
> rather this patch is written to demonstrate this breakage. I hope that
> the test can be added to t6030-bisect-porcelain.sh, and make this patch
> redundant.  

Then perhaps add it to where you think it belongs to before you
post?

In any case, let's critique the patch a bit for future reference,
with a hope that you'd be contributing more ;-).

>  t/t6031-bisect-skip.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 t/t6031-bisect-skip.sh

Good; many new people forget to make these executable.

> +test_description='Tests git bisect --skip'
> +
> +exec </dev/null

Why?

> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +# hash variables
> +HASH_SKIPPED_FROM=
> +HASH_SKIPPED_TO=
> +
> +# initialize testing repo
> +init() {

Style.

> +	for i in `seq 1 20`; do

Use $(test_seq ...)

> +		echo $i >> test &&

Style

> +		git add test && git commit -m $i
> +	done
> +}
> +
> +init

We do that in the first "test_expect_success setup '... code ...'" block
to catch breakages in the initialization.

> +test_expect_success 'test moving HEAD when skip bisecting' '
> +	git bisect start --term-new=ok --term-old=whoops HEAD HEAD~9 &&
> +	HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
> +	git bisect skip &&
> +	HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
> +	test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
> +'

Missing "test_done".

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1384C1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 01:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfJLB0F (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 21:26:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52437 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfJLB0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 21:26:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5F232DB6E;
        Fri, 11 Oct 2019 21:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=hhoJ4mPZ1wuTbZPPn5fyRy5OUm0=; b=O8TOQZ
        iYDYWh+3hXN6pmSpw2hT5DdwCRBKS2ESJGUjT+CawFTzyd/qDeZtYzx5R2rtA4tk
        G1MwhTHzFSKrTpVKZb1rz2hfpdQmPLmvSnZO5h4gsfAxCkxlF/l+UJQrPdjhFQSJ
        G2GfQy4GLUgFozXat4lWWwlSnbyRv95OteMeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GmPqSdAIEhg2tHQDAMdwz0litH6KCxoO
        VbMx9iccksR4pOxi1Xy2OQUHYmNdFjc1dkGA3coDK3XiIr55z4vpM9I579uQJxHH
        SnC4oQqwHYBO8AgIH17DE+eBsWNG5sYtRD4JcJuP/MTrhO9geJJWs36x4thFIATG
        wa71WkG2jlc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBA192DB6D;
        Fri, 11 Oct 2019 21:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EC032DB6C;
        Fri, 11 Oct 2019 21:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com, William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v3 1/1] fsmonitor: don't fill bitmap with entries to be removed
In-Reply-To: <840972e08b2178e89b2c3ed77eb20c91ead894ad.1570824681.git.gitgitgadget@gmail.com>
        (William Baker via GitGitGadget's message of "Fri, 11 Oct 2019
        13:11:23 -0700 (PDT)")
References: <pull.372.v2.git.gitgitgadget@gmail.com>
        <pull.372.v3.git.gitgitgadget@gmail.com>
        <840972e08b2178e89b2c3ed77eb20c91ead894ad.1570824681.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Sat, 12 Oct 2019 10:26:00 +0900
Message-ID: <xmqq1rvig3fb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40B389A2-EC8F-11E9-8D6D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +# Test staging/unstaging files that appear at the end of the index.  Test
> +# file names begin with 'z' so that they are sorted to the end of the index. 

Well, the test is now done in a freshly created repository, so the
z* files are the only thing you have in here---technically they are
at the end of the index, but so they are at the beginning, too.

Would it affect the effectiveness of the test that you do not have
any other paths in the working tree or in the index, unlike the test
in the previous rounds that did not use a newly created test
repository?  

This is not a rhetorical question, but purely asking. "no, this
still tests what we want to test and shows breakage when the fix to
the code in the patch gets reverted" is perfectly a good answer, but
in that case, is "the end of" the most important trait of the
condition this test is checking?  Wouldn't the bug be exposed as
long as we remove sufficiently large number of entries (like
"removing more paths than the paths still in the index at the end"
or something like that)?

Thanks.

> +test_expect_success 'status succeeds after staging/unstaging ' '
> +	test_create_repo fsmonitor-stage-unstage &&
> +	(
> +		cd fsmonitor-stage-unstage &&
> +		test_commit initial &&
> +		git update-index --fsmonitor &&
> +		removed=$(test_seq 1 100 | sed "s/^/z/") &&
> +		touch $removed &&
> +		git add $removed &&
> +		git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-env" &&
> +		FSMONITOR_LIST="$removed" git restore -S $removed &&
> +		FSMONITOR_LIST="$removed" git status
> +	)
> +'
> +
>  test_done
> diff --git a/t/t7519/fsmonitor-env b/t/t7519/fsmonitor-env
> new file mode 100755
> index 0000000000..8f1f7ab164
> --- /dev/null
> +++ b/t/t7519/fsmonitor-env
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +#
> +# An test hook script to integrate with git to test fsmonitor.
> +#
> +# The hook is passed a version (currently 1) and a time in nanoseconds
> +# formatted as a string and outputs to stdout all files that have been
> +# modified since the given time. Paths must be relative to the root of
> +# the working tree and separated by a single NUL.
> +#
> +#echo "$0 $*" >&2
> +
> +if test "$#" -ne 2
> +then
> +	echo "$0: exactly 2 arguments expected" >&2
> +	exit 2
> +fi
> +
> +if test "$1" != 1
> +then
> +	echo "Unsupported core.fsmonitor hook version." >&2
> +	exit 1
> +fi
> +
> +printf '%s\n' $FSMONITOR_LIST

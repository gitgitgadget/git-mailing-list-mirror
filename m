Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE7C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DDA2083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P3yYWAil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgJGUWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:22:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62821 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJGUWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 16:22:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C81F2EEA97;
        Wed,  7 Oct 2020 16:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tsH5L+Opcx2hnx7ih2CpsXxvruc=; b=P3yYWA
        ileq+k2StML3b3tbUjftVfBjEFfPIlZRrggw24VVpmhg1UkDbnBV87dgWv7Cdul9
        SxRgYEhC5Qk5dDPYNhxUR+u9xRMrwK/MjEw9vLWCL+Hy9vjDNowUdT+QH5qXWH+s
        00tC2zS71d9oAfJAhpESlRLqZQwKJVtauCst0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tk1QhDTRvPOpsl4lP7620VYq3qXvqjaM
        xgRObC5C6Hk5HhRSENffxvVmDswit06MSj0iEEBGRCSUnY4NErUvnHTx60mcJ/aW
        4A+16whvZQf/34GR7+eU7yqSG+4s9hv4HYfZogIa2FWExxtJ2o+AyD+4bx67XRTy
        MvQXo/g0xAY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABD33EEA96;
        Wed,  7 Oct 2020 16:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE88BEEA95;
        Wed,  7 Oct 2020 16:22:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] maintenance: test commit-graph auto condition
References: <pull.746.git.1602075317625.gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 13:22:07 -0700
In-Reply-To: <pull.746.git.1602075317625.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 07 Oct 2020 12:55:17
        +0000")
Message-ID: <xmqqblhd23dc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C664622A-08DA-11EB-91C6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The auto condition for the commit-graph maintenance task walks refs
> looking for commits that are not in the commit-graph file. This was
> added in 4ddc79b2 (maintenance: add auto condition for commit-graph
> task, 2020-09-17) but was left untested.
>
> The initial goal of this change was to demonstrate the feature works
> properly by adding tests. However, there was an off-by-one error that
> caused the basic tests around maintenance.commit-graph.auto=1 to fail
> when it should work.
>
> The subtlety is that if a ref tip is not in the commit-graph, then we
> were not adding that to the total count. In the test, we see that we
> have only added one commit since our last commit-graph write, so the
> auto condition would say there is nothing to do.
>
> The fix is simple: add the check for the commit-graph position to see
> that the tip is not in the commit-graph file before starting our walk.
> Since this happens before adding to the DFS stack, we do not need to
> clear our (currently empty) commit list.
>
> This does add some extra complexity for the test, because we also want
> to verify that the walk along the parents actually does some work. This
> means we need to add at least two commits in a row without writing the
> commit-graph. However, we also need to make sure no additional refs are
> pointing to the middle of this list or else the for_each_ref() in
> should_write_commit_graph() might visit these commits as tips instead of
> doing a DFS walk. Hence, the last two commits are added with "git
> commit" instead of "test_commit".
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     maintenance: test commit-graph auto condition
>     
>     As promised [1], here is a test to check that
>     maintenance.commit-graph.auto behaves correctly. In the process, I found
>     a small off-by-one error that is not super-critical, but worth fixing.
>     
>     Thanks, -Stolee
>     
>     [1] 
>     https://lore.kernel.org/git/cfc8a8e9-f812-2cb1-f6d8-57ef585346d1@gmail.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-746%2Fderrickstolee%2Fmaintenance%2Fcg-auto-test-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-746/derrickstolee/maintenance/cg-auto-test-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/746
>
>  builtin/gc.c           |  8 +++++++-
>  t/t7900-maintenance.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)

Hmph.  Something in ds/maintenance-part-2 series does not seem to
work well with this change.  I noticed it when testing today's first
integration cycle of jch and seen branches, but even when applied to
ds/maintenance-part-2 alone without any other topics in seen, it
seems to break in an unexpected place.

    $ git checkout -b ds/maintenance-commit-graph-auto-fix
    $ git am -s $this_message
    $ git checkout ds/maintenance-part-2^0
    $ git cherry-pick ds/maintenance-commit-graph-auto-fix
    $ make && (cd t && sh t7900-maintenance.sh -i -v)
    ...
    expecting success of 7900.9 'prefetch multiple remotes':
    ...
    Cloning into 'clone1'...
    done.
    Cloning into 'clone2'...
    done.
    Switched to a new branch 'one'
    Switched to a new branch 'two'
    On branch one
    nothing to commit, working tree clean
    not ok 9 - prefetch multiple remotes

Perhaps the new test added here breaks the expectation of tests
added in the other series?

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 53c883531e..3e16439bf6 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -52,6 +52,35 @@ test_expect_success 'run --task=<task>' '
>  	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
>  '
>  
> +test_expect_success 'commit-graph auto condition' '
> +	COMMAND="maintenance run --task=commit-graph --auto --quiet" &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/cg-no.txt" \
> +		git -c maintenance.commit-graph.auto=1 $COMMAND &&
> +	GIT_TRACE2_EVENT="$(pwd)/cg-negative-means-yes.txt" \
> +		git -c maintenance.commit-graph.auto="-1" $COMMAND &&
> +
> +	test_commit one &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/cg-zero-means-no.txt" \
> +		git -c maintenance.commit-graph.auto=0 $COMMAND &&
> +	GIT_TRACE2_EVENT="$(pwd)/cg-one-satisfied.txt" \
> +		git -c maintenance.commit-graph.auto=1 $COMMAND &&
> +
> +	git commit --allow-empty -m "two" &&
> +	git commit --allow-empty -m "three" &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/cg-two-satisfied.txt" \
> +		git -c maintenance.commit-graph.auto=2 $COMMAND &&
> +
> +	COMMIT_GRAPH_WRITE="git commit-graph write --split --reachable --no-progress" &&
> +	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-no.txt &&
> +	test_subcommand $COMMIT_GRAPH_WRITE <cg-negative-means-yes.txt &&
> +	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-zero-means-no.txt &&
> +	test_subcommand $COMMIT_GRAPH_WRITE <cg-one-satisfied.txt &&
> +	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
> +'
> +
>  test_expect_success 'run --task=bogus' '
>  	test_must_fail git maintenance run --task=bogus 2>err &&
>  	test_i18ngrep "is not a valid task" err
>
> base-commit: 25914c4fdeefd99b06e134496dfb9bbb58a5c417

Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E072CC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF934207D8
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 16:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1Wlpori"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgFDQ5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:57:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57610 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQ5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 12:57:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 201BE501CA;
        Thu,  4 Jun 2020 12:57:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=umZfJDepxqDeB5gH2yEqrj51kno=; b=U1Wlpo
        ries/MMN8Ui1jneeacl5GHXYhZXYXMXyyDNXbflETOcnGqjpTiMpAZKsluBKdGpy
        Al0exQnFZaWdWzXvgLj1Hauq1+K+wlDs9X7Ld2zZelzS8MgNjsGJlsso7brCAeM6
        pmU8SIgzQtYrUbUeqwedxdqzfx8/VtEKTt8bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CLpoU/4Uf7lPd7PfdFlFekB86E1qWWam
        A3XYabaP2/nFX4Oqew5vPEpnJGccNE2xH000P6dcC/RZKNh1lG4huO3u5ugSJ5Md
        ebGDpbsgc8qekseSb4PDk2ux6tzqbzlso3+p9T0l8nAvuFG1V6V4HLkTyCXS7phr
        VSwtKgo5lSY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17DB6501C8;
        Thu,  4 Jun 2020 12:57:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 915A6501C5;
        Thu,  4 Jun 2020 12:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, warmsocks@gmail.com, stolee@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout: avoid staging deletions of all files
References: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com>
Date:   Thu, 04 Jun 2020 09:57:51 -0700
In-Reply-To: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 04 Jun 2020 08:17:37
        +0000")
Message-ID: <xmqq4krqrcog.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 876BD278-A684-11EA-BF1B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...  Thus, instead of all the files appearing deleted in `git
> status` being known to git as a special artifact of not yet being on a
> branch, our recording of an empty index made it suddenly look to git as
> though it was definitely on a branch with ALL files staged for deletion!
> A subsequent checkout or switch then had to contend with the fact that
> it wasn't on an initial_checkout but had a bunch of staged deletions.

Nicely analysed and explained.

> Make sure that sparse-checkout changes nothing in the index other than
> the SKIP_WORKTREE bit; in particular, when the index is unborn we do not
> have any branch checked out so there is no sparsification or
> de-sparsification work to do.  Simply return from
> update_working_directory() early.

OK, and that would avoid writing out an empty index, leaving the
"is_index_unborn()" still true after we are done.  Makes sense.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     sparse-checkout: avoid staging deletions of all files
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-801%2Fnewren%2Fsparse-checkout-and-unborn-index-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-801/newren/sparse-checkout-and-unborn-index-v1
> Pull-Request: https://github.com/git/git/pull/801
>
>  builtin/sparse-checkout.c          |  4 ++++
>  t/t1091-sparse-checkout-builtin.sh | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 95d08824172..595463be68e 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -99,6 +99,10 @@ static int update_working_directory(struct pattern_list *pl)
>  	struct lock_file lock_file = LOCK_INIT;
>  	struct repository *r = the_repository;
>  
> +	/* If no branch has been checked out, there are no updates to make. */
> +	if (is_index_unborn(r->index))
> +		return UPDATE_SPARSITY_SUCCESS;
> +
>  	memset(&o, 0, sizeof(o));
>  	o.verbose_update = isatty(2);
>  	o.update = 1;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 88cdde255cd..bc287e5c1fa 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -100,6 +100,25 @@ test_expect_success 'clone --sparse' '
>  	check_files clone a
>  '
>  
> +test_expect_success 'interaction with clone --no-checkout (unborn index)' '
> +	git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
> +	git -C clone_no_checkout sparse-checkout init --cone &&
> +	git -C clone_no_checkout sparse-checkout set folder1 &&
> +	git -C clone_no_checkout sparse-checkout list >actual &&
> +	cat >expect <<-\EOF &&
> +	folder1
> +	EOF
> +	test_cmp expect actual &&
> +	ls clone_no_checkout >actual &&
> +	test_must_be_empty actual &&
> +	test_path_is_missing clone_no_checkout/.git/index &&
> +
> +	# No branch is checked out until we manually switch to one
> +	git -C clone_no_checkout switch master &&
> +	test_path_is_file clone_no_checkout/.git/index &&
> +	check_files clone_no_checkout a folder1
> +'
> +
>  test_expect_success 'set enables config' '
>  	git init empty-config &&
>  	(
>
> base-commit: 20514004ddf1a3528de8933bc32f284e175e1012

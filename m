Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C61195F28
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634294; cv=none; b=S73MYUHJ/bm7Y6/f1iJtO/XDGT42Id0fpA4oKB6a9gC3T0eqANeuUCEbK+U2gXg5D083bE8lFx5+UpMU0tNKC3ZaXxMUChpy+z/NqO5lMtFxiWc0vIC575e8h+2KDjQTswi7p76VXkcctoYmENCkRhkuU4x772+fAHuySqGBdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634294; c=relaxed/simple;
	bh=/nk7k1TmeELaU/SHzxLVD2HMTQs1UcHyKiHv7330AOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K8tqFR0SQSCsQSGlBDA0+c90iKfDvWl7bWAiU72KYTfvp51QyNHTh3fw2H0SEUj1czImg5ZJQER17OdoH2SyAxN6tQ+CLWZ5Z1xgsorN5DfS9OApMmDX2MGd+Tweks62lFis3p9tmR49lbih/JFrLPcdVNfgDMpd/dUOtx0vz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k0kuoNEa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0kuoNEa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0950A1EC20;
	Wed, 10 Jul 2024 13:58:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/nk7k1TmeELaU/SHzxLVD2HMTQs1UcHyKiHv73
	30AOE=; b=k0kuoNEaIAmHj5So/Bnu1VNk1hDllVGMN5tISOiCmpZBk1+s1UjtFi
	2VP5ogWReF7J17FQk7okNdrxqYHqQ0jjGLmSLy6iqj9AXv+zkSw0Ns7nOH0eZhRF
	G4R3KBsDhYVMjDlUz85VuspkFVKpR2WeGU8qfKAeFuH/s+jgqGxqY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00E781EC1F;
	Wed, 10 Jul 2024 13:58:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A3351EC1E;
	Wed, 10 Jul 2024 13:58:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Antonin Delpeuch <antonin@delpeuch.eu>,
    Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] merge-recursive: honor diff.algorithm
In-Reply-To: <pull.1743.v2.git.git.1720551701648.gitgitgadget@gmail.com>
	(Antonin Delpeuch via GitGitGadget's message of "Tue, 09 Jul 2024
	19:01:41 +0000")
References: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
	<pull.1743.v2.git.git.1720551701648.gitgitgadget@gmail.com>
Date: Wed, 10 Jul 2024 10:58:06 -0700
Message-ID: <xmqqmsmpw2mp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6E7A67E-3EE5-11EF-9B17-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> The documentation claims that "recursive defaults to the diff.algorithm
> config setting", but this is currently not the case. This fixes it,
> ensuring that diff.algorithm is used when -Xdiff-algorithm is not
> supplied. This affects the following porcelain commands: "merge",
> "rebase", "cherry-pick", "pull", "stash", "log", "am" and "checkout".
> It also affects the "merge-tree" ancillary interrogator.

Unfortunate.

Since be733e12 (Merge branch 'en/merge-tree', 2022-07-14),
merge-tree is no longer an interrogator but works as an manipulator.
As it is meant to be used as a building block that gives a reliable
and repeatable output, I am tempted to say it should be categorized
as a plumbing, but second opinions do count.  Elijah Cc'ed as it was
his "fault" to add "--write-tree" mode to the command and forgetting
to update command-list.txt ;-)

But I agree with the direction of this patch and the structure of
the solution (i.e. have two variants of init_*_options()).

> This change refactors the initialization of merge options to introduce
> two functions, "init_merge_ui_options" and "init_merge_basic_options"
> instead of just one "init_merge_options". This design follows the
> approach used in diff.c, providing initialization methods for
> porcelain and plumbing commands respectively. Thanks to that, the
> "replay" and "merge-recursive" plumbing commands remain unaffected by
> diff.algorithm.

In other words, these two are the only ones that use the _basic
variant.

I am unsure (read: do not take this as my recommendation to change
your patch) which one merge-tree should use, but other than that,
nicely done.

> diff --git a/log-tree.c b/log-tree.c
> index 101079e8200..5d8fb6ff8df 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1025,7 +1025,7 @@ static int do_remerge_diff(struct rev_info *opt,
>  	struct strbuf parent2_desc = STRBUF_INIT;
>  
>  	/* Setup merge options */
> -	init_merge_options(&o, the_repository);
> +	init_ui_merge_options(&o, the_repository);
>  	o.show_rename_progress = 0;
>  	o.record_conflict_msgs_as_headers = 1;
>  	o.msg_header_prefix = "remerge";

Isn't log-tree shared with things like "git diff-tree" porcelain?

> -static void merge_recursive_config(struct merge_options *opt)
> +static void merge_recursive_config(struct merge_options *opt, int ui)
>  {
>  	char *value = NULL;
>  	int renormalize = 0;
> @@ -3930,11 +3930,20 @@ static void merge_recursive_config(struct merge_options *opt)
>  		} /* avoid erroring on values from future versions of git */
>  		free(value);
>  	}
> +	if (ui) {
> +		if (!git_config_get_string("diff.algorithm", &value)) {
> +			long diff_algorithm = parse_algorithm_value(value);
> +			if (diff_algorithm < 0)
> +				die(_("unknown value for config '%s': %s"), "diff.algorithm", value);
> +			opt->xdl_opts = (opt->xdl_opts & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
> +			free(value);
> +		}
> +	}
>  	git_config(git_xmerge_config, NULL);
>  }

This looks sensible.  Even though we have a single merge_recursive()
that is internally callable, depending on the callers, they may or
may not want to be affected by configuration.

As to the tests, it felt a bit unnatural and error prone to make
t7615 depend on material that appears to be made only for t3515 (by
naming the directory as such).

We have not done "a test-material directory that is shared among
multiple tests" in t/, but we have plenty of "test helpers that are
shared across multiple tests" named lib-foo.sh.  I wonder if
doing something like

	... in t/lib-histogram-merge-history.sh ...
	# prepare history for merges that depend on diff.algorithm
	setup_history_for_histogram () {
		cat >file.c <<\EOF &&
		... contents of base.c ...
		EOF
		git add file.c &&
		git commit -m c0 &&
		git tag c0 &&

		cat >file.c <<\EOF &&
		... contents of ours.c ...
		EOF
		...
                git tag c2
	}		

and make the setup step in t3515 (and t7615) use that shared set-up
function like so:

	. ./test-lib.sh
	. "$TEST_DIRECTORY/test-lib-histogram-merge/history.sh"

	test_expect_success setup '
		setup_history_for_histogram
	'

may be cleaner?  I am mostly afraid of mistakes like "now we are
done with the area 3515 covered let's remove all the traces of it,
like t3515-cherry-pick-diff.sh and t3515/ directory", breaking an
seemingly unrelated t7615.

Even better.  Can't we save the scarce resource that is test number
and make these not about "I test cherry-pick" and "I test merge"?
You are testing how mergy operations are affected by the choice of
diff.algorithm, so perhaps create a single test file and name it
after that single shared aspect of the tests you are adding?
Perhaps t/t7615-diff-algo-with-mergy-operations.sh that has all
three of these:

 * the setup_history_for_histogram() helper function as described
   above;

 * the test for cherry-pick in this patch;

 * the test for merge in this patch.

Thanks.

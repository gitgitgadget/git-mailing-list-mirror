Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B2C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACBD2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J4ILYJbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgHQVj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:39:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62602 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQVjy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:39:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 758F8E05B1;
        Mon, 17 Aug 2020 17:39:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L6GicUHbOB3YrX5EtDBOW3G9+VI=; b=J4ILYJ
        bwL1QBAEr7/pY5XlUO/N0gyqkMo+vztxpCvxn9/flOfJOeB6OpLHPuHjVEH4VR2u
        H1LLnXSnSJ5k/StRSHfCt/AucpJoq2olPuMHffYSK+0ei4LYei7qSrqG4sWjTNvi
        W3YCPg1Frvmre9V1PquljYAj2aPwSfWYaMpfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n9J0VRgIqUrHOiEnxlvHVCV0IfmXOFOk
        8aQ4KUzYd/Q7gfIXkB6nosmtvQZ6wrtXf9kf44Fd7pRym3G1WGsZKAO+uoxMd3u2
        2D5PlJJH/3UaxnWVt41Nw1/u96uqbARAMKJBuapIGVOfbFQ42mFcOWxN+gw6+Xiu
        VEhZLsJ53C8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DFCAE05B0;
        Mon, 17 Aug 2020 17:39:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5673E05AF;
        Mon, 17 Aug 2020 17:39:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2] diff: teach --stat to ignore uninteresting modifications
References: <pull.689.git.1596324796918.gitgitgadget@gmail.com>
        <pull.689.v2.git.1597445151824.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 14:39:48 -0700
In-Reply-To: <pull.689.v2.git.1597445151824.gitgitgadget@gmail.com> (Matthew
        Rogers via GitGitGadget's message of "Fri, 14 Aug 2020 22:45:51
        +0000")
Message-ID: <xmqqpn7pymsb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D64CEB4-E0D2-11EA-8C94-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> Sometimes when diffing, files may show as being momdified even when

momdified? mummified? ah, modified.

> there are no interesting diffs to show.  This happens naturally when
> using options such as --ignore-space-change.  

Read the next paragraph and notice that it explains the cases where
the patch does not want not to show, and then read the above again
to realize that the above does not say anything about what it wants
to do to cases the next paragraph does not cover.  It only says such
a case often happens when --ignore-space-change is used.

	When options like --ignore-space-change is in use, files
	with modification can have no interesting textual changes
	worth showing.  In such cases, "git diff --stat" shows 0
	lines of additions and deletions.  Teach "git diff --stat"
	not to show such a path in its output, which would be more
	natural.

perhaps?

> We don't want to prevent
> the display  of all files that have 0 effective diffs since they could
> be the result of a rename, permission change, or other similar operation
> that may still be of interest so we special case additions and deletions
> as they are always interesting.

Yup.  That makes sense.  

It would be nice if this does not have to be implemented as a list
of exceptions, though.  Rather, a more targetted "omit output only
in this narrow case" would be nicer, but the check with the mode
bits should do at lesat for now.

> diff --git a/diff.c b/diff.c
> index f9709de7b4..131903fa3a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3153,16 +3153,19 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
>  	gather_dirstat(options, &dir, changed, "", 0);
>  }
>  
> +static void free_diffstat_file(struct diffstat_file *f)
> +{
> +	free(f->print_name);
> +	free(f->name);
> +	free(f->from_name);
> +	free(f);
> +}
> +
>  void free_diffstat_info(struct diffstat_t *diffstat)
>  {
>  	int i;
> -	for (i = 0; i < diffstat->nr; i++) {
> -		struct diffstat_file *f = diffstat->files[i];
> -		free(f->print_name);
> -		free(f->name);
> -		free(f->from_name);
> -		free(f);
> -	}
> +	for (i = 0; i < diffstat->nr; i++)
> +		free_diffstat_file(diffstat->files[i]);
>  	free(diffstat->files);
>  }
>  
> @@ -3718,6 +3721,26 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  		if (xdi_diff_outf(&mf1, &mf2, discard_hunk_line,
>  				  diffstat_consume, diffstat, &xpp, &xecfg))
>  			die("unable to generate diffstat for %s", one->path);
> +
> +		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
> +			struct diffstat_file *file = 
> +				diffstat->files[diffstat->nr - 1];
> +			/*
> +			 * Omit diffstats of modified files where nothing changed. 
> +			 * Even if !same_contents, this might be the case due to
> +			 * ignoring whitespace changes, etc.
> +			 * 
> +			 * But note that we special-case additions and deletions,

			 * renames and mode changes without any content changes,

> +			 * as adding an empty file, for example is still of interest.
> +			 */
> +			if ((p->status == DIFF_STATUS_MODIFIED) 
> +				&& !file->added
> +				&& !file->deleted
> +				&& one->mode == two->mode) {
> +				free_diffstat_file(file);
> +				diffstat->nr--;
> +			}
> +		}
>  	}
>  
>  	diff_free_filespec_data(one);
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 88d3026894..8bdaa0a693 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -789,7 +789,7 @@ test_expect_success 'checkdiff allows new blank lines' '
>  	git diff --check
>  '
>  
> -test_expect_success 'whitespace-only changes not reported' '
> +test_expect_success 'whitespace-only changes not reported (diff)' '
>  	git reset --hard &&
>  	echo >x "hello world" &&
>  	git add x &&
> @@ -799,10 +799,44 @@ test_expect_success 'whitespace-only changes not reported' '
>  	test_must_be_empty actual
>  '
>  
> -test_expect_success 'whitespace-only changes reported across renames' '
> +test_expect_success 'whitespace-only changes not reported (diffstat)' '
> +	# reuse state from previous test
> +	git diff --stat -b >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success 'whitespace changes with modification reported (diffstat)' '
> +	git reset --hard &&
> +	echo >x "hello  world" &&
> +	git update-index --chmod=+x x &&
> +	git diff --stat --cached -b >actual &&
> +	cat <<-EOF >expect &&
> +	 x | 0
> +	 1 file changed, 0 insertions(+), 0 deletions(-)
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'whitespace-only changes reported across renames (diffstat)' '
>  	git reset --hard &&
>  	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
>  	git add x &&
> +	git commit -m "base" &&
> +	sed -e "5s/^/ /" x >z &&
> +	git rm x &&
> +	git add z &&
> +	git diff -w -M --cached --stat >actual &&
> +	cat <<-EOF >expect &&
> +	 x => z | 0
> +	 1 file changed, 0 insertions(+), 0 deletions(-)
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'whitespace-only changes reported across renames' '
> +	git reset --hard HEAD~1 &&
> +	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
> +	git add x &&
>  	hash_x=$(git hash-object x) &&
>  	before=$(git rev-parse --short "$hash_x") &&
>  	git commit -m "base" &&
>
> base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8

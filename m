Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8124C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C2364F2A
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhCRUsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:48:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59786 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCRUr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 16:47:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19270AEA22;
        Thu, 18 Mar 2021 16:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3NL9/KGqdfkpo7L5hnaA5tgGlI4=; b=yAvbsL
        SxODyovoxEvl/RlZsSGvDgFQVbtEDAQQonOPPZhE1iSrdm9vC3mCNY2zK5p4XG01
        rUBIIzPkwGt8tv0k3yCgSv6Yjvt59BV2Z3M98BxllAHpcxnCBFQI4wyteDacCQJN
        o+xrWsIqC1LH+6VQK0DE8qtBRUoD3WdVTerEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DshnnsakVlfOT+ZSmfj7Zz+s5tlvJTSq
        Sl8Fz3sdHbh0OjTDIcqwhe8mHAY+kunXcwmHKBj1WCdbvbFcO6QwYsZac0QbjIxp
        xXJ04CNM2l2VO9b0OlVAsaPv/2eWCRuM813mBs4GipEs1T3GyrFboqK0HW2yjTzm
        ToWqY6eNOnQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10F53AEA21;
        Thu, 18 Mar 2021 16:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EB32AEA20;
        Thu, 18 Mar 2021 16:47:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v2 2/3] fsmonitor: add assertion that fsmonitor is valid
 to check_removed
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
        <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
        <afd326c5011b09d89b6354817c1913d85142c335.1616016143.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 13:47:54 -0700
In-Reply-To: <afd326c5011b09d89b6354817c1913d85142c335.1616016143.git.gitgitgadget@gmail.com>
        (Nipunn Koorapati via GitGitGadget's message of "Wed, 17 Mar 2021
        21:22:22 +0000")
Message-ID: <xmqqk0q4rxxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37336576-882B-11EB-B3BE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> Validate that fsmonitor is valid to futureproof against bugs where
> check_removed might be called from places that haven't refreshed.

Isn't this the other way around, wrt to the previous step?

At least, "pass around istate throughout the callchain in the
diff-lib.c file" change should stand alone and come much earlier in
the series (perhaps as step #1).  Then "call refresh_fsmonitor from
run_diff_index() and make sure in check_removed() that fsmonitor
does not have bogus VALID bit" assertion should come on top, as a
single step, I would think.

> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
>  diff-lib.c  | 18 +++++++++++-------
>  fsmonitor.h | 11 +++++++++++
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index 3fb538ad18e9..e5a58c9259cf 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -28,8 +28,9 @@
>   * exists for ce that is a submodule -- it is a submodule that is not
>   * checked out).  Return negative for an error.
>   */
> -static int check_removed(const struct cache_entry *ce, struct stat *st)
> +static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
>  {
> +	assert(is_fsmonitor_refreshed(istate));
>  	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
>  		if (!is_missing_file_error(errno))
>  			return -1;
> @@ -136,7 +137,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			memset(&(dpath->parent[0]), 0,
>  			       sizeof(struct combine_diff_parent)*5);
>  
> -			changed = check_removed(ce, &st);
> +			changed = check_removed(istate, ce, &st);
>  			if (!changed)
>  				wt_mode = ce_mode_from_stat(ce, st.st_mode);
>  			else {
> @@ -216,7 +217,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  		} else {
>  			struct stat st;
>  
> -			changed = check_removed(ce, &st);
> +			changed = check_removed(istate, ce, &st);
>  			if (changed) {
>  				if (changed < 0) {
>  					perror(ce->name);
> @@ -278,7 +279,8 @@ static void diff_index_show_file(struct rev_info *revs,
>  		       oid, oid_valid, ce->name, dirty_submodule);
>  }
>  
> -static int get_stat_data(const struct cache_entry *ce,
> +static int get_stat_data(const struct index_state *istate,
> +			 const struct cache_entry *ce,
>  			 const struct object_id **oidp,
>  			 unsigned int *modep,
>  			 int cached, int match_missing,
> @@ -290,7 +292,7 @@ static int get_stat_data(const struct cache_entry *ce,
>  	if (!cached && !ce_uptodate(ce)) {
>  		int changed;
>  		struct stat st;
> -		changed = check_removed(ce, &st);
> +		changed = check_removed(istate, ce, &st);
>  		if (changed < 0)
>  			return -1;
>  		else if (changed) {
> @@ -321,12 +323,13 @@ static void show_new_file(struct rev_info *revs,
>  	const struct object_id *oid;
>  	unsigned int mode;
>  	unsigned dirty_submodule = 0;
> +	struct index_state *istate = revs->diffopt.repo->index;
>  
>  	/*
>  	 * New file in the index: it might actually be different in
>  	 * the working tree.
>  	 */
> -	if (get_stat_data(new_file, &oid, &mode, cached, match_missing,
> +	if (get_stat_data(istate, new_file, &oid, &mode, cached, match_missing,
>  	    &dirty_submodule, &revs->diffopt) < 0)
>  		return;
>  
> @@ -342,8 +345,9 @@ static int show_modified(struct rev_info *revs,
>  	unsigned int mode, oldmode;
>  	const struct object_id *oid;
>  	unsigned dirty_submodule = 0;
> +	struct index_state *istate = revs->diffopt.repo->index;
>  
> -	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
> +	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
>  			  &dirty_submodule, &revs->diffopt) < 0) {
>  		if (report_missing)
>  			diff_index_show_file(revs, "-", old_entry,
> diff --git a/fsmonitor.h b/fsmonitor.h
> index 7f1794b90b00..f20d72631d76 100644
> --- a/fsmonitor.h
> +++ b/fsmonitor.h
> @@ -49,6 +49,17 @@ void refresh_fsmonitor(struct index_state *istate);
>   */
>  int fsmonitor_is_trivial_response(const struct strbuf *query_result);
>  
> +/*
> + * Check if refresh_fsmonitor has been called at least once.
> + * refresh_fsmonitor is idempotent. Returns true if fsmonitor is
> + * not enabled (since the state will be "fresh" w/ CE_FSMONITOR_VALID unset)
> + * This version is useful for assertions
> + */
> +static inline int is_fsmonitor_refreshed(const struct index_state *istate)
> +{
> +	return !core_fsmonitor || istate->fsmonitor_has_run_once;
> +}
> +
>  /*
>   * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
>   * called any time the cache entry has been updated to reflect the

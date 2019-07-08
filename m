Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40A91F461
	for <e@80x24.org>; Mon,  8 Jul 2019 20:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404796AbfGHUPN (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 16:15:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53324 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfGHUPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 16:15:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BE7C7D39E;
        Mon,  8 Jul 2019 16:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z9QRS2y+C86Us73292E1/c9K5gU=; b=QyAyyQ
        uvY0sJN9W7x+vjefGFebcPBY+nGCuoMsXa4+ehc4NNBiBfi2w+33kXsVer0s26Ju
        rJ6pul1Go8oAsJhvoCYW2pllDA71LDAkhm32/bUVvpK6At5fUpza7xnICtQJB8yX
        ZW0DpzXHgxrTBzbyuaFFXeiJB5WlPoWY3nrnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b6WQAEzHYJEQqVku5/tBO8GBhTO60FsA
        DP2WNiLLTFBdfZxTtJ7vbNAyXJWwd1fhJlSN3zmtYyqM5tRK7+CuQ7U4CP3VY7Sv
        ET5+R8bLXmcqJIbzpyGkDtcrx/dppHDThrF3IqREz9awcKoq4oNlaZ4ka6USzNZH
        YVgLaCXbdAI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 843A47D39D;
        Mon,  8 Jul 2019 16:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B21917D39C;
        Mon,  8 Jul 2019 16:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] builtin/merge.c - cleanup of code in for-cycle that tests strategies
References: <20190707000052.26057-1-eantoranz@gmail.com>
Date:   Mon, 08 Jul 2019 13:15:05 -0700
In-Reply-To: <20190707000052.26057-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Sat, 6 Jul 2019 18:00:52 -0600")
Message-ID: <xmqqh87wxoza.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14909F4E-A1BD-11E9-835F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Previous code was a little convoluted to follow logic
> New code is shorter and logic is easier to follow

In the body of the proposed commit log message, please finish each
sentence with a full-stop.

> - Easier to see what happens when merge is successful
> 	and how --no-commit affects result
> - Simpler to see that for-cycle will stop when merge_was_ok is set
> - Easier to spot what logic will run through best_strategy
> - Easier to see that in case of ret being 2, cycle will continue

These bullets are all subjective, and do not add any value to what
you already said in the second sentence.

> - Keep a single break case (when automerge succedes and a revision will
>   be created)
> - Put together closing actions when automerge succedes if a revision
>   will be created

These are facts that readers can see for themselves and agree with.

Something like...

	The cmd_merge() function has a loop that tries different
	merge strategies in turn, and stops when a strategy gets a
	clean merge, while keeping the "best" conflicted merge so
	far.

	Make the loop easier to follow by moving the code around,
	ensuring that there is only one "break" in the loop where
	an automerge succeeds.  Also group the actions that are
	performed after an automerge succeeds together to a single
	location, outside and after the loop.

perhaps?

> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  builtin/merge.c | 51 ++++++++++++++++++-------------------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 6e99aead46..94f2713bea 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1586,7 +1586,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	    save_state(&stash))
>  		oidclr(&stash);
>  
> -	for (i = 0; i < use_strategies_nr; i++) {
> +	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
>  		int ret;
>  		if (i) {
>  			printf(_("Rewinding the tree to pristine...\n"));
> @@ -1604,40 +1604,26 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		ret = try_merge_strategy(use_strategies[i]->name,
>  					 common, remoteheads,
>  					 head_commit);
> -		if (!option_commit && !ret) {
> -			merge_was_ok = 1;
> -			/*
> -			 * This is necessary here just to avoid writing
> -			 * the tree, but later we will *not* exit with
> -			 * status code 1 because merge_was_ok is set.
> -			 */
> -			ret = 1;
> -		}
> -
> -		if (ret) {
> -			/*
> -			 * The backend exits with 1 when conflicts are
> -			 * left to be resolved, with 2 when it does not
> -			 * handle the given merge at all.
> -			 */
> -			if (ret == 1) {
> -				int cnt = evaluate_result();
> -
> -				if (best_cnt <= 0 || cnt <= best_cnt) {
> -					best_strategy = use_strategies[i]->name;
> -					best_cnt = cnt;
> +		/*
> +		 * The backend exits with 1 when conflicts are
> +		 * left to be resolved, with 2 when it does not
> +		 * handle the given merge at all.
> +		 */
> +		if (ret < 2) {
> +			if (!ret) {
> +				if (option_commit) {
> +					/* Automerge succeeded. */
> +					automerge_was_ok = 1;
> +					break;
>  				}
> +				merge_was_ok = 1;
> +			}
> +			int cnt = evaluate_result();

This introduces -Wdeclaration-after-statement, doesn't it?
Perhaps just declare the variable at the top of the for loop, next
to where the local 'ret' is declared?

Other than this single glitch, I think the code with this patch does
become easier to follow.

> +			if (best_cnt <= 0 || cnt <= best_cnt) {
> +				best_strategy = use_strategies[i]->name;
> +				best_cnt = cnt;
>  			}
> -			if (merge_was_ok)
> -				break;
> -			else
> -				continue;
>  		}
> -
> -		/* Automerge succeeded. */
> -		write_tree_trivial(&result_tree);
> -		automerge_was_ok = 1;
> -		break;
>  	}
>  
>  	/*
> @@ -1645,6 +1631,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	 * auto resolved the merge cleanly.
>  	 */
>  	if (automerge_was_ok) {
> +		write_tree_trivial(&result_tree);
>  		ret = finish_automerge(head_commit, head_subsumed,
>  				       common, remoteheads,
>  				       &result_tree, wt_strategy);

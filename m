Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF852EE49A0
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 09:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjHWJq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHWJn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 05:43:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07291FC1
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692780955; x=1693385755; i=johannes.schindelin@gmx.de;
 bh=3N4zi8+0xZ5c7OJrqcbjfVjVxa16jSkuIPEQXXxrOLs=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=Uev3ON8hDhS2AFBd0gJeTup22JazHLIHPpl4eam/yQB+ZNP63JR1aPUD14SfOJd+OTxnVXH
 9hvRQmtueAA7QUOq0W0Vw3kS+AkiRjgIzklws3pUJTWbw+QPIVaVQ1Ni/mqwWJpQQf56bZ03a
 d9D/4UcLpA/I4ZeIMfN4s1qbtPiBEc2u4uf1cQS4ULjOdkaOsHkr+kfIJh1CXt/Zdz7fYkGOM
 iUEES6ZYE41pDE2Y4cRvAz/xeA1e+B16zs4G1iD45uHL5K811y5rYOXWKpLrTQBf4fg1kqwSJ
 /aYhdW9yQjO+kYZpGc0rjuh1OaKQw+TF/QoHH1B5HR56dQQDSmfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1ppob60hCJ-00kAd6; Wed, 23
 Aug 2023 10:55:55 +0200
Date:   Wed, 23 Aug 2023 10:55:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 5/7] rebase: fix rewritten list for failed pick
In-Reply-To: <df4019458665eccf2b16cdf1d6c1061186a62711.1690903412.git.gitgitgadget@gmail.com>
Message-ID: <304553b3-3668-0b98-c6dc-3c047fd9e34c@gmx.de>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com> <df4019458665eccf2b16cdf1d6c1061186a62711.1690903412.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g6PzBRHJhBzcf5VL4yOcoM7K6N7F0q6JD/QZRKeZ7vgeM0sMTSm
 fdnq3ZkimrYVYQSpKSrrIN2I4hm9T0lUywHfP3uOIICsq3oAViX1DrhpOS9WTV5/pQF4lsR
 I9MBorxnzvI6nQuhra0PXFoYGmIFZRIo88jgVtnDmRWxwruI/adAWovFa6oD/kudkYQy3lS
 yhIOEyHzBcCJSAqwhjQnw==
UI-OutboundReport: notjunk:1;M01:P0:3rXHZTE989M=;d+eO/0fuFrQVjY42uky2b0Ek+8y
 DXGyzM5MgfjziMMhkg3XCSdd8Q98IPMhnlqFLYrdcZS/oyRSCkLLpg1B4M/NjwABimGgkY3G+
 n6qi98m5A50CaCld+YcWhYo8+TO7CJras8R0czxJNBbkQjSnsYGidnlntl/8pfZ0Rnyzp2ykn
 W2HK3HV6iBPzbPcJHBs6fZSJqD/REy2p2SdNW0TKOF8Zkc9ol7/1I9ByJM6fl+Rdk2VpbGRMj
 /VkJkWNmIsOLPrUezrDeFoHzYvLPIeb6aLGzOTfQLc9f1n9Rtn8LpxLrohLFmjJo4/USqPgQL
 lmorQ5+BDbsOWDvOf50lVg2u4bBGBCo2vICyL25KXusviDDoVHCOLMFsKVkLKaw2tJ59Jj7cq
 tmojdhf85BYlkhIkIW0+HJxEDQy1n7I91DnhJ1auCczAHf62E1vjEYkLFvGa/Rq+lPBlgyo4D
 p7oIANkCKMGt+cVZYPVZUHUw3ChtBkNv0WhIMhYU00ZuXRx+i4ZsF2+hGIlwj/KsyA5evDON5
 172Dwk3JMu4X6UyWhjMYZxvEx/9EGBiKEIaSTyhj1U2HrPjH8P4SoV2zRSD3M3ZTUOCXAKSTu
 RzJajFPZjlK0nNqdioLzNa4VO7nLrxa/aXcF2T9wdFYVzHPwrBa1gzhYSnWD2XfwgMr6l7Uhz
 n6L7kRk2yocFnqBtd0JsiC3oC3VhE4c6OaT864ZSVC9DszzE3QftneCPfguI2PYN2M1E3krwr
 pK1WrOpxmctmsWm3aI/o1b5poXpN9gIWxXfw9mlIkWLbPUwAoW+mt5sWryfeKW6BvD0JYmdXW
 MdajjlApRx4n0f8qq5MBDY1H51mT9Z2OeO8tvRo9TmU8gT+iYtOifUuQ0sbGAIwbyMLpEUg3V
 j+cB+WpZnldG4Kanq9Fb04McLGhSkfiLfdGP7EcWrzfGDod+B6aO6BEQmda6LDHecx9X3KsP+
 b9m5kAvYe/Op6EInhbdYwnsmQVo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 1 Aug 2023, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> git rebase keeps a list that maps the OID of each commit before it was
> rebased to the OID of the equivalent commit after the rebase.  This list
> is used to drive the "post-rewrite" hook that is called at the end of a
> successful rebase. When a rebase stops for the user to resolve merge
> conflicts the OID of the commit being picked is written to
> ".git/rebase-merge/stopped-sha". Then when the rebase is continued that
> OID is added to the list of rewritten commits. Unfortunately if a commit
> cannot be picked because it would overwrite an untracked file we still
> write the "stopped-sha1" file. This means that when the rebase is
> continued the commit is added into the list of rewritten commits even
> though it has not been picked yet.
>
> Fix this by not calling error_with_patch() for failed commands. The pick
> has failed so there is nothing to commit and therefore we do not want to
> set up the state files for committing staged changes when the rebase
> continues. This change means we no-longer write a patch for the failed
> command or display the error message printed by error_with_patch(). As
> the command has failed the patch isn't really useful and in any case the
> user can inspect the commit associated with the failed command by
> inspecting REBASE_HEAD. Unless the user has disabled it we already print
> an advice message that is more helpful than the message from
> error_with_patch() which the user will still see. Even if the advice is
> disabled the user will see the messages from the merge machinery
> detailing the problem.
>
> To simplify writing REBASE_HEAD in this case pick_one_commit() is
> modified to avoid duplicating the code that adds the failed command
> back into the todo list.

This motivates the change well, and answered all but one of the questions
I had about it, being:

> diff --git a/sequencer.c b/sequencer.c
> index 62277e7bcc1..e25abfd2fb4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> [...]
> @@ -4658,12 +4659,8 @@ static int pick_one_commit(struct repository *r,
>  			     check_todo);
>  	if (is_rebase_i(opts) && res < 0) {
>  		/* Reschedule */
> -		advise(_(rescheduled_advice),
> -		       get_item_line_length(todo_list, todo_list->current),
> -		       get_item_line(todo_list, todo_list->current));
> -		todo_list->current--;

Why is it okay to remove this decrement?

Here is why: The code that calls `save_todo()` in the `if (reschedule)`
block of the loop of `pick_commits()` _duplicates_ the logic that is
removed here, including the advice and the decrementing of `current`.

I had to instrument the code before and after this patch to figure this
out, as I had missed the fact that the now-remaining code also decremented
the `current` attribute.

So: All is good with this patch. If you'd like to amend the commit message
accordingly, I would not be opposed, but I could now live equally as
easily without it.

> -		if (save_todo(todo_list, opts))
> -			return -1;
> +		*reschedule =3D 1;
> +		return -1;
>  	}
>  	if (item->command =3D=3D TODO_EDIT) {
>  		struct commit *commit =3D item->commit;

I'd like to point out how delighted I am about this careful test case:

> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 96ae0edf1e1..4938ebb1c17 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -165,12 +165,12 @@ test_expect_success 'failed `merge -C` writes patc=
h (may be rescheduled, too)' '
>  	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
>  	test_tick &&
>  	test_must_fail git rebase -ir HEAD &&
> +	test_cmp_rev REBASE_HEAD H^0 &&
>  	grep "^merge -C .* G$" .git/rebase-merge/done &&
>  	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
> -	test_path_is_file .git/rebase-merge/patch &&
> +	test_path_is_missing .git/rebase-merge/patch &&
>
>  	: fail because of merge conflict &&
> -	rm G.t .git/rebase-merge/patch &&
>  	git reset --hard conflicting-G &&
>  	test_must_fail git rebase --continue &&
>  	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index 5f3ff051ca2..ad7f8c6f002 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -17,6 +17,12 @@ test_expect_success 'setup' '
>  	git checkout A^0 &&
>  	test_commit E bar E &&
>  	test_commit F foo F &&
> +	git checkout B &&
> +	git merge E &&
> +	git tag merge-E &&
> +	test_commit G G &&
> +	test_commit H H &&
> +	test_commit I I &&
>  	git checkout main &&
>
>  	test_hook --setup post-rewrite <<-EOF
> @@ -173,6 +179,48 @@ test_fail_interactive_rebase () {
>  	)
>  }
>
> +test_expect_success 'git rebase with failed pick' '
> +	clear_hook_input &&
> +	cat >todo <<-\EOF &&
> +	exec >bar
> +	merge -C merge-E E
> +	exec >G
> +	pick G
> +	exec >H 2>I
> +	pick H
> +	fixup I
> +	EOF
> +
> +	(
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i D D 2>err
> +	) &&
> +	grep "would be overwritten" err &&
> +	rm bar &&
> +
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "would be overwritten" err &&
> +	rm G &&
> +
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "would be overwritten" err &&
> +	rm H &&
> +
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "would be overwritten" err &&
> +	rm I &&
> +
> +	git rebase --continue &&
> +	echo rebase >expected.args &&
> +	cat >expected.data <<-EOF &&
> +	$(git rev-parse merge-E) $(git rev-parse HEAD~2)
> +	$(git rev-parse G) $(git rev-parse HEAD~1)
> +	$(git rev-parse H) $(git rev-parse HEAD)
> +	$(git rev-parse I) $(git rev-parse HEAD)
> +	EOF
> +	verify_hook_input
> +'
> +
>  test_expect_success 'git rebase -i (unchanged)' '
>  	git reset --hard D &&
>  	clear_hook_input &&

Here is my ACK.

Thank you,
Johannes

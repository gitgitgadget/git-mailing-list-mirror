Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9DBC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 22:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354202AbhLCWZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:25:46 -0500
Received: from mout.gmx.net ([212.227.17.20]:39203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353945AbhLCWZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 17:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638570137;
        bh=yOkFoE0rp5BtzaUrXpbbEsD7l9L5/TnwOtRgDAuKz+Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AIkQkd6qG3ptj7HseGws5k6LA19P0v+xIcgMcL+j8PmKn6Q0V6aH6cE3Cv9v+3Ss+
         LIg+1AYxNBVh2ZRQWM2kCb+tUWEz0eyDlvkzPfzfzxDV4w4wZvH4l2soee893ca72V
         MfD2zeI4ilTaDgMJ+g4FIn4yh8pI6oFSUXHn5e8M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1mx6h12jUg-0052ZI; Fri, 03
 Dec 2021 23:22:17 +0100
Date:   Fri, 3 Dec 2021 23:22:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: avoid adding exec commands for non-commit
 creating commands
In-Reply-To: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112032321530.63@tvgsbejvaqbjf.bet>
References: <pull.1149.git.git.1638244719381.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:us962fjkXitQ32NKK587WIkMhgajMIdL5tOqEs/4b0uvdJWrByN
 eGnd958LHoP4XHusGIQekmr2eQxjmV+aNYFaimrNlPHnVQyRXZqSHvt3JAn290lSMEC6u9A
 j9tevQ/6imSsRHx0vri9HloB4NpJDosjPOV3OpcvhE7vkh5f2w3LioZyThJNjzI2d8F4X8+
 x8wVQqYNB6ZHX0ysWUe9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yvLH5LTW/n8=:izIkNeq0PrmdthSY3o+Qan
 4eocNCwXI4t/zSy6WLYBrXbQGTu8DCPfbZuLzwEUgHkGtBe+FSOSANhNpW0aTbFtM8HPGZmDH
 watO9dbuFHSR+dR5d84q7t8p6WZ+YBHdy4Ab/G3S4ypJ7D75BQbh6djeMYuvqg8iJTfYHMzje
 4ADa7A++fVV9LHmvOf9gvsanRsj8jHvsrxJcmDDIPBAMC1oL2Wu+OVleCmVfR/aUG1Bg0kuQs
 TVDRWaDvwo6gBe5uvSDQtwvvrDfviNUgyKtXUs9luBgHLCsQoa9mu0YGoo2cbMQ67wGZKAp0P
 hTxfodklSn3qfVPHBVILFFKDTS+3M6eKXl4BXWeBBD82p3w/mosZdv/a6x2/rVcHjpBjqfyPZ
 4FSiZOy8jk0c69F0gX7j5j6sdw4m7XOhiR59dj1lf6OU69Sk5BPbXVpxKWp9s0om0UvLuOyJD
 VClWS2IZvmgarL/GBvdH2pFhSjiLwY9LMyyF+c7+OyO4ZeJXMxK5lMbTFikvavOB+xJQPieUi
 dL01I5yO0FOQMbWAcFgqv88vaVa8ZLTZoByyIkwtgV2Aj9WOxofNZlEJ4/Yb6seMwrpyOkps/
 cjFU7SOt2w2Xw3ZAAOTeSog/oXgnSJOt171rL84DN92weA9Jl/9VmxkTwBub802gTcSKdCvVv
 Oh7igx2O7Ez4q1wePmql0yxYqD+2v2822Y5efYodv08imMVlNgZA4aYmQRSPMBYXFZwR9N6s9
 MsJ89ffDdeF1ef1DHV+RiYo45gFuxTBRbRShUY0XhU1i0HAtOYogxXzcmggw2kcd2wJs6EXYB
 srzkfMnGRbcOngikx2jamiam/prhzgftT6+j/rF3DaId8owXdeAcOn9963UH5DA1HcO/941yl
 v7r6VVBdyR9cetbwXF+9Rz2Faq9KebyJGDbRYZnQMZsCAaL0rXs4KtqhBy7J0YdKQtqWyzKML
 v6HfShLbBWZI+fNovzgkid1odvhQ1aDB8JXpcSEYX1XmqpNO67ozKhZFUKtON8UCG3tylmsCr
 B4tc2NlzJ6e236fuB17nyZNij735Mf6L8tvyHdM4n4IDps3Qu8sM0atSR3fPg2jrFeFMq3mTW
 V0KMltXDl2kKXQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 30 Nov 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> The `--exec <cmd>` is documented as
>
>     Append "exec <cmd>" after each line creating a commit in the final
>     history.
>     ...
>     If --autosquash is used, "exec" lines will not be appended for the
>     intermediate commits, and will only appear at the end of each
>     squash/fixup series.
>
> Unfortunately, it would also add exec commands after non-pick
> operations, such as 'no-op', which could be seen for example with
>     git rebase -i --exec true HEAD
>
> todo_list_add_exec_commands() intent was to insert exec commands after
> each logical pick, while trying to consider a chains of fixup and squash
> commits to be part of the pick before it.  So it would keep an 'insert'
> boolean tracking if it had seen a pick or merge, but not write the exec
> command until it saw the next non-fixup/squash command.  Since that
> would make it miss the final exec command, it had some code that would
> check whether it still needed to insert one at the end, but instead of a
> simple
>
>     if (insert)
>
> it had a
>
>     if (insert || <condition that is always true>)
>
> That's buggy; as per the docs, we should only add exec commands for
> lines that create commits, i.e. only if insert is true.  Fix the
> conditional.
>
> There was one testcase in the testsuite that we tweak for this change;
> it was introduced in 54fd3243da ("rebase -i: reread the todo list if
> `exec` touched it", 2017-04-26), and was merely testing that after an
> exec had fired that the todo list would be re-read.  The test at the
> time would have worked given any revision at all, though it would only
> work with 'HEAD' as a side-effect of this bug.  Since we're fixing this
> bug, choose something other than 'HEAD' for that test.
>
> Finally, add a testcase that verifies when we have no commits to pick,
> that we get no exec lines in the generated todo list.
>
> Reported-by: Nikita Bobko <nikitabobko@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This patch gets my whole-hearted ACK!

Thank you,
Dscho

> ---
>     sequencer: avoid adding exec commands for non-commit creating comman=
ds
>
>     Original report over at
>     https://lore.kernel.org/git/YaVzufpKcC0t+q+L@nand.local/T/#m13fbd7b0=
54c06ba1f98ae66e6d1b9fcc51bb875e
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-11=
49%2Fnewren%2Frebase-exec-empty-bug-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1149/=
newren/rebase-exec-empty-bug-v1
> Pull-Request: https://github.com/git/git/pull/1149
>
>  sequencer.c                 | 2 +-
>  t/t3429-rebase-edit-todo.sh | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index ea96837cde3..aa790f0bba8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5496,7 +5496,7 @@ static void todo_list_add_exec_commands(struct tod=
o_list *todo_list,
>  	}
>
>  	/* insert or append final <commands> */
> -	if (insert || nr =3D=3D todo_list->nr) {
> +	if (insert) {
>  		ALLOC_GROW(items, nr + commands->nr, alloc);
>  		COPY_ARRAY(items + nr, base_items, commands->nr);
>  		nr +=3D commands->nr;
> diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
> index 7024d49ae7b..abd66f36021 100755
> --- a/t/t3429-rebase-edit-todo.sh
> +++ b/t/t3429-rebase-edit-todo.sh
> @@ -13,10 +13,15 @@ test_expect_success 'setup' '
>
>  test_expect_success 'rebase exec modifies rebase-todo' '
>  	todo=3D.git/rebase-merge/git-rebase-todo &&
> -	git rebase HEAD -x "echo exec touch F >>$todo" &&
> +	git rebase HEAD~1 -x "echo exec touch F >>$todo" &&
>  	test -e F
>  '
>
> +test_expect_success 'rebase exec with an empty list does not exec anyth=
ing' '
> +	git rebase HEAD -x "true" 2>output &&
> +	! grep "Executing: true" output
> +'
> +
>  test_expect_success 'loose object cache vs re-reading todo list' '
>  	GIT_REBASE_TODO=3D.git/rebase-merge/git-rebase-todo &&
>  	export GIT_REBASE_TODO &&
>
> base-commit: 35151cf0720460a897cde9b8039af364743240e7
> --
> gitgitgadget
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A9FEE49AE
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 09:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjHWJPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjHWJKE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 05:10:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1204696
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692781298; x=1693386098; i=johannes.schindelin@gmx.de;
 bh=IScgcSgA+1ey9TIEXyTBSDEK9gGJm2BZcNVgvGRxCxA=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=PUUExh4Oa7TE+nD+9Qp8OGUv8SUyDuClwNY99dvCeZrEnPyJddLH7tp9iLNsX/pV3HH9IZB
 3Db1WihbxWP0moPRvfnTfre3Hnh529taDf9mtib/nzEoITe2DLVmRP+5VH3EY6eAGcyWMftd5
 HzVYtwGlOwtnOW9JV+RHTfTx22s/m4XIU9xD/nUiK8g8Y1zuSD7NeH32JGiaqWC1nNjQw+aDL
 foajMZSvpzLvwmSqiarvg4I5lrbc0topy8LSR2vIgu8NS8FiLAmTZRtHHp63C14xuwPiHtLRX
 iRwCd1TfXCpvlGEjpH+m5AJS/9Zy4OfgeaR6f0bXGrpg5GcWrhcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1pbQuv2y4J-012qpz; Wed, 23
 Aug 2023 11:01:38 +0200
Date:   Wed, 23 Aug 2023 11:01:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 6/7] rebase --continue: refuse to commit after failed
 command
In-Reply-To: <2ed7cbe5fff2d104a1246783909c6c4b75c559f2.1690903412.git.gitgitgadget@gmail.com>
Message-ID: <a5bfea5f-0d0d-f7ed-3f72-37e3db6f5b2c@gmx.de>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com> <2ed7cbe5fff2d104a1246783909c6c4b75c559f2.1690903412.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4r3XSYtrqtT+VuoWUlVhBKBVoRu0RlJDWZvkmU60m1fsAaURoKr
 hqawSrr/4SdlvTtgra9yenT1bCdU0mZ4pDW/IxJwlyULvlojsCAjc8oACj1OMVMtHuKI7Gc
 ghY/R7b3JmPbl2J0U8FPhKtSjcdJJb9AkkCy1CPrr8OBEB9KmapI1daBcaEHIvhPvJH0W2S
 TNqN271+j+I83jASds1zQ==
UI-OutboundReport: notjunk:1;M01:P0:9vNd/YDRsec=;l2fcXYdSqkd2BO6AYAShJtJXXoi
 JrLuGVFbIinrUbszqX0cje/vv0M+z0dk8LDJ2KMOo7QlcYWAN805VbVCV/YiGF53PYTje8f7f
 RpZyOZ9JYFjfd1qQGrqIDezNiDDSIfTM7Sb6uzPOxgMNQeClI/qNPpP6wExs9RwIPmi1NfLw7
 zt3U/5EpiIbxUmVZ45bz+8YvJMMxPfiDLvNoe9q3+eL71l2CeE9x1WBuRyuGdYg7+svfpxQWK
 xVc4nuBsK+nV1BZkWAtXT7udA09w2Ma+ZesPA2xL/XshLYd1/UH+tQ5SYD2Y0gJb24cAIAiN+
 gKK4cX/UqnFT69DBmCA+gWm8wWkvIbYlsLdf7EpUQStEgTlIlHS90BizHLLvgB0mwQR6gLKl1
 lyXdeG4VpWiCES2HWZNoYp1E3MyKVpEOyGaOk/RUySALJRTshiX7GfovJ5PMqA/P1d+z+ffKt
 J1E/cOW4JQKzJKEvYe7OoANbOL+JCWrVQiUiJAH2QQ4DnZvzY8mGofh0jbzTcgBb/KQHwTE0C
 PLV6p/vYb+zDpk2o34CIZLqTspjz5TQ64Z79Jc9M8FRnIHQrCqIENVbkPmNv06C8RV/UiPFtw
 x+aV5SY0JEjOxM81HSMISADgqfaOMHejXvCg4327Ngdz//Ti8ApKc61/GvwjR9UTa/mUXPARg
 TVcy7ompT7Y5MiqXkuuOVtsU06Jsc50ydZBZw40T8PWih1B7187wzL5vOxxoc5HHryoh9tPzr
 CJp9UCzhqPFd6Gv9yBWmb1/84u8hOA6PDZ8w77fNPqNjnjoCxNRiMaikoS1rVPbGzlUSS7EJt
 KZDxDaiL5sNaT7B8Co+GkYcA8+KUxuvpYN/yueqZlO7atXfD6lkM8C4w56TzG3Bj8DPcQ5kTK
 25fwBXrXw9v0iEDc4r9eBK2PsektMa2mJSJsTwGoUwyDfCtRMIeg4R9z93nKDf7PNi/7OFs/u
 qP/Ksw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 1 Aug 2023, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a commit cannot be picked because it would overwrite an untracked
> file then "git rebase --continue" should refuse to commit any staged
> changes as the commit was not picked. This is implemented by refusing to
> commit if the message file is missing. The message file is chosen for
> this check because it is only written when "git rebase" stops for the
> user to resolve merge conflicts.
>
> Existing commands that refuse to commit staged changes when continuing
> such as a failed "exec" rely on checking for the absence of the author
> script in run_git_commit(). This prevents the staged changes from being
> committed but prints
>
>     error: could not open '.git/rebase-merge/author-script' for
>     reading
>
> before the message about not being able to commit. This is confusing to
> users and so checking for the message file instead improves the user
> experience. The existing test for refusing to commit after a failed exec
> is updated to check that we do not print the error message about a
> missing author script anymore.

I am delighted to see an improvement of the user experience!

However, I could imagine that users would still be confused when seeing
the advice about staged changes, even if nothing was staged at all.

Could you introduce a new advice message specifically for the case where
untracked files are in the way and prevent changes from being applied?

Thank you,
Johannes

P.S.: To save both you and me time, here is my ACK for patch 7/7
(actually, the entire patch series, but _maybe_ you want to change
"impove" -> "improve" in the cover letter's subject) ;-)

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c                   |  5 +++++
>  t/t3404-rebase-interactive.sh | 18 +++++++++++++++++-
>  t/t3430-rebase-merges.sh      |  4 ++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e25abfd2fb4..a90b015e79c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4977,6 +4977,11 @@ static int commit_staged_changes(struct repositor=
y *r,
>
>  	is_clean =3D !has_uncommitted_changes(r, 0);
>
> +	if (!is_clean && !file_exists(rebase_path_message())) {
> +		const char *gpg_opt =3D gpg_sign_opt_quoted(opts);
> +
> +		return error(_(staged_changes_advice), gpg_opt, gpg_opt);
> +	}
>  	if (file_exists(rebase_path_amend())) {
>  		struct strbuf rev =3D STRBUF_INIT;
>  		struct object_id head, to_amend;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.=
sh
> index 6d3788c588b..a8ad398956a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -604,7 +604,8 @@ test_expect_success 'clean error after failed "exec"=
' '
>  	echo "edited again" > file7 &&
>  	git add file7 &&
>  	test_must_fail git rebase --continue 2>error &&
> -	test_i18ngrep "you have staged changes in your working tree" error
> +	test_i18ngrep "you have staged changes in your working tree" error &&
> +	test_i18ngrep ! "could not open.*for reading" error
>  '
>
>  test_expect_success 'rebase a detached HEAD' '
> @@ -1290,6 +1291,11 @@ test_expect_success 'rebase -i commits that overw=
rite untracked files (pick)' '
>  	test_cmp_rev REBASE_HEAD I &&
>  	rm file6 &&
>  	test_path_is_missing .git/rebase-merge/patch &&
> +	echo changed >file1 &&
> +	git add file1 &&
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "error: you have staged changes in your working tree" err &&
> +	git reset --hard HEAD &&
>  	git rebase --continue &&
>  	test_cmp_rev HEAD I
>  '
> @@ -1310,6 +1316,11 @@ test_expect_success 'rebase -i commits that overw=
rite untracked files (squash)'
>  	test_cmp_rev REBASE_HEAD I &&
>  	rm file6 &&
>  	test_path_is_missing .git/rebase-merge/patch &&
> +	echo changed >file1 &&
> +	git add file1 &&
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "error: you have staged changes in your working tree" err &&
> +	git reset --hard HEAD &&
>  	git rebase --continue &&
>  	test $(git cat-file commit HEAD | sed -ne \$p) =3D I &&
>  	git reset --hard original-branch2
> @@ -1330,6 +1341,11 @@ test_expect_success 'rebase -i commits that overw=
rite untracked files (no ff)' '
>  	test_cmp_rev REBASE_HEAD I &&
>  	rm file6 &&
>  	test_path_is_missing .git/rebase-merge/patch &&
> +	echo changed >file1 &&
> +	git add file1 &&
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "error: you have staged changes in your working tree" err &&
> +	git reset --hard HEAD &&
>  	git rebase --continue &&
>  	test $(git cat-file commit HEAD | sed -ne \$p) =3D I
>  '
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 4938ebb1c17..804ff819782 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -169,6 +169,10 @@ test_expect_success 'failed `merge -C` writes patch=
 (may be rescheduled, too)' '
>  	grep "^merge -C .* G$" .git/rebase-merge/done &&
>  	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
>  	test_path_is_missing .git/rebase-merge/patch &&
> +	echo changed >file1 &&
> +	git add file1 &&
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "error: you have staged changes in your working tree" err &&
>
>  	: fail because of merge conflict &&
>  	git reset --hard conflicting-G &&
> --
> gitgitgadget
>
>

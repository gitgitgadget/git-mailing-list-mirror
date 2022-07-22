Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DD6C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 10:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiGVKtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiGVKte (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 06:49:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928AFA9B9A
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:49:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so5378971eda.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gvpdDgjrWczVUFxbYOE3+eTp2346OqCMadhQCvkHWNw=;
        b=kxJKknR8iiccDX00jEs4ZZl66au7xBUvHKWd5L7f9cWCvwI9cq0WSP84Lr3mTZ3HTA
         lee9CgbAweVGZnaKpsqYlEX4SC+pQLDBRQd332CfA622PMehjl3pBcmH1dQZIh80YKWW
         hJz87EgG/lGvyGM6ptX+URjwsupJ+c8E4QKGAzvtTdTFxofUxMyweIMPuZRR1hOTvjC8
         VSHYtMFtjtqiAblKZwrwYY7Fc5R3PCMSO3WF0sHuPtK+YIpcH1pMD5weShxdsXYePg4O
         3K7OcoNkgiJnfmhxV6YbkXwIC+Ewtw9vmHylb/vdKmw5xTL9GVSC1nirfdDeSaHcOTZe
         hzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gvpdDgjrWczVUFxbYOE3+eTp2346OqCMadhQCvkHWNw=;
        b=K3Tzf1/vinw/OBtHMKpUr/Gp06vjinNTpM6lazx2A6Tapu32oVrDNbPQ5Fvw7uvb4D
         MuEMItAejk4o3jVsuEQgDusl64vUTBMXYgC1bpfu7TdshrUUeyCVWbfzCUf0tTjit72W
         wd4/Q4h2pO1bGvvqKDPEww3w7Vx7V2wrNuaW/IR3H1uxYIyuCUpCwV1UWh4su8OJ6pJ7
         Gq0oRJ3uCC16G4NG792iBo/LHqJnSqtU4foPrAYdkdhM/EDgh3Eu1Q5Ia9IePNs/P1iS
         Wbiybf5HAxQa9+qELQOPQDBEhbOUVGYaC/T/yAnUCVT7ZcqhC1cL2mte8gVuD6aNJhDc
         zJuA==
X-Gm-Message-State: AJIora8xiM1jXdJ+bCkjdsoKI+5B3rEE3c/mgmgE1BH3RzwIAYpqDUTi
        K3TkLew7WiVw8VC5KjGeVCzO6i4xD3dZ7w==
X-Google-Smtp-Source: AGRyM1sZiH7YRk6gEmuMWkIVNE8dRc7Mf1ZiGhNPp/aB/z9BGHXguWqtZpBwPVIVVgidgC2favKLIQ==
X-Received: by 2002:a05:6402:26d5:b0:43a:bf2a:c27b with SMTP id x21-20020a05640226d500b0043abf2ac27bmr2974672edd.61.1658486968452;
        Fri, 22 Jul 2022 03:49:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906594800b00722e7e48dfdsm1832286ejr.218.2022.07.22.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:49:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEqDn-005HNh-3N;
        Fri, 22 Jul 2022 12:49:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/7] merge: do not abort early if one strategy fails
 to handle the merge
Date:   Fri, 22 Jul 2022 12:47:54 +0200
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
 <02930448ea1fbf7084b9d78813908b6355304457.1658466942.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <02930448ea1fbf7084b9d78813908b6355304457.1658466942.git.gitgitgadget@gmail.com>
Message-ID: <220722.86o7xhs9qg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> builtin/merge is setup to allow multiple strategies to be specified,
> and it will find the "best" result and use it.  This is defeated if
> some of the merge strategies abort early when they cannot handle the
> merge.  Fix the logic that calls recursive and ort to not do such an
> early abort, but instead return "2" or "unhandled" so that the next
> strategy can try to handle the merge.
>
> Coming up with a testcase for this is somewhat difficult, since
> recursive and ort both handle nearly any two-headed merge (there is
> a separate code path that checks for non-two-headed merges and
> already returns "2" for them).  So use a somewhat synthetic testcase
> of having the index not match HEAD before the merge starts, since all
> merge strategies will abort for that.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c                          |  6 ++++--
>  t/t6402-merge-rename.sh                  |  2 +-
>  t/t6424-merge-unrelated-index-changes.sh | 16 ++++++++++++++++
>  t/t6439-merge-co-error-msgs.sh           |  1 +
>  4 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 13884b8e836..dec7375bf2a 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -754,8 +754,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  		else
>  			clean = merge_recursive(&o, head, remoteheads->item,
>  						reversed, &result);
> -		if (clean < 0)
> -			exit(128);
> +		if (clean < 0) {
> +			rollback_lock_file(&lock);
> +			return 2;
> +		}
>  		if (write_locked_index(&the_index, &lock,
>  				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  			die(_("unable to write %s"), get_index_file());
> diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> index 3a32b1a45cf..772238e582c 100755
> --- a/t/t6402-merge-rename.sh
> +++ b/t/t6402-merge-rename.sh
> @@ -210,7 +210,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
>  	echo >>M one line addition &&
>  	cat M >M.saved &&
>  	git update-index M &&
> -	test_expect_code 128 git pull --no-rebase . yellow &&
> +	test_expect_code 2 git pull --no-rebase . yellow &&
>  	test_cmp M M.saved &&
>  	rm -f M.saved
>  '
> diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
> index f35d3182b86..8b749e19083 100755
> --- a/t/t6424-merge-unrelated-index-changes.sh
> +++ b/t/t6424-merge-unrelated-index-changes.sh
> @@ -268,4 +268,20 @@ test_expect_success 'subtree' '
>  	test_path_is_missing .git/MERGE_HEAD
>  '
>  
> +test_expect_success 'resolve && recursive && ort' '
> +	git reset --hard &&
> +	git checkout B^0 &&
> +
> +	test_seq 0 10 >a &&
> +	git add a &&
> +
> +	sane_unset GIT_TEST_MERGE_ALGORITHM &&
> +	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&1 &&
> +
> +	grep "Trying merge strategy resolve..." output &&
> +	grep "Trying merge strategy recursive..." output &&
> +	grep "Trying merge strategy ort..." output &&
> +	grep "No merge strategy handled the merge." output
> +'

Ah, re my feedback on 2/7 I hadn't read ahead. This is the test I
mentioned as failing with the code added in 2/7 if it's tweaked to be
s/exit 2/exit 0/.

So it's a bit odd to have code added in 2/7 that's tested in 3/7. I
think this would be much easier to understand if these tests came before
all these code changes, so then as the changes are made we can see how
the behavior changes.

But short of that at least having the relevant part of this for 2/7 in
that commit would be better, i.e. the thing that tests that new
"diff-index" check in some way...


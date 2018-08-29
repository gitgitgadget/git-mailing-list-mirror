Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5511F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeH2Qs3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:48:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:60233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbeH2Qs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:48:29 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzbXq-1fpzgo2pkI-014kIM; Wed, 29
 Aug 2018 14:51:36 +0200
Date:   Wed, 29 Aug 2018 14:51:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, corrmage@gmail.com,
        avarab@gmail.com, sbeller@google.com
Subject: Re: [PATCH 3/3] am: avoid directory rename detection when calling
 recursive merge machinery
In-Reply-To: <20180829070613.11793-4-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808291451030.71@tvgsbejvaqbjf.bet>
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com> <20180829070613.11793-1-newren@gmail.com> <20180829070613.11793-4-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nCO/XDCU17hAFf8glv16MU4PtQXwUsNFbvM6WUddeu0WbGWdllQ
 DdjAvJHIL/ONKedztFGznF99Wwo1yn5aSRYZVRTMyxVzK3rviaA6Wi5pT7pF6NZS9wXLHjz
 Sg3ithXxPvCnmpom6vIXoIi8Abcn0Zegb6IgWI0oKtBBB6yEcW5QzXOpuj8fRFWmyOnErIV
 qjAQBHTRVJE0S6J/Bog0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2EJN7rWQaME=:/diaRzRpF1UNV8MY/nT7RG
 RsBid2TQznFlJf32aFLIwZY7xvuBjCzV9Pfv2k4uSkvpuPvaxRjxIPLw7lCkO19eX23x6KLQ5
 FrE0WL4ux8JpG57p2RVwQqYqJvNk8oMzvfpjBTjY33QMJSEFzdwqtmg6y4ByGJN2SAQG7qTVW
 p1NkfMB7X51THTw2q9oSZ7YFNFx2+2G7Ve+B7p1UJdLmDsLB48N/fKyhIvAfyVu9vlCx58VVO
 OZ/ODRUlvGwcpy0atszkS52NkRLrfHgLJxjjItt9gltYdIZgh4qokXCUa1ye7JYuySvVcgyQW
 kdjx6/DQqY4FFLAm5kKa7kaTRx/avcvifrhQNmrpWiLHDeTrYPhK7Q1FNV0RWkqv9/2Ndxpy6
 dkH2pJquvLZ8qPsafy7wCtL6ct5V0aNfW0tdwH7YUNxmAqPWXmYl0e4knB+ztDnfTGQGz7Q2x
 z8nz3RGHaMkwGPREhPwKseMakdh4KCThrGvSNaEYn+fRbckga3yFkYIlG7B6e73n68c5JbUIG
 nn5p2gE+n38D+heOzgDqDEFZWI1yuc4l3xBFiH0m73NWM2Rj9za18qYpgKm2+vtd3r2sbW8qi
 JgXviaQcjz8X7YJgB72DA3OPCAQirtqNZucmdB1hv3k4kF1YAJy4nOH1B2dajeOdxXXRBNVXZ
 rwQgXFbTTRb/aT/wETLVu3MRvH3kR0WCKjDuxQ7uod5WRZSTQcFHPJl8tMHrCBdyGhnhf/VhO
 U0U4KdMYjQvdeULX6EHUU729FGP+YmR86CO9ykKLen8kwwrwXA2FsHc223tbMDdhE2n2tBlte
 iPLP+1n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 29 Aug 2018, Elijah Newren wrote:

> Let's say you have the following three trees, where Base is from one commit
> behind either master or branch:
> 
>    Base  : bar_v1, foo/{file1, file2, file3}
>    branch: bar_v2, foo/{file1, file2},       goo/file3
>    master: bar_v3, foo/{file1, file2, file3}
> 
> Using git-am (or am-based rebase) to apply the changes from branch onto
> master results in the following tree:
> 
>    Result: bar_merged, goo/{file1, file2, file3}
> 
> This is not what users want; they did not rename foo/ -> goo/, they only
> renamed one file within that directory.  The reason this happens is am
> constructs fake trees (via build_fake_ancestor()) of the following form:
> 
>    Base_bfa  : bar_v1, foo/file3
>    branch_bfa: bar_v2, goo/file3
> 
> Combining these two trees with master's tree:
> 
>    master: bar_v3, foo/{file1, file2, file3},
> 
> You can see that merge_recursive_generic() would see branch_bfa as renaming
> foo/ -> goo/, and master as just adding both foo/file1 and foo/file2.  As
> such, it ends up with goo/{file1, file2, file3}
> 
> The core problem is that am does not have access to the original trees; it
> can only construct trees using the blobs involved in the patch.  As such,
> it is not safe to perform directory rename detection within am -3.

I read through all three patches, and they look fine to me!

Ciao,
Dscho

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/am.c                    | 1 +
>  t/t3401-rebase-and-am-rename.sh | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 2fc2d1e82c..1494a9be84 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1596,6 +1596,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
>  	o.branch1 = "HEAD";
>  	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
>  	o.branch2 = their_tree_name;
> +	o.detect_directory_renames = 0;
>  
>  	if (state->quiet)
>  		o.verbosity = 0;
> diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
> index a87df9e675..94bdfbd69c 100755
> --- a/t/t3401-rebase-and-am-rename.sh
> +++ b/t/t3401-rebase-and-am-rename.sh
> @@ -152,7 +152,7 @@ test_expect_success 'rebase --interactive: NO directory rename' '
>  	)
>  '
>  
> -test_expect_failure 'rebase (am): NO directory rename' '
> +test_expect_success 'rebase (am): NO directory rename' '
>  	test_when_finished "git -C no-dir-rename rebase --abort" &&
>  	(
>  		cd no-dir-rename &&
> @@ -190,7 +190,7 @@ test_expect_success 'rebase --merge: NO directory rename' '
>  	)
>  '
>  
> -test_expect_failure 'am: NO directory rename' '
> +test_expect_success 'am: NO directory rename' '
>  	test_when_finished "git -C no-dir-rename am --abort" &&
>  	(
>  		cd no-dir-rename &&
> -- 
> 2.18.0.12.g97a29da30a
> 
> 

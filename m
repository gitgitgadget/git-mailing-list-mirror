Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9AA1FAD6
	for <e@80x24.org>; Fri,  8 Sep 2017 18:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756859AbdIHSzB (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 14:55:01 -0400
Received: from mout.web.de ([212.227.15.14]:63354 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756777AbdIHSy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 14:54:59 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MejjU-1e5kTs2zQe-00OCVo; Fri, 08
 Sep 2017 20:54:44 +0200
Date:   Fri, 8 Sep 2017 20:54:43 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        pclouds@gmail.com
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Message-ID: <20170908185443.GA15081@tor.lan>
References: <20170908180050.25188-1-kewillf@microsoft.com>
 <20170908180050.25188-2-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908180050.25188-2-kewillf@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:CPzwjOjZQ6ZZn7Z1pLIDAG8oIvTzgbCejHcZaJFLohxlQtG23L8
 GdmQIAAt2dKb2aK0oCbXMc6iB8HNM82nMzXvSLzwL92bsrcoWTGGYduAj26NLyq/Xx/nzf7
 GsuCaeJz0I3hDv2zvgYiaKC/4mUHWoWEzBkc5g/YGsjsmg51n5hm3sCMbaD8V+5aa5bGaJh
 Dspppw9fKCTYpeEYTfeFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QUSPOmjiUP0=:oDKhZ+I7WQzPSd6cEHvu+N
 38Ae+TYO/T865lpSdHA2quvG3pxAFkCZgskyIG0LrIXsRgOIr+givwtrz1FohRe9cFo34fI1I
 YJkQ+HzV/xWBbYERMXleFLMwV+RVIBB4KaKwDOld+JR8ZtEzDSoMtVhs4l9WGoRl5KrzAHu08
 taUvbJj5X61rXGur8fLbUiTrdDTJFMw6TS6QLqhEymZsqui1ImY7g5chYkkDzBYazg/0wmTjn
 YQkGXUf7avN1N5HpLXHA5A6ArAdms6KpaTWk1KYy+wJG63YN3pGiJkR4Nv4SnW+s0NXa12xAc
 0Obs6NTiQ8PsoMHbJEj6Z6L3pXxh0cUeTrPucI6mauOFz2YyH/gLF2mTVzx5DuG8Hs+LvTjaD
 2IedgdkSsO84HsoZH02lVQl2dYwPexfU7S9uOfjtZQQqtKq3dlQGquKeYroqO8y0W1iZaZnDg
 oAKxh8t7JxqBiChzHtQ0U0sgPl2SBJEnF3r5abZEvK7ROxgF2QryKvXK6h/3N9WQJOW6TNeI2
 uTdaO/86hB/etvddGIky4fV8ayA9nV8hI80miVeT+W6ECyv8c/40rJxF+PfPYDDoCB4gLFcDa
 xFWwYQ4pDUyKqaEIBX9kdaJ1OVViFxoKWL2nYmBC/MI1S52R3zi0uOQP600anHFTAXFdR4jeH
 Jm7QVQ0re40iori1jmcB89nip+Q1K/vnasjMrnBBuwlCxEyXNjOYrDOBZKlKlsW6FcidN6VWk
 wooBPSp3W9bC/TMoghW7hCAF6YzXnPn+8l2IGJllWMwRizWEdZ+qstScQonPzGzHOMsJxybYc
 J0UQ+IRgHtqVD9+U479LVkZ8ucqCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 12:00:50PM -0600, Kevin Willford wrote:
> When using the sparse checkout feature the git reset command will add
> entries to the index that will have the skip-worktree bit off but will
> leave the working directory empty.  File data is lost because the index
> version of the files have been changed but there is nothing that is in the
> working directory.  This will cause the next status call to show either
> deleted for files modified or deleting or nothing for files added.  The
> added files should be shown as untracked and modified files should be
> shown as modified.
> 
> To fix this when the reset is running if there is not a file in the working
> directory and if it will be missing with the new index entry or was not
> missing in the previous version, we create the previous index version of
> the file in the working directory so that status will report correctly
> and the files will be availble for the user to deal with.
> 
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
[]
> diff --git a/t/t7114-reset-sparse-checkout.sh b/t/t7114-reset-sparse-checkout.sh
> new file mode 100755
> index 0000000000..f2a5426847
> --- /dev/null
> +++ b/t/t7114-reset-sparse-checkout.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +
> +test_description='reset when using a sparse-checkout'
> +
> +. ./test-lib.sh
> +
> +# reset using a sparse-checkout file
> +
> +test_expect_success 'setup' '
> +	test_tick &&

Do we need a test_tick here ?

> +	echo "checkout file" >c &&
> +	echo "modify file" >m &&
> +	echo "delete file" >d &&
> +	git add . &&
> +	git commit -m "initial commit" &&
> +	echo "added file" >a &&
> +	echo "modification of a file" >m &&
> +	git rm d &&
> +	git add . &&
> +	git commit -m "second commit" &&
> +	git checkout -b endCommit
> +'
> +
> +test_expect_success 'reset when there is a sparse-checkout' '
> +	echo "/c" >.git/info/sparse-checkout &&
> +	test_config core.sparsecheckout true &&
> +	git checkout -b resetBranch &&
> +	test_path_is_missing m &&
> +	test_path_is_missing a &&
> +	test_path_is_missing d &&
> +	git reset HEAD~1 &&
> +	test "checkout file" = "$(cat c)" &&
> +	test "modification of a file" = "$(cat m)" &&
> +	test "added file" = "$(cat a)" &&
> +	test_path_is_missing d
> +'
> +

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F6E202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbdCHPoO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:44:14 -0500
Received: from mylo.jdl.com ([208.123.73.151]:57303 "EHLO mylo.jdl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752867AbdCHPoM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:44:12 -0500
Received: from jdl (helo=mylo)
        by mylo.jdl.com with local-esmtp (Exim 4.82)
        (envelope-from <jdl@jdl.com>)
        id 1cldl4-0006L6-CU; Wed, 08 Mar 2017 09:44:10 -0600
From:   Jon Loeliger <jdl@jdl.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2027: avoid using pipes
In-reply-to: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
References: <0102015aae7b8536-00c57d0a-1d48-4153-a202-87c4ea9e0e19-000000@eu-west-1.amazonses.com>
Comments: In-reply-to Prathamesh Chavan <pc44800@gmail.com>
   message dated "Wed, 08 Mar 2017 15:13:35 +0000."
Date:   Wed, 08 Mar 2017 09:44:10 -0600
Message-Id: <E1cldl4-0006L6-CU@mylo.jdl.com>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jdl@jdl.com
X-SA-Exim-Scanned: No (on mylo.jdl.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, like, Prathamesh Chavan said:
> The exit code of the upstream of a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we
> can test the exit codes of both the commands.
> 
> Signed-off-by: Prathamesh <pc44800@gmail.com>
> ---
>  t/t2027-worktree-list.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 848da5f..daa7a04 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -31,7 +31,7 @@ test_expect_success '"list" all worktrees from main' '
>  	test_when_finished "rm -rf here && git worktree prune" &&
>  	git worktree add --detach here master &&
>  	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short 
> HEAD) (detached HEAD)" >>expect &&
> -	git worktree list | sed "s/  */ /g" >actual &&
> +	git worktree list >out && sed "s/  */ /g" <out >actual &&
>  	test_cmp expect actual
>  '

I confess I am not familiar with the test set up.
However, I'd ask the question do we care about the
lingering "out" and "actual" files here?  Or will
they silently be cleaned up along the way later?

Thanks,
jdl

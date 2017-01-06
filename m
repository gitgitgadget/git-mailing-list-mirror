Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C1D1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 13:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034129AbdAFNmq (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 08:42:46 -0500
Received: from mout.gmx.net ([212.227.17.20]:50265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdAFNmo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 08:42:44 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDV5t-1cHWh32edx-00Gp6f; Fri, 06
 Jan 2017 14:41:44 +0100
Date:   Fri, 6 Jan 2017 14:41:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Kyle Meyer <kyle@kyleam.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch_get_push: do not segfault when HEAD is detached
In-Reply-To: <20170106045623.21118-1-kyle@kyleam.com>
Message-ID: <alpine.DEB.2.20.1701061438300.3469@virtualbox>
References: <20170106045623.21118-1-kyle@kyleam.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yXxkPgJjc9ZF8RlgZtTyAUdcKDu6gldYLaOlAEVtqdmUkqpUQ/C
 hOsqw4xhdWLGuGSTzOBPlz5gf7H1aeQT9QAUXYeBpDE1+GGP9KeW6JO9HCe6+8C3SNd4sHv
 dU5qniciM624i0xHlKVbn+1PjwegCiH+D4lg5p3ljQSJ2Wikaboifj8QHtXk1T3l/c2qPUL
 KSIUFUGn40vHnHBtpwYHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nKTz88r+96Q=:asCXfZ9Tgud/fapW3qWfBo
 h6Jka8RbR7Y7IparwzpAVguIH8ZLZVtJpTa5f1fEub6bWlq88urHs2fKCG5a1ykYxwQyFc+U/
 7wSnrYUs90O1cn1+HFNe0LS1mJWMl/4tUw5hSRA4cAnmgKWKKbuGtolv6rX52WVTEnkktG2MK
 EGDjWOBsQiUUIYAunXvhXDG7OfHvciJX7U4g8J07KFfwUz7pMKeHkgGDPaXRGzSqReBas/XUc
 UhZNu5pI5J36pYGPIItpOyp66B6JhzC0poPaebJ2HJcjeiGq21r8PcjAKnbaWqM/q2xEJcv+5
 6vElc5XV2DqIwAyous8D8NgNe6g5sptgVx9DfgWdvqRBfRGSKIeG6dxqBRAIrLt0ix2OCEifG
 dgFkgxqFRWMIMA8IB839cMPYnUYi0Ps5YqJCCyAIqaWiYxuVuegPQj3SmRJmP/yPCtFSe1NeT
 DWVHqtaxAtg9xdkAE9f89rHXKtwcANMQV4uJ5OpA520Nc3zXYfJU5ZHces6onEcz9fy4czwCS
 U81I15WRsIS+2nFdTZGCxc7FFpMEZz0T8/SVeXrxPIXG4XTEdrfYSx6NDRWYdfLE0G3C/q7ZV
 qxzPM+cnf17b7huKx543xamteWI+WHbNTQX7P+Lo6AWlgH7boc/9mko+pxuecltw/F08H3Z5b
 cAqOJwkSoi5rIOMLk9Zx0T1vlrJgjA8nnIScHpJCFZ3KfQS4a/PHx3Pvj+E3Wsbxz8O/HLRkn
 4YYUfbNVOfTJCaxUMA2uc4avqtGI/tcwZFio9G5QyB7hDcs1EJATzfnGcc7ZvT27Csjbq2Fse
 0CWJPw9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle,

On Thu, 5 Jan 2017, Kyle Meyer wrote:

> Move the detached HEAD check from branch_get_push_1() to
> branch_get_push() to avoid setting branch->push_tracking_ref when
> branch is NULL.
> 
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>

Good point.

> diff --git a/remote.c b/remote.c
> index ad6c5424e..d5eaec737 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1716,9 +1716,6 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
>  {
>  	struct remote *remote;
>  
> -	if (!branch)
> -		return error_buf(err, _("HEAD does not point to a branch"));
> -
>  	remote = remote_get(pushremote_for_branch(branch, NULL));
>  	if (!remote)
>  		return error_buf(err,
> @@ -1778,6 +1775,9 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
>  
>  const char *branch_get_push(struct branch *branch, struct strbuf *err)
>  {
> +	if (!branch)
> +		return error_buf(err, _("HEAD does not point to a branch"));
> +
>  	if (!branch->push_tracking_ref)
>  		branch->push_tracking_ref = branch_get_push_1(branch, err);

This is the only caller of branch_get_push_1(), so all is good.

> diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
> index 7214f5b33..90c639ae1 100755
> --- a/t/t1514-rev-parse-push.sh
> +++ b/t/t1514-rev-parse-push.sh
> @@ -60,4 +60,10 @@ test_expect_success '@{push} with push refspecs' '
>  	resolve topic@{push} refs/remotes/origin/magic/topic
>  '
>  
> +test_expect_success 'resolving @{push} fails with a detached HEAD' '
> +	git checkout HEAD^{} &&

I seem to recall that we prefer HEAD^0 over HEAD^{} and the existing
scripts seem to agree with me:

$ git grep -c HEAD^0 junio/pu -- t/
junio/pu:t/t1450-fsck.sh:1
junio/pu:t/t1507-rev-parse-upstream.sh:2
junio/pu:t/t2020-checkout-detach.sh:5
junio/pu:t/t3200-branch.sh:1
junio/pu:t/t3203-branch-output.sh:3
junio/pu:t/t3400-rebase.sh:1
junio/pu:t/t3404-rebase-interactive.sh:1
junio/pu:t/t5407-post-rewrite-hook.sh:2
junio/pu:t/t5505-remote.sh:1
junio/pu:t/t5510-fetch.sh:1
junio/pu:t/t5533-push-cas.sh:3
junio/pu:t/t6035-merge-dir-to-symlink.sh:3
junio/pu:t/t7201-co.sh:2
junio/pu:t/t7402-submodule-rebase.sh:1
junio/pu:t/t9105-git-svn-commit-diff.sh:1
junio/pu:t/t9107-git-svn-migrate.sh:1

$ git grep -c HEAD^{} junio/pu -- t/
junio/pu:t/t3200-branch.sh:3

Maybe use HEAD^0 just for consistency?

Ciao,
Johannes

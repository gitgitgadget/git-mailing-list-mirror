Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ED1C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC51613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhGNW2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:28:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65256 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbhGNW2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A97C83E2;
        Wed, 14 Jul 2021 18:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nJo+W+QZdmD7UVy9AtVOBl9DgleQif4kdx6C9f
        zRh5k=; b=MpWEJjoTVpWWFAqRrZ3MlCrhlfw9CxlqcvwdqVvJE+9kkYi2dKuRLl
        nfSJ13jIiOJShFKE9P5T+nUZZyG3Zh9BQwQhXGfGe6aL8/zkJsp+8uKSvH/G+mlp
        ZzS9SonsMsAEEhjRgd/9i+BAKGP1WW9uQCbisXqOORX3B5khcUNZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0021BC83E1;
        Wed, 14 Jul 2021 18:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BB56C83DF;
        Wed, 14 Jul 2021 18:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci(check-whitespace): restrict to the intended commits
References: <pull.995.git.1626300577.gitgitgadget@gmail.com>
        <b63a5bbc63ba17449a91913ab28c268db5fa3650.1626300577.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 15:25:15 -0700
In-Reply-To: <b63a5bbc63ba17449a91913ab28c268db5fa3650.1626300577.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 14 Jul 2021
        22:09:37 +0000")
Message-ID: <xmqqwnpsttx0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D67977A-E4F2-11EB-9CB4-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Unfortunately, this means that we no longer can rely on a shallow clone:
> There is no way of knowing just how many commits the upstream branch
> advanced after the commit from which the PR branch branched off. So
> let's just go with a full clone instead, and be safe rather than sorry
> (if we have "too shallow" a situation, a commit range `@{u}..` may very
> well include a shallow commit itself, and the output of `git show
> --check <shallow>` is _not_ pretty).

Makes sense.

As long as you have pull-request base, I suspect that you could
shallow clone the base and incrementally fetch the rest to update,
perhaps?  But I do not know if it is worth doing so for a small
project like ours.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/check-whitespace.yml | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
> index c53614d6033..8c4358d805c 100644
> --- a/.github/workflows/check-whitespace.yml
> +++ b/.github/workflows/check-whitespace.yml
> @@ -12,15 +12,9 @@ jobs:
>    check-whitespace:
>      runs-on: ubuntu-latest
>      steps:
> -    - name: Set commit count
> -      shell: bash
> -      run: echo "COMMIT_DEPTH=$((1+$COMMITS))" >>$GITHUB_ENV
> -      env:
> -        COMMITS: ${{ github.event.pull_request.commits }}
> -
>      - uses: actions/checkout@v2
>        with:
> -        fetch-depth: ${{ env.COMMIT_DEPTH }}
> +        fetch-depth: 0
>  
>      - name: git log --check
>        id: check_out
> @@ -47,7 +41,7 @@ jobs:
>              echo "${dash} ${etc}"
>              ;;
>            esac
> -        done <<< $(git log --check --pretty=format:"---% h% s" -${{github.event.pull_request.commits}})
> +        done <<< $(git log --check --pretty=format:"---% h% s" ${{github.event.pull_request.base.sha}}..)
>  
>          if test -n "${log}"
>          then

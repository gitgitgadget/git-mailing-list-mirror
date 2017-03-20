Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B6520958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbdCTRv2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:51:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56594 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932214AbdCTRvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:51:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 059BB7DD1E;
        Mon, 20 Mar 2017 13:51:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rgUmVI0348cdqOp4ZHRL7DlllUE=; b=xttGGe
        UaSM2NMKQd22JAMMxRnRmyLpXW/+gqnUbHIkEfekBwhni2TKbJp1ZnPscgot4+tP
        xHWdA1tiarXOgUt7iy/8kb4ZH7493ADUux9Q4BQ0gueTA4A1STk/wdS5+8kR+Jvi
        TeL1GgE+iQz6MzYblEKJyNF4g7bRPb/MJoZYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rA1CB4e16LYJKV/nPSJA/fz+bJHa2H2H
        34qmlYorn2/UffNNI9bq41yR4nKRHOrUZvxXkITvnMDXNnnQYgig1c61JN11M/ff
        rboDq+PJGoa2ydzw3V/wPgbHY1dtjbdzHc1kr/7bqrSuCV8LHqH7VZij2GnyouQe
        wlgrsHlg/Qs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F29EB7DD1D;
        Mon, 20 Mar 2017 13:51:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D0907DD1C;
        Mon, 20 Mar 2017 13:51:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC 1/3] stash: show less information for stash push -- <pathspec>
References: <20170318183658.GC27158@hank>
        <20170319202351.8825-1-t.gummerer@gmail.com>
        <20170319202351.8825-2-t.gummerer@gmail.com>
Date:   Mon, 20 Mar 2017 10:51:16 -0700
In-Reply-To: <20170319202351.8825-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 19 Mar 2017 20:23:49 +0000")
Message-ID: <xmqqk27jx2ej.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D17C4590-0D95-11E7-AEB4-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> When using git stash push -- <pathspec> in the following sequence:
>
>        git init -q repo
>        cd repo
>
>        for i in one two; do
>                echo content >$i
>                git add $i
>        done
>        git commit -qm base
>
>        for i in one two; do
>                echo change >$i
>        done
>        git stash -- one
>
> it shows:
>
>    Saved working directory and index state WIP on master: 20cfadf base
>    Unstaged changes after reset:
>     M   one
>     M   two
>
> Even though "one" no longer has unstaged changes.
>
> It really is enough for the user to know that the stash is created,
> without bothering them with the internal details of what's happening.
> Always pass the -q flag to git clean and git reset in the pathspec case,
> to avoid unnecessary and potentially confusing output.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  git-stash.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 9c70662cc8..59f055e27b 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -299,10 +299,10 @@ push_stash () {
>  	then
>  		if test $# != 0
>  		then
> -			git reset ${GIT_QUIET:+-q} -- "$@"
> +			git reset -q -- "$@"
>  			git ls-files -z --modified -- "$@" |
>  			git checkout-index -z --force --stdin
> -			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
> +			git clean --force -q -d -- "$@"
>  		else
>  			git reset --hard ${GIT_QUIET:+-q}
>  		fi

Yup, we only said "HEAD is now at ..." in the non-pathspec case (and
we of course still do).  We didn't report changes to which paths
have been reverted in (or which new paths are removed from) the
working tree to the original state (and we of course still don't).

The messages from reset and clean that reports these probably do not
need to be shown by default to the users (they can always check with
"git stash show" when they are curious or when they want to double
check).





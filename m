Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D46AC55189
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 02:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA3208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 02:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuYY6xXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDWCDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgDWCDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 22:03:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA409C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 19:03:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so449019pfn.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 19:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OJ4D3HxfxMphiZTRZkjNT0z2N+jHRKIeblTyk/QWJ8w=;
        b=SuYY6xXlpMGXUZqX9XgDu4Xv0A4Dh4JQ2jr5m1fjZidGIM+B/wDyubyZtjYml/cwxw
         KQ7v5Ne1jst/K2HYWjwEedM7S6LlIRh8tQbqcaF4MaDwINgatRe8YIIiBOEIzfbegtLJ
         Fh+L6TXl4VNWoDZLEaemMDj5KyAq/vVqAtiPVn+1SHv1hWvBj/d5q+V4Vl6YskeBf2qI
         PZQDPRFDuKEsv/T5ZV7I4PTSmjrvokAUGGTolEivYnahIMfD3rriFp2PsA/c3CE4Sg18
         FTbqPTs3vrKUeoFb/t/bM8ktOr34I0GVcpSeWcOZGbQgjvpBZYwJ8eAYuHJxWRcVWHVB
         qggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJ4D3HxfxMphiZTRZkjNT0z2N+jHRKIeblTyk/QWJ8w=;
        b=FgfHsjnrvZijg4x38f9kDKpgA9hEakoPc2uc3ESVWHWntNwGaxN4PWF+FKacT1WaAd
         MxjAn3MWwhtPIIrx+T0Q0G+eYG7AUMRE/E8ySUj1K7mR93WUwwxM/52oylh+7uqEuyDF
         mqMLNco91K9PCyFFiw/XfotQ78BmPUDqGaPU0kpPhBj2s2fspqKa7UYeX70rywXf8jEY
         Ccy5LczMVf71XwbSZ40gEpqdmdO8oM1Tf4xgnu98+2TxeEhnEjCJdGup1h25J0C7PTTh
         AyxRWke0BFH6vyPbUrgxG85W1OOruPIFMI21WU7BkgCAiM3Xz2XN/+GA2gUn+92OQPNE
         /3gw==
X-Gm-Message-State: AGi0PuYACtdaAJpttqK2zNigKIEN9vvgRfE+nmox2Wcgn941nDXvPKBk
        nr50uJKme0HY2qG6REvObwo=
X-Google-Smtp-Source: APiQypKnKs32HojAbLEFH3l7ANMjkdVVaiMuewVpHTUBPOdI8GZh1bSHCyrPPrtywunYVcl54629ww==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr1527213pfh.150.1587607427117;
        Wed, 22 Apr 2020 19:03:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id n17sm839328pff.81.2020.04.22.19.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 19:03:46 -0700 (PDT)
Date:   Wed, 22 Apr 2020 19:03:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] completion: complete remote branches with switch --track
Message-ID: <20200423020344.GI140314@google.com>
References: <20200422201541.3766173-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422201541.3766173-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jacob Keller wrote:

> If the --track option is supplied to git switch, then a new branch will
> be created tracking the specified remote branch.
>
> Fix git completion support so that remote branches will be completed
> when --track is enabled.
>
> Add a couple of simple test cases to help cover this new behavior. Note
> that ideally completion for --track would only allow remote branches,
> and would not complete all refs like HEAD, FETCH_HEAD, etc, so one of
> the new tests is a test_expect_failure to capture this.
>
> Fixes: ae36fe694180 ("completion: support switch")
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I wasn't able to figure out how to get completion to ignore things like tags
> and similar, but I think this is still an improvement.
>
>  contrib/completion/git-completion.bash |  8 +++++---
>  t/t9902-completion.sh                  | 22 ++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)

Thanks for writing it.

One part I found a little confusing is that --track is being used in
two ways.  On one hand, it's an option to __git_complete_refs, meaning
to complete remote-tracking branches.  On the other hand, it's an option
to git switch, meaning to create a branch set up to "git pull" from a
remote-tracking branch.

Can the commit message give a motivating example to describe what
improvement to the user's life this change brings?  ("So now you can
type 'git ... ' and hit TAB and see ....)

Some nitpicks:

[...]
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2235,12 +2235,14 @@ _git_switch ()
>  		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
>  			track_opt='--track'
>  		fi
> -		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
> -			only_local_ref=y
> -		else
> +		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
>  			# --guess --detach is invalid combination, no
>  			# dwim will be done when --detach is specified
>  			track_opt=
> +		elif [ -z "$(__git_find_on_cmdline "--track")" ]; then
> +			# if neither --detach or --track are specified then

language nits:

- s/or/nor/ (because the clause starts with "neither")
- s/are/is/ (because "either" and "neither" are singular)

English can be odd.

> +			# match only local refs.
> +			only_local_ref=y
>  		fi

Let me check that I understand correctly:

If --detach is passed, the <start-point> parameter is an arbitrary
commit.  So we want all refs (or even all commits), not just commits
that are eligible for "git switch --guess" (the default mode) dwimery.

If --track is passed, the <start-point> parameter should be an
arbitrary remote-tracking branch, not just a remote-tracking branch
without corresponding local branch that would be eligible for --guess.
A few lines up we handle this by setting track_opt to empty.

If neither --detach nor --track is passed, then...

... I'm not sure I understand the neither --detach nor --track passed
case.  Wouldn't this be --guess mode, where "$track_opt" is set, so the
value of "$only_local_ref" isn't used?  Or is this about the case
where (1) --detach is not passed, (2) --track is not passed, and (3)
--no-guess or GIT_COMPLETION_CHECKOUT_NO_GUESS is passed?

Yes, it must be about that case.  In that case, only_local_ref is
right.

In any case, this is getting difficult to understand, so I wonder if
some refactoring is in order.

[...]
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1760,6 +1760,28 @@ do
>  	'
>  done
>  
> +test_expect_success 'git switch - default local branches only' '

nit: "default to local branches only" or "the default is local
branches only".  In other words, this should be a sentence so the
reader can understand what property we're testing for.

> +	test_completion "git switch m" <<-\EOF
> +	master Z
> +	master-in-other Z
> +	mybranch Z
> +	mytag Z
> +	EOF
> +'
> +
> +test_expect_failure 'git switch - --track remote branches' '
> +	test_completion "git switch --track " <<-\EOF
> +	other/branch-in-other Z
> +	other/master-in-other Z
> +	EOF
> +'

Can this have a short comment describing the issue?  If over time the
behavior changes, we wouldn't have an easy place to see what the
behavior was at the time this test was added.

> +
> +test_expect_success 'git switch - --track remote branches partial completion' '

"git switch --track: partially typed remote-tracking branch is completed"

> +	test_completion "git switch --track other/master-in" <<-\EOF
> +	other/master-in-other Z
> +	EOF
> +'
> +
>  test_expect_success 'git config - section' '
>  	test_completion "git config br" <<-\EOF
>  	branch.Z

Thanks and hope that helps,
Jonathan

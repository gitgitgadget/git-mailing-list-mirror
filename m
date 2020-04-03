Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FFEC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 08:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE1A206E9
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 08:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L//UdEh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbgDCIq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:46:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32926 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgDCIq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 04:46:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id z14so1547894wmf.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpZxgdq6BgmCODRN5aZm+PYUnMHvnsz1RBWIRYbb0SQ=;
        b=L//UdEh29tdZyuvQxVgnUAKON+CIES1elvJXxh0v7Hb5e5ncqRrhGOCc/kxSaajOu2
         ZQl8tYwh2kvzQXQeKxCHf3zN4Sk+NZBkb90ZlTljqaQ2/AVtOFGjMs9gaQ/DTI8dMnIv
         d9iXNCKTT6fQ3xbVHizNux3rcTFutd46FG5yr6h2J/WkuP3RCb4AkRVCsOoyWOcssB52
         yI6FToTeL2Z+rePZqVT+jJ71HIMfpE+dLCdx+6RthhXgvzo35QpbwKCVoQ8hr/wi3lmc
         41QJHCCp0m9UN9F8WZsKmdQqcHA2tuyrwpKMUuM2GQF1qeTdJr/NwN+B8NZDCTNnKqz0
         rNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpZxgdq6BgmCODRN5aZm+PYUnMHvnsz1RBWIRYbb0SQ=;
        b=XBBIKRH9b0BOTocd48IgpDJlEaPclqYnv5xmgSKvDfkcf71YsthyMq4vVrOILv6Cq/
         /EpPu447wRNWkcb8TAL7oYPTbomWMSHlOMh1YPMQ1spDYz1NNnrvi+gLVWTqh8rxFrqk
         Toc2ytfXUkGDqrvuePz9Vwt1A9mPhOR0NZp/h6Gm9QQFa58gMTppv9CqL505IoZX1Wiw
         gl+Nkl58lO19pQU9UOMbGK5yoL86uX+mu8xhsQA0eOnqrrrerioqtVeOoxNsbrtwwiPT
         8ZWO47pVebdPUUidyGFLm6as0gHFYDV137S2uoWBrC6ew59AQ/lwyNwTMOampEp19tfX
         zM5A==
X-Gm-Message-State: AGi0Pubjh8IT1Gim4zsLJfhkvoCRnypndQh3L0tJGhDbpLyC/N3i1Cdo
        02aJtLPVpLMFP8lyTV4A8/0=
X-Google-Smtp-Source: APiQypL8yYIkKW7flSVVIHugaXXhUv3IYrMDPoqRWXTc5EH58KuZr5XcjZ2pi1/wt25UP1nqNPc/Xg==
X-Received: by 2002:a1c:b4c6:: with SMTP id d189mr7281679wmf.132.1585903617676;
        Fri, 03 Apr 2020 01:46:57 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id h81sm11583401wme.42.2020.04.03.01.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 01:46:56 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:46:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
Message-ID: <20200403084654.GK2224@szeder.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 12:48:30PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> For each CI system we support, we need a specific arm in that if/else
> construct in ci/lib.sh. Let's add one for GitHub Actions.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/lib.sh | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 8d73551a12f..52e350496a3 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -34,7 +34,7 @@ save_good_tree () {
>  # successfully before (e.g. because the branch got rebased, changing only
>  # the commit messages).
>  skip_good_tree () {
> -	if test "$TRAVIS_DEBUG_MODE" = true
> +	if test "$TRAVIS_DEBUG_MODE" = true || test true = "$GITHUB_ACTIONS"
>  	then
>  		return
>  	fi
> @@ -136,6 +136,24 @@ then
>  	MAKEFLAGS="$MAKEFLAGS --jobs=10"
>  	test windows_nt != "$CI_OS_NAME" ||
>  	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> +elif test true = "$GITHUB_ACTIONS"
> +then
> +	CI_TYPE=github-actions
> +	CI_BRANCH="$GITHUB_REF"
> +	CI_COMMIT="$GITHUB_SHA"
> +	CI_OS_NAME="$(echo "$RUNNER_OS" | tr A-Z a-z)"
> +	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx

Hmm, if "macos" isn't not equal to $CI_OS_NAME, then set
CI_OS_NAME=osx.  This is head-scratchingly backwards, and I think

  test "$CI_OS_NAME" = macos && CI_OS_NAME=osx

would read better.

> +	CI_REPO_SLUG="$GITHUB_REPOSITORY"
> +	CI_JOB_ID="$GITHUB_RUN_ID"
> +	CC="${CC:-gcc}"
> +
> +	cache_dir="$HOME/none"
> +
> +	export GIT_PROVE_OPTS="--timer --jobs 10"
> +	export GIT_TEST_OPTS="--verbose-log -x"
> +	MAKEFLAGS="$MAKEFLAGS --jobs=10"
> +	test windows != "$CI_OS_NAME" ||
> +	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"

Likewise.

>  else
>  	echo "Could not identify CI type" >&2
>  	env >&2
> -- 
> gitgitgadget
> 

Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760BAC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 23:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BD520866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 23:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKWZNZBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfLTXHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:07:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34579 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfLTXHS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 18:07:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so10933301wrr.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 15:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B90Wuhe2d20fPy2FHTrcyrPyDpiMlpRBblEUSqLyV3c=;
        b=bKWZNZBl18ZjrApgpjUiiamN5jAg2AGp1a++KkfwRI2C4rBX74VsZDzSssyVkTr5D2
         ghP1yJMzlaODREbRLpdm441GPFUnOgPGkrDAmD37hvsrqx6mEDbxrco8qkzxvnXCMk/N
         R2R6c2orrIcLEjzZoEdkAtNn1lgVopbsb8zREcy7i38rpA+RXb56bi/q9jMv3UGO7wi4
         ykCN1idwoNphikUvPEcE0lB5ybNo4uFu0W8XPsA49t5rciX3BgaK3TgRZrtZAcLBYu4D
         NDfxSIYUsNg+0AG85m19gcUkzfyMvQG3fpMFgBbZWVUT8BNAWS+sTcO49DmGudk/k8OZ
         Ubww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B90Wuhe2d20fPy2FHTrcyrPyDpiMlpRBblEUSqLyV3c=;
        b=UYM1NWp2MYgUGfD/TA/4Pl1L6UF4oU7iHR7WZOArzWucWA5zlNVSH3uz0Dkc73/USW
         kJ+z01hv9FzN3YtAyS8oUhzn6x0LVYEHZTyHXLPxlAGBVsePpIYMokYK27XLEKmw3IiJ
         /q3Z54E1+KM0wLmzB2q7Kv9z25yZ0aNlQTVVkns1Z/HEc90bYlp+wNWelNUr0A4qDeVp
         lUEu5sYB/T3Xd+0WfgOjliw3UVxsxJ34QtoKZFdbSnucjpdqdfB5N6k7Nv84F3mBwcKw
         DK9SB+KXg3/57N+Goy6SLluXJpKbKNg+VfgN+1xMgmW0Sq3N/jLPFOm4HoRt/FE3e+tR
         ZfHg==
X-Gm-Message-State: APjAAAVKKemJcq1UUAJSAHK9cfE3+dlFpSJVsR1LP0bgLopylJAkWjD+
        jMh+59lnWn3pSCJSdAfm/P9poGhe
X-Google-Smtp-Source: APXvYqxh1h2B73LSDDNeaWd0HtqQJfM7I961lCA4+yJaE728GVyyb7sLygF3WyJ9AqE5PG/wd3zT9w==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr17576135wrs.30.1576883235458;
        Fri, 20 Dec 2019 15:07:15 -0800 (PST)
Received: from szeder.dev (x4db40310.dyn.telefonica.de. [77.180.3.16])
        by smtp.gmail.com with ESMTPSA id q6sm11940983wrx.72.2019.12.20.15.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 15:07:14 -0800 (PST)
Date:   Sat, 21 Dec 2019 00:07:10 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, liu.denton@gmail.com,
        gitster@pobox.com, plroskin@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 11/15] contrib: change the prompt for am-based rebases
Message-ID: <20191220230710.GA32750@szeder.dev>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
 <1c3f8ba328982e633e1431eba3fabcb230821ddc.1576861788.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c3f8ba328982e633e1431eba3fabcb230821ddc.1576861788.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subject prefix for this file is most of the time 'bash prompt' or
'git-prompt'.

On Fri, Dec 20, 2019 at 05:09:44PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The prompt for am-based rebases was REBASE, while for interactive-based
> rebases was REBASE-i.  A while ago, we switched merge-based rebases from
> using REBASE-m to REBASE-i via re-implementing the merge backend based
> on the interactive backend.  We will soon be changing the default rebase
> backend to the interactive one, meaning the default prompt will be
> REBASE-i rather than REBASE.  We have also noted in the documentation
> that currently am-specific options will be implemented in the
> interactive backend, and even the --am flag may eventually imply an
> interactive-based rebase.  As such, change the prompt for an am-based
> rebase from REBASE to REBASE-a.

I had a bit of a hard time following which rebase variant is
implemented with which backend and when it was changed, and... etc.

Makes me wonder: do we really need those "-i", "-m" or "-a" suffixes?
What benefit do they bring?  Why don't we just say "REBASE" in the
prompt?

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 2 +-
>  t/t9903-bash-prompt.sh           | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 1d510cd47b..3c81099d60 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -440,7 +440,7 @@ __git_ps1 ()
>  			__git_eread "$g/rebase-apply/last" total
>  			if [ -f "$g/rebase-apply/rebasing" ]; then
>  				__git_eread "$g/rebase-apply/head-name" b
> -				r="|REBASE"
> +				r="|REBASE-a"
>  			elif [ -f "$g/rebase-apply/applying" ]; then
>  				r="|AM"
>  			else
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 88bc733ad6..8da5b1aee2 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -189,11 +189,11 @@ test_expect_success 'prompt - rebase merge' '
>  	test_cmp expected "$actual"
>  '
>  
> -test_expect_success 'prompt - rebase' '
> -	printf " (b2|REBASE 1/3)" >expected &&
> +test_expect_success 'prompt - rebase am' '
> +	printf " (b2|REBASE-a 1/3)" >expected &&
>  	git checkout b2 &&
>  	test_when_finished "git checkout master" &&
> -	test_must_fail git rebase b1 b2 &&
> +	test_must_fail git rebase --am b1 b2 &&
>  	test_when_finished "git rebase --abort" &&
>  	__git_ps1 >"$actual" &&
>  	test_cmp expected "$actual"
> -- 
> gitgitgadget
> 

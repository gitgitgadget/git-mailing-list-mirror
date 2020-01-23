Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D343AC32771
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 02:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CEA24125
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 02:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5y5JSpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAWCz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:55:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46081 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 21:55:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so676297pll.13
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 18:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fRq4eJ4J8/fkhaFzZPqcPmrug7h17S2F00Ymz128z+U=;
        b=q5y5JSpOSAz1Dk812I9cEjNCz0AGnrAOySTeAXAEwJ9OSZJNIJRVyEs0lvjBT+JZJv
         GnaODQIRsJZ4bZh63NHIZY0TcztR8SsQ0L02aCAqJsFP2cAbmqB+2yIKoqkWjnC9K0KS
         8BjQV7LGtih/DuCRtBhRM6t/XgNgV/n6LROXh+jsCy5s8J2DLJaNOCIJF8t9edGaGBHa
         7F3fjTEi2CK7U+Ga4YdSSCbUn35ID6WiZi795Da2NDLHf2LcJJ5T1dT+/RevLpAs/gVL
         OysOv7B3TsAxfMEzaU3+F9ZyLxNHd4kkc68h3/3yYfkJi+ZoK3y9MRRfsQx18vssJ+nm
         MZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fRq4eJ4J8/fkhaFzZPqcPmrug7h17S2F00Ymz128z+U=;
        b=SCwRUmHmrFDIQt0irUXjG3ARb6IbodxnDxyyVQ+Cs4Yi1i2hgEjtIXn0p0XWPSTG/R
         KASYUBjuygIfW8GAM9njiUPa8C/pR/9f2B23Tm1hJpRnxO+aPJCT7fqXxVxb1iOLS/BT
         kyKTuxA0rT+qdz8yMpvqbzBNqHXC0NTXflvoZz1hLW5Xhds8hsaWA+hUT7BQWr27Rb7Q
         ZnjHrhNDEmbJ8RCBMYABp70uyqXDjrfCyh7VYi/hcEZOJgQSYwxLu+KS8vi32wFA0QtO
         uPBZyipDw0E/1Nhv6T+4SKXMccWOcbQxFNaus6YRr7OAF3ihVxX5HPhaNoK57huJHkoG
         6VTg==
X-Gm-Message-State: APjAAAUSn/IyTIrFI3AqhdqhssvOjs9El1Vnw1Pq82xE6PdaNOtHhJQI
        Niriys1SeWBvEnvWqVU5humTTA==
X-Google-Smtp-Source: APXvYqy2qcya8mZUyrXnxfXbM2D+sL964ZKVYzx82RExgbCA+G7uEGPR9fWJnyPOXGwxHN6j700DjA==
X-Received: by 2002:a17:902:ff11:: with SMTP id f17mr1012502plj.273.1579748126623;
        Wed, 22 Jan 2020 18:55:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h126sm308721pfe.19.2020.01.22.18.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 18:55:26 -0800 (PST)
Date:   Wed, 22 Jan 2020 18:55:21 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] git: update documentation for --git-dir
Message-ID: <20200123025521.GA126375@google.com>
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 02:16:51AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> git --git-dir <path> is a bit confusing and sometimes doesn't work as
> the user would expect it to.
> 
> For example, if the user runs `git --git-dir=<path> status`, git
> will not be able to figure out the work tree path on its own and
> will assign the work tree to the user's current work directory.
> When this assignment is wrong, then the output will not match the
> user's expectations.
> 
> This patch updates the documentation to make it clearer.

One thing Heba doesn't mention here is the effort she spent looking into
how to give a similar hint in the form of an advise() call in cases when
--git-dir is specified but --work-tree is not. While it's possible to
show that kind of hint, it turns out to be tricky to decide whether the
call in question actually wants the worktree. There was also some
concern from Jonathan Tan around whether the hint would interfere with
pre-existing user scripts which use --git-dir; since hints show on
stderr, that interference is likely cosmetic, but still not great.

That left me with a couple questions:

 - Is there a reason the advice library can't check whether it's
   pointing to an interactive shell, along the same lines as deciding
   whether to color output or not?
 - How do we generally worry about changes to stderr output in regard to
   user scripts? Is this as concerning as changes to stdout and return
   code, that is, for plumbing we do not change the format?

> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>     [Outreachy] git: update documentation for --git-dir
>     
>     git --git-dir is a bit confusing and sometimes doesn't work as the user
>     would expect it to.
>     
>     For example, if the user runs git --git-dir=<path> status, git will not
>     be able to figure out the work tree path on its own and will assign the
>     work tree to the user's current work directory. When this assignment is
>     wrong, then the output will not match the user's expectations.
>     
>     This patch updates the documentation to make it clearer.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-537%2FHebaWaly%2Fgit_dir_doc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-537/HebaWaly/git_dir_doc-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/537
> 
>  Documentation/git.txt | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index b1597ac002..3b9402c742 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -110,10 +110,15 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>  	Do not pipe Git output into a pager.
>  
>  --git-dir=<path>::
> -	Set the path to the repository. This can also be controlled by
> -	setting the `GIT_DIR` environment variable. It can be an absolute
> -	path or relative path to current working directory.
> -
> +	Set the path to the repository (i.e. the .git folder). This can also be
> +	controlled by setting the `GIT_DIR` environment variable. It can be
> +	an absolute path or relative path to current working directory.
> +
> +	Note that --git-dir=<path> is not the same as -C=<path>.
> +	It's preferrable to set --work-tree=<path> as well when setting
> +	--git-dir to make sure Git will run your command across the correct
> +	work tree.

I feel biased. I want to say, "In many cases, -C=<path> is easier to
understand than --git-dir" instead. :) But my goal with sending this
task to you was "convince people to use -C instead of --git-dir unless
they're really sure" - which may or may not align with the sentiment of
the rest of the list.

 - Emily

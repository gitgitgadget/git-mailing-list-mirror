Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CBC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B04B2067C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+FdQ8oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgCLPN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:13:27 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34914 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgCLPN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 11:13:27 -0400
Received: by mail-pj1-f68.google.com with SMTP id mq3so2786429pjb.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7IlMbKWD0gaKfFIVpXwqDCRgDtXKYq6lyqlbmOptc8Y=;
        b=N+FdQ8oQnf3JlN8JeX9CLMyEnkGXhTMo7/dg18FC40qJvEEJZwfuG22fvob5G0ZtSB
         /5QbKHp+iRclnTYHv9Jkwa5/6z+hK4YwB2rs9i/TNi0BRsrTjUMbIR42I6VgQD/1HfSm
         uXnSzHvQ6jFfLkPtLHN9TBmVUeLCX6Z4QRzQW1s+XxRtWLIm38ByK0chdkbePUpFtb+7
         BgZ6SSB/cipPuMa+cEiBTbH5yzPAQbb99XmffsjZzGcHSZm6C7W1rpIJ/75AblIrtgpm
         IyDWzikxWjgt0CPT25VAg4EXDECbrWa/41avshr1fp8UlvItfbv4wd2nYkrHu6buR3nc
         7ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7IlMbKWD0gaKfFIVpXwqDCRgDtXKYq6lyqlbmOptc8Y=;
        b=pMOfRD13wTS3bPWzPxRhFVGllTXxSu1JJhZEbALm5XQHesx+Mm07mPIEN3xNKLBA/l
         3SURyhvLDUc9l1hkLwFxYVdZJd+c3pbXCJFVqpMYrgSEkx0HAbo69E4EJ3caiCgzCoz6
         nlVLwWxLVkmQ8hIlUqqSeRFpBKAJZD9ssRRjOuxEkkE09j1F2vH8mOR5LUPfSeoBK2iU
         TFKFl1+CVE6QtenxnPa8eWYaTLbIKXoMt638DJcj2vVqw0YXFDq66LE2pbXUZO5reX81
         nEs5FOefmjL3vnVboOJRv3m2GY67VYKBFNaZuFau+7nhjJyyi6p6JNb59UhOLZs/3cA9
         /Jpw==
X-Gm-Message-State: ANhLgQ15Twx91TyMKdrQOi3rmACV2V1kPeBF6p+8pA8JW5jotxocjxsM
        /lGqyq6t4MJSoUNhwbA/u2f1UA==
X-Google-Smtp-Source: ADFU+vuWsFrwZ1Ps1bL5gZFI2SVyBfh1BAyu+7NlhiP8SHxN3qkKwq+a7EP2ZX7Lv3XzLWBXynOlVQ==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr8399483plk.294.1584026004048;
        Thu, 12 Mar 2020 08:13:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c17sm13683203pfn.187.2020.03.12.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:13:22 -0700 (PDT)
Date:   Thu, 12 Mar 2020 08:13:18 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, liu.denton@gmail.com,
        gitster@pobox.com, plroskin@gmail.com, alban.gruin@gmail.com,
        szeder.dev@gmail.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Message-ID: <20200312151318.GM212281@google.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
 <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 15, 2020 at 09:36:41PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Two related changes, with separate rationale for each:
> 
> Rename the 'interactive' backend to 'merge' because:
>   * 'interactive' as a name caused confusion; this backend has been used
>     for many kinds of non-interactive rebases, and will probably be used
>     in the future for more non-interactive rebases than interactive ones
>     given that we are making it the default.
>   * 'interactive' is not the underlying strategy; merging is.
>   * the directory where state is stored is not called
>     .git/rebase-interactive but .git/rebase-merge.
> 
> Rename the 'am' backend to 'apply' because:
>   * Few users are familiar with git-am as a reference point.
>   * Related to the above, the name 'am' makes sentences in the
>     documentation harder for users to read and comprehend (they may read
>     it as the verb from "I am"); avoiding this difficult places a large
>     burden on anyone writing documentation about this backend to be very
>     careful with quoting and sentence structure and often forces
>     annoying redundancy to try to avoid such problems.
>   * Users stumble over pronunciation ("am" as in "I am a person not a
>     backend" or "am" as in "the first and thirteenth letters in the
>     alphabet in order are "A-M"); this may drive confusion when one user
>     tries to explain to another what they are doing.
>   * While "am" is the tool driving this backend, the tool driving git-am
>     is git-apply, and since we are driving towards lower-level tools
>     for the naming of the merge backend we may as well do so here too.
>   * The directory where state is stored has never been called
>     .git/rebase-am, it was always called .git/rebase-apply.
> 
> For all the reasons listed above:
>   * Modify the documentation to refer to the backends with the new names
>   * Provide a brief note in the documentation connecting the new names
>     to the old names in case users run across the old names anywhere
>     (e.g. in old release notes or older versions of the documentation)
>   * Change the (new) --am command line flag to --apply
>   * Rename some enums, variables, and functions to reinforce the new
>     backend names for us as well.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Hi,

This broke quite a few upstream users for us today when we rolled out a
next with this patch added on top. To shim around the post-commit hook
issue, we had set a system config for all our users to use
merge.backend=am; the machinery is pretty intolerant to a wrongly
configured backend name (die() rather than a warning and fallback).

Would it make more sense to deal with an unrecognized backend by falling
back to the default backend, instead?

>  	if (options.type == REBASE_UNSPECIFIED) {
>  		if (!strcmp(options.default_backend, "merge"))
> -			imply_interactive(&options, "--merge");
> -		else if (!strcmp(options.default_backend, "am"))
> -			options.type = REBASE_AM;
> +			imply_merge(&options, "--merge");
> +		else if (!strcmp(options.default_backend, "apply"))
> +			options.type = REBASE_APPLY;
>  		else
>  			die(_("Unknown rebase backend: %s"),
>  			    options.default_backend);

At the very least, can this die() explain that it found that string in
the config so the user can have a guess as to how to fix it?

(I realize the complained code is from earlier in the series, but this
patch - renaming something that used to be valid without a fallback -
invalidated our configs, highlighting the problem for us. So I'm
replying here instead.)

 - Emily


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C7C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 16:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbhK2QUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 11:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbhK2QSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 11:18:36 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4FBC07CA1A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:14:23 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso25781261otf.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AMihqUBUyb1192UI3d8WzNAwmOztB8ZLLbSAED+lq2A=;
        b=myuxJ7Y0u5/jJ9j8sAT1mvq7ewwm+VUiDCdAW0udS0tqsWdvqFOmRdXQmU3wJMVL2Z
         mzCz4s2uGDnEoH6OsT38OC7aYkB4/zHB5TSi2Gh+vL4ZRR1hdcF6sW8CBM3KfqvwO/E5
         vpOIds8qZEYsieDQQ5U7ZJsaUWXRNEwGYcDJOnzpxIjkKDtDYkClfgwEj8jUoAUUoi3L
         IYLU+GPk1rsTIfpuPb+8EeDpHQ2BDD02Q7KrFKnSmTPu9qdEKvdPPW/bExQ4lbO7cBec
         pRqk5Z1n0cOrokunondsw4Ndcc4R6XS3B48VoLJIsMTIZhkvHQ3MpD2QMz6zzv05dnui
         bgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AMihqUBUyb1192UI3d8WzNAwmOztB8ZLLbSAED+lq2A=;
        b=EgNIZ+baWMRgNZRLhPPXgSnuiJcQPbcLiyArG9c23RQzkdD7kl4BLwuJcq8IowfKxi
         kvFyjUQsKFA6TKF6pjXme1LYo0TIpIUdZ9T29WyaPd7fcrQqI6OwpEUZR+DtMK9BN9M1
         ZQNBkYWX3ZB4DrFm2D893tpm1l7bkHkYXEZCGeB9W+miBZvxO6V8y8VLlGTqZK9KBHYd
         SXTc3Bfwo4wQ5Q03BS466zohApoQyg+s6+B8uT1Z+cwau0/5/dMFGPNV9q4Uh+QEzsS2
         gOjnKKETH00qaJQf7VUbZq3pOybSnhuhDW0ZJh0PW0JjWEWc06hjRhg56+zJWRmFqksy
         Zaiw==
X-Gm-Message-State: AOAM533+UlI9BvKIYs1Uu6kp8ZG9x0BIB2E8yXzKPg0eUCO0Zb8LCHPb
        Qz3T8sbBY5+SeFckyhoefP4=
X-Google-Smtp-Source: ABdhPJwzewes5EGlmdRkNp7j3D//jWdAAuIoSBS7HsPzhTBhi7HLRDhpJDz9MeSzY76JJuJFMPGMuw==
X-Received: by 2002:a9d:f4a:: with SMTP id 68mr45611635ott.327.1638195262376;
        Mon, 29 Nov 2021 06:14:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id 16sm2981171oix.46.2021.11.29.06.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 06:14:22 -0800 (PST)
Message-ID: <f65473df-4cb0-afdb-70e3-ee7685e6d817@gmail.com>
Date:   Mon, 29 Nov 2021 09:14:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 4/9] unpack-trees: add special cwd handling
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <e06806e3a3266fa6fdc973fcd7b479bd395c3023.1637829556.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <e06806e3a3266fa6fdc973fcd7b479bd395c3023.1637829556.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25/2021 3:39 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When running commands such as `git reset --hard` from a subdirectory, if
> that subdirectory is in the way of adding needed files, bail with an
> error message.
...
> -test_expect_failure 'reset --hard fails if cwd needs to be removed' '
> +test_expect_success 'reset --hard fails if cwd needs to be removed' '
>  	git checkout foo/bar/baz &&
>  	test_when_finished "git clean -fdx" &&

This test doesn't include any condition on the final state of
the worktree. I could imagine that an implementation could be
writing to the worktree incrementally and then bail halfway
through. A clean "git status" would give us some confidence that
the worktree and index are in a good state after the command
fails.

> +	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED) {
> +		/* Avoid nuking startup_info->original_cwd... */
> +		if (startup_info->original_cwd &&
> +		    !strcmp(startup_info->original_cwd, ce->name))
> +			return add_rejected_path(o, ERROR_CWD_IN_THE_WAY,
> +						 ce->name);
> +		/* ...but nuke anything else. */
> +		return 0;
> +	}
> +

This implementation appears to do the right thing in the case
I'm describing: we check which entries would need to change and
we reject them before doing any real work.

Thanks,
-Stolee

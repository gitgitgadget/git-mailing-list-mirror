Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3B4C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 09:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C09320663
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 09:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFJdhc5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLJJnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:43:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37590 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 04:43:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so19301245wru.4
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 01:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vfLaEKBvvjnEPhKvpAG0JaJnOamY+4i2qJB1Ln/1jy8=;
        b=XFJdhc5ZyebFq3oplVM1xrjrwFA2rsXNzR8p4gJ4mPj6B95bcTf5ozP17kwC/HXSds
         xp/h2kvJBP5CVwVPmEMQhT3Z0eV8yzKNbJ4MTmWwTef/GZmiZsI/Rs3dDLHgKKARhSpz
         vC0LVKBDwIIEzTBjKvQQ3qEozOhQLudxDq8wtE6wvOQodMw6xlBjU4HmtmZ+xh+H6HC1
         f4X4qys1+b/m6sgFak4tHoMlwFhNeJzkUPy+1c+7Vq6NtJjsa4jS890rQEZJdpKru9Ul
         zQQP/Sw9MT4GshNw29J8YYYCUPtlcqEcKUKEvG+eArlUMVEkpJBoJSit5aBrTSwvRljB
         TZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfLaEKBvvjnEPhKvpAG0JaJnOamY+4i2qJB1Ln/1jy8=;
        b=uF44ZIf81nm25RlX4UuSTfbHARxXwrG4/sAlX/z/dP7EyAlWe36Pbxw6PVbDJ6xTE7
         QIn4rZaULu/mPz44Ym0nL2xcJ8j8M4kCUkUvT2SNY2EU0BEdjdC4jzEmi4Tvd4qeOEal
         q/VyVBELFBxvDd0zisUZBVAzqEhJxwzH+JWodIDPf3Kpy79sIu10fUY5cKskgh8892yL
         IMoyEmD+J9r5HP78VrvQdJgnyJx4GS+kXHEn94UzdCVCbfhUeri18Kj8+MymMRkZMxGw
         50AnMXVXnuDDFTn8asDJ6rfi5xAC1DopZIUDj+EdEem0vlYy6hvZIjNsT2THemgxWhpx
         CuaQ==
X-Gm-Message-State: APjAAAW9hq2ht/Dl+ry2CuJv7LKbM2KHgzGDmCIWUxoXM7jKCSttv/3q
        5jEqxAiBShpPeHlh/z4e3vQ=
X-Google-Smtp-Source: APXvYqwOTxzr+rhrtycZLGqejvyfr0uB94zgVIRzFiS2lFRjj3xnk0C0sIKr8nn7nf8c5+eI5dyA1A==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr2054627wrx.14.1575970986299;
        Tue, 10 Dec 2019 01:43:06 -0800 (PST)
Received: from szeder.dev (x4db55d5d.dyn.telefonica.de. [77.181.93.93])
        by smtp.gmail.com with ESMTPSA id z3sm2561602wrs.94.2019.12.10.01.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:43:05 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:43:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] t1301-shared-repo.sh: disable FSMONITOR
Message-ID: <20191210094301.GB6527@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <f9db0c3416ff50587bffe46bb00268d8094c1ad7.1575907804.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9db0c3416ff50587bffe46bb00268d8094c1ad7.1575907804.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 09, 2019 at 04:09:59PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The fsmonitor feature allows an external tool such as watchman to
> monitor the working directory. The direct test
> t7619-status-fsmonitor.sh provides some coverage, but it would be
> better to run the entire test suite with watchman enabled. This
> would provide more confidence that the feature is working as
> intended.
> 
> The test t1301-shared-repo.sh would fail when GIT_TEST_FSMONITOR
> is set to t/t7519/fsmonitor-watchman because it changes permissions
> in an incompatible way.

I don't understand this, and would like it to be more specific, i.e.
which particular permission changes in which tests are incompatible
with watchman.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1301-shared-repo.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 2dc853d1be..665ade0cf2 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -128,6 +128,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
>  '
>  
>  test_expect_success POSIXPERM 'forced modes' '
> +	GIT_TEST_FSMONITOR="" &&

This is not in a subshell, so it disables GIT_TEST_FSMONITOR not only
for the test it is executed in but for the remainder of the test
script.  From the commit message I can't decide whether that's
intended.

>  	mkdir -p templates/hooks &&
>  	echo update-server-info >templates/hooks/post-update &&
>  	chmod +x templates/hooks/post-update &&
> -- 
> gitgitgadget
> 

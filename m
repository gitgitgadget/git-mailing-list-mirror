Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C193C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF4E6121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDGX0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDGX0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:26:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF76DC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:26:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bg21so152517pjb.0
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wHDA5I0tbQ7SSaQCos1Luht1euFMtk0JgMRMc6gY32g=;
        b=TxJXQ9I+ryVmNUoSJjO+c1ZvnulWcfFbOPIKEb0/5cqqB82jearDMqPVaXoEwguOU5
         tKUkOtFz/05DqKQtVC7AQOJe/kVyxIoFTURB5GLCX2bnHIkFUH0vdhBO9To0+pGb4HBG
         eFArUAORFLWcQLiLeOzR9JUGYQgbn8o2JfCm0CGmMqDEVltflAHwzAhLVClnVlgiHESx
         8cSkhUxTI1wAG44D0YXeviWwQe8DS29sfFDr/O6DmRHbk4Kx4ZhQqT16Z2TJMCAPlzO/
         h+JpHLKoXrNmjkVvHDq59anJJ8jriAH5jZFUmO3C/sdzk8OX+IG6xhjBuseaj7VXDseS
         NnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHDA5I0tbQ7SSaQCos1Luht1euFMtk0JgMRMc6gY32g=;
        b=ua65ay3EZxoUgQC+sMMkSv7P55LlBaXNsupZzPSiwmiDJhVSLo1iotLfOhhd8S7ZOY
         XgSLDkYnSHI9k/zKXSICLiU8C5KPlow1DxbrHp9DldAop4YrpHVY6PZyitJRlLJ7rMMc
         OQZSQZP/reIcs7VmimYszDU5xcEcXfykmGtlwi9LgjygW39RaZUvX397pkoLJF5/Ovhr
         1l57cszqAzgC3RJK/EiN1AS2ZYp7/DxWjWhN9bKg2JlPLKFdSOUobRjelYIs8iQc3sql
         mZcaZulkIsJvd7bqKnCRi5cr2/tPkZcLY2iJXi/JpMXRrP/IqzzSHYBDTHpKTHx5nvgZ
         zdmA==
X-Gm-Message-State: AOAM530HK3FdpkEB6gQFg4GMxjzFlKz3YeYawHJm+dkI6H4WQQcEcnBp
        0sv9y975HVqDyAA2LUpUJrpRzHJNuUsDGg==
X-Google-Smtp-Source: ABdhPJzjm1iJxEZK+qvIUvUO0/PKZMA84wfn+HLzol8w3GTOV6ZdXlEBYg+WGv7dCNy57L0B1JVW0w==
X-Received: by 2002:a17:90b:300c:: with SMTP id hg12mr5350392pjb.165.1617838000438;
        Wed, 07 Apr 2021 16:26:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:8cb6:cbee:2f8c:7584])
        by smtp.gmail.com with ESMTPSA id m17sm5821879pgh.41.2021.04.07.16.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:26:39 -0700 (PDT)
Date:   Wed, 7 Apr 2021 16:26:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/5] test-tool: test refspec input/output
Message-ID: <YG4/qltdbWKSv5zT@google.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <bf296282323aa74f7c5b1a49c74d5aaa4b6f37ae.1617734870.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf296282323aa74f7c5b1a49c74d5aaa4b6f37ae.1617734870.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 06:47:49PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
> index be025b90f989..489bec08d570 100755
> --- a/t/t5511-refspec.sh
> +++ b/t/t5511-refspec.sh
> @@ -93,4 +93,45 @@ test_refspec fetch "refs/heads/${good}"
>  bad=$(printf '\011tab')
>  test_refspec fetch "refs/heads/${bad}"				invalid
>  
> +test_expect_success 'test input/output round trip' '
> +	cat >input <<-\EOF &&
> +	+refs/heads/*:refs/remotes/origin/*
> +	refs/heads/*:refs/remotes/origin/*
> +	refs/heads/main:refs/remotes/frotz/xyzzy
> +	:refs/remotes/frotz/deleteme
> +	^refs/heads/secrets
> +	refs/heads/secret:refs/heads/translated
> +	refs/heads/secret:heads/translated
> +	refs/heads/secret:remotes/translated
> +	secret:translated
> +	refs/heads/*:remotes/xxy/*
> +	refs/heads*/for-linus:refs/remotes/mine/*
> +	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
> +	HEAD
> +	@
> +	:
> +	EOF
> +	cat >expect <<-\EOF &&
> +	+refs/heads/*:refs/remotes/origin/*
> +	refs/heads/*:refs/remotes/origin/*
> +	refs/heads/main:refs/remotes/frotz/xyzzy
> +	:refs/remotes/frotz/deleteme
> +	^refs/heads/secrets
> +	refs/heads/secret:refs/heads/translated
> +	refs/heads/secret:heads/translated
> +	refs/heads/secret:remotes/translated
> +	secret:translated
> +	refs/heads/*:remotes/xxy/*
> +	refs/heads*/for-linus:refs/remotes/mine/*
> +	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
> +	HEAD
> +	HEAD
> +	:
> +	EOF

I don't like these expect/actual here. They are almost entirely
identical, which means that the reader either A) spends a toilsome few
minutes checking every single line to be sure they are not identical, or
B) reads the first three lines, decides they're the same, and misses the
@->HEAD special case.

Why not instead run the test once for all the lines which should be the
same before and after the parse, and again for all the lines which
should differ, to reduce burden on the reader?

 - Emily

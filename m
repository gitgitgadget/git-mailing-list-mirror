Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F7CC54FCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AACD2072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHxXteEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgCWSID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:08:03 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42737 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgCWSH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:07:58 -0400
Received: by mail-qv1-f67.google.com with SMTP id ca9so7699533qvb.9
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qm8qM1bnqJHva8yLitPiBFg2pWKbv6JQPjC27HeuMEU=;
        b=kHxXteEX9Nuz1ANPJ/s0jTq4H/02fo+SPJD2sIlrhRuvsO24pnJEGHLiykmRXWYyxF
         FUj1uID05Vuw+5jqapgqzquTak6KHooB+6QZiWAcR8OYPMxDFPQZA/206aeWzuASu4Gd
         wkxyRMLsPDhpWr1xFFRIDghoIVA3kBYyetYHAgzUhtg65YPXx+oNt9FRhMl45oc4lChH
         kK6KrpsodN3ngrrMFDCYtqpq+rJVNHC/PMjy3On3ONvZYvBo2MWrMRDhvhwv8O6L6KN+
         Xd+2AYfFC/HgOO4s9lh/r/MYqr05OUa8Xe55ScboRq+08UAufVHXeCeXVmIQyRx7D2Ep
         PQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qm8qM1bnqJHva8yLitPiBFg2pWKbv6JQPjC27HeuMEU=;
        b=XNFM9FV7m3YOwP4pnKYGBHnl2lNqfBuQbE4Zs9eU/rztwYLiG/okkLhehtqLH9caCz
         xl2Zw9e3dXGcPAZO4Xo8v0KLcWB4BNK2CGCqqCDy0SLxt2NXn+ljmve4JZlf38nXtr06
         Mxebvbg8Z6irpvr6BZDvOgUaNczK8VRcp4o7VNUbHCRipgbBkTzyBPqsbXWTC3B1vu4Q
         5pWRfR915TCe/UFqtHMHfWnAU29yk0hdQkRFkR34GSFIXlQ25ByklTohmngvL4wcj85Y
         1XJ9BYdvOhwPb5LxmITl5nGQsDvXaRadrkxgcFdn3gAvR0Oz0+PadFg1HSvvEB1SmftG
         Jy/w==
X-Gm-Message-State: ANhLgQ1ZnKgkVt+gOLKw/6DMPbPCfHfN0g8dR+eSlBFldo5EWPDJdyFS
        SyUPefMwSdYNC1trHgp0GRk=
X-Google-Smtp-Source: ADFU+vvq3FlPJuSv1YSrNn32KOR4Wd3fmPVSBCFUmb0TYLDum/7p5CUS5cYG188OhYknr4QHQ9GmRg==
X-Received: by 2002:a05:6214:4e:: with SMTP id c14mr4847232qvr.34.1584986877027;
        Mon, 23 Mar 2020 11:07:57 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f93sm12228093qtd.26.2020.03.23.11.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:07:56 -0700 (PDT)
Subject: Re: [PATCH v2 10/18] sparse-checkout: use new update_sparsity()
 function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <27ed4a3f7a28c66d8185cb4c484e8b0af81b15c6.1584813609.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <45021041-eab4-6e0e-5966-11db06333ab2@gmail.com>
Date:   Mon, 23 Mar 2020 14:07:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <27ed4a3f7a28c66d8185cb4c484e8b0af81b15c6.1584813609.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 2:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Remove the equivalent of 'git read-tree -mu HEAD' in the sparse-checkout
> codepaths for setting the SKIP_WORKTREE bits and instead use the new
> update_sparsity() function.
> 
[snip]
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 8607a8e6d1a..86ae422ff5c 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -277,16 +277,23 @@ test_expect_success 'cone mode: add parent path' '
>  	check_files repo a deep folder1
>  '
>  
> -test_expect_success 'revert to old sparse-checkout on bad update' '
> +test_expect_success 'not-up-to-date does not block rest of sparsification' '
>  	test_when_finished git -C repo sparse-checkout disable &&
>  	test_when_finished git -C repo reset --hard &&
>  	git -C repo sparse-checkout set deep &&
> +
>  	echo update >repo/deep/deeper2/a &&
>  	cp repo/.git/info/sparse-checkout expect &&
> -	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
> -	test_i18ngrep "cannot set sparse-checkout patterns" err &&
> -	test_cmp repo/.git/info/sparse-checkout expect &&
> -	check_files repo/deep a deeper1 deeper2
> +	test_write_lines "!/deep/*/" "/deep/deeper1/" >>expect &&
> +
> +	git -C repo sparse-checkout set deep/deeper1 2>err &&
> +
> +	test_i18ngrep "Cannot update sparse checkout" err &&
> +	test_cmp expect repo/.git/info/sparse-checkout &&
> +	check_files repo/deep a deeper1 deeper2 &&
> +	check_files repo/deep/deeper1 a deepest &&
> +	check_files repo/deep/deeper1/deepest a &&
> +	check_files repo/deep/deeper2 a
>  '

This demonstrates some of the value of using update_sparsity.
I expect some more specific tests are coming later in the
series.

>  test_expect_success 'revert to old sparse-checkout on empty update' '
> @@ -316,12 +323,22 @@ test_expect_success '.gitignore should not warn about cone mode' '
>  	test_i18ngrep ! "disabling cone patterns" err
>  '
>  
> -test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status' '
> +test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
>  	git clone repo dirty &&
>  	echo dirty >dirty/folder1/a &&
> -	test_must_fail git -C dirty sparse-checkout init &&
> -	test_must_fail git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> -	test_must_fail git -C dirty sparse-checkout disable &&
> +
> +	git -C dirty sparse-checkout init 2>err &&
> +	test_i18ngrep "error" err &&
> +	test_i18ngrep "Cannot update sparse checkout" err &&
> +
> +	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> +	test_i18ngrep "error" err &&
> +	test_i18ngrep "Cannot update sparse checkout" err &&
> +
> +	git -C dirty sparse-checkout disable &&
> +	test_i18ngrep "error" err &&
> +	test_i18ngrep "Cannot update sparse checkout" err &&
> +

Should the "error" messages we grep for be more specific? Are they
the same as the "Cannot update sparse checkout"?



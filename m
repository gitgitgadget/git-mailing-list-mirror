Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A1C432BE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 17:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED49F6101A
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhHRRRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhHRRRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 13:17:35 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8126C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 10:17:00 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so2979733ilm.11
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0v9YjdpiQK7kYl40SDEorOoP4cBtdw926Z1o9UcqvSI=;
        b=jbWzrA74YB4A3a+uJaQMNuTsi8mgOv4Tkx5oECMecj/uCpN/o/ZNHLLfIGux8sHwD0
         t63XYZcRQq0U/V7vK2fkYtxR21BOlU9hYRFANtg1JKiKX4XXazsbfoXzEBemR6zmTbk7
         h0G5iTaW5+BDSFVODzt1jdTNAPUk1GoT8XhinAn4Gb7jHqzn5zVKn/as+bgzraj3QMxk
         4cQ1IK57tyg32ZdP4E9NhUN95JJXxLDbUNUic8LijCqWRNXuClgAQhbcfiq/2MM2BYtF
         ibV9ANWWWkzHBRwTtpumYgb9U5hhUhhuFengR5ZfFtiB7F1RQStS1OEOGMDFzNf1R36E
         RN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0v9YjdpiQK7kYl40SDEorOoP4cBtdw926Z1o9UcqvSI=;
        b=rPKfLVFVv+YZcpRb2IaLn4ssfQ/wtAvTZj+qsHN23EvHUfKQD8u/MkWDlTlXiiZW10
         8Hy5FNajqDzrbCnhnNKh16ht6YHI1+wbLVvNcZr2hyUI5srjUwpD/Y9+8r8wGOfc3J7x
         cODVPnI/P4vtvR2qs7TitTVBbuHLYqKTt/e1/MnT3BQkuHuM0wubvSQ5jIll72KujEBH
         y21L2YxLv+NkZhQabiSMEZ7PgINxAfOk83ntsXXgF+MR0dtgOrOV/RY28rQtKO2/UlCq
         jGs1d4Sx7ZZK7vzaFjuW6Qj66MC1S6Y8v8505pcPcDl/eALKKqDVnQLpXG1EO3CcpvGL
         TTwQ==
X-Gm-Message-State: AOAM53332o+/JAbYYCokESiAj89gnUOl54jjDrr33XnhFvwW40irDJXN
        fyWHIvodGfPdIg56hCIybGzX1A==
X-Google-Smtp-Source: ABdhPJz8LzoYpKeOdEF3IgNZQnU39H5FQDVLyqcRbGGV7TeHyHLD7YG4/jMPOaKZyFbfqf3yzmzRSQ==
X-Received: by 2002:a92:ae0e:: with SMTP id s14mr7056589ilh.197.1629307020294;
        Wed, 18 Aug 2021 10:17:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14sm155526ilc.51.2021.08.18.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:16:59 -0700 (PDT)
Date:   Wed, 18 Aug 2021 13:16:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
Message-ID: <YR1AizgiVEjt/ULc@nand.local>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 05:08:39PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse index will be compatible with the ORT merge strategy, so
> let's use it explicitly in our tests.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index ddc86bb4152..3e01e70fa0b 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -7,6 +7,11 @@ GIT_TEST_SPARSE_INDEX=
>
>  . ./test-lib.sh
>
> +# Force the use of the ORT merge algorithm until testing with the
> +# recursive strategy. We expect ORT to be used with sparse-index.
> +GIT_TEST_MERGE_ALGORITHM=ort
> +export GIT_TEST_MERGE_ALGORITHM
> +

Looks good, but are the lower hunks which set `-s ort` necessary, too? I
applied this series into my tree and t1092 still passes after reverting
the next two hunks.

Not worth a reroll on its own, just curious.

Thanks,
Taylor

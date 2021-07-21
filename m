Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA749C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2A26120F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhGULn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhGULn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 07:43:57 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C595C061574
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:24:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso1891511otq.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lIgzNh9m7FDMtG/3ZV+I7sk+34oI+fY5k1U7r+ZhDho=;
        b=NEpT3RnLlzqNs2JIsaAmaui6J4yRir7YShOC0Rfzv4hA1ATAMhM4LvILSGXXBCUikg
         CJUqClUY3o/f5H+J+PbZal7leEOxJdcunHLI73jxMIjKTR6Spi/duBwCbEMvZvAbNww/
         h+LbG2koGhnlRYgvGilNsxxTkhUVEAA6SbomcFVe37utfrpHXNtvXFRTPX8H7s/jzUli
         NQ1+o+yrMmI8iqzI0keZR+37fu4VmeCYxNlifuJPbCw/dM5NTrKKRaXGhwxjKfFe0+wB
         MGc6dE5HpEtRFTeapcgWpvvxwm/XBL7AMPPIaxqensNlGH/ng+Xh9yUV+EBvLcmsV8kJ
         6TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lIgzNh9m7FDMtG/3ZV+I7sk+34oI+fY5k1U7r+ZhDho=;
        b=L1kJ/ju4SeOlxWV5MKwP+RSbqBxIYDkmYFSDfCkPxf9CELBhH4TINqd8uUmysMFqaV
         LsYjy9uZ/Rr9OLfszCpzpPlARmTQXAXUbYkfiq5al3yAaOb/q45G6ED9d28cQCmfl0/1
         iqdSiu5vmdjWDYuQpUWnyt9IxkzaCeU0T2EgVr92TEni7vZW7aNWgDSl0mN+0ZDEn53D
         0bdLQy1fJ9ZNzDgU/b37QR4NgFsGUN3qDhWQSwqSr45HKuwfK6cOHVSkPQ31vy42sXfv
         Xk5ysWto4HITu1wzm5nFd20OQKknMFuDiM+wFo6X595jm/MQGm2KCzmerNWtHUYDFoaK
         Y7DQ==
X-Gm-Message-State: AOAM532HWdg8jaiUNJe+rTcdTMTN4Z8D3buoY8D7R2gEmmJH+/IgeC1y
        Z5UgjVxzfDoOfi+g+cPWmCs=
X-Google-Smtp-Source: ABdhPJzUOrckjVs/BopaeZYIfGUlfdlZ871u6DPEuCI1q9rWZzhzCpNS4GLDaikMEbhyo4mkL74wqg==
X-Received: by 2002:a9d:3a34:: with SMTP id j49mr26248705otc.102.1626870273596;
        Wed, 21 Jul 2021 05:24:33 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s8sm3444997oie.43.2021.07.21.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 05:24:33 -0700 (PDT)
Date:   Wed, 21 Jul 2021 07:24:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f811ffd40b8_1305dc2082a@natae.notmuch>
In-Reply-To: <175609272110e4f8d71dce3e6c4e6ca010a8f366.1626831744.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
 <175609272110e4f8d71dce3e6c4e6ca010a8f366.1626831744.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 1/8] t7601: test interaction of
 merge/rebase/fast-forward flags and options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The interaction of rebase and merge flags and options was not well
> tested.  Add several tests to check for correct behavior from the
> following rules:
>     * --ff-only vs. --[no-]rebase
>       (and the related pull.ff=only vs. pull.rebase)
>     * --rebase[=!false] vs. --no-ff and --ff
>       (and the related pull.rebase=!false overrides pull.ff=!only)

This breaks current behavior.

>     * command line flags take precedence over config, except:
>       * --no-rebase heeds pull.ff=!only
>       * pull.rebase=!false vs --no-ff and --ff

This isn't explaind anywhere.

> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -143,6 +143,188 @@

> +#
> +# Group 1: Interaction of --ff-only with --[no-]rebase
> +# (And related interaction of pull.ff=only with pull.rebase)
> +#
> +test_expect_failure '--ff-only overrides --rebase' '
> +	test_attempts_fast_forward pull --rebase --ff-only
> +'
> +
> +test_expect_failure '--ff-only overrides --rebase even if first' '
> +	test_attempts_fast_forward pull --ff-only --rebase
> +'
> +
> +test_expect_success '--ff-only overrides --no-rebase' '
> +	test_attempts_fast_forward pull --ff-only --no-rebase
> +'

These make absolutely no sense. Why does --rebase override pull.ff=only,
but not --ff-only?

> +test_expect_failure 'pull.ff=only overrides pull.rebase=true' '
> +	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
> +'
> +
> +test_expect_success 'pull.ff=only overrides pull.rebase=false' '
> +	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=false pull
> +'

This breaks existing behavior.

Users expect `-c pull.ff=only -c pull.rebase=true` to do a rebase.

> +test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
> +	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
> +'

This breaks existing behavior.

-- 
Felipe Contreras

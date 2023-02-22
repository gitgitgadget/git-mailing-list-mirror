Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A27C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 23:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjBVX4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBVX4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 18:56:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B843475
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:56:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e9so5836757plh.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS7fN9vUY5+QoxTIt2c8uI2XAb8fGKH8ey7zfvF5Rr0=;
        b=ll1m752Lag9wdKIour29JWkf3AjhnYPSfrWKF7pSdCt1ixD6xoY3aI368iOANX3jer
         pZLYAg9oS1BhZPO2WjZehTB9QFxjz4kCreW6gFWVViuVYSs+R3rmsVMr+k37SFKxA3TJ
         VDYVuE9DrgyhsqNObIP8gMNr1cSI2a3GOuGT0stnYOEL0JJcX2m3RFEe+TLUelziI9Tm
         WVUG+aMsvv0XLQbRvJQF13NhJK/VvSJda/MxdzNIIYUFxzuLjt6dmUJGfQKNkJjtF7re
         FtTjZYPWZhK1WxwySNzmYG2on+HeoXBzVocngO6KcrPFgvW9G8711DLKf8ZznjS0bQiU
         Wh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YS7fN9vUY5+QoxTIt2c8uI2XAb8fGKH8ey7zfvF5Rr0=;
        b=76s1DgrfxnBoS9NBGALuFKsWXg8kOqm2M7J/DBt8lNUeKsim3+Eajb0zGfFD7E6ahN
         yeaajq1hAMnGjtdSqkYzMbMCFcNq0h3LJYsWaMsytzoEU+hC3lAFjP7O63oBZCS2vwGQ
         /4U7TDJFUuR1affHgCeQDDaV7jZBSv1nYMKs9NyUVcwxq1kYywH1E7CYmHEtGQ+Q6aGK
         0tHsJ59Q3GjN/uACPE/J4ZZeu06umu85M4hsgaslG2bvNT8OxgUkBCUc/5JjYfZLH5de
         EBiS8dhq3jn9o1nMCVh8drcwzZgQibNN3ivg6ihaZPv3G3JMsLncTZZVWDxON3ge3byn
         pCJg==
X-Gm-Message-State: AO0yUKX+hga27xPqiyRTFcvdVE2lkLP6MGSiBb3HnMzdjEJAQELl8oxQ
        JjNwM5GaC8Ab+lhEssTA+yU=
X-Google-Smtp-Source: AK7set8QLhTuHSJDos7aG/IlQUkthldxPN3CgElrPpOSQXoO5EYnbfhzAVsv5aIdmojGMonKB9SK2w==
X-Received: by 2002:a17:902:fac6:b0:198:f145:504f with SMTP id ld6-20020a170902fac600b00198f145504fmr8330280plb.30.1677110209725;
        Wed, 22 Feb 2023 15:56:49 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090270c800b0019cb4166266sm846267plt.83.2023.02.22.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:56:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 2/3] rebase: stop accepting --rebase-merges=""
References: <20230222051709.464275-1-alexhenrie24@gmail.com>
        <20230222051709.464275-2-alexhenrie24@gmail.com>
Date:   Wed, 22 Feb 2023 15:56:48 -0800
In-Reply-To: <20230222051709.464275-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 21 Feb 2023 22:17:08 -0700")
Message-ID: <xmqqlekpb6f3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index e0d910c229..b8ba323dbc 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -293,6 +293,12 @@ test_expect_success 'do not rebase cousins unless asked for' '
>  	EOF
>  '
>  
> +test_expect_success '--rebase-merges="" is invalid syntax' '
> +	echo "fatal: Unknown mode: " >expect &&
> +	! git rebase --rebase-merges="" HEAD^ 2>actual &&

"!" takes any non-zero exit, even a segfaulting "git".  Let's use
test_must_fail to make sure it dies in a controlled way, i.e.

	test_must_fail git rebase --rebase-merges="" HEAD^ 2>actual &&

> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'refs/rewritten/* is worktree-local' '
>  	git worktree add wt &&
>  	cat >wt/script-from-scratch <<-\EOF &&

Other than that, looking good.

Thanks.

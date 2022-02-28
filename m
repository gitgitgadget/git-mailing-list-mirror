Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A2C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiB1PbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiB1PbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:31:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B307EB0A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:30:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d10so25500470eje.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=q8HRpBSdocvF+QwLHf8JsJx+Hw+Yi+rW//2HMtx4U4E=;
        b=SeQJdkJlnM8XLYPhTLV//+RKDIrxPYuf2pXJK8pYyu6o/EONtY/fDRcb+ES5rHY9jy
         AJJ5V/if0wfldmC2Obbg3WfSoJ67VANmu84cFRfnCS9uC3tmPiXhVsuhYkal9BWIIyfW
         jMpZHNh14m/5tJaU1qvGW/XmY3Sd67VLD0iovHljODQ/IfBe25M+SbC4l4M+33fMHkGl
         t0Lq0C2YwSDLa950sI5eaGWuZHdoI3gJh1o+v5dZ+P3s60FzrTEE5Kp/J30Bua2I1KJ8
         +jYpmbSIzzK7XnIDUg8YcbaXU56ZGPpaU6yKh2nht9ruT2YBVq7x9nqfA82YXsGcS+Yd
         yxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=q8HRpBSdocvF+QwLHf8JsJx+Hw+Yi+rW//2HMtx4U4E=;
        b=FLgP6/rqeJiM16bjE2ETX7FnDq0+/CTyixJtIrRfigLFBbruRGUzUCkM73e3xqwQY6
         kQsfOwqrIRaNILF3dtT/54e/ZaR/mBR08KcAimdeSL3pKAQA4OGtC+sDnFYYVo726JOA
         fM3Qct5H598TSOcTcsDETML2Br5q7Ocw7NZ3XF+Rs0a//FYUWSB1e48m4IVOcduW2l0R
         BJ12TzdA/emaHuJg1tkzYKuRdFPRLbZk7+m8XjY/2kcgly01IH57N/15S1tuF9Zh3B1m
         /+MIoEhW6LsWj+USQ7X+Du6RYPpfyQopEJaoXPSogsHyHs3NiRkH02VlZwwgj0pgxTiE
         s00w==
X-Gm-Message-State: AOAM530kB33lOH2XLlAgQYHZR9u37AKnPLpVfat/b3kmb2az52QGToy/
        Za9RhYRMM6Hkuzt7UbXiOsgG6+hCRYc=
X-Google-Smtp-Source: ABdhPJymIfYRb4Vhgvc0Ls5JUO7MTuRZeAAO10w5cm/INqyY5Pd1k0nWBS+1K85EirqKLK0tYa+yIA==
X-Received: by 2002:a17:906:b348:b0:6cf:5b66:2f80 with SMTP id cd8-20020a170906b34800b006cf5b662f80mr14970716ejb.638.1646062226036;
        Mon, 28 Feb 2022 07:30:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906374500b006d5825520a7sm4466192ejc.71.2022.02.28.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 07:30:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOhyi-001QnV-AK;
        Mon, 28 Feb 2022 16:30:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/4] commit-graph: fix ordering bug in generation
 numbers
Date:   Mon, 28 Feb 2022 16:25:06 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
 <cbcbf10e6994d469abc5463d08165e6a2ba73153.1646056423.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cbcbf10e6994d469abc5463d08165e6a2ba73153.1646056423.git.gitgitgadget@gmail.com>
Message-ID: <220228.86h78j3t67.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> diff --git a/commit-graph.c b/commit-graph.c
> index 265c010122e..a19bd96c2ee 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1556,12 +1556,16 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  				if (current->date && current->date > max_corrected_commit_date)
>  					max_corrected_commit_date = current->date - 1;
>  				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
> -
> -				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
> -					ctx->num_generation_data_overflows++;
>  			}
>  		}
>  	}
> +
> +	for (i = 0; i < ctx->commits.nr; i++) {
> +		struct commit *c = ctx->commits.list[i];
> +		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
> +		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
> +			ctx->num_generation_data_overflows++;
> +	}
>  	stop_progress(&ctx->progress);
>  }
>  
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 2b05026cf6d..f9bffe38013 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -467,10 +467,10 @@ test_expect_success 'warn on improper hash version' '
>  	)
>  '
>  
> -test_expect_success 'lower layers have overflow chunk' '
> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'lower layers have overflow chunk' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	UNIX_EPOCH_ZERO="@0 +0000" &&
> -	FUTURE_DATE="@2147483646 +0000" &&
> +	FUTURE_DATE="@4147483646 +0000" &&
>  	rm -f .git/objects/info/commit-graph &&
>  	test_commit --date "$FUTURE_DATE" future-1 &&
>  	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&

Isn't it worth splitting up this test instead, so that we can test cases
where 32 bit timestamps overflow without these new prereqs.

Unless I'm missing something that would just be a matter of splitting
this test into helper that takes that $FUTURE_DATE as an argument, then
running it for both timestamps, with TIME_IS_64BIT,TIME_T_IS_64BIT on
the 64 bit one.

Or maybe I don't get it, but it seems like we're throwing out some
carefully considered testing for 32 bit compatibility with the
proverbial bath water here....

Aside from that I wonder how this interacts with both:

    #define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)

And this existing code, where offset is timestamp_t, but
num_generation_data_overflows is an "int":

    offset = CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_overflows;

That proooobably does the right thing if int is say 32 bit, but
timestamp_t is 64 bit (does such an OS exist?), but maybe worth looking
at with a second pair of eyes...

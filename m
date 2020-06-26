Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB2C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339FF2080C
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdYF6/Is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFZRta (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZRt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 13:49:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A511BC03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 10:49:29 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i16so8088279qtr.7
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8pizkZGFeGl5QR+268WsPkL/zIbJEd8CIY3vYBu0fDM=;
        b=NdYF6/Is841vUlmedb8BqcmoO2xa9vrq7zGllc0kaIabvLdxsQTJu5QR4l9a8L0i9C
         /Nv1idmv9AYlvJoeWiK8YNGm26gTKf3JMJ715O7fsunkHAMUZKDeqwkC5vuecTjvN6YK
         rcJn8HzExLlzdhFQPz/cGy7/iXOcs2Mqu9iIoGy01EkrzP+lS9foQaC4F/pMoXegRSka
         UqTWT8bWYgQS4w80p/zqDfEhELPP0dvyx6zncWrPTmvxM9UEsHE6oU4HFFsB8V2AAv8K
         9g0AKbctvPrpCOR1WzDwwKqopKrsPoNJTr9l51GbExSO4e74PKXqByMy++MFTNC/wnxT
         kTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pizkZGFeGl5QR+268WsPkL/zIbJEd8CIY3vYBu0fDM=;
        b=UDefmqo1zLtZNzTtXnT7wWvQPkvEaOM/YU10cLbXmmCm5G5H+txdkRB4OmPDaCL7gy
         cSA7GnYtNR/OFupBtya7tqqcn8ry40ljDVuPoMgZ5p+HiLWMTNe8WEbHkTKeCKuhQ1Ur
         dG0sw70T8to8DdjKHo2P7plzTJwB8Cnv8eI535Lhqq92MLN3v1mGON0XIqaa0+rH+NcR
         X4FX8RAVWQLr9s1h0AZp8dJIqvBnhSyOx6Z1AJtq66BL9W6UpqjdRJ0SwuGBacfv+J5j
         Far+tq/f+1Z6Z8bzHxCDCCgcMI6qAncaz38CP2X3BNgh8283YCQOikFBHUSEGxxYOPet
         qNnw==
X-Gm-Message-State: AOAM530gIrNkcIR2G9qtlti3xWxYm51GkE5K7DiTryBpFwBWOQluSCyt
        niOlawTjNOsaxItLR3mLJP4=
X-Google-Smtp-Source: ABdhPJxoJMkeFfUkQRyXjL/J0UH5/ugQrwK4ndZFueNBKHnvjh3MoQ6czjBTj0kcZMsCLQJWIP6Wfw==
X-Received: by 2002:ac8:6c36:: with SMTP id k22mr4028304qtu.288.1593193768851;
        Fri, 26 Jun 2020 10:49:28 -0700 (PDT)
Received: from mail.clickyotomy.dev ([49.206.12.119])
        by smtp.gmail.com with ESMTPSA id v2sm8791654qtq.8.2020.06.26.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 10:49:27 -0700 (PDT)
Date:   Fri, 26 Jun 2020 23:19:21 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] diff-files --raw: show correct post-image of
 intent-to-add files
Message-ID: <20200626174921.GA50735@mail.clickyotomy.dev>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
 <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
 <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late reply.

> Let's make the behavior consistent with modified files by showing
> all-zero values also for intent-to-add files.
>
-- >8 --
>
>                               diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> -                                            the_hash_algo->empty_tree, 0,
> -                                            ce->name, 0);
> +                                            &null_oid, 0, ce->name, 0);
>                               continue;
>                       }
>
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 8a5d55054f..cf0175ad6e 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -240,7 +240,6 @@ test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
>
>       hash_e=$(git hash-object empty) &&
>       hash_n=$(git hash-object not-empty) &&
> -     hash_t=$(git hash-object -t tree /dev/null) &&
>
>       cat >expect.diff_p <<-EOF &&
>       diff --git a/empty b/empty
> @@ -259,8 +258,8 @@ test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
>        create mode 100644 not-empty
>       EOF
>       cat >expect.diff_a <<-EOF &&
> -     :000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
> -     :000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty
> +     :000000 100644 0000000 0000000 A$(printf "\t")empty
> +     :000000 100644 0000000 0000000 A$(printf "\t")not-empty

This change (and the new test in [PATCH v4 2/2]) looks good to me.

I learnt quite a bit about what the string "0{40}" means in the context
of `diff'  post-image from the conversations around this patch. It was
very helpful.

Thank you.

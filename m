Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C3CFA3740
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 11:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJaLth (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJaLtf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 07:49:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E20E0B2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 04:49:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id be13so18844859lfb.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dRmIfu6NGA8OIgl7GHSWIv0hHQEppfU2u9EKJv1M/2k=;
        b=knfwAu7aqyWU/087BnOeACNlItns8V1KFndOelB2lc9R2uhCH2RdO497JpjrXGYCXh
         5j0rw7uja6iyUM2VX0UGfozEGXyyaV77vmiaCffYseIxXtHK/US9oH0GisRSqinh8p63
         Y6VIareMJeDtXY5KeEbuz38aLLZ1dUKIX6w5H2ZxnBZT6/Y7fuctcARwCuy9pTpVAPA3
         lEQDD9NQZoZgKDUh1SPSMwET5LtGjGrPaew22qoe5LUY0t4CfA9+WRTvDGh4QGTyBagI
         McC7VbYif07/elVVUu/GtY3N288eciH/CdyDVEOmB80J5ro/oQe01XYM+0Pj+I4k5KD2
         H6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRmIfu6NGA8OIgl7GHSWIv0hHQEppfU2u9EKJv1M/2k=;
        b=oWLwKLnlmIWQ7PxVXGiw/L5OJZDHuJHtjgiI0NhIA+ln813GRnbPn9FRAAdArYBIM0
         c3AshBy/sar2CfpX4yl0gFJ0iitqeJvHYW1u1EuxXQAlIOVRZwbfp6gBHp5Ix8oHdB7a
         vYctRxMdqozWJxhx71VtLKk+iKa2O+qH3Appa3xX9aNPjsXzzUxIlA7+VCIFbbOe82Cj
         ioa00brbWsI7O6zq0+HeyaOzYZT64ql0O1hn+yU/K9/ggYG+LwY30RFoyaH97hjaVvW+
         wdgS/N1RUeQBhlcNryXjHhV8CroTxR0XQrrN1ZnX/bbTCrCgiRU6fdPvgl99gXxKZLet
         DbTg==
X-Gm-Message-State: ACrzQf3bu3e2ZlQJQ6s6SCAS9gkXxfzhmhFz0lQUyHtgeomah92qC1jX
        gQ2ilh1FSDTSia2qZGrcaPnGIv+q59ZZ2o4pTW8=
X-Google-Smtp-Source: AMsMyM5piyW1frXgRh4mGVdM4HNzM25AxmlffCSyER8YFXNIL84bMixuR7g8zmra2UfkKyNqI6nIH1tduVtkgljyC54=
X-Received: by 2002:a05:6512:33d4:b0:4a2:568b:9956 with SMTP id
 d20-20020a05651233d400b004a2568b9956mr5055829lfg.178.1667216973277; Mon, 31
 Oct 2022 04:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221029102459.82428-1-siddharthasthana31@gmail.com> <20221029102459.82428-2-siddharthasthana31@gmail.com>
In-Reply-To: <20221029102459.82428-2-siddharthasthana31@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Oct 2022 12:49:20 +0100
Message-ID: <CAP8UFD3VRooL7mxYJGs4BAfYTgZjj+GJPN86o-x57LbOVVmCkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cat-file: add mailmap support to -s option
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 12:25 PM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index ec30b5c574..594b6f2dfd 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -45,7 +45,9 @@ OPTIONS
>
>  -s::
>         Instead of the content, show the object size identified by
> -       `<object>`.
> +       `<object>`. If used with `--use-mailmap` option, will show the
> +       size of updated object after replacing idents using the mailmap
> +       mechanism.

I think this should also go in the other documentation patch that was
split off from this series, but it is less clear cut here as there are
probably no conflicts with the other patch.

Otherwise this patch also LGTM, thanks!

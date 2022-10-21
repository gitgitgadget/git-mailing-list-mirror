Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4081DC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 16:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiJUQmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiJUQmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 12:42:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3498288664
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:39:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a13so8076155edj.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoGXX5u2ORLY4HwroHbPyErpC2a1f4xcDzzFjER2gcY=;
        b=SCINYdjpoMZ+6WCTR3vDz6v5XoxfAHWtjAhu194oh1GzgakeCktLgSvqDCyRY4sGHg
         /cjuM20Zlf9QiOGevS4ezUdMDzI6ZZsnjjbmWxv1mWVwGY/ZDnUdNXtvNr9+ccLOp7yD
         Z1HQKdhgdjb6xIFJDk/G6crCZmHGRsCXqc6mtqgCRGiNCeTyHX/LLAXJZxC5dztb7R5m
         lI83H54r0KOdZAINg1rwB//bwC7RgXiEzzbnxHD+EWfk2a4mVAsp60I0Przq7YeUWAb+
         pP7tFtGVeVhoHzKDLwZvCUYP/k1e/VCuOECMkIb7YYnjX5icyCIxhsV6Eht9cJSGjTCU
         /c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoGXX5u2ORLY4HwroHbPyErpC2a1f4xcDzzFjER2gcY=;
        b=EWGf7JoOkKElsbzjQnTwSrSWb3eSYvYr+hy/9IUIhQ2AftH/HuUGijM/c+KTuHYISu
         ybSkkf9MjLpxxxN5z1GNpdXr7KCjisoQxGFOr62dzVtkd95mt4/83lIpMn0OYna7Vbu+
         9UOT4T6AegFvuBua63B+VNgfkTEz8AYmhcaShPCmA7N00JpcWqItoD1Rr9BXA2OBMCnv
         ujsIOcBAIJ0oeaFwO6O+whLblDXBietYp2ZdFX0kmyxF5jnyj0H4ZzDNmW4gEBG07Deb
         f58yiqSobmr+RkG1ceBRvKZLGAJCCPXiCQp0oOi9imllJ30tOPq/NJgh7fSapXzPfqql
         elhw==
X-Gm-Message-State: ACrzQf3Hv3UrQZbQD/xIRIITjbYCDvkUpu1jFvUtGMEK4E4Lrbh21P+b
        FaHPTeskr+B7Mce2wp30f5QRxZxXDzWDIw==
X-Google-Smtp-Source: AMsMyM6Hzqd9uORdL261CAihdGVEyKDGiyK2QhtKCLd78O0nUPA5MYiwQG8Zpy24IjsSKcTdfnbfbA==
X-Received: by 2002:a05:6402:371b:b0:460:ff7d:f511 with SMTP id ek27-20020a056402371b00b00460ff7df511mr7754328edb.148.1666370337362;
        Fri, 21 Oct 2022 09:38:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b007815ca7ae57sm11762931ejb.212.2022.10.21.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:38:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olv2t-0075g2-0k;
        Fri, 21 Oct 2022 18:38:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 9/9] subtree: fix split after annotated tag was squashed
 merged
Date:   Fri, 21 Oct 2022 18:37:34 +0200
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <86a842d50345f6d4d0b16c78d565474be6f8068a.1666365220.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <86a842d50345f6d4d0b16c78d565474be6f8068a.1666365220.git.gitgitgadget@gmail.com>
Message-ID: <221021.86mt9pdtcw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The previous commit fixed a failure in 'git subtree merge --squash' when
> the previous squash-merge merged an annotated tag of the subtree
> repository which is missing locally.
>
> The same failure happens in 'git subtree split', either directly or when
> called by 'git subtree push', under the same circumstances: 'cmd_split'
> invokes 'find_existing_splits', which loops through previous commits and
> invokes 'git rev-parse' (via 'process_subtree_split_trailer') on the
> value of any 'git subtree-split' trailer it finds. This fails if this
> value is the hash of an annotated tag which is missing locally.
>
> Add a new optional argument 'repository' to 'cmd_split' and
> 'find_existing_splits', and invoke 'cmd_split' with that argument from
> 'cmd_push'. This allows 'process_subtree_split_trailer' to try to fetch
> the missing tag from the 'repository' if it's not available locally,
> mirroring the new behaviour of 'git subtree pull' and 'git subtree
> merge'.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  contrib/subtree/git-subtree.sh     | 26 ++++++++++++++++++--------
>  contrib/subtree/git-subtree.txt    |  7 ++++++-
>  contrib/subtree/t/t7900-subtree.sh | 12 ++++++++++++
>  3 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 2c67989fe8a..10c9c87839a 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -453,14 +453,19 @@ find_latest_squash () {
>  	done || exit $?
>  }
>  
> -# Usage: find_existing_splits DIR REV
> +# Usage: find_existing_splits DIR REV [REPOSITORY]
>  find_existing_splits () {
> -	assert test $# = 2
> +	assert test $# = 2 -o $# = 3

This "test" syntax is considered unportable, I'm too lazy to dig up the
reference, but we've removed it in the past. Maybe it's OK with
git-subtree.sh", but anyway, it's esay enough to change...

...but looking at "master" I see one instance of it in git-subtree.sh
already, so maybe nobody cares...

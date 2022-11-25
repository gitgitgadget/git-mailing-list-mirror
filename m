Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80551C433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 05:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKYF26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 00:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYF25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 00:28:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B826135
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 21:28:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so6733726pjk.1
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 21:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tV9o45ZQPZsh27bM8I/z8eoLXRoOD472z3Xp2vpG5W0=;
        b=ewmXcQJPuEW/y0BU0N0ZqSnlBzC25YfI8Re5x2lmv20W863KFzPwc6vln1rd5f4/ch
         t7821bCjLIl7eXGLX7N/ATY7eeRlkRTR9/t8dbDMtiuhTkyZnU1A0vJq35wsVdJ7s4Xj
         6Q5TPEBuBJpL888XBTsWYcdoAqzY3vmw1bU+eIat+4cm1KgS348UfHzNPO1zDS4YosYe
         P8lktgPCM9H/xfwyx8BBT09OVm1BVCDpMji3oKBecfHPeaEmMEk/3pEnuBPOVmil9rdc
         mC+HICd2sFNO6t8+WgmfVUz2JctKDya8xoy5qLcEx5GpuxP4zO+/eelRY/Ej7nQNUQpG
         6kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV9o45ZQPZsh27bM8I/z8eoLXRoOD472z3Xp2vpG5W0=;
        b=POW3Ov20n6ypGqSYpXALfP9XWBwpzaXyV3c8sObMXdqD/ToV52SPr99aIYSdz1KV/6
         QuWDldPZMGTjmFBa9YGTPKys7cupEvYzrqR5h37IABdettJSZtKabBSLClslc4T3lvFV
         OC6AxLCyZFPThpzT44l+/C9DnbyUvPJ5061ZfTO1rJUCAolANBG0pVFFuwAqleOUBipn
         gtSTJTBfrjYyivdNANPvDgQsFbNaMutwfBytPYnLQCMPWGRZoGxNnvcvnKM4nTQxVZ24
         pDBU6VR3ZA3PEnlxZypibmRuzoOF72l2S4C+RMG2yQa+/KdAU+blJYp+zBuaD5qJCD0+
         rXYg==
X-Gm-Message-State: ANoB5pmBkHyxym47STriThnFDiZrpN00PRDBuvLxPse77sQNM+ZkxfaR
        yiRgNwKNE1dlAOess599ABEcby3yDo1gAg==
X-Google-Smtp-Source: AA0mqf5KlsFJhR6whNqpRJobsjYzGP5zq7RmoEWzv34MJrNOdprYNM7HPMgA31asfyNTJuLJP5slYg==
X-Received: by 2002:a17:902:ab89:b0:186:88bd:e656 with SMTP id f9-20020a170902ab8900b0018688bde656mr17516936plr.137.1669354136359;
        Thu, 24 Nov 2022 21:28:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r29-20020a63205d000000b0046ec0ef4a7esm1821434pgm.78.2022.11.24.21.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 21:28:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        kylezhao <kylezhao@tencent.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v8 3/3] docs: fix description of the `--merge-base` option
References: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <pull.1397.v8.git.1669261026.gitgitgadget@gmail.com>
        <c21466d1db0e7f7fcd7308b61aa1e3cd4e3d67c4.1669261026.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 14:28:55 +0900
Message-ID: <xmqqtu2neh60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Zhao <kylezhao@tencent.com>
>
> Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
> ---
>  Documentation/git-merge-tree.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index 298c133fdb6..88ee942101a 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -66,8 +66,8 @@ OPTIONS
>  
>  --merge-base=<commit>::
>  	Instead of finding the merge-bases for <branch1> and <branch2>,
> -	specify a merge-base for the merge. This option is incompatible
> -	with `--stdin`.
> +	specify a merge-base for the merge, and specifying multiple bases is
> +	currently not supported. This option is incompatible with `--stdin`.

Makes sense.  Will queue.

Thanks.

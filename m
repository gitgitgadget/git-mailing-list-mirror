Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649BAC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 21:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhLUV3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbhLUV3I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 16:29:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5CEC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:29:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m21so1634965edc.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SwLgaa1UWVHvwR+LO3zGVnpB7GbkIOlWRGIM+RtgFFw=;
        b=bs4LgILlzjQPZUwX3bZalUFBDUJoomSgzyyI/LJbe1jPnLG22mL7A2qYoV4pdYvwFa
         xOLtdYcFbtcRb0WxmW+Vd7fj2lfOY7fla2xvzOLqGClQ5ZQWUN6A2/qjT1Sn/Q4Gdp87
         F6dG7zUOCZaqSbQV7hp+Sv8lGdGQJImBHih43PqguDaQmaCbAi1AJxj3jnYeQNcbvW+I
         rGT5lmKcgwdW5291V0zF64eJJqmIUOpmi6UpSmLymq1lqRU/6sP1PUHSPqz2fCgtIfl3
         XJBl3Yx+BFEvCMAdRfL+KcZr7hkFet6CXGKGGBZGF8CItWxMF4q0c4GyeEOletYecVmN
         q39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SwLgaa1UWVHvwR+LO3zGVnpB7GbkIOlWRGIM+RtgFFw=;
        b=Mhlsq5Muq8CztOespYNyxaUS4FdUK0cv/6YdCDHI5sW6FQ4A2RUylBZhFGn9/say9I
         QBfojWIwRMyhr6vbHwrIBDEfKC6AHpBhQXvm85iR8J7DY384gr8xaCCjIXZvEkIxfNsd
         IWE0JlRbP47KGFSupMiXF/8BenF/77h7B7MSdyqC9Yo5E8tQE2ldp6ltK1y5vKXiC01m
         cNLQmZzEdsCyaja5yGu8RAmq+fcofPkSG2U3eNxvYCKTX6lMlfbB1ahPq8fKviTx4FuB
         NiPXzIXhJLlzOow/iQRjPJ7KO0DgZYRUSSibP+k6iVOAcvA5c8I8RSpKGD7KJ8GYq0xK
         H6ow==
X-Gm-Message-State: AOAM533VTX6fwDVdpOV1eHO25/xYaRHpTPpO9wNmEYhL22ZGGrwfy1aE
        JA5a0mk9Tn+zo/i8yKnQstpLrrMz+XQ=
X-Google-Smtp-Source: ABdhPJzbeIwEQJ0ZouISUhvkR/r2DAHE3X8IsFtsY8g8Za6EJuOCxWkLBiKYJzsHodBLJin7SfB16Q==
X-Received: by 2002:a17:907:94c3:: with SMTP id dn3mr119320ejc.609.1640122145758;
        Tue, 21 Dec 2021 13:29:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg34sm22084ejc.74.2021.12.21.13.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:29:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzmgz-000x3X-0H;
        Tue, 21 Dec 2021 22:29:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 9/9] doc/diff-options: explain the new --remerge-diff
 option
Date:   Tue, 21 Dec 2021 22:28:48 +0100
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <4f21969e35724ffac6938beb9e089a970f90c41a.1640109949.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <4f21969e35724ffac6938beb9e089a970f90c41a.1640109949.git.gitgitgadget@gmail.com>
Message-ID: <211221.86zgotprz3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/diff-options.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index c89d530d3d1..b05f1c9f1c9 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -64,6 +64,14 @@ ifdef::git-log[]
>  	each of the parents. Separate log entry and diff is generated
>  	for each parent.
>  +
> +--diff-merges=remerge:::
> +--diff-merges=r:::
> +--remerge-diff:::
> +	With this option, two-parent merge commits are remerged to
> +	create a temporary tree object -- potentially containing files
> +	with conflict markers and such.  A diff is then shown between
> +	that temporary tree and the actual merge commit.
> ++
>  --diff-merges=combined:::
>  --diff-merges=c:::
>  -c:::

This & 5/9 would I think be better squashed into their respective "main"
patches.

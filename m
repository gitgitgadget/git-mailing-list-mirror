Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FE8C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiF3Xt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3Xt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:49:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA322B2E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:49:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b133so742439qkc.6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RYw52vFcS/Z5hJY+M7bnQcJrHdwQNwsQYsoqBua0mas=;
        b=e/fXRa+012BH80pE3mPUSlnLbg7wZ85V20bx+u+TAu2lod+hwidlsES8MvnICAgFY9
         NfiSBp7lmXXQfu3Lkb501YBOcX/DsuK59sOXIWE0nBHuoRJc+8qjc0IJru4VQ8DQklvU
         BShDdsSP6sSV4xqODJMWTz2i8YGYS4GPDSxzDVmgLIZkikZqQI4xQ+4GYLiFhYyX/v4H
         t4/XfO4ReMzQc45yD2KyDTgCuDMh0gOOqpiM0WL6IOWaFXmEppD23MiXn45P7XboR4zF
         vvNL4+WN9MzNICyXCqzKXxyGUb7Hk3osV7zLirHIuQhhGUUPk+1eaH9DENvyWYTkYILl
         5jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RYw52vFcS/Z5hJY+M7bnQcJrHdwQNwsQYsoqBua0mas=;
        b=vtqfqc19gO+iQOzJQUW8iAW9kLuLGDP2IWMFMA3Chf0MYlHcZrT70ViFvjt/ZnQK/y
         MJ141iBV7RGo2IlVJDdyFCvrISZ1XKYpabnPp/XE7GKul8KrB0JUzBJV2Y6Cl6rvwOgG
         lOKphh086WU/eCDsVy7zDCyQAP8xmf7V7UpNTSu+r1Bknsb7qrG/y95th/jKZCxt4NgZ
         4ETIqUIS1eQ8oENKUoxb/mYcNm2V1awcoR8HyMTaGIlnB8ulEO/pbD0/T1JPUIIftTH1
         5NdjDxtsIE5XjRkkhOt4AAmgZNJYRnUvMo1ra9KYnEgvcLGPuXcU2FrZNkYlyPH/0bsq
         q16w==
X-Gm-Message-State: AJIora8NV4xxJY0Acr5hgRTclLzde8lUCP4kocLRqbVsXoN4Mnb0ckiX
        PxVLl1hEY6Q+xzUQA8bb3t/rEQ==
X-Google-Smtp-Source: AGRyM1sqdWjGsJ2/DxfPJWXywqqe/HIP1rN4XB6fwOu6ugmQyzZ+WMqz4mmk0NU/D9iBoHIB2Xf6QA==
X-Received: by 2002:ae9:f812:0:b0:6ae:f3d3:6f89 with SMTP id x18-20020ae9f812000000b006aef3d36f89mr8607260qkh.472.1656632944927;
        Thu, 30 Jun 2022 16:49:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s11-20020a05622a1a8b00b003196e8eda26sm8335605qtc.69.2022.06.30.16.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:49:04 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:49:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6 2/5] Documentation: define protected configuration
Message-ID: <Yr42b+MYsuw8ihgG@nand.local>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <43627c05c0b997ea407c865b04994cba630297d6.1656612839.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43627c05c0b997ea407c865b04994cba630297d6.1656612839.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 06:13:56PM +0000, Glen Choo via GitGitGadget wrote:
> @@ -380,6 +381,18 @@ Most configuration options are respected regardless of the scope it is
>  defined in, but some options are only respected in certain scopes. See the
>  option's documentation for the full details.
>
> +Protected configuration
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Protected configuration refers to the 'system', 'global', and 'command' scopes.
> +For security reasons, certain options are only respected when they are
> +specified in protected configuration, and ignored otherwise.
> +
> +Git treats these scopes as if they are controlled by the user or a trusted
> +administrator. This is because an attacker who controls these scopes can do
> +substantial harm without using Git, so it is assumed that the user's environment
> +protects these scopes against attackers.
> +

I think this description is a good starting point, but I think I would
have liked to see some more from the commit description make it into the
documentation here.

One thing that I didn't see mentioned in either is that the list of
protected configuration is far from exhaustive. There are dozens upon
dozens of configuration values that Git will happily execute as a
subprocess (core.editor, core.pager, core.alternateRefsCommand, to name
just a few).

I don't think we should try and enumerate every possible path from
configuration to command execution. But it is worth noting in the
documentation that the list of configuration values which are only read
in the protected context is non-exhaustive and best-effort only.

Thanks,
Taylor

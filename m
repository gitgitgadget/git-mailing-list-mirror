Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8727AC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406AD2068F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdB4HXZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKVULy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:11:54 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:38918 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVULy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:11:54 -0500
Received: by mail-pl1-f170.google.com with SMTP id o9so3540726plk.6
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2wrKmFs87l/Ex0Q82C48UmkSEVBM8Rx1zspPIIJIneU=;
        b=EdB4HXZYjrRWRU/oiaKjgkRxLa0pTbhNKKWDw+8HsffkDi4lj04PmqDyup70WafDUS
         zmfvFNZGn3rxfmr1nVym4mpPOE3IciHrb4aiqRydoKCvn9HiIo93H5Tl9YvviYV6Bz/3
         qGLK1jlkLu4o46vBbFAtaYtPY46U2RB9jhQOt2hQUP6BFmSIoK3qoe0UzV3hqSfB8GsL
         qjg/cF0bHhTjyj7Ln7uCluWK4KceTv8DoI/yMOk54dG7yfoThyKMvKCjJl9drQU3G4l9
         SXxQ6nv/8EJS35EuIoJX1XGUYpGEqUskeRrzx5h0sUXa2BlUYEdkTJMr4U5bZQOYtc/u
         ik7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2wrKmFs87l/Ex0Q82C48UmkSEVBM8Rx1zspPIIJIneU=;
        b=Yg+xWclbCEgWnnmzBc30vfDQIVAUQV5MYSc3NC0pmivhGxutuvPzSvLI5xncLxAJaB
         Dog4/AyRu6K3ck/HDy0G6i4hStH+jcajzPfmCQefGW+ha5DjpAdn5X4vqwPD/AAGQKKD
         AQV/fBVL0WlAGTELEDTyQi3piZv05B/EGaKJIIVC1KZcxJqST28QrsAGsD7ACnI7Di2M
         4QIqo6wYtcwt8fCbAfrUCCYYG7u7NjjzFCGtQzKIQ5QLKoWFX3L0D2LYLbFwA+mzT1aR
         Fn8w75pwoW7Xz4w47UY39jFfyoayH97tYYWdf66zCALltOyCtd03P1tbBHwEFcIoPnN6
         hRcg==
X-Gm-Message-State: APjAAAUddFMxzjbUwDLLgSOExJwuPTh81kytyv0hd387paqc0KIBOYEd
        kkZfO7ZeSDNdYQkki5yYla0=
X-Google-Smtp-Source: APXvYqyUQ0480Em2IJ/ZY1ZwbMjQ1pIuQ8mvYMhAzzp56nW/G96NF4AGHrr/hvmW/WcnR8ZmDfyqWQ==
X-Received: by 2002:a17:902:8508:: with SMTP id bj8mr15729761plb.178.1574453512255;
        Fri, 22 Nov 2019 12:11:52 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u20sm7763183pgf.29.2019.11.22.12.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 12:11:51 -0800 (PST)
Date:   Fri, 22 Nov 2019 12:11:49 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Wes Hurd <13hurdw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] git diff assumes executable permissions change is always
 0755
Message-ID: <20191122201149.GA70732@generichostname>
References: <CAOAGZwFScnS=FSfe9WiJ2h5W1-NCtxU4HM4FUH9LwtcCRuimcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOAGZwFScnS=FSfe9WiJ2h5W1-NCtxU4HM4FUH9LwtcCRuimcg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wes,

On Fri, Nov 22, 2019 at 02:47:02PM -0500, Wes Hurd wrote:
> git 2.24.0
> macOS 10.14.6
> 
> To reproduce:
>  - Start a file, commit in git
>  - chmod 0744 file.txt
>  - git diff
>  - ls -l file.txt
> 
> git diff reports :
> old mode 100644
> new mode 100755
> 
> expected:
> git lists actual permissions of file
> new mode 100744
> File's permissions are 0744 (-rwxr--r--)
> 
> Thanks,

This is expected behaviour. Git only tracks the user executable bit and
extends it to group and other. See here[1] for more details.

Would setting your umask help in any way?

Thanks,

Denton

[1]: https://git-scm.com/docs/user-manual#tree-object

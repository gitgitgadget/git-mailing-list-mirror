Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CE2ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiHaUME (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiHaULz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:11:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D14FF14CE
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:11:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 199so15429909pfz.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=3dWznRqQxkrq1JFxpZtYaEJL4lUgI94wcs674xHEJ8Q=;
        b=SE2XQ+w7ptOETCopvHkJ+4OU+kDVaccC6NPPL+eEBqbr65zDGKNfqzAJ09X2m6aEp7
         PEzfSmAui7NugmVmxTCBCmVikq8zM67YQQpKuA3twZHWTThcZ+6JqY/+UE3SL/ssr1FT
         DRqbO3dsity/UzNUygXL/1JXFv9GuzNcE9d/mdRCiql+lw2KwEBVdb+QWlToxQSRMuA1
         UBlDJi5UIP5Aw5vYVZmV8iXXfW2Krs6rqi9/q5xV0xoEXHFBDYmv+vkSWTHgiUj0wW7S
         QPlLR/s4MTa2w20+pe+2tpuZF6oYhyHGCGNtYgCea/hRukuJ8J9sILW3iL7ar/LfRuZB
         HY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=3dWznRqQxkrq1JFxpZtYaEJL4lUgI94wcs674xHEJ8Q=;
        b=E5PBaGSntEhgjAz5V/KLDHeMeRsGavWjuNqvBURAJV6Mf0f4Zl+cT8/X/NiqhUKNoN
         5lb412SlZT/JvoPCs07TmXrkWFLd3iVqFeh5OnqFjF+uZXeOBoOFcqzFFP7xY96pposx
         imB0/9vBjY57cj4u+syqPvM5WfRyoMCygQSX6A85xOSxUmG7zQm7W0rp6v7w1VT4g6n2
         np8MVu0sxyjtYKssrytDKoGVz2fV7fBsVQMeaA0Akpiu4KBvhOkrHuyzihsCTDoMXv9A
         LDU5iiCvCQvi7ueYhWDgRjT+Y7yv/J3XRHZ7+6EeJ8XGdM2g5y7nQpADHpOZThZub5IU
         4mXg==
X-Gm-Message-State: ACgBeo1uX9AZ3Rb1PLR8nBuThly5NtuzqN4S5LGXK3O3ebdk1z+H1iNG
        mh68UIbGIoZoqwjHAc/ffgRPFOfTl5g=
X-Google-Smtp-Source: AA6agR6MZhSlqKNe56LmvwahSuUhhgFvmqct0uLN+9XuSCwB55akYvb+1QU27RPbshgEUq5+1tjaDA==
X-Received: by 2002:a65:68cf:0:b0:42b:44ad:7235 with SMTP id k15-20020a6568cf000000b0042b44ad7235mr23243757pgt.517.1661976709974;
        Wed, 31 Aug 2022 13:11:49 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b0016bdc98730bsm11978575plb.151.2022.08.31.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:11:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 2/4] fsmonitor: generate unique Unix socket file name
 in the desired location
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
        <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <2cb026a631704b004b06e4a944c79a434df08440.1661962145.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 13:11:49 -0700
In-Reply-To: <2cb026a631704b004b06e4a944c79a434df08440.1661962145.git.gitgitgadget@gmail.com>
        (Eric DeCosta via GitGitGadget's message of "Wed, 31 Aug 2022 16:09:02
        +0000")
Message-ID: <xmqqzgfkdvga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +const char *fsmonitor_ipc__get_path(void)
> +{
> +#ifdef WIN32
> +	return fsmonitor_ipc__get_default_path();
> +#else

Hmph.

As compat/fsmonitor/ directory already sets up a good way to have
platform-specific implementation of a common API function, I think
this patch goes in a wrong direction by fighting it.

Shouldn't the rest of the function we see here be made to another 
implementation of fsmonitor_ipc__get_default_path() that is
specific to platforms, i.e. in compat/fsmonitor/$somenewfile.c,
that is used for !WIN32 case?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D4BC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170C1613DA
	for <git@archiver.kernel.org>; Fri, 28 May 2021 07:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhE1HEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhE1HEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 03:04:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B75C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 00:03:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso1981632pjq.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sVVxjRbOaE38ebzP2h5L0wD+NcWcNNdSUNO02SSldvg=;
        b=lqhQwSP0xSNmUM5PAsKPAfADv9qOBys8o/ZLkDSrjKq0WirARWw6OuRyNxZkWLd3Vu
         7IJjpLHxoiBa2cuFcFrZpOVOwU6hW632/1RPjW8SjlCrRHLNfmKBtFfUXQd+qCsFUDUj
         TvLBuySWYxd+1YNIgV2eGz4Kw+ntDdynng2A+OB3nh7HNSgJtB8ZUG2bWC7Q7g7gVaS4
         zTw8Lr0sphGSXXxjFuwCsi9DnLrUYqYR1FHZMrbHA5CNRKJqdiJYLnTWIpaICdmCDvoZ
         NKJg+LuYrKIHS5daGm0N2dVTYKceCY1/G+LnkYKNdVCYCR2xBXhWG1t1JqycRrNUdojz
         XQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sVVxjRbOaE38ebzP2h5L0wD+NcWcNNdSUNO02SSldvg=;
        b=KkTB9b0vRcbGtKYdciW+fR5qOyXGMLqyIBTik7/3m/ZfojdWfujIYQdKvp0GNbtxTN
         3kT04blX6Jt1l98A5VSAgy0AbRODWWp4oEYJaN17dyxsQHqs+HaAofLKmiaIaOvOTE1P
         tkdT61Ct1nGqcSRgektmE5PGHLRI05JnGT9r2UrJ1V3ApZ0e7gM4A+LcoYGo5zPPFhBv
         cFPvdks1JaLfs1qB4BO9ofy9WniE7kguIY3u0L+Bv8pEvnyNzupSAQsjenmIox83p8b5
         H5Sa6EIcsaGtU+pUO0KNsLK/RaJdrMbEKOkJSyMv6XZzCooXhJ6wPk8Z925PRmCPDImM
         ceBA==
X-Gm-Message-State: AOAM530vja79tuAbNRzaffJKzzPNTSgVCWMrfR+GaI40smM5U5UZJRhX
        asagEFLSM/z5wZN9CEmchuGXpxb4k3BqNg==
X-Google-Smtp-Source: ABdhPJxi3sfxz3+gqwVr0Bf1y4ryfTaMy1F+qPDDncD3PTso9c3lXKuRJBEPJdED4LWGiiurG3bzmA==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr2734473pjb.148.1622185388798;
        Fri, 28 May 2021 00:03:08 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id f186sm3647310pfb.36.2021.05.28.00.03.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 00:03:08 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fetching single tag in shallow clone almost unshallow the clone
Message-ID: <304633fd-e677-7956-6787-f60f195db9b5@gmail.com>
Date:   Fri, 28 May 2021 14:03:05 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a copy of Golang repository [1] on my local Git server on my 
computer. I'm experimenting with fetching single tags in shallow
clone.

I begin with shallow clone the repo:

$ git clone https://<myhost>/path/to/go.git --depth 200 golang
$ cd golang

Because only one, default branch (master) is checked out on shallow 
clone, I fetch latest release branch shallowly:

$ git remote set-branches --add origin release-branch.go1.16
$ git fetch origin release-branch.go1.16 --depth 25

Then I fetch single tag only, that is latest tagged release:

$ git fetch origin tag go1.16.4 --no-tags
> From https://<myhost>/path/to/go
>  * [new tag]           go1.16.4   -> go1.16.4

That above worked, because the commit the tag refers to is already on 
the clone.

But when I fetch a single tag which the commit the tag refers to isn't 
already on the clone, Git fetched almost the entire history (thus almost 
unshallow the clone):

$ git fetch origin tag go1.16.1 --no-tags
> remote: Enumerating objects: 436644, done.
> remote: Counting objects: 100% (427655/427655), done.
> remote: Compressing objects: 100% (75334/75334), done.
> remote: Total 419698 (delta 343975), reused 416121 (delta 341201), pack-reused 0
> Receiving objects: 100% (419698/419698), 146.94 MiB | 16.06 MiB/s, done.
> Resolving deltas: 100% (343975/343975), completed with 4892 local objects.
> From https://gitnode.io/bagas/go
>  * [new tag]           go1.16.1   -> go1.16.1

I expect that instead Git will deepen the shallow clone until the 
specified tag.

Note that I used "almost unshallow" phrase, because although almost the 
whole history had been fetched, `.git/shallow` still exists, meant that 
the clone was still shallow. To convert to full clone, I did `git fetch 
--unshallow`, which also fetched tags referenced on either master or 
already configured released branches.

Thanks.

[1]: https://github.com/golang/go
-- 
An old man doll... just what I always wanted! - Clara

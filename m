Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D8C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 11:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C8420726
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 11:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g49wsczA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLPL5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:57:23 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45314 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLPL5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 06:57:23 -0500
Received: by mail-wr1-f41.google.com with SMTP id j42so2698505wrj.12
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 03:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9rqHsI9nfHLtTYussObj/S0AA2NSg82fy5KKAoj5bbc=;
        b=g49wsczAzAGCOF1JeLl+hfbn0p0b9Unxv9K1ezL23T9ObRjDtagqvlOVH1EDbNjBps
         9AhrowJ6ZvivurVCtmPLLiv/IE4UQjnxpFJR6xApHfpAW8MSxL1z18sswQRJ/lYVRxPP
         j4YQiJXBUZmGSJwJYkTqeKyYW8xJ+TLlB3NEf0jpBDTBX0ow99it91iRA9oY5XPkASVj
         /b6MLS2PQBDiGM1Uk0sCoqcb9b0Zty+JBLyHRsAgnrGrHQhkpMcvfPmGbCKEvxddhPo/
         lZ2jJQEtq20AOQNPgvUb1sK9SwYUwbGokBQkNfj8xDLXapIzamp+aRr+cd73x573mQkS
         AK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9rqHsI9nfHLtTYussObj/S0AA2NSg82fy5KKAoj5bbc=;
        b=ei7VnCs9DChCfqt2BoE8FIejsJU5xOgYQi4Iwh3bHy2fAAAuHNf+9McPsfxIh/5s13
         YGNZ1/HN88JznAQrODOiVypFX5Smk2uuRdyTuQ+UdUTcMssIw94V4aHeIzV76l4ibtK3
         InPdnaCniUcZRfLr7IQtlVqHyR9vVTtYsFu1XwZ3/Kkzn6s2PJQkDSD34eSwpI2wKnGO
         5I+htNYpu+2kN8j9YRDM4/7lWCYLXH5sNHzL2T+Fv75BBtiIDT310al9u1uaVpy5qSty
         52+Yg7d2WIpmmfcWMWqgijEG3mjQ8uPuM6kLwH4RznwtPCs34D7GSM5qJkvgn4DA6+Nk
         7uvA==
X-Gm-Message-State: APjAAAUsHjVlIXrdsaUEF1LyZPINxJibtmOedXkBQvpipUDrBsyd246D
        jF1goxmXotSI/jke3ped6SH5fqfD
X-Google-Smtp-Source: APXvYqzynZ07/fEvfvE6HqxL5rSm9Dc75l2/SusiUQBI+/0ylTEgTsmC3oTlYOTmOgNylk3Pt7Zwkw==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr30818905wro.216.1576497440531;
        Mon, 16 Dec 2019 03:57:20 -0800 (PST)
Received: from [192.168.2.201] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.googlemail.com with ESMTPSA id x10sm21123072wrp.58.2019.12.16.03.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 03:57:19 -0800 (PST)
Subject: Re: git restore --staged --worktree does not restore the index (Git
 2.24.1)
To:     =?UTF-8?Q?Henr=c3=a9_Botha?= <henrebotha@gmail.com>,
        git@vger.kernel.org
References: <CAHbriemxQLVFQw9pTb37JmoD2QVqLcfgY43qFg4Ab8prrBSkuw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4c1324bb-faca-23e2-22b0-5fe2e2aa92e3@gmail.com>
Date:   Mon, 16 Dec 2019 11:57:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAHbriemxQLVFQw9pTb37JmoD2QVqLcfgY43qFg4Ab8prrBSkuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Henré

On 16/12/2019 10:51, Henré Botha wrote:
> git help restore says:
> 
>     The command can also be used to restore the content in the index
> with --staged, or restore both the working tree and the index with
> --staged --worktree.
> 
> However, this doesn't seem to work as advertised:
> 
>     $ mkdir foo; cd foo; git init
>     $ touch a b; git add a b && git commit -m "Initial commit"
>     $ echo "Foo" > a; echo "Bar" > b
>     $ git add a
>     $ git status --short
>     M  a
>      M b
>     $ git restore --staged --worktree .
>     $ git status --short
>     M  a
> 
> I'm not sure whether I expect 'a' to be empty at the end of this
> sequence, but I definitely expect it not to contain staged changes.

Thanks for taking the time to report this. The man page for git restore
states

When both `--staged` and `--worktree` are specified, `--source` must
also be specified."

So I think the bug is in the code that checks the options. It looks like
it is just restoring from the index which is why there's no change to 'a'.

Best Wishes

Phillip


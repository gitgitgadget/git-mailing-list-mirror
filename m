Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB55C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5B860F94
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhG3Nfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhG3Nfr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 09:35:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710AC061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:35:42 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c18so9410056qke.2
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dRZYCcNHNsiHVqMdXcVe7ERZ/arVSFrEW4s7BpyJ/24=;
        b=nbg2l3SDEbrpnIMVZtmh7hfWLZjuPmKH07s9PRiK7KNOig4nbfWTdAoCOWJ2u1jzMn
         ckneUgyIAmr19V7kmPha+LK8OlUj7uhwK/ileCYIu2Gf18k4DWHrWPwItQWRRCO9WdfJ
         owvOju9yOI6cNKlmKe1IcLLd6SZ+QrDZdeW1rK+TiVIOlp7HbbRRazlQwxnHxX6Cv3jT
         e5RdD1yEJpCmZcKAKYT+8s8Fyn+o/x3OB1VdL7BGby3L5S+Pp+cv46dWO6R2gxmD2+rP
         m1bwHHFfYlWK0qCvJ/mn7HESfAEXYguHJ7Rn+dwc1Dd0GzUvVNt0JWBXGbYzMR3OO2z0
         FFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dRZYCcNHNsiHVqMdXcVe7ERZ/arVSFrEW4s7BpyJ/24=;
        b=QqAKSG9RLGdH5C7Sf0K2p2aq6DEOtYERLIXsjxcfeYPae7hyIv9g2PqUUQTUz2QQGn
         Dgm1l1pATvOPDLqRJMYYR1HJFytMv27aVNmCA5mxIwiQPznkw/eP+nnYUZyoTooOozAJ
         SyogdPFEcIHZ9tGORL7sNub6GwVUMC6r+/Kbd2+TVkcV9YjHagqiP8i3bM7ycywyYxCz
         SZ4NmI92yiNUDPqpngDZVYjrdKSRx8oVqgOw4MF+ISUjJRILfi482JDNne+bJtb6aZbN
         1hpctCkZhvylWt0yxveKq2Mf1qPDU9l8bbjEVa2G2JQrieIYr8HdEq0DpFEcML1B4yeF
         xO1w==
X-Gm-Message-State: AOAM533qND2czOyUbtystfY2uIDfbh/bFHnM5JIH9woeYJoREtSAGqOE
        +ey3Kw5xd+ufVG0vbGueNXg=
X-Google-Smtp-Source: ABdhPJz0Di/ftXclDNluFRlNo6aPUzRLv8XmntudpkL0gWeRNU4brp5a1kuoP0pVufshEWhDYHQIlQ==
X-Received: by 2002:a05:620a:1090:: with SMTP id g16mr2292210qkk.256.1627652141424;
        Fri, 30 Jul 2021 06:35:41 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id p187sm887147qkd.101.2021.07.30.06.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:35:40 -0700 (PDT)
Subject: Re: [PATCH 0/1] Improve automatic setup of tracking for new branches
To:     Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <9b8b3a12-6801-1c5d-9cfb-c87b51cd9548@gmail.com>
Date:   Fri, 30 Jul 2021 09:35:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729020125.746206-1-mathstuf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

Le 2021-07-28 à 22:01, Ben Boeckel a écrit :
> Hi,
> 
> I recently discovered some of the nicer behaviors of the `--track`
> option for local branches (courtesy of `vim-fugitive`'s status
> rendering). However, after a few weeks of slowly working `-t
> origin/master` into my workflow, I figured that Git could help me out
> here.
> 
> This patch adds two new configuration variables to initialize the
> `branch.<name>.*` settings for tracking remote branches.
> 
> I searched the docs (including `Documentation/gitworkflows.txt`), but
> didn't see anywhere to describe the fork-based workflow common on forges
> (such as GitHub and GitLab) where this felt "at home". I suppose I could
> describe the workflow I'm used to, but I think I'll hammer that out as
> blog posts before submitting it as documentation.

I'm in favor of a change like the one you propose, thanks for working on this!

The 'triangular' aka 'forking' workflow is, as you discovered, only explicitely
mentioned in the description of '@{push}' [1]. 'gitworkflows(5)' is mostly about
how the workflow used by the Git projet itself (from the description):

     This document attempts to write down and motivate some of the workflow
     elements used for git.git itself.

> 
> I suspect there are more tests that should be added.
> 
> Thanks,
> 
> --Ben
> 
> ---
> v1 -> v2:
>    - removed `branch.defaultPushRemote` (`remote.pushDefault` covers this
>      case already)
>    - improved the commit message with more background and an expanation
>      of the intended uses
> 

Small nit: usually when sending a second version of a patch, you would use
the '-v2' argument to 'git format-patch' so that the patch and cover letter
is prefixed [PATCH v2].


[1] https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-emltbranchnamegtpushemegemmasterpushemempushem

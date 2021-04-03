Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFFFC433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21975611EE
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhDCFYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 01:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhDCFYT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 01:24:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E55C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 22:24:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q10so4743449pgj.2
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 22:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q2DxGj/a0PoD7uW+fv0OQksjJwJ+Iqvff32VWwV/B44=;
        b=tIAzr/E+S+ojQT5+v0s0NFjjEzLVv8PVBh/HVm7kxaUKOrEVOtJczkYsvf2AP1vqCX
         Ar7d9cJeL1Kec3v/9rKGvkIX3NDNVogGBrgoSpE9K+z2C2/4MGtJcljfiHBTy9avseVi
         HbIg5NV6I8gvzeV6n2wo+w7ymPmPHQh64zt/TygVn7nkEVvar4OfW5vhGTcG/TbfcScN
         Zc2l/2A0JRLN3HM7a85bqMOpZjEdfgvjloNvKxdessVPoRcVOqO3+ci8+sCTqJzElmqx
         OojimXlmVjbAByha7zkaFQiKBycjwySxkWHFWqPQeWXsI68kpDyIHFfbMhEEGrTuIOco
         1Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q2DxGj/a0PoD7uW+fv0OQksjJwJ+Iqvff32VWwV/B44=;
        b=DFVNfrELvMF64MUyg7xgtZ6g8eGzXaBxpqDVr7sRGlXF9KO4E/fNWEpEcH1RwwDVsd
         HvO+DG2SuYkHjkblBfuxFtKgOasxaTgOLmQhH38WGK6cTYQ+crGM4KEmSCrDUswdLOh2
         iI+pAeWQAtgxDltFyPp/pMTzMMUg+qlQFhl7sugyCvmm/o+Bx9eBOUtMo6tXxvxCqLO+
         TSYRZzSe5FIfdimrQqnKgyVYnfACcz64/KAYy27EtuKCxqx2g2e6sMo6QNjGIgUYqsF9
         oCcsM0fDaqfWb4ujHj6Wf5PmA+MjD66rqj2b9Ulp+oKi8S2oY6DM02BpFiaHTP17NqGw
         DXEA==
X-Gm-Message-State: AOAM532WwXc3TQfCRBROqUUyk+FmqEgBqwFhCvmBrM6aPNZ9h2nZeR1M
        0/MPKddxfptRa1P8A9IgiHDKma9TBqB32w==
X-Google-Smtp-Source: ABdhPJw/DYaCFUliGZNjEkvFOn6Eq7aj77r9azYtpSj34N8TIGPkHpxI4TxmUmNrQDkr0VTW+yR96A==
X-Received: by 2002:a63:7c5a:: with SMTP id l26mr7927004pgn.224.1617427456381;
        Fri, 02 Apr 2021 22:24:16 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-50.three.co.id. [116.206.28.50])
        by smtp.gmail.com with ESMTPSA id x1sm9638823pfj.209.2021.04.02.22.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 22:24:16 -0700 (PDT)
Subject: Re: [PATCH 0/1] git-apply: Allow simultaneous --cached and --3way
 options
To:     Jerry Zhang <jerry@skydio.com>
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiask@skydio.com,
        git@vger.kernel.org
References: <20210403013410.32064-1-jerry@skydio.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0803a702-ae9c-da9a-c168-d534fe2aab58@gmail.com>
Date:   Sat, 3 Apr 2021 12:24:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210403013410.32064-1-jerry@skydio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04/21 08.34, Jerry Zhang wrote:
> I'm creating a script/tool that will be able to cherry-pick
> multiple commits from a single branch, rebase them onto a
> base commit, and push those references to a remote.
> 
> Ex. with a branch like "origin/master -> A -> B -> C"
> The tool will create "master -> A", "master -> B",
> "master -> C" and either make local branches or
> push them to a remote. This can be useful since code
> review tools like github use branches as the basis
> for pull requests.
> 
> A key feature here is that the above happens without
> any changes to the user's working directory or cache.
> This is important since those operations will add
> time and generate build churn. We use these steps
> for synthesizing a "cherry-pick" of B to master.
> 
> 1. cp .git/index index.temp
> 2. set GIT_INDEX_FILE=index.temp
> 3. git reset master -- . (git read-tree also works here, but is a bit slower)
> 4. git format-patch --full-index B~..B
> 5. git apply --cached B.patch
> 6. git write-tree
> 7. git commit-tree {output of 6} -p master -m "message"
> 8. either `git symbolic-ref` to make a branch or `git push` to remote
> 
> I'm looking to improve the git apply step in #5.
> Currently we can't use --cached in combination with
> --3way, which limits some of the usefulness of this method.
> There are many diffs that will block applying a patch
> that a 3 way merge can resolve without conflicts. Even
> in the case where there are real conflicts, performing
> a 3 way merge will allow us to show the user the lines
> where the conflict occurred.
> 
> With the above in mind, I've created a small patch that
> implements the behavior I'd like. Rather than disallow
> the cached and 3way flags to be combined, we allow them,
> but write any conflicts directly to the cached file. Since
> we're unable to modify the working directory, it seems
> reasonable in this case to not actually present the user
> with any options to resolve conflicts. Instead, a script
> or tool using this command can diff the temporary cache
> to get the source of the conflict.
> 
> Happy to address any feedback. After I address any major
> changes I will add new tests for this path.
> 
> All tests passed locally.
> 
> Jerry Zhang (1):
>    git-apply: Allow simultaneous --cached and --3way options
> 
>   Documentation/git-apply.txt |  4 +++-
>   apply.c                     | 13 +++++++------
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
I know this patch series only have one patch, so why add the
cover letter (PATCH 0/1)? Customarily, single-patch series just
begin with `[PATCH] some title`, then patch message, and actual
diff; all without cover letter.

-- 
An old man doll... just what I always wanted! - Clara

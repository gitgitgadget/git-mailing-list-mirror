Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95CFC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD44961177
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhJFKdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbhJFKdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:33:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED7DC06174E
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:31:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g2so1975874pfc.6
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2RIagVQlElIvBj9COPrtVGYjY0u0m1azCr0z3GPfrc=;
        b=kyayKSTIwmoR0ntJbZSkue9aclg3ybphxF0kdgULBsIcWjVCwugm0iP+hksLbnaH4D
         OHVGTkKGLBT9KEa2guTRGl9QIDdRlaE3Nap1N04nJTxU14lfrHslin2m6wHxzW07USO5
         7QrHnfAfCTioIVP2r0nowuw5F125VDRY+NRI3jm7Or+XAtFXrSlWhk4cBhMd25hV97fW
         DKq5nqDl5jxyZ9b5KJvyUU5xYrESS+lCPhWuIlUIu6BgR10KtavsF8wtibfKDdmEY9FE
         MXJyJQaaf/PmyZ8nJp/52a29gfWtsDwMUxG01m1G7Z5t2bW4jpaYF6wOiXhxPSdgAnPI
         8J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2RIagVQlElIvBj9COPrtVGYjY0u0m1azCr0z3GPfrc=;
        b=BSd5Ib7uSYrqj7+zV1SUC6QjW8lZRDYY0SaQ6Ff+ul/fTYxnMg7mBW068en0Ox5qsH
         Qr98qEOV3OS313vKqaifGAeunN/l8aXvIZV6QPf9hRpFbcBR8+8SUG6PNPXL6Kn/wQh9
         HMIkjhg8zoh2+xvkrxo9fnNwVS6alU9sS4cAenUJCefarIHrJaEH0StcAF5Dpkns+PGk
         SWUIO6LIK7P0rFK0sSCXLcM4wmcXsBnXQmbNujmNf42sA24RPXzxcNlKCs1gTr1pw+4R
         7LAmioPISZ0k1w9PxB3YBfmuF7rKBSpDytqfkC7OfQcxGeJrO1559+ekkv8i6cxgVt8p
         BX8A==
X-Gm-Message-State: AOAM532WsSfoDj/CJzwkz0lZkAN5KDGlhNz1mXIIQlrzy9s5DAfeGbi2
        +OYoRv8D52TCvn24QbBEmCX9H6mrJ50cTQ==
X-Google-Smtp-Source: ABdhPJzG8Cg85+ASHi3D412dtl5OVFEeRuUa1g3Ys4ItMc3/6tFhTGyS3sv7zoZDoDF7SHGuKnhBLw==
X-Received: by 2002:a05:6a00:43:b0:43d:f06e:4f4a with SMTP id i3-20020a056a00004300b0043df06e4f4amr36559378pfk.20.1633516276435;
        Wed, 06 Oct 2021 03:31:16 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id ie13sm4657015pjb.20.2021.10.06.03.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 03:31:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] reset: behave correctly with sparse-checkout
To:     Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Kevin Willford <kewillf@microsoft.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f6ccec5f-1946-dc13-c19e-d6889f943bc2@gmail.com>
Date:   Wed, 6 Oct 2021 17:31:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/21 20.20, Kevin Willford via GitGitGadget wrote:
> When using the sparse checkout feature, 'git reset' will add entries to
> the index that will have the skip-worktree bit off but will leave the
> working directory empty. File data is lost because the index version of
> the files has been changed but there is nothing that is in the working
> directory. This will cause the next 'git status' call to show either
> deleted for files modified or deleting or nothing for files added. The
> added files should be shown as untracked and modified files should be
> shown as modified.
> 

Better say `... but there is nothing in the working directory`.

> To fix this when the reset is running if there is not a file in the
> working directory and if it will be missing with the new index entry or
> was not missing in the previous version, we create the previous index
> version of the file in the working directory so that status will report
> correctly and the files will be availble for the user to deal with.
> 

s/availble/available

-- 
An old man doll... just what I always wanted! - Clara

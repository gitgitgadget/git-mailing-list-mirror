Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF6C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AFA60FDB
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFGRNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGRNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:13:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B372C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 10:11:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r7so6871666edv.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2kqowXnYDwi/TtRXHLO4CMt2VSC5aLanCfXvkJNJyDg=;
        b=X6buaocx6zla3PSd7G2pYgwxssO/WExBcWJ7M61rlQ+DT8uEIMR+Y24eK5S0jSclaI
         GEcOEQ1xvR4Cp+tOc78i1kPl9EOldaPzv+WgxbppIud/jPgX2E9Tr6tZXPEI/dyydSSZ
         4cWWfPW/hKK8Vqxl/XeVhGL1GkLZMPsSMOkK5BEklRK4BJDv6KsXKVjj4Ls1j5c6X0w7
         AlhSF1zAFLtRdUOjNSVH6zG0x954mPHOFEmPJgGcqD66YK3FWRyNAvw7IIgPkzyFl+gn
         neLgBrqPQO7UH0W3LHoA+73H6VxdqjDnZVUqDdF8g/QhjtYHLPLiiPLyaiNQ4ei+YTbF
         tKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2kqowXnYDwi/TtRXHLO4CMt2VSC5aLanCfXvkJNJyDg=;
        b=MFrjfmx9UAL+sXhFyVm/yukb8KEBpDw/CrO76CPBEGX36yRLwiSwDw84a/S7BjUGyi
         yePlSLdZQyD3W3/NqoNtHeskvKjJZwLA1v5SUoFoTDZ7oLC56zidEscU5a+f8t4nYyjA
         CaJTymYQABteJt0O0hLxa7Ftwxo1Sy5BU/Y3ccqBellmQaOfspwHRj08rg2flrzed+47
         ChCHoWAWJd9+OFIMSv/0Jbap9V4wwUUUFxnD/SfLaZAeir5OT+O5YW0XAsuvMOE94iJV
         T6z3kxAU34RTEglAtj8J0k2Lt3zEdj/yD926e2BiqR6JxfslrTPTy8s5b1mMGGp5TDlf
         brJA==
X-Gm-Message-State: AOAM532qXJ5HcHf/WUE4p5s7i10tCMQ5CGNVrLat2gf5pSZdZswJiIFm
        dL8rHj/RgyYcYeTZP9/vey1uoI7ps+1Ilg==
X-Google-Smtp-Source: ABdhPJxImaEQcE/x4cji/qIqgYEyQTDasx2eJow+0IgCQ8B+5AYyg4ZtoSdxrIue+AKY9q8ySdO/Cw==
X-Received: by 2002:a05:6402:145a:: with SMTP id d26mr21185403edx.151.1623085896711;
        Mon, 07 Jun 2021 10:11:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id um5sm6742197ejb.109.2021.06.07.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:11:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Date:   Mon, 07 Jun 2021 19:09:15 +0200
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
Message-ID: <87eedd4n20.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> There are several instances in our documentation where we refer to an
> anonymous user as "a contributor" or "an integrator" or similar. To
> avoid repeating this role, pronouns are used. Previous examples
> chose a gender for this user, using "he/him" or "she/her" arbitrarily.
>
> Replace these uses with "they/them" to ensure that these documentation
> examples apply to all potential users without exception.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

I think this is mostly an improvement, however:

>  .../using-signed-tag-in-pull-request.txt      | 38 +++++++++----------

This is a quote from a mail of Junio's[1] (date and all). I don't think
it makes sense to copyedit that after the fact without at least editing
the header that indicates that it's a verbatim reproduction.

1. https://lore.kernel.org/git/7vehuyosaa.fsf@alter.siamese.dyndns.org/

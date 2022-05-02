Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA30C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 14:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385625AbiEBPAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385619AbiEBPAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 11:00:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F978DFCB
        for <git@vger.kernel.org>; Mon,  2 May 2022 07:57:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so146953pjb.0
        for <git@vger.kernel.org>; Mon, 02 May 2022 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnKxQTXlAzzQEyOAVYQUp5r7nxc6vZnAXY6N/5b4fWk=;
        b=grxHmCBpW/Wa6ueP2UWNKvLNfPRYm0fXh0rRpJdhaqZmywQH5TeG0JhWyBabpYrLeY
         P1M6PqGtD71sMG282RHgNIDohAq8ALQSdcnzOG1tpETF1EH1b1mfsl/At5HjUWdSU6iM
         wpGxy99UKO0uHX6RT9GXhpSR6K+wSFWwZYq8VB1GpzifjkyxviNflLMOmiaTuqp6uSAZ
         BJXJEiL33XfKZz+36TP4AhZo7Ejy+kth8LYiMqpv7M+ctHVG8+XjdEfFe6Q8gcSrMRja
         zNXvDgVbQFnEphE/zmghruZUTdBFzornjRlzt4vwM5xWh0+hV2MgVCI6h9M/RYpnKuc5
         PP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnKxQTXlAzzQEyOAVYQUp5r7nxc6vZnAXY6N/5b4fWk=;
        b=vm0aKy9E0Pt9+qh0SXGopgahkIC9vZK0niX6BdmO0WyabFiT6HfLvlFNFNEkhbjrvN
         FFCc1NnG9WyV1HC5cX9mAGv8jTeqfUGz4SFkWXm/27tqrhz8GMAuIY46yb/LjCP++gSJ
         n37MyTrDv5OkhFtdnYZefb6dx0i5ysJ0/HNRd1mKi4e5cqMixC1rp+Krt2upQNYeLYN6
         vqML/ui9mBNgpeTWxKbOB30JkwIweAcQW3Wb6FV43VETiXFsyuc5QPMWEGFeRMpBhb/m
         ZHSJQHVBZ0xdOXz9pErqEJ07L8kbatVez8yJgOhyra2RDwMXn1TNqUcQsnST2L7iBK6J
         CUEQ==
X-Gm-Message-State: AOAM533DqvEGcMg+wDR3S1cY6Ev+8jANRGZdKkDwxG425v43D1Vni9pz
        NOgUr0xw6XZpmsK1nFTZOpHUic8sEMU=
X-Google-Smtp-Source: ABdhPJzmg4gsJraqYcSXes2bw/g00FRVi5pPhI10+/o3orgKNitGxmsUsC5w1Xnzq7JJNYIFr1NLaQ==
X-Received: by 2002:a17:902:ef48:b0:159:51d:f725 with SMTP id e8-20020a170902ef4800b00159051df725mr12533940plx.47.1651503431834;
        Mon, 02 May 2022 07:57:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2dc8:74e2:c904:9b3b:957c:f8a7])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0015e8d4eb25bsm4764407plx.165.2022.05.02.07.57.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 May 2022 07:57:11 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Mon,  2 May 2022 20:26:24 +0530
Message-Id: <20220502145624.12702-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ab047b4b-6037-af78-1af6-ad35ac6d7c90@iee.email>
References: <ab047b4b-6037-af78-1af6-ad35ac6d7c90@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Philip Oakley <philipoakley@iee.email> wrote:

> When I use the `git remote` command, I use the -vv variant to what what
> I need, i.e. its more than `-v`, so maybe adding an extra
> `--show-partial-filter` option may be necessary (with a more compact
> name ;-).

If adding new informations to `-v` is not possible (to avoid messy output),
atleast including it to `-vv` makes sense to me (though I am not sure if 
`git remote -vv` is currently implemented). 

> There will also be a similar desire (IIUC) to match the sparse/cone mode
> repos to their remotes, i.e. to remind a user that what is held at the
> remote isn't the same as held locally.

Yeah, maybe.

> I hear your pain here. I had the same issue with the branch description.
> (https://stackoverflow.com/questions/15058844/print-branch-description).
> It's the same 'extract from config' problem.
>
> ```You can display the branch description using a git config command.
>
> To show all branch descriptions, I have the alias
>
> brshow = config --get-regexp 'branch.*.description'
>
> , and for the current HEAD I have
>
> brshow1 = !git config --get "branch.$(git rev-parse --abbrev-ref
> HEAD).description". ```
>
> so it is possible to generalise the config query, if hard to discover.
> <https://stackoverflow.com/a/15062356/717355>

Thanks for the info. I tried your suggestion and it worked. But still,
it is better to include <list-object-filter> in the output. This is
because of the second point I mentioned in my previous comment. Users
can be much more clear about the types of available remotes overall.
IMO specifying filters for remotes is far more important than the
branch description. The behaviour of `git fetch` depends on it. If
we can specify `(fetch)` in the output then why not the filter of that
`fetch` on which the behaviour of `fetch` functionality highly depends?

Thanks :)

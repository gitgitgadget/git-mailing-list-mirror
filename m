Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B635C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 17:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446746AbiEGSDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244397AbiEGSDO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 14:03:14 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF7562C5
        for <git@vger.kernel.org>; Sat,  7 May 2022 10:59:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id y21so11954665edo.2
        for <git@vger.kernel.org>; Sat, 07 May 2022 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDv3I3vcoaLfknn++Pdr5IyODW9mffQ1Fy8OWUYE+Uo=;
        b=qdCcTXnc6xgJYlV73vDHWc1cS0TXkIFs3bAl342H5LCWKU7GrpGRdX7rFsjtPStZ37
         vdGssU1+odPsyAoav+9NmAv8qZENWP8hqvamZ+D4X+MZC06zRZV9ypkNmUDh0Brk6Swh
         IyzLOhwu8/M6FgE9B38/VU+nG9djFv6qXcex1/JJ8CCDJ/O7iSdnnpWk0W3LMOPtUC9d
         Ll66fRaa/9lkCOFa2CVqM/fOWGoZlbFgKUjZkU064gAIVBMTRNTQIVvmXUU9jyfsWGOe
         bXrsdufaokK+bJoeF1NCSBSs8cCw8516Hdr4El3x4xf/uxvIdT7f+XUjKiP6A2C2+7x4
         eG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDv3I3vcoaLfknn++Pdr5IyODW9mffQ1Fy8OWUYE+Uo=;
        b=QtMFqwclTXH2iei3YNDbkZyWZoVr/JZ+G+J6+FjPU21uFbfeZ9T/zYNHAGWal6UASd
         t2uY6HZGPEdPBntZPr0h0UL/ZfFGCh+AxHWb3nf5Tl3XD2dcEXt1aXuOqYa4ZKwZzt6J
         js6yYvTYJc93ju+XBKR9zN2GZHscxoQmBLtf4OIRMVx9TiBgPHLvsbBk7g7yDGktPGlc
         3H5Q1A5To1IS+P/bMwkyzN0Opw1I7k5hlfz2YRGERB2kD12Z/RMYQI/58C32hiyhwbWV
         dhey6NOTLQl/4CF8rkFE48fFMMblpen+btZA99p6sgEuXZirUASONa3AZeeupoEUpouq
         hpbA==
X-Gm-Message-State: AOAM53254aIi9Y898/ddZAgBKDvJJGbWJgb/E5QacKVhbLnsx9pMvsYH
        IJjPjsmY7m++mia4VLrVPqxULJtgYpi6+BfjEvfIjV+1/H3Phg==
X-Google-Smtp-Source: ABdhPJyDXkg85eZra+oF3lwcdF0ozcUqwsNOiza65qMNYILZUSiX1t7RtWU1mA98SGwGS6jjtob73001tLtD3kYvpKI=
X-Received: by 2002:a05:6402:1113:b0:428:679e:f73f with SMTP id
 u19-20020a056402111300b00428679ef73fmr7287149edv.378.1651946365629; Sat, 07
 May 2022 10:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220505203234.21586-2-ggossdev@gmail.com>
 <CABPp-BFwiLXMVaFs-Lc-zU6X=pBiF8+o9rOuHEAArD2zMQ1NNQ@mail.gmail.com>
In-Reply-To: <CABPp-BFwiLXMVaFs-Lc-zU6X=pBiF8+o9rOuHEAArD2zMQ1NNQ@mail.gmail.com>
From:   oss dev <gg.oss.dev@gmail.com>
Date:   Sat, 7 May 2022 13:59:14 -0400
Message-ID: <CAAA5oLmAMu=Dj8pOgMLGCeYO2c4mrNP38bjdKEVuBkzdb1=R9g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] dir: consider worktree config in path recursion
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 11:26 PM Elijah Newren <newren@gmail.com> wrote:
> I haven't thought it through, but is there a reason you can't just
> compare the_repository->gitdir to sb.buf at this point?  Why is
> real_pathdup needed?

I used `real_pathdup` here because `the_repository->gitdir` is not necessarily
normalized as required for the `strcmp`.  For example, when using option
`--git-dir=./././xyz/.git` while outside the worktree, the path will remain as
is (see [1] and [2]).

[1]: https://github.com/git/git/blob/e8005e4871f130c4e402ddca2032c111252f070a/setup.c#L962
[2]: https://github.com/git/git/blob/e8005e4871f130c4e402ddca2032c111252f070a/environment.c#L353

> Thanks for finding, reporting, and sending in a patch.  Could you
> split up the patch as indicated above, and add a testcase to the patch
> with the fix, and include your Signed-off-by trailer on the commits?

WIll do, thx.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F04C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 03:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbjELDGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 23:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbjELDF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 23:05:57 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F224B59F3
        for <git@vger.kernel.org>; Thu, 11 May 2023 20:05:53 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-55aa1da9d4aso167785187b3.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683860753; x=1686452753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HiyyLMzBfsfxRHuCYHYavK3tM2rp1EMHbnFc7hqhXDc=;
        b=YvFaEoRoSaZpgONuDyWp/krv5KJ/YVSfIgiaeNPJ8ZDiOXo+HzH+6H7giruzziO1wX
         obk4NjXMSt5gnNNv0VeEs4L2U6Pt6/blAJmPB4HFxY8vq0YZ03tCCqpfS35K9Fd22H+i
         YKVgiE9lTG1PXL5W7a1qmRQSN+wSTdr0kUbTakEgZLPmwsHSqqDu32OYNDQKc4vRS1WI
         dZ6xLbsugNae3SlA48hbbw6mgeHhygm09r4GIIimdV0AUiiYMCAMTFWvQ9+zTgv1Ru1/
         lK1F0Ief0uipfm00DLe21F/f/AvNNFk4A9MfqfPyVfNhqY1TqULnjDR3bkUe31ydMXO+
         dzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683860753; x=1686452753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiyyLMzBfsfxRHuCYHYavK3tM2rp1EMHbnFc7hqhXDc=;
        b=EiMCzeFunIPtjt3JMpZGVPAfM7gmRIaWWrKY5c9dnE+v6RrpbS/461aCchG1p4Mv2n
         u/wUfiHnx/J948iMXu1aOho77GFwuIdY9FR9r/VZSrbe3l6dxbd1eQafYPlDFlhj945a
         q8AljvLHUjdYreg7ZUwbOyi/MAIGTVtc5tzfTphAbIy6ya0IBLJdRvEG59xyOLH6ofR0
         YbbzjZIFd/Vk+mkr6ex93r/4afMxu1Fj3VF+KNl01jgl/3Jw6LHQum+w+g0FFO/refw2
         ycZbHQPzuq7r35JCr060ZuaPFI/AtW/NikAUHy3z+C0RhtkQuy4AwP7KjgnlHLg4SZw6
         nECw==
X-Gm-Message-State: AC+VfDx/FzJmoL32rKHY1ixIvjIexQdkL3jUUp1dpKYvxHNp5H1O8UKD
        EXVp5kaGQN4dde+phXbmy4Dj9Q==
X-Google-Smtp-Source: ACHHUZ4zOv56saPRytAZY44w1Rc8uvg8PwfruXw/pKS2F5ePW8NY+oGX2/FXotKFvWJs08gd883idQ==
X-Received: by 2002:a81:834b:0:b0:55d:6dd4:e634 with SMTP id t72-20020a81834b000000b0055d6dd4e634mr23466266ywf.3.1683860753172;
        Thu, 11 May 2023 20:05:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e6-20020a0dc206000000b0054e82b6a95esm5350063ywd.42.2023.05.11.20.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 20:05:52 -0700 (PDT)
Date:   Thu, 11 May 2023 23:05:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: What's cooking in git.git (May 2023, #04; Thu, 11)
Message-ID: <ZF2tDgngoBHZojLf@nand.local>
References: <xmqqo7mqs7rp.fsf@gitster.g>
 <CAMP44s0GAiFhoHFo4Ex464utf2Jm1F-LEdX2PZdUGEdp5x6Liw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s0GAiFhoHFo4Ex464utf2Jm1F-LEdX2PZdUGEdp5x6Liw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 08:36:36PM -0500, Felipe Contreras wrote:
> Junio C Hamano wrote:
> > * ds/merge-tree-use-config (2023-05-10) 1 commit
> >   (merged to 'next' on 2023-05-11 at e0dab53028)
> >  + merge-tree: load default git config
> >
> >  Allow git forges to disable replace-refs feature while running "git
> >  merge-tree".
> >
> >  Will merge to 'master'.
> >  source: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
>
> Why was this series merged after only 11 minutes of review window? Are patches
> from GitHub favored over all others?

Certainly not.

The reason that this was merged quickly is because both of the first two
reviewers had already seen the patch and reviewed it earlier on the
git-security list. The patch that Stolee sent was urgent enough to merit
a quick merge. But it was not so urgent as to do an embargoed release
since the client-side attack isn't interesting, rather it was important
for forges which may use merge-tree directly to perform merges.

Thanks,
Taylor

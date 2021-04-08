Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC3EC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F9661132
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhDHVhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHVhw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 17:37:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212BCC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 14:37:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a12so3569889wrq.13
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tArX2v29ucBKLNtBRYKdg4MHciWU438pwz16SGQ5FTU=;
        b=do2CFWkN/HxelVk0Xa7fgmax8zEaoZYxyEd6j0sybkoncn9fJQ99+K9j+asp0wP/3N
         iQ09D2VNMARD5v8yz7LHnJvUIbYowQG8ypU/w160096Tr2iGhRf0HpCxZbYwz/8sJTDs
         U1xFyQlHfsQ/7nG8m2ASBOsnWUy7cV8334va8dk+29yockSPlSpPaNTf+XaFjWLiOVer
         LW7nqtoHNK5s2lqsnZ8tyfmQxQEbBOFZr544568ch8oRjlRQSebdDHoEws8tMemCZs2I
         Ft6gszv3DD/qyS7luwzEAoJnXvslCjdKL+LS+NCTA9FToYqXRYuHWra1gfHn2yWxBnHC
         5Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tArX2v29ucBKLNtBRYKdg4MHciWU438pwz16SGQ5FTU=;
        b=qomF/OQVv6NBGIGG5d+RpncfcFH9qp+rvFswZiCVVbQr1d1wc8Zc3kyaMjRRTqSRpR
         pMVJQqs230sx4/FUfMEiMO6MmOPqEydpJyE7ziY+nNpRa2+oR4JU0FAxmUT1Tn4i/EPp
         UlDF5b+7X25JXW2wHO6IOi3lPr9k6iDrixekCpDHRGHsKwCgstPJtLXBwIgHXqzp2lXN
         ecHX1178K3tHQZDpbvDWTdohIEXQyD0w2yy1nO72MI7Q9ZwFW9bcdcXbov8rg/9O+ToU
         X51+6KlpGPBIytg/svvVkrqTpnZ4KQcJrXTgtKTPZQhSzdlDeH7V+N/1nL1wx3kOGNDD
         BAKw==
X-Gm-Message-State: AOAM531NDEzPiGE91fFZgRmU0gPfdG4KgjpSg7tarC8Bv/ShuMk7mZwR
        yZudb1EjBXLY8SmVaLVhORpc4yWLto0=
X-Google-Smtp-Source: ABdhPJye/nsHF6YTeHGaHm9upKg8Q9jE9a2pqIaaPPCjkH/ttkQu7pRyZgtSGTsJGSSJdX7ecjQRAg==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr14708004wrv.204.1617917857990;
        Thu, 08 Apr 2021 14:37:37 -0700 (PDT)
Received: from szeder.dev (94-21-58-238.pool.digikabel.hu. [94.21.58.238])
        by smtp.gmail.com with ESMTPSA id f20sm616965wmg.36.2021.04.08.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:37:37 -0700 (PDT)
Date:   Thu, 8 Apr 2021 23:37:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/9] diff-merges: introduce log.diffMerges config variable
Message-ID: <20210408213736.GB2947267@szeder.dev>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210407225608.14611-4-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407225608.14611-4-sorganov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 01:56:02AM +0300, Sergey Organov wrote:
> New log.diffMerges configuration variable sets the format that
> --diff-merges=def will be using. The default is "separate".
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  builtin/log.c |  2 ++
>  diff-merges.c | 11 +++++++++++
>  diff-merges.h |  2 ++
>  3 files changed, 15 insertions(+)

Please don't forget to document this new configuration variable.


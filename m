Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6FC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FF961477
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhD3VKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhD3VKo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:10:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351BC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:09:55 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g7-20020a9d5f870000b02902a5831ad705so2428015oti.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yoIrANxiA6Env6qAiXz84z4lBD8CYN6IXv6d8Rsfl64=;
        b=RcNzvg6+RD+4SmRq+JjZ7zAWNFcEfPRQHN846ytWcCx7iidEsrhXRcY6cxUGkI9v2o
         dfQStX8ExO7dZWC4gN1PnSxb6j0ubJArdq2jJRdSmbN2chYRYGH8IC3iWK+k2U3d5r05
         KJ8Io/Bds2zmzkHAsrUJHfZrum2tS9OjRhj6Hg2YzKxj6T6zTuRUHBfC0CnBn+A8W9aL
         afu2c3ecBFxVmAxHlS+k6jRE1g6y6yhp8YxOo4xw7/iA70178sjOSAY3huwjq99k+lLA
         3vRQLPEAMoi+aD3O8iRCzqrmG+BQd+yDF5wNhToGMyhibcbQ6/+nBEvjKpwdC62XnkmV
         W3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yoIrANxiA6Env6qAiXz84z4lBD8CYN6IXv6d8Rsfl64=;
        b=f/lgG3CGzVKjVigALy/G0MckL/msXJvrmjxzOL34aKH2DncVjKNj+Kv6Sd2Ny7uADm
         6O+JMb1ROep77v4DD7tKkz9SwvUmtZ9ICXirAWoAixkLUS4BhVmSz3s82hYH42ghONe0
         N7vxcWjlsUbrqxDFLDcBNrifIH04+WzZO/tizP4GpctkQPLJmHcaXfgT08RCE0rWOt05
         E4dOXpaMYtVm1Sm6+/vCr01T+uNYnwWlaNucLk0eXHwFC7pWdAoZJB6aZC6KX9xqvBxc
         9Om0V9EzVu2Y6q2hJMTfsrL2szI6vs2p9cTc63uNjgw1TV8yCmTS3yoobvLpuPxHhfU1
         8R5g==
X-Gm-Message-State: AOAM531foaSo0aTlBcZpD9NaCqD2pwKXHwCfkwLitzp93zaRmr4C0xHE
        QxpyCqDYz7IGZp2Sfd3jt8c=
X-Google-Smtp-Source: ABdhPJyxdHG6el3EvorC+UFEo+qzBGbhcelptR3g3RM9QsmPqBGf3i1B+aglunwdZN2ZLqQS4E/JEA==
X-Received: by 2002:a9d:4e9a:: with SMTP id v26mr5152739otk.74.1619816995429;
        Fri, 30 Apr 2021 14:09:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id 10sm954655oiq.48.2021.04.30.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:09:54 -0700 (PDT)
Date:   Fri, 30 Apr 2021 16:09:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Raxel Gutierrez <raxelgutierrez09@gmail.com>, mricon@kernel.org,
        patchwork@lists.ozlabs.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Message-ID: <608c722135d6f_2cb20846@natae.notmuch>
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
Subject: RE: Pain points in Git's patch flow
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> He'll be working on a bit of an experimental project: we want to take
> Patchwork[1], which in principle can be a helpful addition to a
> mailing list centric workflow[2], and improve it to be something that
> people in the Git open source project get day-to-day benefit from.
> Raxel's previous successes in making changes to tools to support a
> better user experience make me excited for the potential for this
> work.

Raxel, I would consider looking at nmbug[1]. It is a tool developed by
the notmuch team in order to deal with patches both in command line and
web interfaces.

As you can see from the discussion that ensured from the original mail,
the git community does care about the command line interface a great
deal.

> Those four are important in my everyday life.  Questions:
> 
>  1. What pain points in the patch flow for git.git are important to
>     you?

My only real pain point is that sometimes a patch series is sent as a
subthread of another patch series, which makes it difficult for me to
mentally separate the two.

>  2. What tricks do you use to get by with those existing pain points?

There is nothing I can do. This is a culture thing that hopefully will
change.

>  3. Do you think patchwork goes in a direction that is likely to help
>     with these?

No.

>  4. What other tools would you like to see that could help?

nmbug[1], but again, it depends on how it's actually used.

Cheers.

[1] https://notmuchmail.org/nmbug/

-- 
Felipe Contreras

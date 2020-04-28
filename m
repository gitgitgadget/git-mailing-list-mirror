Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7126C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE2C2073C
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpj/7cGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD1AzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgD1AzM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 20:55:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D570C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:55:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so8641690pfv.8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iDoJS40noPveZazvCTQ1Zbmi15iGPZm04SMlxqmdJ1A=;
        b=Bpj/7cGZdd6sFzohD591fYV99pnbIIb+mq9A0EHEqYOdntOI0lOS4l747pGxgzujyQ
         G7lD03zJxp8Ok/pyhLUXV4ZxUY88ksfvSfByiqyPajy3O/Hs9IGeOEhUOhEhJ7pN8K21
         8Pxa0cdh2a0XUfqarKic2RsU8yzzoIE85gZmr1FsXqIlV0SRNyMMgKYKUCmgrM8gUNjt
         UAVRRtlYYFcV5Agm2pI23Ec44XKcbLPjTMGRO6LvWdLaCdoreNcUDcSrj9Qb4kak676N
         ynoTgZ3qhRw5tQJc2kcnotII7dcD3ze5ya9WcI8FTJNp1LN/j/4f0bdPOUbwgCG0xR+p
         diNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iDoJS40noPveZazvCTQ1Zbmi15iGPZm04SMlxqmdJ1A=;
        b=TO93GVeXzf4CAneHHKUs80Z18lNgkSBCfIFuydYChSpfrSrvqBw2r7PgPq/TGVjbEK
         We8AWlihBjP+bUEJBup+r5X4So/c1OkyCudWfTP8TTrrwHmJmn07bbKSXmXgcM9dpH+z
         FhHgwgyQKKPdFdEozEugIxzLmqoX8x0tHk4Lpg621P9onWLheiIyJrlkuqwvUCOHrcfm
         Mf8LTd0Yordgs3vHkqzY9ivZyF7s3STba8eazUHsw+pJhrUOCXpranCKHqi1TygZjEWS
         DJ7Ep3NdXXd0nSapkoZVSTzSe4iafELJzzldlenaM6DaT+YqNpGHpZmHG3CLoeBL873S
         S88w==
X-Gm-Message-State: AGi0PuajifMnZXyEvGhzmnP05v6qo6moYYYhmw4CJXMZdFtAKM1gnzeo
        mHBbkkcalX+JH20ipApIcdIhNn0I
X-Google-Smtp-Source: APiQypKYTF54EZtlxDec2mes8m9fnQbyfZ4KfqoxyLNndzX1kkgCWtCPBt3HhEOksCNF7p2reqe5vA==
X-Received: by 2002:aa7:8429:: with SMTP id q9mr26755697pfn.205.1588035312011;
        Mon, 27 Apr 2020 17:55:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t7sm13520658pfh.143.2020.04.27.17.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 17:55:11 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:55:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/3] fetch-pack: in protocol v2, reset in_vain upon ACK
Message-ID: <20200428005509.GG36078@google.com>
References: <cover.1587775989.git.jonathantanmy@google.com>
 <cover.1588031728.git.jonathantanmy@google.com>
 <e89646cb9ab1164d866ba9747575cab9199e3f62.1588031728.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89646cb9ab1164d866ba9747575cab9199e3f62.1588031728.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> In the function process_acks() in fetch-pack.c, the variable
> received_ack is meant to track that an ACK was received, but it was
> never set. This results in negotiation terminating prematurely through
> the in_vain counter, when the counter should have been reset upon every
> ACK.
>
> Therefore, reset the in_vain counter upon every ACK.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c          |  1 +
>  t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B28EC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350885AbiE0UXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiE0UXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 16:23:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BAD689A2
        for <git@vger.kernel.org>; Fri, 27 May 2022 13:23:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m1so5056477plx.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2lkd+aTN/dtaB99prCoiL27+0ypp226+sCsSaS6sVHA=;
        b=HAtyqB8RXLbJErVNmrBokUb6pRUuWid8JuGuwcazdB7XeuFKbbh+/HJx+/o2NdOYGO
         ejJ4RAOogYV8ISAs2CM/3m+gE3zZQh9JKCo8tDiVqThKdZZsGf50L7VVFpPwQPiQpJRO
         ET2Eorq0Ce/59du0Aec+zDObFbeuUI88+stDFUHGPheykO70ZPvUgFIZFE7hjTcwvatO
         HDWsdIARcZWQLK4j7eKAHTB4OLhhY5OIIIQywvbIRz2lA5LVRJgFJf97UpNqkvCCF6Hz
         yTb48VYj1f1IZSqnVmWxEIVGyUAIVUc+yXtZQhBzl5tSZhGsM9CKoaMEANjp5PeflJOM
         sStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2lkd+aTN/dtaB99prCoiL27+0ypp226+sCsSaS6sVHA=;
        b=6hVaJV+k37R80ZWpw2nzmqidphlaC0NQWMEpbLU1I0k8HO9lQmzJHyRznzTMPkTKAV
         75f+BJWUXL7H07HXH/SK+2hatQWquo6Tp9PJzIYvzA2LIn5EiKnGoHwvw7l7S8ZNF+oJ
         2XRBbXESUMRmbydJtu/rMeUmWnewTmYGuwIOwTiOwBZtTU8ftjlIYg+o+9Yuq5I2FPVq
         liyeaRd0P4briB+SPGbCTaWVMnfPJ7nqgXvg0qJEuge9kZ+/C/SVL4wJbe3StdMc95u5
         bH4i+3/spvHAGkIc4wK57TUZHmv8GwP98GvUeygO1vbbE594e4TRaGy5CAsSada1IWdw
         wQmw==
X-Gm-Message-State: AOAM5326+PZHncyIXxYwCZfyYAGrpoBf9vJzxKsUEKBf4NUgpWSSXFeT
        nNgJNb4CCPuL9k+nHRNN34eyiA==
X-Google-Smtp-Source: ABdhPJziPsWvnb3kdHo9UkdzeqU8NT8ruaH6nWxyoAk+kL9gYhRh5knh2fG2DOz48C8BDuwEnJwyzg==
X-Received: by 2002:a17:90b:4ac9:b0:1e0:ce14:20dd with SMTP id mh9-20020a17090b4ac900b001e0ce1420ddmr10236707pjb.198.1653682980550;
        Fri, 27 May 2022 13:23:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:fbc7:30a9:c3f6:e550])
        by smtp.gmail.com with ESMTPSA id m6-20020a635806000000b003c67e472338sm3807268pgb.42.2022.05.27.13.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 13:22:59 -0700 (PDT)
Date:   Fri, 27 May 2022 13:22:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Frantisek Hrbata <frantisek@hrbata.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/3] fix memory leaks in transport_push()
Message-ID: <YpEzHfrD4e0S2Sjq@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Frantisek Hrbata <frantisek@hrbata.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
References: <20220520081723.1031830-1-frantisek@hrbata.com>
 <20220520124952.2393299-1-frantisek@hrbata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520124952.2393299-1-frantisek@hrbata.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.20 14:49, Frantisek Hrbata wrote:
> Fix memory leaks in transport_push(), where remote_refs and local_refs
> are never freed. While at it, remove the unnecessary indenting and make
> the code hopefully more readable.
> 
> Changes since v2:
> 
>  * "transport: remove unnecessary indenting in transport_push()"
>    s/push_refs/transport_push/ in commit message as noticed
>    by Ævar Arnfjörð Bjarmason
> 
>  * "transport: unify return values and exit point from transport_push()"
>    Added as suggested by Ævar Arnfjörð Bjarmason. It allows the following
>    memory leak fix to be a very simple patch.
> 
>  * "transport: free local and remote refs in transport_push()"
>    Just free remote_refs and local_refs. The other changes were
>    included in the previous patch.
> 
> Changes since v1:
> 
>  * Slit into series of two patches. The first one just changes
>    indenting in transport_push(). Second one adds the fix for
>    the local_refs and remote_refs memory leaks.
> 
>  * The resulting trees are the same, there is no code change.
> 
> Frantisek Hrbata (3):
>   transport: remove unnecessary indenting in transport_push()
>   transport: unify return values and exit point from transport_push()
>   transport: free local and remote refs in transport_push()
> 
>  transport.c | 260 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 133 insertions(+), 127 deletions(-)

Sorry for the late review. This all looks good to me, thanks for the
fix!

Reviewed-by: Josh Steadmon <steadmon@google.com>

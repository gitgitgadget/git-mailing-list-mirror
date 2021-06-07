Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC0C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D0261073
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 22:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFGWnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 18:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFGWnU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 18:43:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7304DC061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 15:41:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v12so9534612plo.10
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUNvo1CT62celzaF98V/xLqUu9/szbS7sHgztu+mFHM=;
        b=KvOkciFfnGQrVUPX6meanI2kKHZb29WvaQNXuigz+rEThufxbFRNowXc578y7OtZf7
         NZi/9nY5SxA3HQVdzl5I840x6jFuY0ND2qrIc6XtUMuQxC9d9muZS+/GkCCB5rEdT9oF
         wyClGYPG4L1xexFODtn4iEP8H2zlJTj3bkgaTbFWtwqLANZ51HD/dkDx9I4xV1htw4g1
         jD8HsczTDI1C6ZLydQoM1vgW3W6DgxG32LYv8rVIEDy11/ZTWDGyk39/KWLn4O/riqZy
         H4k2RFVXWSGyhmk2HoKPVDNkNKW98UjTp6AJTO0F7utb7Ybd4RfV0NPN9b7tDnNsJsME
         KRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUNvo1CT62celzaF98V/xLqUu9/szbS7sHgztu+mFHM=;
        b=UwF5xdoY61DxJk1LawQNyWYVxPz9yXlhxN1gc+gHEc/Hcztz8VuKrt8wCozg2sCAbQ
         EOYsP8xR5Q4w7S3sq2YvU1QiuxyNT+oe6dc+Dw9AIJzr+Da4x+668M99bBw5Wz+KbTKZ
         qm6WCMr01RPXw7WlIX0cwGX1JC//ywm77RfOyN6SnR2hLdpGPju/nIEmg78o1UuipvUh
         b5rVz0rtEFCu7ecmh+78H3Emf4k0gilJd5QBEv3IrVlaNuy+dE1jJYFHWXFq/uW3nuBd
         eVQMRgHSNbDLq5Len/o9ngfdpdDH3En0ctNoNJJqgYJp8qe9kcoCOLcY6tPYxaLg2hxb
         uBUg==
X-Gm-Message-State: AOAM532iZr7nXSuSXfLJzofQzbz7KfNppss96KW79thz8NPHbL80d7Yw
        FJIE8I61CX9JCWgiIFOzXanjDA==
X-Google-Smtp-Source: ABdhPJxRkaxfB/2UWP+eTiQk5XDWW+KFPTVptEt6YVzTa4EpK/DRaVW+sZwdKEfqQVhYyKiAvLcaSQ==
X-Received: by 2002:a17:90a:db4a:: with SMTP id u10mr21773539pjx.149.1623105686370;
        Mon, 07 Jun 2021 15:41:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2096:9338:a9c3:81da])
        by smtp.gmail.com with ESMTPSA id e10sm5218641pgc.63.2021.06.07.15.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 15:41:25 -0700 (PDT)
Date:   Mon, 7 Jun 2021 15:41:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] promisor-remote: read partialClone config here
Message-ID: <YL6gkaIlcHzqgTYn@google.com>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <4a7ad9ffeb140c8b613c308280c2c234154ae2ab.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7ad9ffeb140c8b613c308280c2c234154ae2ab.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:16PM -0700, Jonathan Tan wrote:
> 
> Currently, the reading of config related to promisor remotes is done in
> two places: once in setup.c (which sets the global variable
> repository_format_partial_clone, to be read by the code in
> promisor-remote.c), and once in promisor-remote.c. This means that care
> must be taken to ensure that repository_format_partial_clone is set
> before any code in promisor-remote.c accesses it.
> 
> To simplify the code, move all such config reading to promisor-remote.c.
> By doing this, it will be easier to see when
> repository_format_partial_clone is written and, thus, to reason about
> the code. This will be especially helpful in a subsequent commit, which
> modifies this code.

Do we reliably call promisor-remote.c:promisor_remote_config()? It's
called only during promisor_remote_init(), which happens if we call
something like promisor_remote_get_direct(), and I guess we call that
one unconditionally (e.g. there's no "if (partial_clone)
promisor_remote_get_direct();" that I saw in a brief glance) then it's
OK.

> @@ -1061,7 +1061,6 @@ extern int repository_format_worktree_config;
>  struct repository_format {
>  	int version;
>  	int precious_objects;
> -	char *partial_clone; /* value of extensions.partialclone */

I also don't see that this repository_format.partial_clone value gets
checked anywhere anyways - I only see where it's set and freed in a
brief grep - so this seems fine to me.

I saw Taylor's comment about NULL-ness and other than that, this patch
looks good to me.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

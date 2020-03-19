Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94004C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 19:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A5B206D7
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 19:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f426JG6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgCST6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:58:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45277 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCST6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 15:58:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id e9so3688352otr.12
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kPWg7k8tOE31Cl6gsgRY2hVtckHPMEsRZYZkvu92rHM=;
        b=f426JG6ygkI1f8zO1salu6E8rLpK6HP6ej44ex12sR+rQ85HcPdhy3lXMxzhpnvlTV
         bZtGkEUCxzQAtAWxOQyYxfvRjoXOrAsL4iSUx5yRBMTm+k0vIB6ZkGXxEyObfIIWEm1Y
         See2hZMP8p4y0Wpfm/XecQ7JlQkMDJeZNVEyjksTchz4XRyK69X93E5Jght6d3ZjH9Nh
         AdJNQhYP0VxGldftpBR7Y0V4GpPUc61Sh2eJ4aNHL5ECW/LhNs1jsSbDZqF41UQTLdJS
         MbCn6upq00blMrmzxcshPq5zw5KrIRRxRWzYnlTvGxnU0lQ+h3GgqyfEOwwSTQEpDMpi
         YJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPWg7k8tOE31Cl6gsgRY2hVtckHPMEsRZYZkvu92rHM=;
        b=Z1mIPx/Hyb5TlWwK6lBcbMs5lvzaHteHZjAe72cU25ZofjN3P8U4klG3Gi2t0CKIlI
         hJaKHgGKQLt/TfnPr/uWqNteMhZ97e8dIOtYGpK96Nd6NxnEcb44ePjuGpb9y0XOkUNp
         CmvlOtNzE4yAmj8vi1WSqjTqP3txWMS82bAys976NphLAmdZ6hSwgAIb7BcLn6MD3Lmm
         orS5b+FtVou5RgVwTB90hPPv26O32u0AHfBC9SjS+sxBFjYfY7nQV5iYmcq5/KOpGPsb
         UUegR1S0D+0GTGfZC7qp/+ha2i9s1NEKj3mOwJE8oeqjeXcGJIkXbfYb0snqtfiajHpb
         UfnA==
X-Gm-Message-State: ANhLgQ0c25eKZzea94Ch1uDNC/JhBvwt2tmpbr+gmWAwIF1r9jy5REei
        envLUTWcBJ0H6k0NM9Mvc8A=
X-Google-Smtp-Source: ADFU+vviEUIfXpE9C9PO2thcrd6IzZ6qvefgqwaSgaKSIyYNqgwfUnskmCRQDEAxAiGe8GpDUtn8mg==
X-Received: by 2002:a9d:27c7:: with SMTP id c65mr3881660otb.318.1584647915185;
        Thu, 19 Mar 2020 12:58:35 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o1sm1099292otl.49.2020.03.19.12.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 12:58:34 -0700 (PDT)
Subject: Re: [RFC PATCH] fetch-pack: lazy fetch using tree:0
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     peff@peff.net
References: <20200319174439.230969-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <593efac4-75f8-df74-259d-83dd8297aa3f@gmail.com>
Date:   Thu, 19 Mar 2020 15:58:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200319174439.230969-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2020 1:44 PM, Jonathan Tan wrote:
> Support for partial clones with filtered trees was added in bc5975d24f
> ("list-objects-filter: implement filter tree:0", 2018-10-07), but
> whenever a lazy fetch of a tree is done, besides the tree itself, some
> other objects that it references are also fetched.
> 
> The "blob:none" filter was added to lazy fetches in 4c7f9567ea
> ("fetch-pack: exclude blobs when lazy-fetching trees", 2018-10-04) to
> restrict blobs from being fetched, but it didn't restrict trees.
> ("tree:0", which would restrict all trees as well, wasn't added then
> because "tree:0" was itself new and may not have been supported by Git
> servers, as you can see from the dates of the commits.)
> 
> Now that "tree:0" has been supported in Git for a while, teach lazy
> fetches to use "tree:0" instead of "blob:none".
> 
> (An alternative to doing this is to teach Git a new filter that only
> returns exactly the objects requested, no more - but "tree:0" already
> does that for us for now, hence this patch. If we were to support
> filtering of commits in partial clones later, I think that specifying a
> depth will work to restrict the commits returned, so we won't need an
> additional filter anyway.)
> ---
> This looks like a good change to me - in particular, it makes Git align
> with the (in my opinion, reasonable) mental model that when we lazily
> fetch something, we only fetch that thing. Some issues that I can think
> about:
> 
>  - Some hosts like GitHub support some partial clone filters, but not
>    "tree:0".
>  - I haven't figured out the performance implications yet. If we want a
>    tree, I think that we typically will want some of its subtrees, but
>    not all.
> 
> Any thoughts?

The end result of fetching missing objects one-by-one matches how the
GVFS protocol has handled these tree misses in the past. While there
may be a lot more round trips, it saves on excess data since a
missing tree likely can reach several known trees and blobs.

The real unknown here is how the "boundary" of missing trees is
created. In the GVFS protocol, missing trees happen mostly when our
pre-computed "prefetch pack-files" of commits and trees are behind the
ref tips.

The usage pattern for depth-limited or path-scoped filters is not
quite as established as the blob-limited patterns (because they are
similar to the behavior in VFS for Git and Scalar).

The code seems to be doing what you say, but I highly recommend taking
this for a spin on a real repository with a real remote, if possible.
The more that we could get some numbers for which situations do better
in one case or the other, the more this change can be adopted with
confidence.

Thanks,
-Stolee

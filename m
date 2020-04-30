Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12203C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD92C206C0
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 21:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zlfm6M6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3VRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726430AbgD3VRU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 17:17:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90796C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 14:17:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so1415463pjw.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CtOw03RcaRBZV8ooaP2Ym8ApPlYIK5s9ugaP7elAeF4=;
        b=Zlfm6M6CSG4JylXUR3vUiQJY2ai/HqwyYLKed0NxV4bylCxbDGPVXHwn0ak7zVT09C
         vTqbTbAmUzBEuYdtOQbG8sfLcbmNPsjSBbUxZUW2eV/WxhBIzMFGZFrGBDa4QFO6vgR1
         OdRuLkaS9fOKB9YE9dOWQiYHDUsT5E9iBb6VIYLgHRE3Jf3r8ewg4Ot1pew7KwsyEPhP
         JbKefeAG4ZsByye/CDFx1m1jmGA3GaqBlA11cE3SKpe1J093bRfZL1Huv3o+b7Wp1aZS
         acbuxciTi/PhQSuybg5h3/jfOtaI4ZxRDfWitXsmO8R74LliWf9+W6b5h7fjbiW/EIKs
         VFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CtOw03RcaRBZV8ooaP2Ym8ApPlYIK5s9ugaP7elAeF4=;
        b=llAKzATT9KTFYmqat4bJFn9n6h55eLtTghAefEtEBxXRZ8Ur1614l58KpXVNLqnfi+
         +Ce4KAyEha4cstndVUY5oj7qOqdW7oqfF7J6f5FyACNt9+YM/5cvgDz6mk6MLW7u5r/0
         VkROEOWy0FYoBvvrc9dOqs9RIp43fNFOtw8ihHsPvXm61lBGV54TiSKJFCEGFfmkFeKM
         8b/7f4VUCojoUAw2EqspxPk6Gr2idrbNTOPzeU2+SLLh1vZrEaQ0dGB+jU/il1gxq95P
         fOqQu31PWJivEU0O+TpFk1P9Qt2K3ma6XDQaOxxMZ4mMefXP+ChwWkjJK8kNOXxS6KGo
         dy1g==
X-Gm-Message-State: AGi0PuYyFAB/UrwxMcWIc8cp63cDXM6OLXbmNSiqUk0jaeV9Q/YOBAaZ
        RSctExwzdkxUwjTxEpbDSWwfWg==
X-Google-Smtp-Source: APiQypJrGmTFx6ILEvmHLQU9dRHddveAhEekt+6SUpAsGXxWfTJbrnsTpt+XtKIZd1LT0dnf9ZLdRQ==
X-Received: by 2002:a17:902:b614:: with SMTP id b20mr969961pls.217.1588281439758;
        Thu, 30 Apr 2020 14:17:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id nm22sm558505pjb.38.2020.04.30.14.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:17:19 -0700 (PDT)
Date:   Thu, 30 Apr 2020 14:17:14 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v10 02/12] Iterate over the "refs/" namespace in
 for_each_[raw]ref
Message-ID: <20200430211714.GE77802@google.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
 <45fd65f72e097dcabba6ea15b1d54c85e7271593.1588018418.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45fd65f72e097dcabba6ea15b1d54c85e7271593.1588018418.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 08:13:28PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> 
> 
> This happens implicitly in the files/packed ref backend; making it
> explicit simplifies adding alternate ref storage backends, such as
> reftable.

As an outsider to this part of the codebase, a little more explanation
could be handy in the commit message. I found the backends you mentioned
in refs, and it seems like they're the only two, but it's not obvious
how this delta is related to those backends. Furthermore, grepping looks
like this function whose behavior is changing is being called from
somewhere else, with no change to that function (and it looks like the
callsite's callback doesn't check whether a ref begins with refs/ or
not).

All this to say - it's hard to convince myself this is a safe change,
and I'd really like to read more to understand why you made it.

> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index b8759116cd0..05e05579408 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1569,7 +1569,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
>  
>  int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
> +	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
>  }
>  
>  int for_each_ref(each_ref_fn fn, void *cb_data)
> @@ -1629,8 +1629,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
>  
>  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(refs, "", fn, 0,
> -			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
> +	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
> +			       cb_data);
>  }
>  
>  int for_each_rawref(each_ref_fn fn, void *cb_data)
> -- 
> gitgitgadget
> 

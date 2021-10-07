Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B17FC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CB46103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbhJGSgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJGSgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:36:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C6C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 11:34:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n2so4448149plk.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=G613q6j0E0rIZ3eboPgmEpvAEsrAWpdt+z6rIG36e/A=;
        b=h2bsAr764ikwnII2zrYq2HyQM0YaFW/PevJTGr2J7YOzUoQOJC8cERQzcgcYWFqe0H
         4bS2RoVngV9HvEP9cvsVcK2lACTKdVtmGKDXQ6pNceAZggsIapJptnAv3mj53Qp8wJbS
         E/9AmT7BKmb1l1gtl07CFg4iCOvXo0uypOEvcCX+v8HLagEDwyWMzhE7HLSdF07Z3AE3
         0dS2VbtoiL8+0SRFWsRWAJdXRezJl9wILOaXTgVnPHTiYxIA42iiP62U6jDiSEwcTeiV
         M+kAiHOYGfw1d9kHwIb6bRVupNIj3oMoHkpzYs2NxFM1f34ClB69qwuJEFFknGbLTLHW
         NHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=G613q6j0E0rIZ3eboPgmEpvAEsrAWpdt+z6rIG36e/A=;
        b=Fo0FvUXba4xsoD1VGBoIDs/VNYnLWsFyXcr02HstpWHW7Kc3AaCiMJdTb4uZ7Q6lB7
         ocxTDxhv/uoRQbhqQCgNMzWuXJFRPYET7lrBNUJ0yams9nXb0iPzumRrnjcA/SAek0Vk
         3Uz6i6HUhiD5vCuutrxo6s8wE3uxlAx5K9TVdK+u1d07B+Xh8m7+wBypvwr6CmGFgUrF
         2c4ZMQ4zwn+FV6u2UrPBxSKiCjzIaxxcX8nAY+AlcPhPRgkYtlgVJtwNti2JWXpAJOWs
         Yw60hRWobRAwyEiIQRjnq9menR/L2/mHtBgtXOZfxfEHbflDMFsPBS9g4JMF1auEotbj
         clkQ==
X-Gm-Message-State: AOAM533Fh8f/UaSSe+yPIN7O2x8OtdiO7oAhiWSy2T3z/T+gfrWSVJmv
        lKHI9A1eA8lmrHiU8ks+Sw+JW00h4WS/rQ==
X-Google-Smtp-Source: ABdhPJxQpCrou7u5wdsbdh1Xyd4qpsJDlRZHY0Krbw7xFlz4v/oCTtAhaWZ/1pt1jcn0AwHIGGqGQg==
X-Received: by 2002:a17:90b:490a:: with SMTP id kr10mr6577910pjb.192.1633631681407;
        Thu, 07 Oct 2021 11:34:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf7:7c1c:a2ca:e52a])
        by smtp.gmail.com with ESMTPSA id b14sm135536pfo.127.2021.10.07.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:34:40 -0700 (PDT)
Date:   Thu, 7 Oct 2021 11:34:34 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/7] object-file: only register submodule ODB if needed
Message-ID: <YV89ukrCS3NmIKsl@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1632242495.git.jonathantanmy@google.com>
 <cover.1632956589.git.jonathantanmy@google.com>
 <0200f1880b7d92dcee0ef1d011bdc654bc3b4f0d.1632956589.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0200f1880b7d92dcee0ef1d011bdc654bc3b4f0d.1632956589.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.09.29 16:06, Jonathan Tan wrote:
> In a35e03dee0 ("submodule: lazily add submodule ODBs as alternates",
> 2021-09-08), Git was taught to add all known submodule ODBs as
> alternates when attempting to read an object that doesn't exist, as a
> fallback for when a submodule object is read as if it were in
> the_repository. However, this behavior wasn't restricted to happen only
> when reading from the_repository. Fix this.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  object-file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/object-file.c b/object-file.c
> index be4f94ecf3..2b988b7c36 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1614,7 +1614,8 @@ static int do_oid_object_info_extended(struct repository *r,
>  				break;
>  		}
>  
> -		if (register_all_submodule_odb_as_alternates())
> +		if (r == the_repository &&
> +		    register_all_submodule_odb_as_alternates())
>  			/* We added some alternates; retry */
>  			continue;
>  
> -- 
> 2.33.0.685.g46640cef36-goog
> 

It looks like this is just a small bugfix, but can you expand on the
implications here? What happens if r != the_repository?

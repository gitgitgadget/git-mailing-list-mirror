Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B92BC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CB26145F
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 11:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhGAL7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAL7g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 07:59:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D144AC061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 04:57:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w13so8111646edc.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HXax4g9Bi0QrCxkSE4/QSY2x9kaiZl8AjN0Ro+DA+l8=;
        b=K0iukiNukLbDS4phJPDcK4Tq1U7+81PP9GV6KBufbSIuFP8NaJzF+hqoGCPUGvczFi
         ECTjMI7hCBixmm7cMomGVWX190/uCutZpKpu/urAzgXf/QfsIoWJ8QpfEUjlObW2D1/p
         IbAoh52Rdk5H1M8PqFKLMci/O39C1WgS4RhBTCxomTaOuxWD1rvYy9fNIGhcX6XzecC2
         yM0Tubb0aPjTRrk43vpR6xhFl5EIOxo6cRf2M7NwEXtkObz+L7M5neC+jJ44+tF1kmEM
         f1xMJfwj5xSolBHJfnWcMlrWTWyemtYOgSskUEd7+dJ0SJ4z8Hyb+ZZfyOqxgNSscJb1
         pkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HXax4g9Bi0QrCxkSE4/QSY2x9kaiZl8AjN0Ro+DA+l8=;
        b=D7uzkniSVYlr1o/j7Y4jvmZnah4U0S0W7oMtcf70myFqAiFgrMh/unLEyPBJ/LB26M
         WbYve/oDSck/tqE4DAtuSG7shPHD9LkWixXa5RFTcUKLqEoE0cwcAslbvSg+Kp2oX/Vz
         cflkGsEffOYmJC0JhnpiFZ8KUJKaGGAhMtzWt+uEkF/m2pbvYjEmHVmeGLBMpDNTLruM
         u1o77+nfYghiSktjSX0NBNExSHZgiLaFWMONRfQWLG+HkdeBi1gFhA0zcUrer8O6byX0
         H5MYZN0K9+evfuJ9RXPWesRB2Vifk+wOMc9PwL7MhZ4PF73jrkXSAMfAd9NMkZVMbfvF
         SOgA==
X-Gm-Message-State: AOAM532Uluttoun910eHIcLFtkot1Ay2xPJradAD+7PCUMOiQC8FsH+4
        v+//+kNNAQG6FiHxGIIad7owEVMsm1TROg==
X-Google-Smtp-Source: ABdhPJza8J98EK1QzmWVDDKoVHCwiWdNDLiDYaJ6zXi9efJx2RwxxDdXXOHD/LdsBV0FTi+dnijN+Q==
X-Received: by 2002:a05:6402:151:: with SMTP id s17mr52927894edu.233.1625140624195;
        Thu, 01 Jul 2021 04:57:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bx11sm10656274ejc.122.2021.07.01.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 04:57:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 4/8] refs: make errno output explicit for
 refs_resolve_ref_unsafe
Date:   Thu, 01 Jul 2021 13:56:19 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <11b2184044d766183edf5ee1888f38945e8a7fd1.1623329869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <11b2184044d766183edf5ee1888f38945e8a7fd1.1623329869.git.gitgitgadget@gmail.com>
Message-ID: <87eecidz74.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
> contract for the errno output explicit. The implementation still relies on
> the global errno variable to ensure no side effects of this refactoring.
>
> In a follow-on commits, we will
>
> * migrate callers that need this error information
>
> * clear errno in refs_resolve_ref_unsafe() to make sure these other callers
> aren't using the error output accidentally.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs.c               | 12 ++++++++++++
>  refs/refs-internal.h |  8 ++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index bebe3f584da7..64e2d55adcfb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1781,6 +1781,18 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  	return NULL;
>  }
>  
> +const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
> +					       const char *refname,
> +					       int resolve_flags,
> +					       struct object_id *oid,
> +					       int *flags, int *failure_errno)
> +{
> +	const char *result = refs_resolve_ref_unsafe(refs, refname,
> +						     resolve_flags, oid, flags);
> +	*failure_errno = errno;
> +	return result;
> +}
> +
>  /* backend functions */
>  int refs_init_db(struct strbuf *err)
>  {
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 904b2a9e51ae..eb97023658f8 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -153,6 +153,14 @@ int refs_read_raw_ref(struct ref_store *ref_store,
>  		      const char *refname, struct object_id *oid,
>  		      struct strbuf *referent, unsigned int *type);
>  
> +/* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
> + * failure. */
> +const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
> +					       const char *refname,
> +					       int resolve_flags,
> +					       struct object_id *oid,
> +					       int *flags, int *failure_errno);
> +
>  /*
>   * Write an error to `err` and return a nonzero value iff the same
>   * refname appears multiple times in `refnames`. `refnames` must be

Okey, this might be eligable for comments similar to what I've had so
far, but no callers yet. Let's read on to those commits, right now I'm
thinking "this looks small enough that it should be squashed into that
future commit"....

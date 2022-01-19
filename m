Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC51C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 16:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbiASQvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiASQvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 11:51:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F026EC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 08:51:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j2so14981503edj.8
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9Akjh+wL9PFpdxakAZi7cUbTn9cRYTE5UofXpsLX8I0=;
        b=KFsUqP4R+16U8pBMIw4p3HDkMgRTri/7Ocm055hUxO2Sn91RIeVQBBu7m0IisA/hRN
         ecH+I/aIPjavRGa4ze8glFqiOg4CDwZ6VjmKBqqmLau3hNCiRN8hX/NJu6QtyQmcc/Te
         DpokjagCk43rw73s2jXU3YJlXdSRfySkoHzAOyg3ji7f/GaKEjBGPs5x1cQfapVbAy/o
         gQK3YBODVVS0PSwbotVRg7BfpUbYxsuUTqF/s2peuvnI1OsCR2NLzT8kdikBDPC1UjDG
         3WSOoZr1HhGESSZQ+x1ifSadb1HEWdrLhX7MOVkFdNv8Rsf064YJ5UOwLaGm0tqJP9XB
         B/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9Akjh+wL9PFpdxakAZi7cUbTn9cRYTE5UofXpsLX8I0=;
        b=UpRbL5KS3kqh3JALGwsal/KNQF78eGf4VlwfeW/T6TKaOmZeheYYWDMovHPqPjlLyD
         wNoQrbryEtEPrzWp6Tgf+HoI8mEkiHSlU46t6aUAlRPxCW4yqCJrUqfry9QoSfwm3tPY
         LR+H17gidThUEXNqry4Kbzlpxn6GAwsJ3jlY2+XbLfaw6R7lI/8hLalmzw2jOjMfxRm6
         1ffOTIGccSbA0p+u9A65/fqY7xfdKUY5AUPVKJplXgKvuvm1p9zypzIZCLZGNrCTodqW
         aUvaVGvqL/JCj8zPbng0Fc0U6nk3NtWVcg0pxZ6kFWBE8BV5O65G9WdhOrU2yyzjcooo
         7VYg==
X-Gm-Message-State: AOAM533yCrlsmgFRGhcgIurwc+1NOz0m1GZTCsIgI01lO2Txz+XFwCRr
        V+ve5srBFuXrgJBWx/Yr5sWCIjCKJ/eGrg==
X-Google-Smtp-Source: ABdhPJy0wkFyp7YmPKU6POY5QNr1thh2AM1UwoM2jw2mKdPqNdt+glSAqFeAJwVaC/mgM31y+hfWrA==
X-Received: by 2002:a17:907:7f01:: with SMTP id qf1mr25382173ejc.9.1642611076209;
        Wed, 19 Jan 2022 08:51:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d16sm68133eje.131.2022.01.19.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:51:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAEB0-001oj8-Qn;
        Wed, 19 Jan 2022 17:51:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/9] ll-merge: make callers responsible for showing
 warnings
Date:   Wed, 19 Jan 2022 17:41:14 +0100
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
 <b952f674df13a1c3e4bffa823490f905e862ef7c.1640907369.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b952f674df13a1c3e4bffa823490f905e862ef7c.1640907369.git.gitgitgadget@gmail.com>
Message-ID: <220119.86h79zmzy5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:

> Note that my methodology included first modifying ll_merge() to return
> a struct, so that the compiler would catch all the callers for me and
> ensure I had modified all of them.  After modifying all of them, I then
> changed the struct to an enum.
> [...]
> -int ll_merge(mmbuffer_t *result_buf,
> +enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
>  	     const char *path,
>  	     mmfile_t *ancestor, const char *ancestor_label,
>  	     mmfile_t *ours, const char *our_label,
> diff --git a/ll-merge.h b/ll-merge.h
> index aceb1b24132..e4a20e81a3a 100644
> --- a/ll-merge.h
> +++ b/ll-merge.h
> @@ -82,13 +82,20 @@ struct ll_merge_options {
>  	long xdl_opts;
>  };
>  
> +enum ll_merge_result {
> +	LL_MERGE_ERROR = -1,
> +	LL_MERGE_OK = 0,
> +	LL_MERGE_CONFLICT,
> +	LL_MERGE_BINARY_CONFLICT,
> +};
> +

Isn't the other side of the enum checking missing in many cases?

E.g. ll_ext_merge() returns "enum ll_merge_result" now, and does:

        status = run_command_v_opt(args, RUN_USING_SHELL);
        ret = (status > 0) ? LL_MERGE_CONFLICT : status;

And grepping at the tip of this series shows:
    
    $ git grep LL_MERGE_OK
    ll-merge.c:             ret = LL_MERGE_OK;
    ll-merge.c:                     ret = LL_MERGE_OK;
    ll-merge.c:                     ret = LL_MERGE_OK;
    ll-merge.h:     LL_MERGE_OK = 0,

Similar for LL_MERGE_CONFLICT, the only one that's used outside of the
file itself and its header is LL_MERGE_BINARY_CONFLICT.

I.e. shouldn't these codepaths:

    git grep -w ll_merge

Be doing a switch() on that new enum? E.g. we lose the type in
three_way_merge() in apply.c, it seems to me that that function should
switch over this new enum, and return the "int" that the callers of
three_way_merge() care about (i.e. just <0, 0, 1, not this enum's -1, 0,
1, 2.

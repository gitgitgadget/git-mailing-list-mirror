Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7001C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECF660C40
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFKRFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFKRFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:05:02 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C52C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:02:48 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i16-20020a0cf4900000b029022023514900so18462436qvm.11
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/NEWwyZZy8pgoDPTIGdA4CcpGBETObaeOypHvQTSz/8=;
        b=hipK0xUhlhiRECMyMVMIXJ1k2f5832LpAewZCqDTuxlSDurueLkmlePHRdRZzJEWzr
         pV4oz5to8vdErU/aRbtcitMJbo+UVHaENCRHJf2ISsw6isXGuHXhEEPuUBZTcgswTuDC
         A9aP14wkUcStFdLwfjEL5Y3a0i8DCjxg+TrHn70dKtNclH/CZPqvdSlbVqBVvajNIh6Z
         q33euD9SmZwA7vRAdJ0QOLY8aqGEZhtQt0iYxL3WoGN0pEfDqPC22EPBaPyas2x5Ppeq
         tw6dqUqxEeHAPysfvy9tag7t2TYzJTAZxXu5qg44M7S0ZI/DiHu+fW+83RbC19CdIxcJ
         TNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/NEWwyZZy8pgoDPTIGdA4CcpGBETObaeOypHvQTSz/8=;
        b=MpYdGB3iVZiV3FlDcwx0MUpTOCDONv8kc+gX5/jXO3aY534e1+fv8RmrAUUt9GXF7O
         MPsFlc16pZds6zIoL01wZJtOleQajWOOZdhmhUjMHpY7CbBXbXFcN2yIcj0Qbj8ZA35G
         7qGNHEyQ9gAeus94I8GbnQHlLMbs/gT4sBJyGt9K6uOYcFKWaqYc4llN9/YX0xyWqcYH
         BctXJhqPCHHHIRJE3ZRF8qiCI4kIn70pvS9a7UaRxonpL604QpgZkHYJ5QhqcOLEzco5
         /oxi6yyRE2DDxRsejGixGZbrpbWTafM9PkgR3u34sOX/xbBoVN+iR/10Y353wDclnPbp
         DR+A==
X-Gm-Message-State: AOAM532DpAXPhlSRB8Udu4cx8EvD4191i1JDhK9P7thoMl9tWLJtHNEJ
        jpfsRBf6QwpPFJRkqyTWHZs2/f37OOpVKVdfMELV
X-Google-Smtp-Source: ABdhPJw9YwzhQyCjFJnEsJsOBY8GGRH5DqsFu8wy/iYs/mtWO78/qC9w70ED0SmE+QZnNnc9kE0yDH6ARxJBnQdqcRJs
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:2a8a:: with SMTP id
 jr10mr5941794qvb.50.1623430967094; Fri, 11 Jun 2021 10:02:47 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:02:43 -0700
In-Reply-To: <YMKJSuin9fS/4acr@coredump.intra.peff.net>
Message-Id: <20210611170243.486447-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YMKJSuin9fS/4acr@coredump.intra.peff.net>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: Re: [PATCH v3 3/5] submodule: refrain from filtering GIT_CONFIG_COUNT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     newren@gmail.com, jonathantanmy@google.com, git@vger.kernel.org,
        me@ttaylorr.com, emilyshaffer@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I'm super confused.  It appears that
> > prepare_submodule_repo_env_no_git_dir() is filtering out
> > "GIT_CONFIG_PARAMETERS" (CONFIG_DATA_ENVIRONMENT) and
> > "GIT_CONFIG_COUNT" (CONFIG_COUNT_ENVIRONMENT), using all environment
> > variables other than these ones.  But the commit message talks about
> > adding an extra environment variable, rather than filtering another
> > out.  I must be mis-reading something somewhere, but I'm struggling to
> > figure it out.
> 
> I think there might be a double (triple?) negative here:
> 
>   - we want to pass through the config parameters variable, but not
>     other local repo env variables;
> 
>   - so we _don't_ want the config variable to appear in the "out"
>     strvec, because its presence would cause it to be cleared
>     from the child process environment;
> 
>   - so we go through the list adding everything _except_ that variable;
> 
>   - and we match using strcmp(), so a true value means "did not match",
>     so we should add it to the list
> 
> > Also, from looking at the other commit messages you reference, it
> > appears GIT_CONFIG_PARAMETERS was just one big environment variable,
> > whereas GIT_CONFIG_COUNT is closely associated with 2*N other
> > environment variables...so shouldn't your loop (and perhaps also
> > git-submodule.sh) also be checking GIT_CONFIG_KEY_\d+ and
> > GIT_CONFIG_VALUE_\d+ ?
> 
> We definitely could clean out those GIT_CONFIG_KEY_* values. But the
> COUNT serves as a master parameter. Anybody who sets COUNT would then
> also set the individual key/value parameters, too (and even it only sets
> it to "5", and there is a crufty GIT_CONFIG_KEY_6 in the environment,
> that is not wrong).
> 
> -Peff

As Peff describes, if an envvar is present in the list, it becomes
unset. (Perhaps confusingly, if an string of the form "ENVVAR=VALUE"
(note the "=") is present in the list, it becomes set to the given
value.) So in order to *not* filter out the envvar from the subprocess,
we need to filter out the envvar from env_array.

If you can think of a better way to document this, please let me know.
One way I thought of that might reduce confusion is for this function to
take the struct child_process directly. I don't like taking the whole
struct when we're just modifying env_array, but I think that this
becomes easier to document (just say that we're unsetting all these
envvars from the child process, and in the function body, say that to
unset a variable, we need to make it appear without a "=" in env_array).

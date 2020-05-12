Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74519C54E4A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA44206D3
	for <git@archiver.kernel.org>; Tue, 12 May 2020 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXHOhZ/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgELOPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgELOP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 10:15:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAEC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 07:15:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id r14so6436230pfg.2
        for <git@vger.kernel.org>; Tue, 12 May 2020 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36JsqDbphDtV8nXMLD1FUMexALJ0TNpR5sXOON2kiUE=;
        b=SXHOhZ/50mcTU61d9u6spPnoN4d4EEAjlWBCY+Eg8SekZdRX5PHUMu2jthVwwJ2Rij
         eCJJBa/f/MW7Pb9lf4+q+KskPy4P619MJWUNJW5PuFS8ZItWPSwrZBj+8DXtSQ8DI3pg
         uaarkuzc6sS39L9LFg/E3qvNBFZ7g6eXNI/A+FZPNEwuolFSPHgK/q/7FSfnzz5bcZok
         MZlBaGBQJ9Dlae/4K/WxTiFAdutrUkFoSC9KIaDnzfrXb56hZHFtPTqVh2+tVojkWqWb
         TZU9fGW3gXRN+T6n8YrRKUBE5jML+62otUVxhjf/r2UkCE3rktDxydUlOkaiMzYBduPK
         puog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36JsqDbphDtV8nXMLD1FUMexALJ0TNpR5sXOON2kiUE=;
        b=sppXWlo1rmiQzXJwB9/W+yKE9unFcWq0sLxQkKyFxeE0QcCftIrGwWBlUII39etnJF
         AG0LgXOXeYbL25XKCRo+8wM1Ql0XTt046buHCBlFNf+PCl2u+q/e/C1/zwA4Yodfk+hc
         h2ROLOhI7GTMPtpDE1MHoPBVZsa7dht2SIHFwn/E+a3Gfa72C2laQZNU/Cf3LL4QpAj/
         X7aCVOzmHkeWAyuIci/KtjZdqwydAP5g63N/SBwhhnaIeW5me20P+u7zT8v5G52uHteE
         ByGUqytXlmAVJh/AEVKf6pYNPBSbnkgts92W4q5tcU1iaxCZSEB8vL8SgHbVGtbxZqxS
         nSRQ==
X-Gm-Message-State: AOAM532LBHfMPtPQgSOx7HYpEfM2xlQpnnkWVEquIjy2pQZ99a/yqjNe
        2l+Y2erefYoMFEURPrPCG7eRGPFh5jiI5w==
X-Google-Smtp-Source: ABdhPJx29G7aPjm7CfIMsby7RAGX9UNK1XffvWdi9uAFnbTOmaPDW0eBZcaXazgg8UI2JNiQ9E5Wcw==
X-Received: by 2002:a62:e10b:: with SMTP id q11mr4209668pfh.34.1589292927178;
        Tue, 12 May 2020 07:15:27 -0700 (PDT)
Received: from konoha ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id 14sm12522012pfj.90.2020.05.12.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:15:26 -0700 (PDT)
Date:   Tue, 12 May 2020 19:45:20 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        liu.denton@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
Message-ID: <20200512141520.GA8133@konoha>
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <20200510164424.GA11784@konoha>
 <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOEXN9yyL8T8kDmpHKTjjaG9tVS1kh34B-=PuH1hRaA7jF_K6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05 11:51, Guillaume Galeazzi wrote:

Before I comment on the patch, I want to apologise for the delay in the
reply. I got caught up with some stuff.

> Now with the vice-versa idea in mind, I think it is maybe better to
> change a bit the original patch
> to add the option to execute command only on inactive submodule as
> well. Could someone need
> that in future?
> 
> Basically this would mean:
> 
> On struct foreach_cb instead of only_active adding field:
>         int active;

Yeah, keeping the option name as `active` would be better if we were
to go for the inactive submodules option as well.

> Defining some macro to hold possible value:
>         #define FOREACH_ACTIVE 1
>         #define FOREACH_INACTIVE 0
>         #define FOREACH_ACTIVE_NOT_SET -1
> 
> Changing the FOREACH_CB_INIT to
>         #define FOREACH_CB_INIT { 0, NULL, NULL, 0, 0, FOREACH_ACTIVE_NOT_SET }

Do we really need to include the last macro here?

> The filter become:
> int is_active;
> if (FOREACH_ACTIVE_NOT_SET != info->active) {
>         is_active = is_submodule_active(the_repository, path);
>         if ((is_active && (FOREACH_ACTIVE != info->active)) ||
>             (!is_active && (FOREACH_ACTIVE == info->active)))
>                 return;
> }

Is it okay to compare a macro directly? I have not actually seen it
happen so I am a bit skeptical. I am tagging along some people who
will be able to weigh in a solid opinion regarding this.

> It need two additionnal function to parse the argument:
> static int parse_active(const char *arg)
> {
>         int active = git_parse_maybe_bool(arg);
> 
>         if (active < 0)
>                 die(_("invalid --active option: %s"), arg);
> 
>         return active;
> }

Alright, this one is used for parsing out the active submodules right?

> static int parse_opt_active_cb(const struct option *opt, const char *arg,
>                                int unset)
> {
>         if (unset)
>                 *(int *)opt->value = FOREACH_ACTIVE_NOT_SET;
>         else if (arg)
>                 *(int *)opt->value = parse_active(arg);
>         else
>                 *(int *)opt->value = FOREACH_ACTIVE;
> 
>         return 0;
> }
> 
> And the option OPT_BOOL become a OPT_CALLBACK_F:
> OPT_CALLBACK_F(0, "active", &info.active, "true|false",
>         N_("Call command depending on submodule active state"),
>         PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>         parse_opt_active_cb),
> 
> The help git_submodule_helper_usage:
> N_("git submodule--helper foreach [--quiet] [--recursive]
> [--active[=true|false]] [--] <command>"),

What I have inferred right now is that we introduce the `--active`
option which will take a T/F value depending on user input. We have 3
macros to check for the value of `active`, but I don't understand the
significance of changing the FOREACH_CB_INIT macro to accomodate the
third option. And we use a function to parse out the active
submodules.

Instead of the return statement you wrote, won't it be better to call
parse_active() depending on the case? Meaning that we call
parse_active() when `active=true`.

Regards,
Shourya Shukla

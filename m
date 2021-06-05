Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251A1C4743D
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F271A613BF
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFEB7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEB7b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:59:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87554C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 18:57:44 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id n3-20020a378b030000b02903a624ca95adso7736926qkd.17
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wCT3y1C/dDv30SSL6Y30+Gog35hmiHRCSb2ERYhXTQU=;
        b=Dlgom+AAbqbEZwqAu0dLs843AzamXDzQxFq+KHzd2UGccVoTOttaXIpOyf/j8s+Sdk
         SUUzbzq9oY47Iq4qcNLdvl3wT9eE+72HqQUowOhf/WBPMY1jJuXV9w79mLhmDsyU76zW
         0G01XmNipESbzVi73Rx2h4tPLfoUbAC97u/AA0V56vAhNXzoD5Ure4akzma/5I7keC5y
         ZJ16Wv0O5OiXlsaly29UChHhjbdli72c6xHavc/Ff4aZQ8HKR/uN+2t08IFf0SOkcDEO
         0XiWKQtIUAGdzNFCGEwrOyW4zG9IL+IFUPJjsMVPp6EoTAfpycC7XKBYYGvlJG3eLmb4
         SWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wCT3y1C/dDv30SSL6Y30+Gog35hmiHRCSb2ERYhXTQU=;
        b=HSp+EzOn37Z+j4WspRa5O5XghRQUT/ZBbHoqi9/cFjgb1dRaPtm+Ad4GF3xDko9784
         v4xJq8Wb/hCxLVDb1UFS7VD8joNZAvfWPg1zIHWMAEf1RN4VyzQBgnR6+YGL4woe0WJB
         VaJHyyj61JXTsnQHW8/84gY4tuMg2OTpLQXDCdjAS10fUXY+yYuxIgvuxkwXhxL4qou3
         Kc40/njfzG3eKXzu5tEgovw5bSAEjWpyH4uxu8xXQnPut64KgJh+vRDV8vzVwzGuzFsW
         w9d0ddIBbEx5ghcrfgBHkVigtBiR2reYYcxLP3frW/F8AlNpi2G/TS/BO0rHBaO/jhxP
         rXSw==
X-Gm-Message-State: AOAM532C/iRgIjSwAZPD1lSHgbOLpGrc2Fy/YHoL9lwgTdJexmyWhTpo
        eYBHEpjREo4YphYoQsborErBZuNQ0PcrjrufFeQe
X-Google-Smtp-Source: ABdhPJwHlRQYdLUnMZLuHl5qsWNmW2ZuAs8zRwifN16e4YNFI0LKfHsyomAvyThIN57YcX/fsbMLstyntnyXjdtyO0EP
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4522:: with SMTP id
 l2mr7589677qvu.61.1622858262983; Fri, 04 Jun 2021 18:57:42 -0700 (PDT)
Date:   Fri,  4 Jun 2021 18:57:41 -0700
In-Reply-To: <YLqK6XTmnaQoFycz@nand.local>
Message-Id: <20210605015741.607933-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YLqK6XTmnaQoFycz@nand.local>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 3/4] run-command: move envvar-resetting function
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jun 01, 2021 at 02:34:18PM -0700, Jonathan Tan wrote:
> > There is a function that resets environment variables, used when
> > invoking a sub-process in a submodule. The lazy-fetching code (used in
> > partial clones) will need this function in a subsequent commit, so move
> > it to a more central location.
> >
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> 
> All seems pretty normal to me. I did have one question, though:
> 
> > +/**
> > + * Convenience function that adds entries to env_array that resets all
> 
> Hmm. Why "resets"? IIUC local_repo_env is the array of environment
> variables that change behavior. With that understanding in mind, I
> probably would have written something more like:
> 
>     Convenience function which adds all GIT_* environment variables to
>     env_array with the exception of GIT_CONFIG_PARAMETERS. See
>     local_repo_env in cache.h for more information.

I mentioned "reset" because the effect of adding the name without any
value makes the environment variable of that name unset in the
subprocess. I'll word it as you say, and add "When used as the env_array
of a subprocess, these entries cause the corresponding environment
variables to be unset in the subprocess." after the first sentence.

> (Confusingly, cache.h calls this variable CONFIG_DATA_ENVIRONMENT, but
> binds it to GIT_CONFIG_PARAMETERS. I think it probably makes more sense
> to use the environment variable's name rather than our #define, since
> we're saying "all GIT_* variables, except this one", so it would be
> weird for "this one" not to start with "GIT_".

OK, that makes sense.

> Otherwise the movement looks fine to me.
> 
> Thanks,
> Taylor

Thanks.

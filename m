Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF12C001DF
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 15:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGUPzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjGUPzg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 11:55:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BF2D50
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 08:55:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c926075a50cso5449920276.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689954914; x=1690559714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YL2xABUgcONUuBoXxDbMgJ1JWbYBO7bWDNwjxXOUahA=;
        b=py7qhjlZDt0G2Xm6w/Fi2tEX2NXN4DBmCJjrvh5C+AgU0yLaQtgjak0ST8BOrHvvo3
         hhGAYnZZMGWihI86RZYVhEYbn5mYNCeesdGuneXjCX4vsOSs5gaGSwpGa2LIJDQqdj9E
         S4apfIz7wSwwH6xxwsIjy1DXoGO6VyGDfILyqUGo1HFei5iaZ32Gcatjdslal8HegQ/P
         uogRjweNuu5y1jN3fAbw8sphbKinMGq8mKuWQK94Xmsj2HPvf5xcf75crJu31J8aimVb
         YFG0ikOIoHcRK8zTUQM2OHw4b+Z2AMk8eNCX0Eo+hBxN48KN4kSnBvOTDovcnfToygQq
         jLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954914; x=1690559714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YL2xABUgcONUuBoXxDbMgJ1JWbYBO7bWDNwjxXOUahA=;
        b=PrDR5a6g0HH0EnA/Yu6DnVQunA0E6K3NFQyt8zb1yXo6nE4urVuORD7r7zZ1E2xKzo
         LK7AEs84yqzls1NRdtEV4U1IF55a7m6uKi/gBH94TSRmZqqLRcWEF2qdAaZnJBlBABiL
         rHvWnnkUi/ptWbJQERedt998M1PnnMeZsV6vdxMiUnEzthlGNO/y5u8ywuNeYqB5CvQe
         5yaGVIosKv71Nwwa8sDTMdpANIp0XIxIf3id0Mtbu8DM9JaUCJwBEagEWP1vOAOW17zm
         r3MTURvkRytNmZOiainxJAHA/yZbS4m0TKGLlPA022GV4x2yjIYjDVr0e61UMZQ9Ju0b
         2P8w==
X-Gm-Message-State: ABy/qLYfKumkVS07CZIvSuEpZVxnO9RCrjKfn8vMscEA4JLS++5DHM3u
        uVWbUGl57mqZBJYebFroIoG3aDuE1EiUCg==
X-Google-Smtp-Source: APBJJlGUR0trgzwOrDzZ5J/BH8s/FRTBg5JjHN4AAaL9r/YL4EoSy7l20/2Fb/bUpnc15BrnUFnUWiQ7oTzN7g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:704:b0:cc8:2833:2202 with SMTP
 id k4-20020a056902070400b00cc828332202mr36143ybt.3.1689954914156; Fri, 21 Jul
 2023 08:55:14 -0700 (PDT)
Date:   Fri, 21 Jul 2023 08:55:12 -0700
In-Reply-To: <20230721003107.3095493-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230721003107.3095493-1-jonathantanmy@google.com>
Message-ID: <kl6lwmytz2cf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/2] config-parse: split library out of config.[c|h]
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Begin this process by splitting the config parsing code out of
>> config.[c|h] and into config-parse.[c|h].
>
> I think we need to be more careful in how we split. It would be easier
> if there is a concrete use case, but some preliminary questions:
>
>  - "respect_includes" is in the library, but callers might want to opt
>    out of it or provide an alternative way to resolve includes.

Makes sense. Or alternatively, we could choose not to support
"respect_includes" initially, and exclude it to avoid confusion.

>  - There is a lot of error reporting capability with respect to the
>    source of config, and not all sources are applicable to library
>    users. How should we proceed? E.g. should we expect that all library
>    users conform to the list here (e.g. even if the source is something
>    like but not exactly STDIN, they should pick it), or allow users to
>    customize sources?

Good point. I would also prefer to have the list of sources constrained
to the list of sources available via the library. Some possibilities I
can see are:

1. Move the Git-program-specific error message reporting to a level above
   the library (i.e. config.c).

2. Proceed as-is (with the additional sources in the library) and leave a
   FIXME to address this when we find a Git library-idiomatic way to
   handle errors. This won't be the last time we'll have to untangle
   Git-program-specific error reporting from the library - it might be
   useful to try to figure out all of that in one fell swoop.

3. Figure out library-idiomatic error handling mentioned in 2. right
   now.

I think 1. is the best option, but if that fails, 2. is also reasonable.
3. is too difficult to do with a sample size of 1.

> In the absence of more information, the split I would envision is
> either something that can only parse a buffer, its error messages being
> very generic (the caller should turn them into something more specific
> before showing them to the user) (but one problem here is that we must
> postprocess includes, which might be a problem if the output of parsing
> is a flat hashtable, since we wouldn't know which keys are overridden
> by the includes and which are not);

Hm, how does the include mechanism here this differ from what's in this
patch? This also only parses a single file and ignores includes. I'm not
sure why this requires us to postprocess includes - in config.c,
includes are handled by 'pausing' parsing of the current source,
evaluating the included files, then 'resuming' parsing.

> or something that can take in a
> callback that is invoked whenever something is included and maybe also
> a callback for access to the object database and that has full knowledge
> of all sources for error reporting (or allows the caller to customize
> the sources).

Ah, I like this callback idea quite a lot. This lets config-parse.c
easily support unconditional includes and provides entry points for
program-specific behavior (like checking the odb). I will try this.

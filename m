Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC2C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3361996
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC3ALh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhC3ALC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 20:11:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12A6C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:11:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l76so10464645pga.6
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w3DEZT2vOO/uDRlWRzLDxq7PaGvtTPrW6kZfQ/D4RQE=;
        b=ehJKEH76VovCYkTyDBAfak0vNsfu+cyUQMNvHN4Ygy/rY0Kmvng30rXgFsHMaDBOE/
         pIv2fifZ8gtwTcVwg0iUe/8X5x3Q81tKW+VQKE5I/Qv0fNVE2EwWdRS/OrVOepZda1J1
         7iB0TJe6seF3m8O10Dl0/NlEgm+V6UtW4ls5hwHEIFAw/00KM269NAZgRRs+5jCKz+xX
         +0bvHqzcyAjJT3pOfoI4tGl3hwgdO3iBk3Sug6hcLywFs5X+1mHfnPxUUHkO0faZK6HF
         OKn23KsqOmTXgRdjJynM2LLUkvOqZCtg4/athN9YB/St3K6pr3EupKAQVHqFlm4Aaaom
         i2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w3DEZT2vOO/uDRlWRzLDxq7PaGvtTPrW6kZfQ/D4RQE=;
        b=b+FSjJUNCtN0At6o2Vnnr9TyRWkIiRgKu6LCT3fZs84BugqLDWAkUFPpE2b5LY66Ly
         UMoIuDU00AdP5XkKLjIiyWX7FwClDUFfiZ7Te/Pb6fXlvTJnJgZBSXp+JbzhPwhxJz/O
         x3qGqbTosNJOPAEWsHpqoYJjZppCOhhK/2PT4jqg9gUAkyXB/+E0lDGEdIvmxhGWEjfU
         1XC8y1Y4kIBk0n5MumMpuiQG8VTzmNEpwAQ3ClGejiQaRtMLSacySCklWfCdOlh8oYcV
         PxV4eydLFeZpUqvVHn83cYVjo4fpwd6SHby+6fIHWYFyKNvCjExH5FdoQ9n2kh05dwys
         274Q==
X-Gm-Message-State: AOAM5339gwJNGfzv1jxd49zdDZrKLc6+tu6SMqIH5VKVPODIkTEHPT2v
        8gHYadEuMnhV4mNdcWjyxSlnxw==
X-Google-Smtp-Source: ABdhPJw94axZjvZaiEWGVLaJIGyR8LB9K77ottLOiHk9okrUy2nyJsp5wymE587p2bygwsIoiYodlA==
X-Received: by 2002:a62:168b:0:b029:20d:69a5:189 with SMTP id 133-20020a62168b0000b029020d69a50189mr27408529pfw.57.1617063060888;
        Mon, 29 Mar 2021 17:11:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id o76sm16861470pfg.217.2021.03.29.17.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 17:11:00 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:10:54 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
Message-ID: <YGJsjgEngx8z6wDk@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-38-emilyshaffer@google.com>
 <87sg50g1nz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg50g1nz.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 10:29:52AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > By showing the list of all hooks in 'git help hook' for users to refer
> > to, 'git help hook' becomes a one-stop shop for hook authorship. Since
> > some may still have muscle memory for 'git help githooks', though,
> > reference the 'git hook' commands and otherwise don't remove content.
> 
> I think this should at least have something like what my b6a8d09f6d8 (gc
> docs: include the "gc.*" section from "config" in "gc", 2019-04-07) has
> on top, i.e.:

Yeah, this seems reasonable.

>     
>     diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
>     index 4ad31ac360a..5c9af30b43e 100644
>     --- a/Documentation/git-hook.txt
>     +++ b/Documentation/git-hook.txt
>     @@ -150,10 +150,18 @@ message body and cannot be parallelized.
>      
>      CONFIGURATION
>      -------------
>     +
>     +The below documentation is the same as what's found in
>     +linkgit:git-config[1]:
>     +
>      include::config/hook.txt[]
>      
>      HOOKS
>      -----
>     +
>     +The below documentation is the same as what's found in
>     +linkgit:githooks[5]:
>     +
>      include::native-hooks.txt[]
>      
>      GIT
> 
> But I also don't think we should demote githooks(5) as the canonical doc
> page for the hooks themselves.
> 
> If you run this in your terminal:
> 
>     man 5 git<TAB>
> 
> You'll get:
> 
>     gitattributes         gitignore             gitmailmap            gitrepository-layout  
>     githooks              git-lfs-config        gitmodules            gitweb.conf 
> 
> (Well, maybe not the lfs-part, but whatever...).
> 
> We should move more in the direction of splitting up our "file format"
> docs from implementation, like the git-hook runner.
> 
> I'm somewhat negative on including it at all in git-hook(1). For the
> config section it makes sense, and it's consistent with established doc
> convention.
> 
> But including githooks(5) is around 2/3 of the resulting manpage, I
> think just a link is better.

Maybe so. What I really would like would be if `git help githooks` //
`man githooks` opened `git-hook` manpage, but I had trouble getting it to do
that and still publish to the `githooks` manpage (because the command
doc format doesn't match the guide format). (Or, really, if `git help
githooks` didn't exist so we didn't need to split the docs up. But that
ship has sailed.)

Regardless, I won't complain that much about using a link instead. I'll
make this change for v9.

 - Emily


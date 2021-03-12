Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47796C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F2E64F2C
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhCLJaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhCLJ3y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 04:29:54 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE24C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:29:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x21so6968202eds.4
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=a/tOqoiR9aTdAWJ8gnkqlhR7wBqY9zd5C2KUQM0JR6U=;
        b=ZuVycg28DnKY3/UwQ4OZstcCrfbZfsHxW1zt+rb1B7ZzSgLcBocIlJKt5UwYrwHnvb
         QR3LlRciZKFGkD8tvJNqlqzqmrNYFZIQUcyXLfg5bbEgK6FKpu1LkftZRDIEbd1pDe1z
         CnXVp0zy44Qb6r7HCd7F+SWvx9hSaOGfRGBO3NQS+njPrgKe1sO3+IUD0noWIjXivNhv
         lcQWPoYVSVknHHdJ/IdwwBDQPpU/dkYsBBhCTZ7Z3Gl+Gpm+Dh8hpcmPwggcy+7+wb+0
         IrFPqyP25cN8QUX/5Stita9SvTruiliLbb4UvCbb3Ro+v+Rl+PAtnS6+RgkXIcQYUVS/
         ulOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=a/tOqoiR9aTdAWJ8gnkqlhR7wBqY9zd5C2KUQM0JR6U=;
        b=T01zqoXFVSku4jUEZq5oFwBrc7+gtGuJWrWEoE3Sz+rWMsUm+AeT/JZq7t9NOKzZx/
         9ruCn8SZC71K1fCqa5qQg3694j3LYRRyXbQhpb7pgaQpDE/jfOCD0Rr/C9/LCfY5qdho
         7brAPujF/fdA14Q6AL031Rq2Di4EvVvWD4V+KhcJNYH1P8HrPqnJ5ENiqLRxXxHbR+Hx
         mfBJzcgluAsZc8K1UtmOs94B9BUmYXx22ekB0ztPSletYZRCTd6DLKFYRyyx8sDFHICu
         LhVvg0/KlWp52ErfUBQePVQDvn0WTzFWJV+p2XwgX8WtDdO6LzTSEhe/s4lvpiqk3XWR
         QC9A==
X-Gm-Message-State: AOAM530TxopaITeFiIh+CDvvp8W0d4TBszTPQFFUGea00kj30aseiiff
        5ydo21XVb0VXcL0o1HdALvnUIpqihxCZZQ==
X-Google-Smtp-Source: ABdhPJzGlbfvJwWpX8fPIcsrIRfQFMeuESuQLLTALwTK6T9ARuwp3FhhAEOuE26r3N6hf1yVLbnWTA==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr12530537eds.375.1615541392891;
        Fri, 12 Mar 2021 01:29:52 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c19sm2605291edu.20.2021.03.12.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:29:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-38-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-38-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 10:29:52 +0100
Message-ID: <87sg50g1nz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> By showing the list of all hooks in 'git help hook' for users to refer
> to, 'git help hook' becomes a one-stop shop for hook authorship. Since
> some may still have muscle memory for 'git help githooks', though,
> reference the 'git hook' commands and otherwise don't remove content.

I think this should at least have something like what my b6a8d09f6d8 (gc
docs: include the "gc.*" section from "config" in "gc", 2019-04-07) has
on top, i.e.:
    
    diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
    index 4ad31ac360a..5c9af30b43e 100644
    --- a/Documentation/git-hook.txt
    +++ b/Documentation/git-hook.txt
    @@ -150,10 +150,18 @@ message body and cannot be parallelized.
     
     CONFIGURATION
     -------------
    +
    +The below documentation is the same as what's found in
    +linkgit:git-config[1]:
    +
     include::config/hook.txt[]
     
     HOOKS
     -----
    +
    +The below documentation is the same as what's found in
    +linkgit:githooks[5]:
    +
     include::native-hooks.txt[]
     
     GIT

But I also don't think we should demote githooks(5) as the canonical doc
page for the hooks themselves.

If you run this in your terminal:

    man 5 git<TAB>

You'll get:

    gitattributes         gitignore             gitmailmap            gitrepository-layout  
    githooks              git-lfs-config        gitmodules            gitweb.conf 

(Well, maybe not the lfs-part, but whatever...).

We should move more in the direction of splitting up our "file format"
docs from implementation, like the git-hook runner.

I'm somewhat negative on including it at all in git-hook(1). For the
config section it makes sense, and it's consistent with established doc
convention.

But including githooks(5) is around 2/3 of the resulting manpage, I
think just a link is better.

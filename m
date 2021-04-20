Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E3C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EC3613FA
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhDTVP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhDTVPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:15:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468FC06138C
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 14:14:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z6so3208970wmg.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7qo457m9VetVq+X8R9TYR/OXVTouMdkvB8ff23deN0U=;
        b=Q1Ri676ibZ7/FFsnK4ortbQlonbJLcUEu+vy4YomMkj2hNdyunQw/nnOj+W9mKEpW9
         PJrkLABq58iTnKgl7FlNlZSbQfSowYWd2E8wlsQlhxgz+7c8EQWyTHYt7R2kkJeSl8+v
         DHTB3YHYdxXoZqy7w7VutWChOgR/UV83pwsmJgHIdOS7fvSgSuOjxzaLM/aD1cMi2QlF
         7X00W99ep6Xwu5UidtJjRoSCjiYTUYdPWyu1BbdSqPW48KBVjPCAgj9gBznwEbMiryhi
         M52ZFlrty1QFN0OsOrxopk8YTwDSq0htJhz4J/4x3gJEpmLqJGJguHYrCtGwFAMHtBuZ
         mGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7qo457m9VetVq+X8R9TYR/OXVTouMdkvB8ff23deN0U=;
        b=PHbu0kSIkN4SQ1XfJaeGi4VygrodtUKNyHCq7FVbw1hG89AwkWF6ZkI4RsPD1YHKqD
         HQZmI0fRkccG0fbBiB4kBZzg8HtdGaznhKo9WMRVDjn1fmiLpJPpQTfTe5X4rCD3jguy
         ZoGpxClfcw81aaye6+keGqVqKTudsDVZtG2GY5bogjkeVC6WsRbkAr4HeFRWG/LpvGfT
         TbP/MFHRUlVoifXPC7NDgpfi1vIMVAsi3Rk2vS4sdSOF2/rHt2AOVP+Qj9qUiCLESUiY
         IAGwbK538jt1DBPffdpWL3dx9CuxGhxPN1mmIwUvUDxvJxkBZGeeJQEGsR+xiWfSAkvs
         owOQ==
X-Gm-Message-State: AOAM533X378tljl/fVtQvV77kUR9J+xB4DZ8SchVKx98prBsUZBFvLGY
        nzDG4BfMYgUzrtdDVPL21t8=
X-Google-Smtp-Source: ABdhPJymzgHPu+6udKxjiNrBRuvrM0ka+h3jBGTHk/LYyEwAuNRAAan+4verB3M7FUjpa5OqL3/izA==
X-Received: by 2002:a05:600c:3544:: with SMTP id i4mr6144365wmq.38.1618953277749;
        Tue, 20 Apr 2021 14:14:37 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id f6sm251857wrt.19.2021.04.20.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:14:37 -0700 (PDT)
Date:   Tue, 20 Apr 2021 23:14:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] git-completion.bash: rename to $__git_cmd_idx
Message-ID: <20210420211432.GA3842406@szeder.dev>
References: <cover.1618910364.git.liu.denton@gmail.com>
 <7c7d6de380d1aaa860e86627778bef6c0c78ca08.1618910364.git.liu.denton@gmail.com>
 <xmqqr1j44r5g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1j44r5g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 01:50:19PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > In e94fb44042 (git-completion.bash: pass $__git_subcommand_idx from
> > __git_main(), 2021-03-24), the $__git_subcommand_idx variable was
> > introduced. Naming it after the index of the subcommand is flat-out
> > wrong as this variable really holds the index of the git comand (e.g.
> 
> comand -> command
> 
> > "stash").
> >
> > Rename this variable so that it's obvious it's about git commands. While
> > we're at it, shorten up its name so that it's still readable without
> > being a handful to type.
> 
> As the patch has already written, I won't complain too much, but to
> many people "git" is a command and "add", "commit" etc. are
> subcommands of "git", so I do not see git_subcommand_idx so wrong
> that it needs to be renamed.  I do understand that it is a bit too
> long and it may be easier to type if renamed to say git_cmd_idx,
> though ;-)

The completion functions for git commands having subcommands usually
start like this:

    _git_remote ()
    {
        local subcommands="
                add rename remove set-head set-branches
                get-url set-url show prune update
                "
        local subcommand="$(__git_find_on_cmdline "$subcommands")"
        if [ -z "$subcommand" ]; then

__git_subcommand_idx holds the index of the word "remote", not the
index of "add/rename/etc.", so in the context of the completion script
that name is misleading.


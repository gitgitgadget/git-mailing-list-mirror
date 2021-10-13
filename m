Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD78C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A061261139
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhJMSxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSxs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 14:53:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC6C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:51:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ls18so2941088pjb.3
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QkgIlNCvE07gDIlPXCd62dIgnkgKrmUWzFYUZlOVuD4=;
        b=M101WzXF8fgonP6/ZPV+5dhEcl+DjBbwJjOn2/Ur2kh8nHcDUovHu6Jla4IYgoeIGi
         Z0F22MSoJRew0vaM5PXLPb2jvVPh7mubEkEDNXGv1hzQQi2l0WgE2DNyGkNNcU1x/wCn
         ejG+9tVP0JX+0/Fl4YizZiD2dS49QqZ2WzP1mKfQVf8xc0GxUF/YCcWqUIDeoAUiqvkf
         2Hf3ewMuaW+rAYixfWAbb5TEHX1PqiW5RrTi0eCTj5pNKfTZg5PCqxqKGBk9iJTf5ctJ
         WfWVcG0SJL0BfLN/S4j/gY/O74r5SAS9iuXC/eWyODHsbIXbswjKrz1kRn4DtS/XEACV
         WDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkgIlNCvE07gDIlPXCd62dIgnkgKrmUWzFYUZlOVuD4=;
        b=dQdRdIVxqOYaY1Qvs1wM1n9WucXwKkLjpX9AusK4g8mOF8YcSz2yl+drUnFpZnktr7
         xcc7zDqVyvFx3j6MU6TTgcQJ0T57aP9N5O+XmLWlmIPy0Rs3Ym6BWn/JUjLXigjYfLcZ
         gBePplmhUTUEVFmH5RCIl88jmrIq9ME2H5fg+oKNwUty4cekCppY9y1Sn4eV9RxwVa0m
         DoJ3Ut3QtajTY5OjzNBNoK8Rw7bmPpjWgqoGp3+ey37JiL/qo2YYWivGQrW6xtpHe15I
         a/VA1JinYHWyBbwytIZ3bDyNBLHHoLf1uV4Pau/domONTsr4eksQHm2k11WkDaWcI3+/
         dltQ==
X-Gm-Message-State: AOAM532LwJenV65ayGCHvuM1UcIGG3znLRgMSyiWFfYAk1ZEGpiQDS1L
        /t0JdZy90p5ipYbOT/n7UpoGmChgV0ODBQ==
X-Google-Smtp-Source: ABdhPJy0/XpJjk6TOgqq6VyCe3Jby8CrMdrEqxnxCS54Ga4wvRLu+H7sI+TSSMgpNu1MWKzyHSMqGw==
X-Received: by 2002:a17:90b:3cc:: with SMTP id go12mr15298870pjb.127.1634151104145;
        Wed, 13 Oct 2021 11:51:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3db2:597e:d036:ff3f])
        by smtp.gmail.com with ESMTPSA id o2sm245521pgc.47.2021.10.13.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:51:43 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:51:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/4] cache parent project's gitdir in submodules
Message-ID: <YWcquctPsrRm964k@google.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <f5197594-550f-3bd8-2d22-c9e1b3e161fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5197594-550f-3bd8-2d22-c9e1b3e161fd@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 09:09:46PM -0400, Derrick Stolee wrote:
> 
> On 8/19/2021 4:09 PM, Emily Shaffer wrote:
> > Since v2, mostly documentation changes and a handful of small nits from
> > Junio and Jonathan Tan. Thanks for the reviews, both.
> 
> Sorry to show up late with many questions (mostly because my understanding
> of submodules is not as strong as yours),

Well, here I am apologizing for showing up even later with a reply ;)

> but I do have some concerns that
> we have not covered all the cases that could lead to the relative path
> needing an update, such as a 'git checkout' across commits in the super-
> project which moves a submodule.
> 
> Leading more to my confusion is that I thought 'git submodule update'
> was the way to move a submodule, but that does not appear to be the case.
> I used 'git mv' to move a submodule and that correctly updated the
> .gitmodules file, but did not run any 'git submodule' subcommands (based
> on GIT_TRACE2_PERF=1).

During a live review a few weeks ago it was pointed out, I forget by
who, that this whole series would make a lot more sense if it was
treated as the path from the submodule's gitdir to the superproject's
gitdir. I think this would also fix your 'git mv' example here, as the
submodule gitdir would not change.

> 
> You mention in an earlier cover letter that this config does not need to
> exist, but it seems to me that if it exists it needs to be correct for us
> to depend on it for future features. I'm not convinced that we can rely
> on it as-written, but you might be able to convince me by pointing out
> why these submodule movements are safe.

Yeah, that is a good point, and I wonder how to be defensive about
this... Maybe it makes sense to BUG() if we don't find the
superproject's gitdir from this config? Maybe it makes sense to warn
(asking users to 'git submodule update') and erase the incorrect config
line?

Both those approaches would require a wrapper around
'git_config_get_string()' to cope with a failure, but it might be worth
it.

I'll try proposing such a wrapper in the reroll, unless I hear back
sooner.

 - Emily

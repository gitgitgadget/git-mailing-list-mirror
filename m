Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A5C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E56264D8F
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhBWTxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhBWTxm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:53:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F9AC06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 11:53:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t5so2081785pjd.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YB+qPDHfKZi7zLa71mKEbVi4tIvIaBe0mgWPAhQ9Aq4=;
        b=R8PKrrZ+WLAB1XYwb7t4/+1dRn6a9jsysjUnUDGr7g4EwlLTphy9jJTp+g3ZgG1GWL
         313kgqhFB1+BGzBtj5Tyj2Y9C5QuNB5RiCF0oR/uPYOXP49CEn7C+LjpjiAkx8aUUO2v
         2WrbbH6Zzj5DgazUPJ8MJTveYIAPHlCz69BsZH5Lcu9UNz5kV9NypBWVfijkrUxnup+X
         q6rwTGjg8rvi2qZ7nrWSo5Ktedpw3mgkdoRwLH7E9/DbzOYiXy6stx2SdahyIlxrv0xy
         fKxmluUS4loXXGEKyXAnSV4gMDLEyVwaaUYcePfL9LicwerJHvmRe2SuCftDsV2UaaAa
         Wuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YB+qPDHfKZi7zLa71mKEbVi4tIvIaBe0mgWPAhQ9Aq4=;
        b=Om57CcSNM0z+do5972aCeJwsrPQebIPbUso/vQHNCTPpxcFcIe6AAw0HO5c04DjJYP
         ZpNO3vP09FWr+nVwA4g1wpGCXkbxTBlMFW5xEBOjUnSlu06s4T84vu1dZwKm7z7KWBpr
         +ze82mymDhlHbKprgzchdMT/z6AqQjJXSDJZAunguFyHaWV2kFASDoEMfhRvUljnAqEy
         AEMLQemhG+KGi1YO6ySAFRDPjCwOjgPXbwIXGhHI6vwgIo0FNaHKRXU1aazBENfeu5mO
         MYCQUc/gQ7R3Qtu0jT1YlxxCCtTnAAjiBRVuWVsCqL8HgNakeegDydPiYV0G1hyKdBIh
         czNg==
X-Gm-Message-State: AOAM5313ZA78x1KT+rN0FbhAa91JpG4ODarLvTPIigLeObUoDSO+Opzu
        L2c2PI0t/WkB82OLBipnh2ejhQ==
X-Google-Smtp-Source: ABdhPJxfwnKa3URpBelpLNY0fWf1IXlDamKwicqIqyFy32sc12QefBCedmjTK9AfraQYRt2u28c3pA==
X-Received: by 2002:a17:90b:806:: with SMTP id bk6mr466401pjb.16.1614109981982;
        Tue, 23 Feb 2021 11:53:01 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:398c:f3d9:88c:7d6a])
        by smtp.gmail.com with ESMTPSA id g9sm3730028pfo.115.2021.02.23.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:53:01 -0800 (PST)
Date:   Tue, 23 Feb 2021 11:52:56 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 15/17] hook: provide stdin by string_list or callback
Message-ID: <YDVdGNefUehBknRB@google.com>
References: <20201222000220.1491091-16-emilyshaffer@google.com>
 <20210201070448.1325624-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070448.1325624-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 31, 2021 at 11:04:48PM -0800, Jonathan Tan wrote:
> 
> > In cases where a hook requires only a small amount of information via
> > stdin, it should be simple for users to provide a string_list alone. But
> > in more complicated cases where the stdin is too large to hold in
> > memory, let's provide a callback the users can populate line after line
> > with instead.
> 
> [snip]
> 
> > diff --git a/hook.h b/hook.h
> > index 8a7542610c..0ac83fa7ca 100644
> > --- a/hook.h
> > +++ b/hook.h
> > @@ -2,6 +2,7 @@
> >  #include "list.h"
> >  #include "strbuf.h"
> >  #include "strvec.h"
> > +#include "run-command.h"
> >  
> >  struct hook
> >  {
> > @@ -14,6 +15,12 @@ struct hook
> >  	/* The literal command to run. */
> >  	struct strbuf command;
> >  	int from_hookdir;
> > +
> > +	/*
> > +	 * Use this to keep state for your feed_pipe_fn if you are using
> > +	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
> > +	 */
> > +	void *feed_pipe_cb_data;
> 
> When would we need per-hook state? I see in patch 14 that you give each
> running process little by little (in pp_buffer_stdin()), perhaps so that
> each hook can make progress at roughly the same pace, but I don't think
> we can expect all hooks to work the same, so I don't think it's worth
> complicating the design for all that.

I agree that this is a complicated way of doing it, and if you have a
better design I'd be really excited to hear it.

It seemed like this was what was necessary for hooks like
https://lore.kernel.org/git/20201222000435.1529768-15-emilyshaffer@google.com
where the hook and the invoking process talk back and forth, or like
https://lore.kernel.org/git/20201222000435.1529768-17-emilyshaffer@google.com
which generates stdin on the fly for hooks which cannot be parallelized
(and so won't run at the same pace).

The former example - proc-receive - does have a constraint that multiple
hooks can't be specified, so we could theoretically keep the old
implementation and just pick up the single hook's location from the new
hook library. But the latter example still makes me think this much
complexity is needed.

> 
> >  };
> >  
> >  /*
> > @@ -57,12 +64,24 @@ struct run_hooks_opt
> >  
> >  	/* Path to file which should be piped to stdin for each hook */
> >  	const char *path_to_stdin;
> > +	/* Pipe each string to stdin, separated by newlines */
> > +	struct string_list str_stdin;
> > +	/*
> > +	 * Callback and state pointer to ask for more content to pipe to stdin.
> > +	 * Will be called repeatedly, for each hook. See
> > +	 * hook.c:pipe_from_stdin() for an example. Keep per-hook state in
> > +	 * hook.feed_pipe_cb_data (per process). Keep initialization context in
> > +	 * feed_pipe_ctx (shared by all processes).
> > +	 */
> > +	feed_pipe_fn feed_pipe;
> > +	void *feed_pipe_ctx;
> 
> Instead of 3 fields, I think 2 suffice - the function and the data
> (called "ctx" here). We can supply a function that treats the data as a
> string_list.

Nice catch, sure.

 - Emily

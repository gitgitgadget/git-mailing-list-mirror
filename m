Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6816C433E0
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD6764F20
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575640AbhCBPWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380136AbhCBBsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 20:48:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC631C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 17:47:52 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o38so12799360pgm.9
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hr9oi0wIq/m7svJWLlSjv+YNDu7tK+Niks+CGgf2r6E=;
        b=l2S/0A972lYlezvmb5iVo4Cp6dFNuHf2E6weiTOAIh5QV5EJKa6Rcchl8VF3uuTgUY
         zP8A/98CDfVwS+rjYG72E+YauSuNUtYvuBS5S5QJlLVVufNvM33f/YWOue27MhtCDTOF
         3SA7FC9PxyU/eqjwpqkZ5SKjHFFMFnCy6i3Ry6EcC9gs8dD3+ZG9U9FQqqKgN9Z2XjfL
         U8aoALuOCHXdWxTpPIDbPxNMDVlkMiDzLXz9iI2tfIalacqyhbdoOjb3OXyUZtlVzES5
         VyY3PcDH3joOjdiQOwu2qD6pz3Dav73bL6MRbnqrZIFgIPPICAYt9cbLKS0Pfpg3em+F
         JmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hr9oi0wIq/m7svJWLlSjv+YNDu7tK+Niks+CGgf2r6E=;
        b=OTOwLIqh9CX+kL+Gp2ynUoIE+1ASXt6X28RfwnSVMRqcONtzGYnv2HN8BzMQEGk8eT
         MO7+As2bVKOeILEJcCKxnhY1psQHLTKUBOENpuwKGK/vwnk1vPLL7oiNhcAAimRununI
         oQ24UJg8jUb1aKIbftrIDIbTdn77rTC1886cu5yQ8YjkLd0iMzYL5TVCqcyYAUPtsY+l
         lYAdRDfMUuihcPRf3CWQUlcy80RakO1qaWxbCK0Egfk/atXiZ1r+eLMz1Yis2Z6ZrpoR
         jYvl9Ooli37706HoLbyt4PDsihApuX5NC52/JCoh36DFAjx8hPrKDYcUaMINkTx8s9ER
         gZKw==
X-Gm-Message-State: AOAM532MHDJ21YGe8+BMOqqPzzVqXE+xxDgLt750z6+r1jr5zp5h9nlV
        f5qvw18bTru9PmNjcPOAKDcCZg==
X-Google-Smtp-Source: ABdhPJyK/1kBzM10s1nQXRUXvJDelk9JFH+wXyY7ZWdydEjFPNTnwbOkz078N1GYrW/tI4jRgzo5Yg==
X-Received: by 2002:a65:5c42:: with SMTP id v2mr16320805pgr.339.1614649671762;
        Mon, 01 Mar 2021 17:47:51 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:f06f:1607:6adf:4b8])
        by smtp.gmail.com with ESMTPSA id u66sm20757599pfc.72.2021.03.01.17.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 17:47:50 -0800 (PST)
Date:   Mon, 1 Mar 2021 17:47:44 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 15/17] hook: provide stdin by string_list or callback
Message-ID: <YD2ZQIRfcwGzpFuQ@google.com>
References: <YDVdGNefUehBknRB@google.com>
 <20210225205612.2061342-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225205612.2061342-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 12:56:11PM -0800, Jonathan Tan wrote:
> 
> > > When would we need per-hook state? I see in patch 14 that you give each
> > > running process little by little (in pp_buffer_stdin()), perhaps so that
> > > each hook can make progress at roughly the same pace, but I don't think
> > > we can expect all hooks to work the same, so I don't think it's worth
> > > complicating the design for all that.
> > 
> > I agree that this is a complicated way of doing it, and if you have a
> > better design I'd be really excited to hear it.
> > 
> > It seemed like this was what was necessary for hooks like
> > https://lore.kernel.org/git/20201222000435.1529768-15-emilyshaffer@google.com
> > where the hook and the invoking process talk back and forth, or like
> > https://lore.kernel.org/git/20201222000435.1529768-17-emilyshaffer@google.com
> > which generates stdin on the fly for hooks which cannot be parallelized
> > (and so won't run at the same pace).
> > 
> > The former example - proc-receive - does have a constraint that multiple
> > hooks can't be specified, so we could theoretically keep the old
> > implementation and just pick up the single hook's location from the new
> > hook library. But the latter example still makes me think this much
> > complexity is needed.
> 
> Ah, I see. From your explanation, in these 2 cases, only one hook
> executes at a time (in the former case, because there is only one hook,
> and in the latter case, you said that the hooks cannot be parallelized).
> So it seems to me that the global state (in struct run_hooks_opt) would
> be sufficient to keep track of what's going on. (The feed_pipe_fn
> function can use pp_cb to keep track of the last executing pp_task_cb
> and then compare it against the new pp_task_cb, I think, to keep track
> of when a new hook has started.)
> 
> Even in the case of multiple hooks run in series (as opposed to a single
> hook), I would think that the reason they can't be run in parallel is
> because the nature of execution of a hook depends on what happened
> during the execution of the previous hook, which seems to me to be even
> more reason to centralize the state in struct run_hooks_opt.
> 
> Having said that, if my suggestion of not having per-hook state makes
> certain patches more complicated, then that might be reason enough to
> have per-hook state. In that case, you should write "per-hook state,
> though strictly not necessary, makes <case> simpler" (or something like
> that) in the commit message.

Jonathan and I discussed this a little more offline and agreed to leave
the implementation as is.

Jonathan had suggested "have one callback invocation apply to all hooks
that are running now", either by having the callback iterate over the
task queue or by having the run-command lib take the result from the
callback and have *that* iterate over the task queue. The idea being,
one pointer to one copy of source material is easier to handle than
many.

I suggested that the callback's implementation of the second version of
that, where the library takes care of the "and do it for each task in
progress" part, would be pretty much identical to the callback's
implementation as it is in this patch, except that as it is here the
context pointer is per-task and as Jonathan suggests the context pointer
is per-entire-hook-invocation - so there isn't much complexity
difference between the two, from the user's perspective.

We also talked about cases where N=# of hooks > M=# of jobs, that is,
where some hooks must wait for other hooks to finish executing before
that could start. In this case, users' callback implementations would
need to be able to start over from the beginning of the source material,
and a long-running hook would block other short-running hooks from
beginning (because the long-running hook would be confused by hearing
the source material to its stdin again).

Hopefully this diagram illustrates better based on my understanding of
Jonathan's suggestion:

 A B <- "hey everyone, stdin 'foo'"
 A B <- "hey everyone, stdin 'bar'"
 A B <- "hey everyone, stdin 'baz'"
   B
   B
   B
   B
 C   <- "hey everyone, stdin 'foo'"
 C   <- "hey everyone, stdin 'bar'"
 C   <- "hey everyone, stdin 'baz'"
 C

 Anyway, since the complexity is probably about the same to the end user
 and using per-hook context means we don't have to wait like this, we
 agreed to stick with the implementation as is.

  - Emily

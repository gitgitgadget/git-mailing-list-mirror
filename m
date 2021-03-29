Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5B6C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAD361878
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC2X4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC2X4S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:56:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D3C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:56:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gb6so6827501pjb.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ae2OKl0OUTrk+5OsMjmc0L/hs56fi6Ix3KTxPW2RyMQ=;
        b=DWrOe/sM3v/xoBTrfMRM9dhh5GZQTdQnbiTKP9WGrEK5KFA7H9OBmBL/YIgqarI9zZ
         Ww9zo65CGDUB3zfT0Su70wefLbHDT1srXDLkHbbKaVH33v1tVNJd3ecdUCREsVAv89d6
         ImKM8T5UsG89CkstOuyN9VvDeC/5zteA2fGxZYhEtSX5Hh2pPbWfwWHKpJeke8Sf23QQ
         4eWM1rTZrA7moxtcHGDZ9nArIo3jBBoRDZkwn7cKzet9IsDEDOOMvqgMm/YHbWfw+KUr
         NzVUo4Ii4yv87eq6GrGQGridtOwAnyrm7LYbpyG31t3AgCBhfVhiaKh3WsfqUIlyIX0L
         fW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ae2OKl0OUTrk+5OsMjmc0L/hs56fi6Ix3KTxPW2RyMQ=;
        b=mdudgNKudQWU0sRmux+r21Va17SNA9C1tK2qN9EpesHj28S8m+z1HCXYautZMS9mzC
         XFcMsXU0hLfXxsQ2vzxQRUgdiC2W/M7bWni+LPsAZYx0/BO4CQuorrQgluNgHvGWjnP7
         KyEE51zTQDelQvGltxbMpBDp0wYu0qyIKX+2tCCprs4QlhoWT6rdqEfa4gfGx5ICyXA+
         0v5dhkv/IXNlVcIczfcfrl3oR6I5sFQORsaax+rrjrp4SJ3Xvp6QHaDtxQkKAPsYJ6u1
         8EmS2tt3SG0q8QQMMsvMR1d4lB5cT6ttLm92nKduOGOu14CWaCe3y/YvNyOfI0Rd+NpD
         o3EA==
X-Gm-Message-State: AOAM532VBdBLFPswgZN2rWhno82av8fL/41nxND9v3AGv5b2vRRXCamy
        TkBqII5+T0ywwpkBI50bMhZ8qoTDjl1GfA==
X-Google-Smtp-Source: ABdhPJycJcldtvHwEqBmjBZ72WbNPEQO2ty+3fMMANPGB/1H1N17IUT42rcqzTBL1Y9qt9KXBYzkcQ==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr1543685pjt.170.1617062177633;
        Mon, 29 Mar 2021 16:56:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id a15sm723147pju.34.2021.03.29.16.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:56:16 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:56:10 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 23/37] read-cache: convert post-index-change hook to
 use config
Message-ID: <YGJpGvqOIPZc+nYP@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-24-emilyshaffer@google.com>
 <xmqqr1kk8yen.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1kk8yen.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 02:22:08AM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > @@ -3070,6 +3071,8 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
> >  				 unsigned flags)
> >  {
> >  	int ret;
> > +	struct run_hooks_opt hook_opt;
> > +	run_hooks_opt_init_async(&hook_opt);
> >  
> 
> Nit. blank line between the last of decls and the first stmt (many
> identical nits exist everywhere in this series).
> 
> >  	/*
> >  	 * TODO trace2: replace "the_repository" with the actual repo instance
> > @@ -3088,9 +3091,13 @@ static int do_write_locked_index(s
> >  	else
> >  		ret = close_lock_file_gently(lock);
> >  
> > -	run_hook_le(NULL, "post-index-change",
> > -			istate->updated_workdir ? "1" : "0",
> > -			istate->updated_skipworktree ? "1" : "0", NULL);
> > +	strvec_pushl(&hook_opt.args,
> > +		     istate->updated_workdir ? "1" : "0",
> > +		     istate->updated_skipworktree ? "1" : "0",
> > +		     NULL);
> > +	run_hooks("post-index-change", &hook_opt);
> > +	run_hooks_opt_clear(&hook_opt);
> 
> There is one early return before the precontext of this hunk that
> bypasses this opt_clear() call.  It is before any member of hook_opt
> structure that was opt_init()'ed gets touched, so with the current
> code, there is no leak, but it probably is laying a landmine for the
> future, where opt_init() may allocate some resource to its member,
> with the expectation that all users of the API would call
> opt_clear() to release.  Or the caller of the API (like this one) may
> start mucking with the opt structure before the existing early return,
> at which point the current assumption that it is safe to return from
> that point without opt_clear() would be broken.
> 
> I saw that there are other early returns in the series that are safe
> right now but may become unsafe when the API implementation gets
> extended that way.  If it does not involve too much code churning,
> we may want to restructure the code to make these early returns into
> "goto"s that jump to a single exit point, so that we can always
> match opt_init() with opt_clear(), like the structure of the
> existing code allowed cmd_rebase() to use the hooks API cleanly in
> [v8 22/37].

OK. I'll audit this second half of the series looking for this type of
thing and try to clean up/use gotos if appropriate/etc. Thanks for
pointing it out.

 - Emily

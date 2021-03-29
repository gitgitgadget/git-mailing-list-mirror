Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2065CC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBC4619A6
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC2Xk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2Xj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:39:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38AFC061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:39:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ha17so6795211pjb.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FOAWWBbOKtoJb60eljqK6RXw7BZpWdEm1wWxRAq9ttw=;
        b=D+gAmrSm9/88hwVCWEGBuW6qpWaF/74f2HYY6kk1ostwjKX8cqBnQhwwwWxcm4gTuL
         UW9RWVeYKoFpTx0HyXLC6oDj00N5lsjE8T6n3qA4OnY4gYrP7PFKSnidm7ewbjMRlF+J
         8Gk7XBlmu2Ct2YzupmJqiZ7A6r5VWlvNjInesMhrhd2p44tVIlyZixL2BAahoD4hI3VP
         FLkJiCkAp32FWMi2DErk3hfze2MMqE+UkipBF/F2SdwgjoKgOMoJLzUprGFSNZgpqr4W
         Wr0ukIiESuF3wvIsWY5GzFYcQ+qeCYbRCUkuhy4QSMqaloTfLoZ8ecz6RbfQF/uF/Vfj
         vWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FOAWWBbOKtoJb60eljqK6RXw7BZpWdEm1wWxRAq9ttw=;
        b=Xo/BsQ9/+uVGdkssQZCcPGXvvCpL25fsYLb17ATusmwMliWpbC+yR95sx5qcDllovE
         YdoLYL59hF8bdkEq9WAJRwby71IqGSyudcy80RbuE9NevwxG1k3clvmBxPUZQik+Go/p
         qCiIkaPlpI6UbNqjEBGtUdeK37aYXmXcdbNQMuJbF+IIXWpSxRQwE5zpFli4GPJgk2nA
         +KUij8wd60eOEl1O4uQbNpsrK8AUq6HoNyfUSglbZTIepled73QGpwiN5tP0XkgJlKR2
         8RiVxjzKFCYLTmZkYJlJtQYD4pKSniS5M8d3oWjgOUCUn0ecGyz1Annk8Wmq1pHhXalK
         3FmQ==
X-Gm-Message-State: AOAM532PLzEbSQwswquxDF2tyoOnW9omxs64H1qsvT42to7xFOXccnuv
        A3IQau39sHNMCcix2297CMY2NQ==
X-Google-Smtp-Source: ABdhPJycZQf/JS32C7LRN7/pY4JB9MBrApBsFcyDTLvaQaRyjdlP0fc/yIxLilJ+bGQ1gxkLMvvKFQ==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr1451360pjq.9.1617061197141;
        Mon, 29 Mar 2021 16:39:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id k27sm16585597pfg.95.2021.03.29.16.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:39:56 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:39:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 19/37] am: convert applypatch hooks to use config
Message-ID: <YGJlR57DGV+KGysB@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-20-emilyshaffer@google.com>
 <xmqqy2es7jro.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2es7jro.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 02:23:39AM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > @@ -1558,8 +1563,10 @@ static void do_commit(const struct am_state *state)
> >  	struct commit_list *parents = NULL;
> >  	const char *reflog_msg, *author, *committer = NULL;
> >  	struct strbuf sb = STRBUF_INIT;
> > +	struct run_hooks_opt hook_opt;
> > +	run_hooks_opt_init_async(&hook_opt);
> >  
> > -	if (run_hook_le(NULL, "pre-applypatch", NULL))
> > +	if (run_hooks("pre-applypatch", &hook_opt))
> >  		exit(1);
> >  
> >  	if (write_cache_as_tree(&tree, 0, NULL))
> > @@ -1611,8 +1618,9 @@ static void do_commit(const struct am_state *state)
> >  		fclose(fp);
> >  	}
> >  
> > -	run_hook_le(NULL, "post-applypatch", NULL);
> > +	run_hooks("post-applypatch", &hook_opt);
> >  
> > +	run_hooks_opt_clear(&hook_opt);
> >  	strbuf_release(&sb);
> >  }
> 
> This one does opt_init(), run_hooks(), and another run_hooks() and
> then opt_clear().  If run_hooks() is a read-only operation on the
> hook_opt, then that would be alright, but it just smells iffy that
> it is not done as two separate opt_init(), run_hooks(), opt_clear()
> sequences for two separate run_hooks() invocations.  The same worry
> about future safety I meantioned elsewhere in the series also
> applies.

Interesting observation. I think the only thing that could be mutated in
the run_hooks_opt struct today is the caller-provided callback data
(run_hooks_opt.feed_pipe_ctx) - which presumably is being manipulated by the
caller in a callback they wrote. But I don't think it hurts particularly
to clear/init again between the two invocations, to be safe - so I will
change the code here.

 - Emily

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F3C433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F9B64DA5
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBVXjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBVXjI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:39:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C90C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 15:38:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b15so635491pjb.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 15:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BOUYXphyAq3eJHIv8q1yW7gsnR514AlgRaFNvic2ZWg=;
        b=EkwwSKt19rCv8XS3x+DARUl+K1/4kopG+hupcS05cqQIa0Pttm1fWyiNYIdnRjv+Yr
         lkCcNFMYmr++Xj5nYKv9A8ZdsH2itfyO0VAJPi1a84HattN80Y10zdX3cogdoa9upTaY
         FovcLrTFa2fzUyRsPf1aZotq+5PgTSTvDSweQcPv8esiY+0muXJVhVYtvgLVYhK/JBfn
         6mjkGdX041CcZOl/BDjhMLSz7uQ+FtoLDlZp4ICey3uqnHBL/8Jc6RWoWC/9CzCYh5uN
         0pzl6rR8wdwMabRSER8mHNNNfAw+57EZWj2phuDGvqYwZZ4K9CZy2N3hLCJtq73sseiz
         iLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BOUYXphyAq3eJHIv8q1yW7gsnR514AlgRaFNvic2ZWg=;
        b=Y7yWgoKwpKgwE4ZKhd6MwBuvtD2mNom/ROzsZpBhjBruD1ORvw7HBmwGV0Q06jwSlV
         3BrwjgSmxg+Q3Tf5gUYBSrSrhqmL2EMhSjZL1ACMJ0zsR7wJyijOy8VII5MO4JbhLic/
         6gVBYKr7oLZAT5pd3KIUs0p1rk8F1AZzmZx+E232FEPEnkmdz9SmqlDRIdyHSOnC6YN2
         efYwRCRSCMLixt7EWpiKyRVXzwXWB6Bwb1ulnfoAxzEZFk4X60dy7j4wERDuOduHH0iW
         qpeGsqAFP32pSEwyGjUsRm7vx98Uq6Jk/rMDljRsLbVv9JsvGt8tymapjpFrmgt/QKIE
         qb0Q==
X-Gm-Message-State: AOAM531HGM3ExCxtB/f4SW/XywNfVSPeo5pcwdagTyNNgH9T6h4faKGn
        7q67GftK5kn6pHN/y0/OAywxgEd+iQq/2Q==
X-Google-Smtp-Source: ABdhPJwDTEKzggxfKhv76wtkmXe9QlG6ea91CHXa+7fa0We1FfDwJBOR/eqekfzhNUuBYQsXFtNUrw==
X-Received: by 2002:a17:902:8c91:b029:e3:d52:9402 with SMTP id t17-20020a1709028c91b02900e30d529402mr24301306plo.21.1614037106388;
        Mon, 22 Feb 2021 15:38:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:398c:f3d9:88c:7d6a])
        by smtp.gmail.com with ESMTPSA id f18sm561043pjq.53.2021.02.22.15.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 15:38:25 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:38:21 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 14/17] run-command: add stdin callback for
 parallelization
Message-ID: <YDRAbcqtWRpVn703@google.com>
References: <20201222000220.1491091-15-emilyshaffer@google.com>
 <20210201065153.1322296-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201065153.1322296-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 31, 2021 at 10:51:53PM -0800, Jonathan Tan wrote:
> 
> > If a user of the run_processes_parallel() API wants to pipe a large
> > amount of information to stdin of each parallel command, that
> > information could exceed the buffer of the pipe allocated for that
> > process's stdin.  Generally this is solved by repeatedly writing to
> > child_process.in between calls to start_command() and finish_command();
> > run_processes_parallel() did not provide users an opportunity to access
> > child_process at that time.
> 
> [snip]
> 
> > diff --git a/run-command.h b/run-command.h
> > index 6472b38bde..e058c0e2c8 100644
> > --- a/run-command.h
> > +++ b/run-command.h
> > @@ -436,6 +436,20 @@ typedef int (*start_failure_fn)(struct strbuf *out,
> >  				void *pp_cb,
> >  				void *pp_task_cb);
> >  
> > +/**
> > + * This callback is called repeatedly on every child process who requests
> > + * start_command() to create a pipe by setting child_process.in < 0.
> > + *
> > + * pp_cb is the callback cookie as passed into run_processes_parallel, and
> > + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> > + * The contents of 'send' will be read into the pipe and passed to the pipe.
> > + *
> > + * Return nonzero to close the pipe.
> > + */
> > +typedef int (*feed_pipe_fn)(struct strbuf *pipe,
> > +			    void *pp_cb,
> > +			    void *pp_task_cb);
> > +
> 
> As you mention above in the commit message, I think the clearest API to
> support what we need is to just have a callback (that has access to
> child_process) that is executed between process start and finish.
> 
> As it is, I think this callback is too specific in that it takes a
> struct strbuf. I think that this struct strbuf will just end up being
> unnecessary copying much of the time, when the user could have just
> written to the fd directly.

Since the rest of the run_processes_parallel() API passes strings around
with strbufs, I'd prefer to leave it as-is to match the general API
expectations and style.

 - Emily

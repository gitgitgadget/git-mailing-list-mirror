Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC2CC47076
	for <git@archiver.kernel.org>; Fri, 21 May 2021 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B4E613B6
	for <git@archiver.kernel.org>; Fri, 21 May 2021 19:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhEUTED (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 15:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhEUTEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 15:04:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B598C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 12:02:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so6508272pjb.4
        for <git@vger.kernel.org>; Fri, 21 May 2021 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k1iEJdPFR/jRWhgWpEyfENLOy3GnPbUDMsv96+qKcDI=;
        b=Iu9yj+w2WvCF3MxuujuyiN92ZxgSRNxH6PbEzf3GGBTkl524uyMY/YJ6tpazUbfqwH
         OUTfmYQjf3+u9LaRIb0YXQHxnSyEgXjHXwVkHhkOYfAcIB4YMNv8J7fQav3vOfnao8lo
         jRtjZkLyCMHeX3p5QY8fHIahCxf16S/GZzZZ4Gu2iullj8zZX5mKem5qe0DChIFYAYba
         M/aMcCugXNq1wARvh8ci8hVsIgnBa9ycZrDEz4ZB8E5mB+J4FWg7F0wMgJdfU5B1hdnT
         P1s73WYh1j5/P0ji/JRC1BeVb19O+pqBncD4dc1rfIluWXxdf771hwTX2uXKHvRq5ABE
         AlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k1iEJdPFR/jRWhgWpEyfENLOy3GnPbUDMsv96+qKcDI=;
        b=PknyHWlV5un2Ss7qSVLQOls6eh56swbY7HzBdjfNets5m1wm4/tWfEpfcao0EwSH19
         xqYabOh4YQWCaUBSmvytaXPvzgri7FsMxd4IFbnkuour7mDSzsO5AltQRv4FSm5PY8/a
         eC+Xk+zOiJUFRqnN6Cgixjs1+IfyX8dMeLlHokEPSEtQl/E3rEur7pNCh+fAQpRFFzem
         FFdLeT5bqtIdYrILKmcGKlXGm5zRblGC2T6Z+Han121u9Fh33Khx3Vl7+S6uh1mpZ6tm
         n9Bp1x6WNDZwb487bBhWoq1ZyAizX1yLryAxlen2OcOh1rf70UbbCvUnpmKCgpBOm9j/
         owhw==
X-Gm-Message-State: AOAM532TO/W5O0eP9mCz3CkDjw2umYgSkN2gCqyzH8/nqoTdOh73Qevh
        779TdL/aElgiWvtFs9QcGTsKUQ==
X-Google-Smtp-Source: ABdhPJxErQEKo0spd7/exO5cN2gLfF94rYvIkSLkimCQ9AajNptAl5dgu9I0uhPZvSwmoozATsft9w==
X-Received: by 2002:a17:902:bd0b:b029:ef:8970:281c with SMTP id p11-20020a170902bd0bb02900ef8970281cmr13365326pls.35.1621623754999;
        Fri, 21 May 2021 12:02:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:ec87:8dd2:f844:6cda])
        by smtp.gmail.com with ESMTPSA id t19sm4756709pfq.116.2021.05.21.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:02:34 -0700 (PDT)
Date:   Fri, 21 May 2021 12:02:29 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] tr2: log parent process name
Message-ID: <YKgDxahhwK/zYznH@google.com>
References: <20210520210546.4129620-1-emilyshaffer@google.com>
 <xmqqpmxksuqa.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpmxksuqa.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 11:09:49AM +0900, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Unfortunately, there's no cross-platform reliable way to gather the name
> > of the parent process. If procfs is present, we can use that; otherwise
> > we will need to discover the name another way. However, the process ID
> > should be sufficient regardless of platform.
> 
> Not a strong objection, but I wonder if seeing random integer(s) is
> better than not having cmd_ancestry info at all.  The latter better
> signals that the platform does not yet have the "parent process
> name" feature, I would think.

Hm, we could; I guess then analyzers could still correlate "all these
things were called by some kind of wrapper, even if we don't know if
that was an IDE or a script or just the user or what, we can guess based
on other heuristics". Ok.

> 
> > Git for Windows also gathers information about more than one parent. In
> > Linux further ancestry info can be gathered with procfs, but it's
> > unwieldy to do so. In the interest of later moving Git for Windows
> > ancestry logging to the 'cmd_ancestry' event, and in the interest of
> > later adding more ancestry to the Linux implementation - or of adding
> > this functionality to other platforms which have an easier time walking
> > the process tree - let's make 'cmd_ancestry' accept an array of
> > parentage.
> 
> Could we rephrase "more than one parent" at the beginning to
> clarify?  I initially had to wonder what "an array of parentage"
> contains (father and mother, or a sole parent and its sole parent,
> which is a sole grandparent).  Since there is no "multiple processes
> meet and spawn a single process", I take it is the latter.  Perhaps
> "more than one generation of" or something?

Good point, will refer to "more than one generation". Thanks.

> > +	if (!strbuf_read_file(&out, procfs_path.buf, 0))
> > +	{
> 
> Place this opening brace at the end of the previous line.

Will polish up this and others for v3, hopefully today.
> > +		if (!names[0])
> > +			return;
> 
> OK, so if there is no name given, we do not show pid as a
> placeholder.

Based on your suggestion above I think it will make sense to show pid as
placeholder after all, though. So I will change that for v3.

> >  	PROCFS_EXECUTABLE_PATH = /proc/self/exe
> > +	HAVE_PROCFS_LINUX = YesPlease
> 
> Have all Linux instances procfs enabled and mounted?  It might be
> that we need to detect this at runtime anyway?
> 
>     ... goes and thinks ...
> 
> Ah, OK, that "try reading from proc/%d/comm" is the runtime
> detection, so it is only this Makefile variable is slightly
> misnamed (it is not "HAVE" but "is worth checking for it").

I wonder what is better. "MAYBE_PROCFS_LINUX"? I don't see any other
vars in config.mak.uname that indicate "pretty sure but not totally
sure" in a quick scan. However, right above this line we seem to feel
certain in our guess about "PROCFS_EXECUTABLE_PATH"...

...but when it is used in exec-cmd.c:git_get_exec_path_procfs(), invoked
by exec-cmd.c:git_get_exec_path(), we're very tolerant to faults if it's
not there:

  static int git_get_exec_path(struct strbuf *buf, const char *argv0)
  {
  	/*
  	 * [snip]
  	 * Each of these functions returns 0 on success, so evaluation will stop
  	 * after the first successful method.
  	 */
  	if (
  #ifdef HAVE_BSD_KERN_PROC_SYSCTL
  		git_get_exec_path_bsd_sysctl(buf) &&
  #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
  
  #ifdef HAVE_NS_GET_EXECUTABLE_PATH
  		git_get_exec_path_darwin(buf) &&
  #endif /* HAVE_NS_GET_EXECUTABLE_PATH */
  
  #ifdef PROCFS_EXECUTABLE_PATH
  		git_get_exec_path_procfs(buf) &&  /*** <- OK if fails ***/
  #endif /* PROCFS_EXECUTABLE_PATH */
  
  #ifdef HAVE_WPGMPTR
  		git_get_exec_path_wpgmptr(buf) &&
  #endif /* HAVE_WPGMPTR */
  
  		git_get_exec_path_from_argv0(buf, argv0)) {
  		return -1;
  	}
  
  [snip]
  
  #ifdef PROCFS_EXECUTABLE_PATH
  /*
   * Resolves the executable path by examining a procfs symlink.
   *
   * Returns 0 on success, -1 on failure.
   */
  static int git_get_exec_path_procfs(struct strbuf *buf)
  {
  	if (strbuf_realpath(buf, PROCFS_EXECUTABLE_PATH, 0)) {
  		trace_printf(
  			"trace: resolved executable path from procfs: %s\n",
  			buf->buf);
  		return 0;
  	}
  	return -1;
  }
  #endif /* PROCFS_EXECUTABLE_PATH */


So it seems this other procfs bit takes the "probably but not
definitely" step and is tolerant at runtime as well. Which doesn't help
me much to decide how to rename HAVE_PROCFS_LINUX.

I'll switch it to MAYBE_PROCFS_LINUX for v3 unless someone yells, I
guess.

 - Emily

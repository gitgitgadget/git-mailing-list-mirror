Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF541C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3082076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MKZpOKO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633147AbgDNUbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633142AbgDNUbG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:31:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E00C061A0E
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:31:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu11so5702586pjb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=apdGjphPGUhVveY1nlw/K5r3tMOswtUTcKPQSxUNrh8=;
        b=MKZpOKO5tuM1O4DQ8P1gkcB4b4jTJyNAGRar+xaG+O7S/VK6cA99rnN+85uUHP+S+2
         Q7dx3uBIsTnXshLI5QjyXEQWqsSKXET9HL6dOoOFlWI7H4lkZ8WEByanzSNUQDlQm25h
         cbnKxvU3w11vsnhw+mN8dyTKfLPRxQX6C+K9WLlxclAajt1+crFoa2/CTc/yod67fGcW
         RZqoU7f2D1SpsMlgduYngNxKQXrN7cgUhIoWOytd6SLHxtVJejGPaRBL4EMN+1z2mR7S
         uzWVt2HVrbzVS+pXRw7FZompDIIrMIJ3d+zjTFjz5qd3RjGEqk8wcV7wWoFetoBkVrFG
         7Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=apdGjphPGUhVveY1nlw/K5r3tMOswtUTcKPQSxUNrh8=;
        b=ORR3eIAgFYkO3U5lbvuZ9ZXMAjddzUeXVVG6B/QVG8CXDQojQedbo+t3LBUQxQDGi9
         5MCDx97ew8xoKKHVLD/bxzrz12d5xmeq1kJjE9tMWfo50rnwFcDOSnMuin5Tf7oiTdKw
         HPnMUn24qPP8JGo6jE0VWShtMILMEXl3Oj+vBPfSp3YFyBfig8LuDBjSIPQfqy50BdMn
         XoZgAIqF99fAmuXTkfRs6rREG/ORdm+QNn9EY54G1E1k9Uj6VEMUO2GPTNmkjv4LnJCZ
         FMw43HjVuzEm6Ky3RtpsE/qa92F2lERlhz63dtYfEwMeMO8+8a+0+eE06V5EcrMYkbnn
         1lsQ==
X-Gm-Message-State: AGi0PuYxAglm+MZ8dJXruxTL6I9XG+1D/dV8+SJs/v99X3NexKg++b6E
        WSOdUSkkl/7AkGkg6qUwG+18tg==
X-Google-Smtp-Source: APiQypKp0aKcN6NwYEwJMBFp3usH/gabEV9+I8FDCJsB85k7bYvdKHbvu7cLQQ8G4XyzeW6Q/fgFPw==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr1677107ple.102.1586896263981;
        Tue, 14 Apr 2020 13:31:03 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u16sm10532011pgf.52.2020.04.14.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:31:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:31:01 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
Message-ID: <20200414203101.GE93424@syl.local>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 01:22:45PM -0700, Elijah Newren wrote:
> Hi,
>
> I was building a version of git for internal use, and thought I'd try
> turning on features.experimental to get more testing of it.  The
> following test error in the testsuite scared me, though:
>
> t5537.9 (fetch --update-shallow):
>
> ...
> + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> remote: Enumerating objects: 18, done.
> remote: Counting objects: 100% (18/18), done.
> remote: Compressing objects: 100% (6/6), done.
> remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
> Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
> From ../shallow/
>  * [new branch]      master     -> shallow/master
>  * [new tag]         heavy-tag  -> heavy-tag
>  * [new tag]         light-tag  -> light-tag
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5
>
> Passing -c fetch.writeCommitGraph=false to the fetch command in that
> test makes it pass.

This failure makes sense, since taking the reachability closure over
the ref tips will fail in shallow clones of repositories that have more
than one commit.

I wonder if fetch should be taught to avoid generating commit-graphs
(and ignore 'fetch.writeCommitGraph') when in a shallow clone.

> There were also a couple other tests that failed with
> features.experimental=true (in t5500), but those weren't scary -- they
> were just checking exact want/have lines and features.experimental is
> intended to change those.  This test from t5537 was the only one that
> showed some unexpected fatal error.
>
> Thanks,
> Elijah

Thanks,
Taylor

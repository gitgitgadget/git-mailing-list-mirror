Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B2C64EC4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCGAke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGAkd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:40:33 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF03B22B
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:40:32 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p13so7601091ilp.11
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678149632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUJSQt9tCTviLOiLNW1TWEOs7z3sxijV16EiVZ3tgXs=;
        b=uvc4gNy4RWKYf5lg+iL3ukRthhteNOdn9Wk5aWTix5iJzZwH0J/lL3BWE+CH200/YH
         e7XPeY5Ved1MlcUHz4KSTpcIW6m95DfdoRZzi4Aq+aa71TXtKf5mogX92tA+0mJWwh7L
         6O+MaLZUFhN0h8Q+k5M+cl+hL9fd2/6fVDsAKpt5WrdKZdjWFPtVMjJRLZhp+Xwbv4WW
         BjYQh1/0Fkg6f5l0hTuLobs5j9qI921t7+eQaY+pW4zP8/8s9zfVn8nLh879g15Ha/4K
         51JBGzUroLogOcmWqF0S7ZODN7yZdXjDhUI5vW9sZxvxP9+dPjVliO6C5n4J49tv6DFR
         E0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678149632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUJSQt9tCTviLOiLNW1TWEOs7z3sxijV16EiVZ3tgXs=;
        b=1o1pAPottUwtU05Qc/Wzt9MCUJ4sp5xt34huxLZg/flYhlEXO8WcY9DJXTTdDzQBEb
         y27CR9/kBQi/Zo7eRjB4QbcrHo9EEZ0j8j2uPjc/hEtlA2rLafUS4xAyaGJOyH1igv/Y
         VnNLNyP1fWtQ2FaCyF7pAxbNjycZ8YK3BsGZdxKsXqzJzV/FppLbmcNV8yrWNUm9XBBO
         LLSfwm37g1q/ockaPg8+jCpVU8QGM51R6Js0JDXG1bJhbessDTidQlP55EqUs9CeqBjo
         tZZhdj2uMclNyRG4cKYKfowwIez209EkbQP4VwZGFDO1Ce/28Z245jYutbcSzjXSFyZ/
         b05w==
X-Gm-Message-State: AO0yUKWaXAMl+2pT4uI8EJtxzCujqKlfHQY08kE7nvRVEXsk0/ivBYQB
        IwwFPvrqUajh3dOh6rNAq4b4/g==
X-Google-Smtp-Source: AK7set9BLveZT9aDEk/L0D40iKs/vH4ZNplJ7e99LEbZ89olkwIo5UZxq2H9XFf5O7sTmv29TOctWQ==
X-Received: by 2002:a05:6e02:1a05:b0:317:106c:649c with SMTP id s5-20020a056e021a0500b00317106c649cmr10581964ild.27.1678149631924;
        Mon, 06 Mar 2023 16:40:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r1-20020a028801000000b003b39dcca1dfsm3650432jai.170.2023.03.06.16.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:40:31 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:40:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/8] ahead-behind: create empty builtin
Message-ID: <ZAaH/iCsqdewYrUj@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <0fd18b6d740f1e8a6f62a25947bc3ad49c2674a6.1678111599.git.gitgitgadget@gmail.com>
 <xmqqzg8p90mq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg8p90mq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 10:48:45AM -0800, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > For example, we will be able to track all local branches relative to an
> > upstream branch using an invocation such as
> >
> >   git for-each-ref --format=%(refname) refs/heads/* |
> >     git ahead-behind --base=origin/main --stdin
>
> Stepping back a bit, this motivating example makes me wonder if
>
>  $ git for-each-ref --format='%(refname) %(aheadbehind)' refs/heads/\*

One disadvantage to using for-each-ref here is that we are bound to use
all of the ref-sorting code, so callers can't see intermediate results
until the entire walk is complete.

I can't remember enough of the details about the custom traversal we use
here to know if that would even matter or not (i.e., do we need to
traverse through the whole set of objects entirely before outputting a
single result anyway?). But something to think about nonetheless.

At the very least, it is quite a cute idea (especially something like
'%(aheadbehind:origin/main)') ;-).

> that computes the ahead-behind number for each ref (that matches the
> pattern) based on their own "upstream" (presumably each branch is
> configured to track the same, or different, upstreams), or
> overrriding @{upstream}, a specified base, i.e.
>
>  $ git for-each-ref --format='%(refname) %(aheadbehind:origin/main)' refs/heads/\*
>
> would be a more intuitive interface to the end-users.
>
> It would probably work well in conjunction with
>
>     git for-each-ref --format='%(refname)' --merged origin/main refs/heads/\*
>
> which is a way to list local branches that are already merged into
> the upstream, to have the feature appear in the same command,
> perhaps?

One thing that we had talked about internally[^1] was the idea of
specifying multiple bases. IOW, having some way to invoke the
ahead-behind builtin that gives some set of tips with a common base B1,
and another set of tips (which could--but doesn't have to--intersect
with the first) and a common base to compare *them* to, say, B2.

There are some technical reasons that we might want to consider such a
thing at least motivated by GitHub's proposed future use of it. But they
are kind of technical and not that interesting to this discussion, so I
wouldn't be sad if we didn't have a way to specify multiple bases.

OTOH, it would be nice to avoid painting ourselves into a corner from a
UI-perspective if we can avoid it.

Thanks,
Taylor

[^1]: ...and couldn't decide if it was going to be a nice future
addition or simply another case of YAGNI ;-).

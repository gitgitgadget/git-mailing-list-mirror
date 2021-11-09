Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A3C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358F4610C8
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhKIQtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbhKIQtP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:49:15 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A1C061767
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 08:46:29 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id l19so21349083ilk.0
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 08:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7TKbDTV6/dW+IpANgmIU5mb05jw48+/YGLvQaYeqHCw=;
        b=U8C1uThUdmPNnV7eOd4t+ClCr8brZxCzRwghcv66zKtaMiVrVw/gh/R80a38f0gYgG
         7saSKGi7t/J3sZQtOejpf6Z8FObfpQKvQdiE7rQOadcTzXHcPZjkQJ8FBu75/YFusMTF
         JmYHuUzZaW4lS4iXMZaMBXFpRzpjEvry1HYt5yTz2R5U9gBIOLByXYdThBOt9+EXHsVY
         lslY7yMRWSep0nziEKN/Z6e+jjCQLoHRWoSqCFn5dBlLJDnKNCSqh0trzpE62M97eJzV
         nQcQ9Zq5wP1jQIC+GvOGGdYhJhNJ56rtcp2mCiyoT/s+UE2CxTbkaLSCehqMGhveqGNI
         u4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7TKbDTV6/dW+IpANgmIU5mb05jw48+/YGLvQaYeqHCw=;
        b=7/F0cwXIA48ajZG7IjJxLLRRHiVLnxb29fLLtUjio4bI1/9/IeJ1I4a+alxet/qn3j
         t6zCpBRPriNgSvoUNvfVEoP+aGTS1xj++xo0S4ZurcOTfmRzkG9r008igRsjhDIvi9MM
         8n2ovss64dJZlJgh6QxrgKwKHBuGs2FWickhW3nd14y+I4PjX9lT00I3L9y7NhScXM5l
         wEpuyhZL4hmFZTr3u3jFGc2/nCSmD1RwwdFItzCiFODEUaulTn0TQmDc/mQnnMHZntkW
         /qImP0/KyqlAhnZj3ZMu4Xr2dVZfXA/7sderFcOuaQpw36WqTGl7jxRL+Pz5IFYy95/U
         126Q==
X-Gm-Message-State: AOAM531LdwkK4aw6YnDtAu0+jXBcH4ihKfXpX0tXqrf49OK4sn+UEP6Q
        0UCmeHEXmBi7AZi9NJEPk1tmoQ==
X-Google-Smtp-Source: ABdhPJzbU9KDRDS8FH/8I3cU14TQ7j5XvaLmWufrehKDLLXQOD5uPt4ZFFQgpiH5mb2eUnP3G65EMg==
X-Received: by 2002:a05:6e02:1a4c:: with SMTP id u12mr6203410ilv.104.1636476388336;
        Tue, 09 Nov 2021 08:46:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h17sm10836200ilj.69.2021.11.09.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 08:46:27 -0800 (PST)
Date:   Tue, 9 Nov 2021 11:46:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-jump: pass "merge" arguments to ls-files
Message-ID: <YYql4uR39putmHP7@nand.local>
References: <YYqjY/zcBWyqY8/5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYqjY/zcBWyqY8/5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 11:35:47AM -0500, Jeff King wrote:
> We currently throw away any arguments given to "git jump merge". We
> should instead pass them along to ls-files, since they're likely to be
> pathspecs. This matches the behavior of "git jump diff", etc.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just a little wart I noticed while doing a really tricky merge today.

This is hilarious to me, because I wrote the exact same patch to skip
some conflicts while resolving what I can only assume is the same merge.

> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 931b0fe3a9..92dbd4cde1 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -39,7 +39,7 @@ mode_diff() {
>  }
>
>  mode_merge() {
> -	git ls-files -u |
> +	git ls-files -u "$@" |

It's kind of unfortunate (maybe not?) that a caller could now run:

    git jump merge --no-unmerged

and get the same results albeit *much* slower. We could limit ourselves
to only accepting pathspecs (by writing `git ls-files -u -- "$@"`), but
that feels overly restrictive. We could also say `"$@" -u`, but that
breaks if the caller writes `--` or `--end-of-options`.

So I think that what you and I both wrote is least bad, but it does make
me cringe a little bit at being able to pass `--no-unmerged` to `git
jump merge`.

Anyway, I know that it's late in the -rc cycle, but I'd be happy to see
something like this get picked up once Junio tags 2.34 and we have
stabilized a little bit.

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FC0C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 23:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiBOXu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:50:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiBOXu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 18:50:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB6C4E25
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:50:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k25so682389ejp.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=my/vUW7fhoaKsdTOU8Gx+osMmdELthi7XiAH/bkFUSU=;
        b=chv1JH15gpD5VkRNcRCrUD7utx/eOKyV5G0ZLE1I6+11Z3j2sOt2feOMqQCinvfw7u
         g65V8Pjk9cUG+k7NDK29uww6k1fMsjObXyPChsAfn0ug33JvSvandeup8/isouYhyIb4
         P9XbKKKrt7RJTsZ17j3Kb4jEa7vGO7Y+hclIEY4q6Hauk7v9b6CZNH1nFbkUwJ6EzkJ6
         RIxKVmMBxwFnbap8Q72O9q1Zhw5kCuyBKu7KOFP/OhGjSu+g+xG+3DVVB43LQ4Aia4sI
         WboOLQ9JVkn+BpopXtQJtssLvbhrLS/09a3wrYaECqEeUMBJps5I++qX7bs2lzXG17H1
         urBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=my/vUW7fhoaKsdTOU8Gx+osMmdELthi7XiAH/bkFUSU=;
        b=KbuBz2MN9ToR0k5P6n3D0M9hzMpccDENjLgjMsxeXG7z2jl9qEKW4vszylcTFLeTs8
         O+0JEpugcdqjbDqgcauKu1iS8m9/oe8rzwxxkQZAgb1Mbx21p1ahgDo1XUUmVAgE1640
         3w/I/h5OcmCYC501SqcUg+kcUfw9e0kS5zG/yZhzGNIB3m8TF4EIXgAxLZ03g2RzHbhc
         iMoDUVy7VRMIX80EVVr2D2JJ0CL0TTQa1GB/nvQKvn//XtVeIMNNr7AYRWTzN1721FaU
         WySsjT69KYLsFXwCiYz2bLRBvJNIpxBTUVjdAyjz8/gt7pxYQ77MlP/mEwEEzAKkVVMv
         De+g==
X-Gm-Message-State: AOAM531WdTYtpxCWMF0U+8iSUmnL0204uvsTZkG8nume8BS9Ct1WgHIt
        Uy0IODXz0AiLX+weFK25CSaWLWe4gAc=
X-Google-Smtp-Source: ABdhPJw2exwvp0pFxN+K5rcI+v3AzHHSkXlDfC6saEFWQ4kZgfEUH49Tr+u8USFNAh8Cz1yUKnpdCw==
X-Received: by 2002:a17:906:6b8e:b0:6cd:7d22:e5b6 with SMTP id l14-20020a1709066b8e00b006cd7d22e5b6mr285081ejr.259.1644969015373;
        Tue, 15 Feb 2022 15:50:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t21sm705268edd.74.2022.02.15.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 15:50:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK7aI-002yxc-9q;
        Wed, 16 Feb 2022 00:50:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
Date:   Wed, 16 Feb 2022 00:40:02 +0100
References: <20220209012951.GA7@abe733c6e288> <20220209013354.GB7@abe733c6e288>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220209013354.GB7@abe733c6e288>
Message-ID: <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 09 2022, Edward Thomson wrote:

> Provide an indirection layer into the git-specific functionality and
> utilities in `git-xdiff.h`, prefixing those types and functions with
> `xdl_` (and `XDL_` for macros).  This allows other projects that use
> git's xdiff implementation to keep up-to-date; they can now take all the
> files _except_ `git-xdiff.h`, which they have customized for their own
> environment.

It seems sensible to share code here, but...

> +#ifndef GIT_XDIFF_H
> +#define GIT_XDIFF_H
> +
> +#define xdl_malloc(x) xmalloc(x)
> +#define xdl_free(ptr) free(ptr)
> +#define xdl_realloc(ptr,x) xrealloc(ptr,x)

...I don't understand the need for prefixing every function that may be
used from git.git with xdl_*. In particular for these memory managing
functions shouldn't this Just Work per 8d128513429 (grep/pcre2: actually
make pcre2 use custom allocator, 2021-02-18) and cbe81e653fa
(grep/pcre2: move back to thread-only PCREv2 structures, 2021-02-18)?
I.e. link-time use of free().

Of course trivial wrappers would be needed for x*() variants...

> +#define xdl_regex_t regex_t

This is a type that's in POSIX. Why do we need an xdl_* prefix for it?

> +#define xdl_regmatch_t regmatch_t

ditto.

> +#define xdl_regexec_buf(p, b, s, n, m, f) regexec_buf(p, b, s, n, m, f)

But this is our own custom function, which brings me to...

> +#define XDL_BUG(msg) BUG(msg)

...unless libgit2 has a regexec_buf() or BUG() why do we need this
indirection? Let's just have xdiff() use a bug, and then either libgit2
will have a BUG() macro/function, or it'll fail at compile-time.

This seems to at least partly have been inspired by git.git's
546096a5cbb (xdiff: use BUG(...), not xdl_bug(...), 2021-06-07), i.e. we
used to have an xdl_bug(), but now we just use BUG().

I then see on your libgit2 side 1458fb56e (xdiff: include new xdiff from
git, 2022-01-29).

But why not simply?:

    #define BUG(msg) GIT_ASSERT(msg)

It would make things easier on the git.git side (etags and all).

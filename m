Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97983C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 12:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7314561B95
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 12:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhKQMkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 07:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKQMky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 07:40:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5319BC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 04:37:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so10289006edd.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 04:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+8nyIJI8eyvqVsK6sCmTox0z+TNcIXDF45cmm+girAg=;
        b=L9dN/Gm1GasWE3unvU4WkY6suVS9/f4uRm5MO1NLjtpU9YeXqyRkoa6RXl6uec/Ki5
         jQeeeFcBFxRy5NJ37Y3kUfpInXXXcSjk+3JHcmrt8BHDLItTBN5LZgWmL+S5k+Sw1y2t
         BBs/yFNE+Q3abC+Q63wrIiMrcUb6QsKeMipA1r/sp/NE8qx/Bhurpc61iU0TtvfEglcX
         yEthBe7+ka+nAp7GW72BFVhDMBNB18X2st9aHz32GtbKPsMlZb90mTs4ZdCH8jEQFA27
         S/tWYHxs5eBAZrYs6mYkD1klIlXnHHwqYXIuwa0HFAQTNqgoxFI+hUkZ4v4wFYbBJsIa
         Q3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+8nyIJI8eyvqVsK6sCmTox0z+TNcIXDF45cmm+girAg=;
        b=g33+brI+mCxgkxL8ZDkuQlmdPwx0e57ZZBwgRAPz9/yxakGM3BlZnl7aWLRAlgf4dr
         WIDGqEZPsnGpfvw1ke2DW1pSl+3qYkZhVdcJmL3C1Yfz5OUff8qsM6jZEr1+hE2KhR+b
         cKbw9s+9CQ0fROiGmm8Wqs6V1u8K1LDSHcthQrZahrfmT6fmGGMYnQ5DRrtQlSxNCfNf
         ejXY2rEs3Xd9ZWXytKPWFGbjHNqnVe8Ns/BkibY3YUaBACtcjmuNVYYoFuMiT9V+SUJN
         soEGocMzoXvmyDhc++Lzh7ovmT/07AJJc4WkTIRmX5uJjhYzo6DygDWryByfvFn+UqUx
         bNCg==
X-Gm-Message-State: AOAM53014TSNj8pZCZRgEdDCFXh3B1AH9SfsHFIw9JoENwQQUKotW0Fy
        u0WVCHk21QPliqDNfJnV9tJyu8wEpyjEYA==
X-Google-Smtp-Source: ABdhPJx/hDhL4z6s4FHRhWXEPF0YoAKm0/I14cCIeQfdhN/RWCIlgrYxkm9AVJqZA1lnznpnlr5qrg==
X-Received: by 2002:a17:907:1b16:: with SMTP id mp22mr21903776ejc.503.1637152674792;
        Wed, 17 Nov 2021 04:37:54 -0800 (PST)
Received: from gmgdl ([109.38.148.220])
        by smtp.gmail.com with ESMTPSA id d10sm9627375eja.4.2021.11.17.04.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 04:37:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnKCG-0008iP-G3;
        Wed, 17 Nov 2021 13:37:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Wallace, Brooke T (US 349D-Affiliate)" 
        <brooke.t.wallace@jpl.nasa.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Config spec for git
Date:   Wed, 17 Nov 2021 13:32:18 +0100
References: <D5EE9939-F639-4E69-BD81-10B05EC43A8E@jpl.nasa.gov>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <D5EE9939-F639-4E69-BD81-10B05EC43A8E@jpl.nasa.gov>
Message-ID: <211117.86fsrv6jq7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Wallace, Brooke T (US 349D-Affiliate) wrote:

> Has any one considered adding a config spec feature to Git or does Git alreadt have some way to support the same features?
>
> I've been using Git for a while now for small projects but taking on a
> new larger project I've come to realize that Git does not have config
> specs and so seems to be missing an important feature for managing
> large projects.
>
> We use configuration specs to select directories from a common code
> base (repo) and map them into different baselines to creat multiple
> product builds with different feature sets. We used this feature in
> VCSs such as Clearcase and Perforce. Ultimately this allows us to
> manage the repo in one directory structure and create product builds
> with a different one. For example the repo has multiple directories
> for different products/targets, but a baseline, the workspace, has
> only one target directory always with the same name mapped to the same
> location. Obviously the corresponding directories in the repo have
> different names.
>
> Git supports the notion of submodules, but I see no way to map a
> submodule directory to a different name, remove unwanted subdirs of a
> submodule, or map a submodule over a subdirectory of the primary
> repo. Config specs also allow you to specify a specific branch or
> version that you want to map to your workspace independent of other
> directories, branches and versions.
>
> I suppose it may be possible to achieve the same result by treating
> the primary repo as the configspec. But I feel like there are some
> features config specs support that i do not have using submodules, but
> might need down the road.
>
> I can see that omitting, obscuring, or overwriting parts of a repo
> would not play well with the commit id. So I imagine there could be
> some real complications trying to add support for the notion of a
> flexible config spec.
>
> Appreciate any comments/feedback

I understand all the terms involved in your E-Mail except "config spec",
so on the first couple of readings I was thoroughly confused.

I gather from some Google searching that you may be referring to
ClearCase SCM jargon:
https://en.wikipedia.org/wiki/Rational_ClearCase#The_configuration_specification
&
https://www.ibm.com/docs/en/rational-clearcase/8.0.0?topic=views-how-config-spec-works

From your description it seems like you're talking about some
combination of the work-in-progress "sparse checkout" feature, and a
feature to compose arbitrary subdirectories and overlays of existing
repositories.

As far as I know nobody's working on the latter, although I suppose some
clever combination of submodules and sparse checkouts might make it
possible.

All of that's really a shot in the dark, I think I'm probably not the
only one who'd benefit from a description of what you'd expect a "config
spec" to do for you that doesn't assume pre-existing knowledge of the
term.

More generally it's a very common initial migration stategy between
SCM's and X SCM -> Git in particular to first consider how you could 1=1
map existing behavior to Git.

Those sorts of migrations are generally much more painful in the longer
term than considering how you'd map the software or assets you have to
Git if you were starting out today, which may be something to think
about.

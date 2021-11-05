Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D56CC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 20:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A64160F5A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 20:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhKEU12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 16:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhKEU11 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 16:27:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3EC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 13:24:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id iq11so3795427pjb.3
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JTc4SL4E1tBqA9JO0d/cRmax2PfGJ/etdT8kYhWh74g=;
        b=Y+9W2Wb16ons6tmPlThryUr181M/FU41CAhmw3nKoq+fztB7PYWGbDDlreQxDCBR+x
         xJQaxBySQRlD7aelcmJ5Y0ox89vZL2oFHU/n0/paRari0ldqMPakqjqbI09m7VQSiFuR
         3G9YX4qB9eMDB13F0BDPOrGnKELss127a/5XmjRZHByBmdHNEYOyhh0I5Qn9Lcu5rk8O
         f88wcFvbYfYm45bTSYv9U6tEr3nIOycCGvMOYCtHDld4ZixCWvOHNGex3naJMr0UsK4i
         XtlncbkkmaZ51PAVkhhl86ABlJkmwOzMRqFq6yjl5fn+g5HUxRKcRXU/34Q0e/pdwaeh
         U5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JTc4SL4E1tBqA9JO0d/cRmax2PfGJ/etdT8kYhWh74g=;
        b=UMVJbePzr0emEXoJGEZIbyyHLx+7wcbtzkLHD5STMdb0siISNYP5O+loj5IyZ9a8Qz
         yTr6/iTBJILa697aq6gI9nUvGQXabM1iQWUvoJ29kqHbfyiwi+C0J2ZWZiVSqCgQ8RCr
         C2Esb7R+8UteHpW6+bsIyM/yrDUrhacUyz/hqjTNwtClg4om07jLfgiG+o1gU5Qaxdaa
         gibebr5vpynxUHuZpA4ZPKBdzHGpGUHbnXRWpfjRIW3zYRGOsS1iwWZeitVIirCBTytR
         nG1W4VscHNk9BkFoBAkNSlzGzxaN49RuUp9GeaIAh3McMYPvTzsQyjKWUhM4bN/Ze2nA
         6soA==
X-Gm-Message-State: AOAM531rD3xfhL1RAwJCK0qduhuHcIfFdMeaFA1hJV/8WJBRtOwH8enT
        tL+keJE8JyRHECNrHsWLp6VMHA==
X-Google-Smtp-Source: ABdhPJyFPeKtkPLtdnRjbRJtEbyIQeB+nrkd6BUTr1VoLc8Ih8sYNbCRvLLFg2391sx7xrrTHYsi+g==
X-Received: by 2002:a17:90a:4509:: with SMTP id u9mr33342314pjg.79.1636143886798;
        Fri, 05 Nov 2021 13:24:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2b10:976d:eb88:7e7f])
        by smtp.gmail.com with ESMTPSA id ne7sm10382986pjb.36.2021.11.05.13.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:24:45 -0700 (PDT)
Date:   Fri, 5 Nov 2021 13:24:41 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [WIP v2 2/2] config: include file if remote URL matches a glob
Message-ID: <YYWTCcAljHQRTJQ/@google.com>
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1635527389.git.jonathantanmy@google.com>
 <3c0d51ee39b8e149b5be57b8cd3f8cd403fe49c9.1635527389.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c0d51ee39b8e149b5be57b8cd3f8cd403fe49c9.1635527389.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 10:31:10AM -0700, Jonathan Tan wrote:
> 
> This is a feature that supports config file inclusion conditional on
> whether the repo has a remote with a URL that matches a glob.
> 
> Similar to my previous work on remote-suggested hooks [1], the main
> motivation is to allow remote repo administrators to provide recommended
> configs in a way that can be consumed more easily (e.g. through a
> package installable by a package manager).

To expand a little more on this:

At Google we ship /etc/gitconfig, as well as /usr/share/git-core/. Our
/etc/gitconfig looks basically like:

 [include]
   path = /usr/share/git-core/gitconfig
   path = /usr/share/git-core/some-specific-config
   path = /usr/share/git-core/other-specific-config

Jonathan's WIP allows us to append lines to /etc/gitconfig sort of like

 [includeIf "hasRemoteUrl:https://internal-google/big-project"]
   path = /usr/share/big-project/gitconfig

That's approach #1 to shipping a config, which we might use for a
project that makes up a significant portion of our userbase. We ship
(and own) the /etc/gitconfig; BigProject team ships and owns their own
gitconfig; everybody internally who works on BigProject, whether it's
just once to fix a small thing or every day as their main job, gets the
relevant configs for BigProject.

Approach #2 I think is also still a useful one, and maybe more
interesting outside of Google:

When I run 'sudo apt install big-oss-project-devkit', a few things
happen:
1. /usr/share/big-oss-project/gitconfig appears
2. `git config --global \
		'includeIf.hasRemoteUrl:https://github/big-oss-project/*' \
		'/usr/share/big-oss-project/gitconfig'` is run
3. whatever other special tools, scripts, etc. are installed

That way regardless of which project I'm working on -
big-oss-project/translation, big-oss-project/docs,
big-oss-project/big-oss-project - I still get configs and style checkers
and whatever else.

With this approach #2, it's still possible for someone to do a drive-by
contribution without ever running 'apt install big-oss-project-devkit',
so it's not quite as strong a recommendation as the former
"remote-suggested-hooks" topic. User would still want to take a look at
the README for big-oss-project to learn they're supposed to be
installing that package ahead of time. But it's still a oneshot setup
for nice things like partial clone filters, maybe sparsity filters,
maybe config-based hooks, etc., especially if big-oss-project already
was shipping some project-specific tooling (like maybe a special
debugger or a docker image or I don't know).

The nice thing about 'hasRemoteUrl' in this case is that we don't need
to know the location of the user's big-oss-project/ checkout on disk. We
can set that config globally and they can checkout big-oss-project as
many times and as many places as they wish. It wouldn't be possible to
ship configs via a package manager or other automated script without it.

> 
> NEEDSWORK: The way this works is that if we see such an include, we
> shunt all subsequent configs into a stash (while looking for URLs), then
> process the stash. In particular, this means that more memory is needed,
> and the nature of error reporting changes (currently, if a callback
> returns nonzero for a variable, processing halts immediately, but with
> this patch, all the config might be read from disk before the callback
> even sees the variable). I'll need to expand on this and write a
> documentation section.

Hm. I'm not so sure about making another structure for storing config
into memory, because we already do that during the regular config parse
(to make things like git_config_get_string() fast). Can we not re-walk
the in-memory config at the end of the normal parse, rather than reading
from disk twice?

I think git_config()/repo_config() callback even does that for you for free...?

2304 void repo_config(struct repository *repo, config_fn_t fn, void
*data)
2305 {
2306         git_config_check_init(repo);
2307         configset_iter(repo->config, fn, data);
2308 }

> 
> One alternative is to rerun the config parsing mechanism upon noticing
> the first URL-conditional include in order to find all URLs. This would
> require the config files to be read from disk twice, though.

What's the easiest way to "try it and see", to add tooling and find out
whether the config files would be reopened during the second parse?
Because I suspect that we won't actually reopen those files, due to the
config cache.

So couldn't we do something like....

pass #1:
 if (include)
   if (not hasRemoteUrl)
     open up path & parse
 put config into in-memory cache normally
pass #2: (and this pass would need to be added to repo_config() probably)
 if (include)
   if (hasRemoteUrl)
     open up path & parse
     insert in-order into in-memory cache
 don't touch existing configs otherwise

I think it's in practice similar to the approach you're using (getting
around the weird ordering with a cache in memory), but we could reuse
the existing config cache rather than creating a new and different one.

 - Emily

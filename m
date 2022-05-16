Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330BC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 22:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbiEPWoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 18:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348783AbiEPWoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 18:44:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFFB3F334
        for <git@vger.kernel.org>; Mon, 16 May 2022 15:43:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id p4so13160679qtq.12
        for <git@vger.kernel.org>; Mon, 16 May 2022 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nu3UYcIglhvl8XKA5srtTxgBewsUNXPFm1r7U9OJLng=;
        b=ixzxHERBxbecM+F8+z1Tg2NSVogNa+bmAn5/YM9imQ3f4QfiCNiNKFhJ4zEypi05kg
         jMtatV1xB4sThesuM6LoSxwZV6Sinrkk3yUWDVlQZcK0+8pwQaFmD64pKqRqW5L5g+LU
         me84Qc2M6SBcGTVB484ZNr6Y5c7/Neqqybv/4ygx6Dhec9JVEZ0vvHZQEzVSzNtdrHSI
         oCem06xm8+CWdYBhxR2kfmp/tkuPhWJkFP8RfnCvB2ELYRX/Y3lkEzbccWJuYH/YhBYw
         PhD9jrl+RgLWHcoJhNKgWr8k3NZicRkbvk3L74m15koRUSa/bWsNfU3vwiXqD9+CloeO
         n2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nu3UYcIglhvl8XKA5srtTxgBewsUNXPFm1r7U9OJLng=;
        b=1WuoNsUqjXTir3GdwNqVSC/WwQ3r+eQdrSZ28SYQsCX0CAS8UuiOI20WdGo3JUqxU4
         KP+fwfW4O29dHjl/1JdMbCje038kMc6cvnJdUzJ6a55xW43KkouSJwrbgZhdnws10+YR
         IMy/Hr4vo3Xk0frR/zYXvnKWxmZMrvp2PjYIUXBGDfsHpKcLf2Rix2v0mzRyhaGxz9cS
         5vZS5vOY2yAysytLIZ450iaqv0hyo/XGwWXpJaLZTRfw6wopB5B9qCZf21dLJFRR/ITO
         mR4fYnurEAcRgIpVfRC1qKzmDTMdnhU34bpCJBIZAkqZtghGDMB0kqPMae3LlTLBASS6
         HfUQ==
X-Gm-Message-State: AOAM532g6un2o1tHATpOUck+wGhZAruMZxDpqMCgdej7J8SnF0Hl3Fbk
        L7NBM/cYCeWewqjZh8t4FjpvXw==
X-Google-Smtp-Source: ABdhPJyrBfg25+5SZWbzqba620G71DN+gPMXpQhto87GAdzZgS9bdi9c5clR+8dIjdclKgqztC1qJQ==
X-Received: by 2002:ac8:7d01:0:b0:2f3:eb3b:c2f4 with SMTP id g1-20020ac87d01000000b002f3eb3bc2f4mr17592282qtb.182.1652741037167;
        Mon, 16 May 2022 15:43:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y68-20020a37af47000000b0069fc13ce1f3sm6728678qke.36.2022.05.16.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:43:56 -0700 (PDT)
Date:   Mon, 16 May 2022 18:43:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
Message-ID: <YoLTqxYU7VO91Dam@nand.local>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <5b969c5e-e802-c447-ad25-6acc0b784582@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b969c5e-e802-c447-ad25-6acc0b784582@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 16, 2022 at 03:07:35PM -0400, Derrick Stolee wrote:
> On 5/13/2022 7:37 PM, Glen Choo via GitGitGadget wrote:
> > Thanks all for the comments on v1, I've expanded this series somewhat to
> > address them,...
>
> Please include a full cover letter with each version, so reviewers
> can respond to the full series goals.
>
> Your series here intends to start protecting against malicious
> embedded bare repositories by allowing users to opt-in to a more
> protected state. [...]

Thanks for the summary, which I think will be especially helpful to
others looking at this series for the very first time.

> The 'never' option is a good one for very security-conscious
> users who really want to avoid problems. I don't anticipate that
> users who know about this option and set it themselves are the
> type that would fall for the social engineering required to
> attack using this vector, but I can imagine an IT department
> installing the value in system config across a fleet of machines.

When I first read this, I disagreed, since presumably that same crowd
has legitimate bare repositories that they want to continue being able
to operate in without having to pass `--git-dir` or `$GIT_DIR` in.

In fact...

> I also think that this protection is too rigid: it restricts
> _all_ bare repositories, not just embedded ones. There is no check
> to see if the parent directory of the bare repository is inside a
> non-bare repository.

...this resonates quite a bit more with me. "never" isn't a good option
unless you aren't a user of bare repositories _and_ don't have any
embedded bare repositories (either at all, or any ones that you trust).

> This leads to what I think would be a valuable replacement for
> the 'cwd' option:
>
> * 'no-embedded' allows non-embedded bare repositories. An
>   _embedded bare repository_ is a bare repository whose parent
>   directory is contained in the worktree of a non-bare Git
>   repository. When in this mode, embedded bare repositories are
>   not allowed unless the parent non-bare Git repository has a
>   'safe.embedded' config value storing the path to the current
>   embedded bare repository.
>
> That was certainly difficult to write, but here it is as
> pseudo-code to hopefully remove some doubt as to how this might
> work:
>
>   if repo is bare:
>     if value == "always":
>        return ALLOWED
>     if value == "never":
>        return FORBIDDEN;

This is indeed very similar to a proposal I had made upthread (which you
note lower down in this email). One thing that's nice is that we only
have to traverse up to the parent repo when in the "no-embedded" mode.
That may be slow (since it's unbounded all the way up to the filesystem
root or a ceiling directory, whichever we encounter first), but I think
it's unavoidable if you need to distinguish between embedded and
non-embedded bare repositories.

>     path = get_parent_repo()
>
>     if !path:
>        return ALLOWED
>
>     if config_file_has_value("{path}/.git/config", "safe.embedded", repo):
>        return ALLOWED
>
>     return FORBIDDEN
>
> With this kind of option, we can protect users from these
> social engineering attacks while providing an opt-in protection
> for scenarios where embedded bare repos are currently being used
> (while also not breaking anyone using non-embedded bare repos).
>
> I think Taylor was mentioning something like this in his previous
> replies, perhaps even to the previous thread on this topic.

Yep, see: https://lore.kernel.org/git/Ylobp7sntKeWTLDX@nand.local/.a

> This 'no-embedded' option is something that I could see as a
> potential new default, after it has proven itself in a released
> version of Git.

I would be totally happy to see "no-embedded" become the default. It
might be nice to issue a warning when the top-level config is unset,
to give users a heads up about cases that may be broken, perhaps like:

    if repo is bare:
      switch (value) {
      case "always":
        return ALLOWED;
      case "never":
        return FORBIDDEN;
      case "no-embedded": # fallthrough
      case "":
        path = get_parent_repo()
        if !path
          return ALLOWED;

        if config_file_has_value("{path}/.git/config", "safe.embedded", repo)
          return ALLOWED;

        if value == "no-embedded":
          return FORBIDDEN;

        # otherwise, we're in an embedded bare repository with an unset
        # discovery.bare config.
        #
        # warn that this will break in the future...
        warning(_("%s is embedded within %s"), the_repository.path, path);
        advise(_("to allow discovery for this embedded repo, either run"));
        advise(_(""));
        advise(_("  $ git config --global discovery.bare always, or"));
        advise(_("  $ git -C '%s' config --local safe.embedded '%s'"),
               path, relpath(path, the_repository.path));

        # ...but allow the invocation for now until the default is
        # changed.
        return ALLOWED;
      default:
        die(_("unrecognized value of discovery.bare: '%s'"), value);
      }

...where relpath is similar to Go's path/filepath.Rel function.

With an appropriate deprecation period, I think we could even get away
from the "continue executing, but don't read config+hooks", which in
retrospect is more error-prone and difficult to reason about than I
initially had given it credit for.

Thanks,
Taylor

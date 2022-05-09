Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE4C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 23:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiEJABx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 20:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiEJABu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 20:01:50 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D92BD0ED
        for <git@vger.kernel.org>; Mon,  9 May 2022 16:57:55 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e194so16983864iof.11
        for <git@vger.kernel.org>; Mon, 09 May 2022 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjJTqETWPwRvH1PV6keevP6I9TDPPaidOKWnVXITQj4=;
        b=UtWYV5XKQEjuCQ4TUuQg7FDmfrHOkuDkcn2vaYjHFXgk7WxGAjX/HZsURW2ITu3gYo
         pOIgXqvkowXq2+Vfq60z5MCweRr2YxGdm2Gv8+H+GizOg6DGcrTvoP4zgPudbIgNMnOJ
         pvt6vJkT2YLN7UnR4xO0AAdepj3WnjfWHcuF5eruUTuvFIBwF7ByNsM/kWYm1BGkmhub
         fqZbhlhRacs6oCPnGHsrSXnLPHC3NQj7DqLpdoKdwx+qu+wZhAR5IyEHl3hpzO4hr/HE
         6wr6tfFflgcv6Eurp2Hbi0f31gADnLggSUdVfSFDZFDx67zRuWLJyA2YJQcp9PH72wyN
         ezGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjJTqETWPwRvH1PV6keevP6I9TDPPaidOKWnVXITQj4=;
        b=cjypqGcToLgXixvRNqc+T4JOvyauvp60zCujnaFhqgd/AVvq7cjVlAZAUcNH4ISmi0
         zBo+fQZhK0u+1ocEngC+ZQf8hFQ/Tp8YiJFKPpXaiQbx3bFFFem3zwu9Vr9kAkKMZTRE
         E3xJyH1uBe/AWheedyrMssz4BQm/o1H86lkypv6gfhmvo1Guy/OnJtykRgAddw5jONI4
         11mRN6PxIi5TFCObV0O2Etl/H9+TTt7hst+uFaihqH5HEZZzA6gIC/7r50f5nXzbnm5R
         eXptUbI+F+Uyq+glZZvLIuokn+5QxvVaOI5PS1s8mFI33ZwMaQTm+Y8B96sqnLB2tFcw
         AWfw==
X-Gm-Message-State: AOAM531U4cTmGVage4/dJUMygMelGp4o73D4ATiEe2y9a8q3+/rmUyA0
        xojQrH6NQF0OKHWbz7246JSR5A==
X-Google-Smtp-Source: ABdhPJw7w3UXeVpEVaWIkQp4LLbL3YlbsbqYdSDj86JkRjUpLzJJ3w/v9WbTJSRB6kd0CRMJrLWi1A==
X-Received: by 2002:a05:6638:2647:b0:32b:b7e6:1c68 with SMTP id n7-20020a056638264700b0032bb7e61c68mr8644732jat.8.1652140674905;
        Mon, 09 May 2022 16:57:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l5-20020a056e0212e500b002cde6e352d5sm3428708iln.31.2022.05.09.16.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:57:54 -0700 (PDT)
Date:   Mon, 9 May 2022 19:57:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] [RFC] setup.c: make bare repo discovery optional
Message-ID: <YnmqgdJUaKCYOT4J@nand.local>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <YnmKwLoQCorBnMe2@nand.local>
 <xmqq8rrab9m7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rrab9m7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 03:54:08PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Thanks for working on this! I'm excited to see some patches here, though
> > I'm not totally convinced of this direction. More below.
> >
> > To summarize, this proposal attempts to work around the problem of
> > embedding bare repositories in non-bare checkouts by providing a way to
> > opt-out of bare repository discovery (which is to only discover things
> > that are listed in the safe.bareRepository configuration).
> >
> > I agree that this would prevent the problem you're trying to solve, but
> > I have significant concerns that this patch is going too far (at the
> > risk of future damage to unrelated workflows) in order to accomplish
> > that goal.
> >
> > My concern is that if we ever flipped the default (i.e. that
> > "safe.bareRepository" might someday be ""), that many legitimate cases
> > of using bare repositories would be broken. I think there are many such
> > legitimate use cases that _do_ rely on discovering bare repositories
> > (i.e., Git invocations that do not have a `--git-dir` in their
> > command-line).
>
> I think 99% of such use is to chdir into the directory with HEAD,
> refs/ and objects/ in it and let git recognise the cwd is a git
> directory.  Am I mistaken, or are there tools that chdir into
> objects/08/ and rely on setup_git_directory_gently_1() to find the
> parent directory of that 'objects' directory to be a git directory?

If you took this change, and then at some point in the future we changed
the default value of safe.bareRepository to "", wouldn't that break that
99% of use cases you are talking about?

When I read your "I think 99% of such use is ...", it makes me think
that this change won't disrupt bare repo discovery when we only traverse
one layer above $CWD. But this change disrupts the case where we don't
need to traverse at all to do discovery (i.e., when $CWD is the root of
a bare repository).

> I am wondering if another knob to help that particular use case
> easier may be sufficient.  If you are a forge operator, you'd just
> set a boolean configuration variable to say "it is sufficient to
> chdir into a directory to use it a bare repository without exporting
> the environment variable GIT_DIR=."

Yes, GitHub would almost certainly set safe.bareRepository to "*"
regardless of what Git's own default would be.

> It is likely that end-user human users would not want to enable such
> a variable, of course, but I wonder if a simple single knob would be
> sufficient to help other use cases you are worried about?

I'm not sure I agree that end-users wouldn't want to touch this knob. If
they have embedded bare repositories that they rely on as test fixtures,
for example, wouldn't safe.bareRepository need to be tweaked?

(On a separate but somewhat-related note, I still think that this
setting should be read from the repository config, too, i.e., it seems
odd that we'd force a user to set safe.bareRepository to some deeply
nested repository (in the embedded case) via their global config.)

> While I wish "extensions and nothing else", i.e. we use "degraded
> access", not "refuse to give access at all", were workable, I am
> pessimistic that it would work well in practice.
>
> Saying "nothing else" is easy, but we do "if X exists, use it" for
> hook, and to implement "nothing else", you'd need to find such a
> code and say "even if X exists, because we are in this strange
> embedded bare thing, ignore this part of the logic" for every X.
> We've been casually saying "potentially risky config" and then
> started mixing "hooks" in the discussion, but who knows what other
> things are used from the repository by third-party tools that we
> need to yet add to the mix?
>
> > I'm still not convinced that just reading repository extensions while
> > ignoring the rest of config and hooks is too confusing, so I'd be more
> > in favor of something like:
>
> I do not think it would be confusing.  I am worried about it being
> error prone.

Yeah, on this and the above quoted hunk, I am fine if our behavior
eventually became "call die()" for when we are in an embedded bare
repository. But I do think this transition should be gradual, i.e., we
should likely emit a warning in those cases that would be broken in the
future to say "this will break, run this `git config` invocation if you
want it to remain working".

> >     $ git.compile rev-parse --absolute-git-dir
> >     warning: ignoring repository config and hooks
> >     advice: to permit bare repository discovery (which
> >     advice: will read config and hooks), consider running:
> >     advice:
> >     advice:   $ git config --global --add safe.bareRepository /home/ttaylorr/repo.git
> >     /home/ttaylorr/repo.git
>
> Is the last line meant to be an output from "rev-parse --absolute-git-dir"?
> IOW, the warning says you are ignoring, but we are still recognising
> it as a repository?

In this example, yes. But again, I'm not so deeply attached to the idea
that we *have* to run in those cases. So I would equally be OK with the
above s/warning/fatal and minus the last line, too (i.e., that we call
die(), obviously we'd have to emit the advice before calling die()).

> By the way, do we need safe.bareRepository?  Shouldn't
> safe.directory cover the same purpose?
>
> If a directory is on the latter, you are saying that (1) the
> directory is OK to use as a repository, and (2) it is so even if the
> directory is owned by somebody else, not you.
>
> Theoretically you can argue that there can be cases where you only
> want (1) and not (2), but as long as you control such a directory
> (like an embedded repository in your project's checkout) yourself,
> you do not have to worry about the "ok even if it is owned by
> somebody else" part.

I'm not sure yet, but will think more about it.

Thanks,
Taylor

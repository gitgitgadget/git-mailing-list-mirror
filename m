Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23470C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbiC1TRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245653AbiC1TRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:17:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D101F66C9F
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:16:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t2so13609984pfj.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=LNstmGnnR3nkpxf44CZy6QMqEGf+1nVOy2JjtDuTfZM=;
        b=Pa5uct2cgn0rOSaPW9fSVCUv8+3h6gv0l3g7PxxrF8/ekP7Rfazu/VrYYJnCbD/n3m
         0MF0uN7QQYoUZKNmagx6PyqEJ6yUkTL6ieu3K8AQ48st2moXfu9gRWoTYufgDsKwD0Wy
         fK2EpQL8bPRD9A0+FbLCzbnzasqnOTg/6b8CEfIJZIMe+TsDN7RaHEfGNbBk7I8HlGrx
         sH0ZrOOjXCuYXOtIlCQtw9adbBUDBfSp8sOYsaPI/OU4zfQxXaecCs1YDgWeTc3LjMRZ
         XjV6RISQRar5v8GQsqCPJmrVgiyrbBHUSo+xFg8FwQfLwLJx1IpkqFsF4B4CO9KTxpoJ
         Bcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=LNstmGnnR3nkpxf44CZy6QMqEGf+1nVOy2JjtDuTfZM=;
        b=VUKPOxhhqvIX3jwG4n5fo95agcjV9uPFbK2O3RFeLyRfItTCHZpAVokA4goJOz3YNv
         ZVTcnUDJdThSlWj6eECzLxCn1SjHRqijDI6V2KsOGbHSIFAxnHQZ0tJXOktVy1AD2FyT
         00saRby2ojjuiEZDElB/7iT6Xrvv3nRFq0LTWIJBwwi/nt73uomelRrEJJRx8uY7u0Ix
         HvF8FkrUnNwJuf+4dCUDsQPYzzh+4OC0vQFwboBa9tUKcE4IWmEocP6eF1MtgH5kb+fw
         VdRue2r8wkEEroLRWzyvQeAQOErwgmpigMXnevTqPHwZbScYzjBu7OlL8OYVkfgJs31C
         dFnQ==
X-Gm-Message-State: AOAM531RPusdsMEgVbay5Pzb6u+8OQu9Awkx3RtTWeZnWAavJzk01bfb
        wgDhGC87qi5dJsffbD+TfZ6iU+JaVmxkiw==
X-Google-Smtp-Source: ABdhPJyW2J6mu8iz3yGWCjNSlCw80sxxfP2cNa+4ThRLSb0bWctQAxOspIInNuSfOqI0BVvWaavq2A==
X-Received: by 2002:a05:6a00:1c95:b0:4fa:81f5:b9d4 with SMTP id y21-20020a056a001c9500b004fa81f5b9d4mr3184303pfw.49.1648494960134;
        Mon, 28 Mar 2022 12:16:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:11a8:5d81:f67f:aef9])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm18245425pfl.70.2022.03.28.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:15:59 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:15:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Message-ID: <YkIJacCaaqFk1MDa@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjt6mLIfw0V3aVTO@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.03.23 15:52, Taylor Blau wrote:
> On Wed, Mar 23, 2022 at 03:22:13PM -0400, Derrick Stolee wrote:
> > On 3/23/2022 2:03 PM, Josh Steadmon wrote:
> > > prepare_repo_settings() initializes a `struct repository` with various
> > > default config options and settings read from a repository-local config
> > > file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
> > > in git repos), prepare_repo_settings was changed to issue a BUG() if it
> > > is called by a process whose CWD is not a Git repository. This approach
> > > was suggested in [1].
> > >
> > > This breaks fuzz-commit-graph, which attempts to parse arbitrary
> > > fuzzing-engine-provided bytes as a commit graph file.
> > > commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> > > since we run the fuzz tests without a valid repository, we are hitting
> > > the BUG() from 44c7e62 for every test case.
> > >
> > > Fix this by refactoring prepare_repo_settings() such that it sets
> > > default options unconditionally; if its process is in a Git repository,
> > > it will also load settings from the local config. This eliminates the
> > > need for a BUG() when not in a repository.
> >
> > I think you have the right idea and this can work.
> 
> Hmmm. To me this feels like bending over backwards in
> `prepare_repo_settings()` to accommodate one particular caller. I'm not
> necessarily opposed to it, but it does feel strange to make
> `prepare_repo_settings()` a noop here, since I would expect that any
> callers who do want to call `prepare_repo_settings()` are likely
> convinced that they are inside of a repository, and it probably should
> be a BUG() if they aren't.
> 
> I was initially thinking that Josh's alternative of introducing and
> calling a lower-level version of `prepare_commit_graph()` that doesn't
> require the use of any repository settings would make sense.
> 
> But when I started looking at implementing it, I became confused at how
> this is supposed to work at all without using a repository. We depend on
> the values parsed from:
> 
>   - commitGraph.generationVersion
>   - commitGraph.readChangedPaths
> 
> to determine which part(s) of the commit graph we do and don't read.
> 
> Looking around, I think I probably inadvertently broke this in
> ab14d0676c (commit-graph: pass a 'struct repository *' in more places,
> 2020-09-09). But prior to ab14d0676c, neither of those settings existed,
> so parsing the commit graph was a pure function of the commit graph's
> contents alone, and didn't rely on the existence of a repository.

Yeah, I have not done a great job keeping the fuzzers up to date with
commit-graph changes :(.

> We could pretend as if `commitGraph.generationVersion` is always "2" and
> `commitGraph.readChangedPaths` is always "true", and I think that would
> still give us good-enough coverage.

It might also be worthwhile for the fuzzer to test each interesting
combination of settings, using the same arbitrary input.

> I assume that libFuzzer doesn't give us a convenient way to stub out a
> repository. Maybe we should have a variant of `parse_commit_graph` that
> instead takes a `struct repo_settings` filled out with the defaults?
> 
> We could use that to teach libFuzzer about additional states that the
> commit graph parser can be in, too (though probably outside the scope of
> this patch).
> 
> I tried to sketch all of this out, which seems to work. Let me know what
> you think:

Yes, your patch looks like a much smaller change than I feared would be
the case for a parse_commit_graph refactor. I'll test it out, and
probably add some additional fuzzer improvements on top. Thanks for the
patch!

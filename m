Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB1C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 03:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356471AbiFVDRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 23:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiFVDRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 23:17:36 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A022F009
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 20:17:35 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef5380669cso149974957b3.9
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDvfbGMFq6ZJvAOLLOsu+ZahX20l+WZG2ANrrqq3j3s=;
        b=BWvbMiIF1JFAmRQ2SDhdR/p5yoek790OeK50ZLgF5OKBncchSF0sxCfuInhf7Q/ypm
         FToqRz4WELsMPsvsAWC4fz18d2XqreBgcRsvjQSb6caXj8BpHVEohrAXjGYsWuTeqsMw
         jMYuhbLgCqNgZW5dkOK4uoJujBkFl96m8SE3PxmPN8hD4iBQj8Pq7sIcurCl6V5ca2+m
         nu7fjCambwCTDfn+WmaObk+THUINga94lYTDsDZeZeLi/VFxWPg6+9ZucutMdyRT83yd
         7ZuUaeQIwHO0XQPCduwiizvSOzaU+4KB5YDf8Fsb/Sw8gnE4/3YksoaOxRGkEDXRDGmn
         Es6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDvfbGMFq6ZJvAOLLOsu+ZahX20l+WZG2ANrrqq3j3s=;
        b=FsYAWDiTrRMEyfIZ99tvEf0Mb/aKpj0+Oar3aoAZyuByZe4V4+B3wHl+Ygrhc6KUPJ
         Xt00ycT0jPt0s/C96jGfp8QwHKAk5ghxKvExumBI+SU3eogDzlMaFGaFt+RTdINsXtXf
         flevOrZuaNO1Akiet19S18jAcBwh8prKcrEB0dLWi8tdzGk1WbNgack8PXRGQmZmZCCl
         0gdQZv0AwEdRrYkoO/66sQ0qNtXKmuY/KaENWZ6i/XgrxlpJh2xDBkAoFKaGoj7D03ww
         g6n/SpEer36p0fqkCnE9RbEe1jwITw24O1Q2DcOaADmxjSLd8ZL2/0GZkZp+wSX7Y6nY
         dfEA==
X-Gm-Message-State: AJIora82/0dO7TDoJ1a56ZJfdKRNR9Cm0fLFS5KyuMjbV6lF2mzP++m0
        +wefdqrT1T6+se4JUd6zCjqgcmd0Q0/Kgr4qpHQmOA==
X-Google-Smtp-Source: AGRyM1utUIhqmwAL58cOlLxoavb3Mz1kiefzplT2ufle4frxgEpHeFZ1oqt5fqKr5+6LeJq7KTRpaYRs/Gl4KujPHSk=
X-Received: by 2002:a81:238e:0:b0:300:642f:fdb2 with SMTP id
 j136-20020a81238e000000b00300642ffdb2mr1692491ywj.373.1655867854556; Tue, 21
 Jun 2022 20:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220618030130.36419-1-hanxin.hx@bytedance.com> <20220621182322.3444926-1-jonathantanmy@google.com>
In-Reply-To: <20220621182322.3444926-1-jonathantanmy@google.com>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Wed, 22 Jun 2022 11:17:23 +0800
Message-ID: <CAKgqsWUdRpm8Aa6+oLqHGGXMzXB76f7mM9vf89mG8XVSsQ-1aw@mail.gmail.com>
Subject: Re: Re: [PATCH v1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2022 at 2:23 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Han Xin <hanxin.hx@bytedance.com> writes:
> > If a commit is in the commit graph, we would expect the commit to also
> > be present. So we should use has_object() instead of
> > repo_has_object_file(), which will help us avoid getting into an endless
> > loop of lazy fetch.
> >
> > We can see the endless loop issue via this[1].
> >
> > 1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail.com/
>
> As described in SubmittingPatches:
>
>   Try to make sure your explanation can be understood
>   without external resources. Instead of giving a URL to a mailing list
>   archive, summarize the relevant points of the discussion.
>

Nod.

> > +test_expect_success 'setup' '
> > +     git init --bare dest.git &&
> > +     test_commit one &&
> > +     git checkout -b tmp &&
> > +     test_commit two &&
> > +     git push dest.git --all
> > +'
>
> You can commit directly to the repo by using "test_commit -C dest.git".
> Also, can the repositories be better named? I see a "dest.git" (which
> seems to contain all the objects), "alternates" (which seems to contain
> everything except refs/heads/tmp), "source" (which only contains the
> commit graph), and the current directory. It would probably be better to
> name them e.g. "with-commit", "without-commit", "only-commit-graph", and
> omit using the current directory altogether.

Yes, it makes sense to me.

>
> > +test_expect_success 'prepare a alternates repository without commit two' '
> > +     git clone --bare dest.git alternates &&
> > +     oid=$(git -C alternates rev-parse refs/heads/tmp) &&
> > +     git -C alternates update-ref -d refs/heads/tmp &&
> > +     git -C alternates gc --prune=now &&
> > +     pack=$(echo alternates/objects/pack/*.pack) &&
> > +     git verify-pack -v "$pack" >have &&
> > +     ! grep "$oid" have
> > +'
>
> OK, except refs/heads/tmp could probably have a better name.

I'll rethink the naming here.

>
> > +test_expect_success 'prepare a repository with a commit-graph contains commit two' '
> > +     git init source &&
> > +     echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternates &&
> > +     git -C source remote add origin "$(pwd)/dest.git" &&
> > +     git -C source config remote.origin.promisor true &&
> > +     git -C source config remote.origin.partialclonefilter blob:none &&
> > +     # the source repository has the whole refs contains refs/heads/tmp
> > +     git -C source fetch origin &&
> > +     (
> > +             cd source &&
> > +             test_commit three &&
> > +             git -c gc.writeCommitGraph=true gc
> > +     )
> > +'
>
> Is the purpose of the fetch only to add a ref? If yes, it's clearer just
> to create that branch instead of fetching.

Nod.

>
> > +test_expect_success 'change the alternates of source to that without commit two' '
> > +     # now we have a commit-graph in the source repository but without the commit two
> > +     echo "$(pwd)/alternates/objects" >source/.git/objects/info/alternates
> > +'
>
> OK.
>
> > +test_expect_success 'fetch the missing commit' '
> > +     git -C source fetch origin $oid 2>fetch.out &&
> > +     grep "$oid" fetch.out
> > +'
>
> Is the bug triggered by fetching the missing commit or by fetching any
> commit (which triggers the usage of the commit graph)? If any commit,
> then it's clearer to create an arbitrary commit and then fetch it.
>

Yes, using the missing object in the commit-graph seems to be a little
misleading.

> Also, I thought that the issue was an infinite loop, and the thing being
> tested here looks different from that. If you want to ensure that
> nothing is being fetched, you can use GIT_TRACE="$(pwd)/trace" to
> observe a fetch-pack command being invoked or
> GIT_TRACE_PACKET="$(pwd)/trace" to observe the packet being sent. If
> you're worried about an infinite loop, you can set origin to a directory
> that does not exist (so that the fetch immediately fails).

Maybe we can use "ulimit" ?

Then the test case can be:

    test_expect_success 'fetch the missing commit once' '
        ulimit -u 512 &&
        GIT_TRACE="$(pwd)/trace" git -C source fetch origin $oid 2>err &&
        ! grep "error: cannot fork" err &&
        test $(grep "fetch origin" trace | wc -l) -eq 1
     '

Without this fix, "git fetch" would finally succeed because we didn't
check the return value of promise_remote_get_direct(). We can find
the err output like this:

    error: cannot fork() for -c: Resource temporarily unavailable
    fatal: promisor-remote: unable to fork off fetch subprocess

And we can see a lot of trace logs as follows:

    trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    trace: built-in: git fetch origin --no-tags --no-write-fetch-head
--recurse-submodules=no --filter=blob:none --stdin

Thanks.
-Han Xin

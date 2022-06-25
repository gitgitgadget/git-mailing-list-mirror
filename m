Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E2C433EF
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 02:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiFYCZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 22:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFYCZq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 22:25:46 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF773B875
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 19:25:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3177e60d980so40017077b3.12
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 19:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Gml/2GH4DJjzM4dvGvKs/vUf92sEyIUETKVoiN4AGc=;
        b=aHRgzYSQiNxYjfLn0TzjubB/m1PiNBKXEtg+EZ/PP7VvCmFvHWRH5aaLbNE6k3u9ZB
         BmGpX3Q3Jp2lT6hBEtsVYUPtn793gR4I8SfuWUu9dFjBka68KVLxr6SofIElN90mRx2k
         2sKAHDBhkLKqsi5X+3zquK9xC4ZL/JfY+2FukZZt70ar20mKhtZELjyILyXloCgirxUo
         1J9OR8D9080NjYCDl8DMRNan2ZouJpHOgsSeUgGiSv+3Wm5SCrjecfjwhG07JNiwwu+p
         fWGb5SfSCQAKvnGX3ClUIOi+SyQNJWI/Vn/XWWPvW82fTT3eTrdhQUjOdB1oQFM0Pblh
         b7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Gml/2GH4DJjzM4dvGvKs/vUf92sEyIUETKVoiN4AGc=;
        b=46FqqCAC827C817Ygvspds09y5d5/TMaKoy1ULdp5Yj7hz6W+2k6kcwSLB9R7MkpAy
         ihs4+67ETnd4rCp0BbiNXYR0GqMgVCCfwIAAQ5wFgHweJIOlgWf/OR+P7z1jmkFvFjsz
         1BoNMnL3l1VVa+yd7aFCmBxruU2/1uXxWQcHG8Sti/Ha682IvfoCLjDSuTN0Fcr0y1io
         m8gaEVgXnXqrTIweRHsh9cbGGpAJnDm87n/rBWuRJptQ+3T86zYaSWbfRvg0TuOKrdpF
         tyFhTiyuIaoTtjAG2LNWtWhKEkNoo4yIBmNzJeoiLlTAewkJqb0dSQRYdUjN7KBNc0KK
         +DDA==
X-Gm-Message-State: AJIora9UMgeU4Kj6di6vua3RN276ejsSWj6OaFNj4LOKkVG8L4fQH5nD
        c9KXA4ROd3KSL/ByzMRPAoZM8pHmMy7+a9QTnJESdw==
X-Google-Smtp-Source: AGRyM1vXomWGYDh0vKiSe9yT40A0NhrzkfEOnn3QfvYD9VDHuB8hQ0dGSI0RRUigtl4fxeYYOMShzZXTxCKZ17lBeoI=
X-Received: by 2002:a81:1cc:0:b0:317:a0fa:7a61 with SMTP id
 195-20020a8101cc000000b00317a0fa7a61mr2199354ywb.10.1656123944183; Fri, 24
 Jun 2022 19:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220618030130.36419-1-hanxin.hx@bytedance.com>
 <cover.1656044659.git.hanxin.hx@bytedance.com> <d3a99a5c5ae538b626e04d7069dd2fc316605dfc.1656044659.git.hanxin.hx@bytedance.com>
 <xmqqpmiyuhjj.fsf@gitster.g>
In-Reply-To: <xmqqpmiyuhjj.fsf@gitster.g>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Sat, 25 Jun 2022 10:25:33 +0800
Message-ID: <CAKgqsWXwf5h7r4fqOnfTbe6vyR25PzQ+hhEddCQV3cMis2ruEg@mail.gmail.com>
Subject: Re: Re: [PATCH v2 2/2] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2022 at 12:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han Xin <hanxin.hx@bytedance.com> writes:
>
> > If a commit is in the commit graph, we would expect the commit to also
> > be present.
>
> > When we found the commit in the graph in lookup_commit_in_graph(),
> > but the commit is missing from the repository, we will try
> > promisor_remote_get_direct() and then enter another loop.  While
> > sometimes it will finally succeed because it cannot fork
> > subprocess,
>
> Is that a mode of "succeed"-ing?  Or merely a way to exit an endless
> loop that does not make any progress with a failure?

For the user, "fetch-pack" does succeed, because in
deref_without_lazy_fetch(), even if lookup_commit_in_graph() fails to
lazy fetch the lost commit, the following oid_object_info_extended()
will help us complete the previous work.

In a sense, this infinite loop is based on the fact that infinite processes
can be created.

However, your attempt to express the reasoning bellow is clearer.

>
> > it has exhausted the local process resources and can be harmful to the
> > remote service.
> >
> > Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> > ---
>
> I think the single-liner change in the patch is a good one, but I am
> having a hard time to agree with the reasoning above that explains
> why it is a good change.
>
> Here is an attempt to express a reasoning I can understand, can
> agree with, and (I think) better describes why the change is a good
> one.  Does my understanding of the problem and the solution totally
> misses the mark?
>
>         The commit-graph is used to opportunistically optimize
>         accesses to certain pieces of information on commit objects,
>         and lookup_commit_in_graph() tries to say "no" when the
>         requested commit does not locally exist by returning NULL,
>         in which case the caller can ask for (which may result in
>         on-demand fetching from a promisor remote) and parse the
>         commit object itself.
>
>         However, it uses a wrong helper, repo_has_object_file(), to
>         do so.  This helper not only checks if an object is
>         immediately available in the local object store, but also
>         tries to fetch from a promisor remote.  But the fetch
>         machinery calls lookup_commit_in_graph(), thus causing an
>         infinite loop.
>
>         We should make lookup_commit_in_graph() expect that a commit
>         given to it can be legitimately missing from the local
>         object store, by using the has_object_file() helper instead.
>
> > diff --git a/t/t5329-no-lazy-fetch-with-commit-graph.sh b/t/t5329-no-lazy-fetch-with-commit-graph.sh
> > new file mode 100755
> > index 0000000000..4d25d2c950
> > --- /dev/null
> > +++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh
>
> Hmph, does this short-test need a completely new file?
>
> > @@ -0,0 +1,47 @@
> > +#!/bin/sh
> > +
> > +test_description='test for no lazy fetch with the commit-graph'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup: prepare a repository with a commit' '
> > +     git init with-commit &&
> > +     test_commit -C with-commit the-commit &&
> > +     oid=$(git -C with-commit rev-parse HEAD)
> > +'
> > +
> > +test_expect_success 'setup: prepare a repository with commit-graph contains the commit' '
> > +     git init with-commit-graph &&
> > +     echo "$(pwd)/with-commit/.git/objects" \
> > +             >with-commit-graph/.git/objects/info/alternates &&
> > +     # create a ref that points to the commit in alternates
> > +     git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
> > +     # prepare some other objects to commit-graph
> > +     test_commit -C with-commit-graph somthing &&
>
> somthing? something?

Nod.

>
> > +     git -c gc.writeCommitGraph=true -C with-commit-graph gc &&
> > +     test_path_is_file with-commit-graph/.git/objects/info/commit-graph
> > +'
> > +
> > +test_expect_success 'setup: change the alternates to what without the commit' '
> > +     git init --bare without-commit &&
> > +     echo "$(pwd)/without-commit/objects" \
> > +             >with-commit-graph/.git/objects/info/alternates &&
>
> Doesn't this deliberately _corrupt_ the with-commit-graph repository
> that depended on the object whose name is $oid in with-commit
> repository?  Do we require a corrupt repository to trigger the "bug"?
>

The "bug" depends on the commit exist in the commit-graph but
missing in the repository.

I didn't find a better way to make this kind of scene.

This bug was first found when alternates and commit-graph were
both used. Since the promise did not maintain all the references,
I suspect that the "auto gc" during the update process of the promise
caused the loss of the unreachable commits in the promise.

> > +     test_must_fail git -C with-commit-graph cat-file -e $oid
> > +'
> > +
> > +test_expect_success 'setup: prepare another commit to fetch' '
> > +     test_commit -C with-commit another-commit &&
> > +     anycommit=$(git -C with-commit rev-parse HEAD)
>
> anycommit?  another_commit?  Be consistent in naming.
>

Nod.

> > +'
> > +
> > +test_expect_success ULIMIT_PROCESSES 'fetch any commit from promisor with the usage of the commit graph' '
>
> So we did all of the above set-up sequences only to skip the most
> interesting test, if we were testing with "dash"?  I suspect that it
> may be cleaner to put the prerequisite to the whole file with the
> "early test_done" trick like t0051 and t3008.
>

It make sense to me.

Thanks.
-Han Xin

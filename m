Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44D8C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiFTIyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbiFTIyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 04:54:03 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F667B1F
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 01:53:59 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3177f4ce3e2so69752577b3.5
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5How4SrTGyz1mt2/gNCVV8MHVu30+3acXVhab7v+9w=;
        b=iRbo3UIvw34DREi20gIfnyl3zGuEGc7LTYOdm7UF7X79WpihQvzvJq26aVQHYAQJwT
         9wBx3WRe/ZviSpYeWxxB/whLU7LQTi7qvTpC6QUfYAEQbED7B2HdYFQtrhZ3QJVnlhz8
         qw65nNN0IuRwHF9IlHpQQIrK2s02NgxGIXDLUcDAW7MIYgommuQ0nUJXli1yZ4bRLguw
         meE8/zRq+kcYspABUEKOxJ3vPc75HgnaAmVMDL7OIM56NUyTqYIqzSpLn2YiHDWV0mBQ
         lcefzRpSgv6YgeBwmb5bu2jDbdiXzbsBFw5gXvJHRx2zNXU+6GwsYUPCz7cSLvpRayrl
         SANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5How4SrTGyz1mt2/gNCVV8MHVu30+3acXVhab7v+9w=;
        b=amf5HdOqkONnRI9rhOoMgRlBiyfoAoGJnZaPZko/KkKK3pQ5O7fdtRjpyTn3snF+Gp
         skP6rg3uELGWKDytnhB4wpQlr/cJ9HTSwtUplK7RmO4i5VyNI7HCH/PEJVU1vYBMoAit
         I5lv/Lcq+GvjkTwM7yuTrinhlkeGTIL1sR4hqK6rVT6K91Hj7uVZMFItI4Cq6JhvS+Hq
         uP9+sRIQmQLNL6kCpI44fHoyiPmVPH9qMYZo3BXdbhA1r3UMM0EfksAir/S5vAtP3R1i
         I+M40p3tWJCGc2ge5TDT0mGnEfn3V89HG0eWdm1YMQE1pKGs57e7vSQslx2DIcMRpIVY
         bzqA==
X-Gm-Message-State: AJIora8duRa0mXm6hiD1x9/beLOleOIv3i6YLjd4/xGVSsAl/4kSZlRI
        rKzkWd9FterhLU+Qx0Bwbvn+71xyK8nLfTcyOEtPyA==
X-Google-Smtp-Source: AGRyM1siVr5gtLhUfIXuRJhg3zDysO/KwxPFlpYyJnu0KnMdNXIlFSNNOjG7iT5NhLz3FSbBWu1/1zXzq55ghpdrV8w=
X-Received: by 2002:a81:2443:0:b0:2eb:4ffe:fab2 with SMTP id
 k64-20020a812443000000b002eb4ffefab2mr25844913ywk.330.1655715238808; Mon, 20
 Jun 2022 01:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655350442.git.hanxin.hx@bytedance.com> <20220618030130.36419-1-hanxin.hx@bytedance.com>
 <YrAcrNApaZDngLL+@ncase>
In-Reply-To: <YrAcrNApaZDngLL+@ncase>
From:   =?UTF-8?B?5qyj6Z+p?= <hanxin.hx@bytedance.com>
Date:   Mon, 20 Jun 2022 16:53:47 +0800
Message-ID: <CAKgqsWVfjOw-b4hbz1WDH5sevUab_bQVLb703apew3fX7B60rQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     Patrick Steinhardt <ps@pks.im>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 3:34 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> On Sat, Jun 18, 2022 at 11:01:30AM +0800, Han Xin wrote:
> > If a commit is in the commit graph, we would expect the commit to also
> > be present. So we should use has_object() instead of
> > repo_has_object_file(), which will help us avoid getting into an endles=
s
> > loop of lazy fetch.
> >
> > We can see the endless loop issue via this[1].
> >
> > 1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail=
.com/
> >
> > Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
>
> Thanks a lot for working on this issue!
>
> > ---
> >  commit-graph.c                             |  2 +-
> >  t/t5329-no-lazy-fetch-with-commit-graph.sh | 50 ++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 1 deletion(-)
> >  create mode 100755 t/t5329-no-lazy-fetch-with-commit-graph.sh
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 2b52818731..2dd9bcc7ea 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -907,7 +907,7 @@ struct commit *lookup_commit_in_graph(struct reposi=
tory *repo, const struct obje
> >               return NULL;
> >       if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, =
&pos))
> >               return NULL;
> > -     if (!repo_has_object_file(repo, id))
> > +     if (!has_object(repo, id, 0))
> >               return NULL;
>
> Agreed, this change makes sense to me.
>
> >       commit =3D lookup_commit(repo, id);
> > diff --git a/t/t5329-no-lazy-fetch-with-commit-graph.sh b/t/t5329-no-la=
zy-fetch-with-commit-graph.sh
> > new file mode 100755
> > index 0000000000..ea5940b9f1
> > --- /dev/null
> > +++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh
> > @@ -0,0 +1,50 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'test for no lazy fetch with the commit-graph'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
>
> Nit: I find it a bit confusing that you only call the first test case
> `setup`, while all the other tests except for the last one are also only
> setting up the necessary state.

Nod.
There is indeed some misleading information here.
I will adjust it in the next patch.

>
> > +     git init --bare dest.git &&
> > +     test_commit one &&
> > +     git checkout -b tmp &&
> > +     test_commit two &&
> > +     git push dest.git --all
> > +'
> > +
> > +test_expect_success 'prepare a alternates repository without commit tw=
o' '
> >
> > +     git clone --bare dest.git alternates &&
> >
> > +     oid=3D$(git -C alternates rev-parse refs/heads/tmp) &&
> > +     git -C alternates update-ref -d refs/heads/tmp &&
> > +     git -C alternates gc --prune=3Dnow &&
> > +     pack=3D$(echo alternates/objects/pack/*.pack) &&
> > +     git verify-pack -v "$pack" >have &&
> > +     ! grep "$oid" have
> > +'
>
> Instead of going into the low-level details you could just verify that
> `git cat-file -e $oid` returns `1`.
>

Nod.

> > +
> > +test_expect_success 'prepare a repository with a commit-graph contains=
 commit two' '
> > +     git init source &&
> > +     echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternat=
es &&
> > +     git -C source remote add origin "$(pwd)/dest.git" &&
> > +     git -C source config remote.origin.promisor true &&
> > +     git -C source config remote.origin.partialclonefilter blob:none &=
&
> > +     # the source repository has the whole refs contains refs/heads/tm=
p
> > +     git -C source fetch origin &&
> > +     (
> > +             cd source &&
> > +             test_commit three &&
> > +             git -c gc.writeCommitGraph=3Dtrue gc
> > +     )
> > +'
> > +
> > +test_expect_success 'change the alternates of source to that without c=
ommit two' '
> > +     # now we have a commit-graph in the source repository but without=
 the commit two
> > +     echo "$(pwd)/alternates/objects" >source/.git/objects/info/altern=
ates
> > +'
> > +
> > +test_expect_success 'fetch the missing commit' '
> > +     git -C source fetch origin $oid 2>fetch.out &&
> > +     grep "$oid" fetch.out
> > +'
>
> This test passes even without your fix, albeit a lot slower compared
> to with it. Can we somehow cause it to fail reliably so that the test
> becomes effective in catching a regression here?
>

Could you help me find the reason why this testcase passes even
without the fix.

From the execution of Github Action, it seems that the problem always exist=
=EF=BC=9A
https://github.com/chiyutianyi/git/actions/runs/2527421443.

Thanks.
-Han Xin

> > +test_done
> > --
> > 2.36.1
> >
>
> Patrick

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9254C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 07:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbjEKHpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjEKHpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 03:45:44 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762EB1BE9
        for <git@vger.kernel.org>; Thu, 11 May 2023 00:45:42 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-18f4a6d2822so49261602fac.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683791141; x=1686383141;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZaxuXVXKRWYI68mRVrlODgQ6nKYMUpThoVp/Nrb0/8=;
        b=cFtzIKcUpli57lGKbQJMBbWI0pXpEVrjegE8NoHHW7u7lP5MsUcj+l5Sibb+/MzQxf
         P8gCsl2RAVhVX9JP2mJJV522ocs4x6YBzuPbYvW1iLIG1EGY8SNpuu1ZL9R2fdP+CcX6
         tRQcdg7JvKElughg0tu4Xw6AEcV1ti/FGUA/mRoVxms7blCO5Jw9vvd99jlT9Fq4nBnE
         yGMpTb7EoyoFQwfOZm4pdYGiKhYtFcajyAGLoOixX9f2FPyHRH5xyyTaulVD2Hz+tJqS
         +bukDtkZH5FDau0qvpuiSRsctCngpAQzwdgsuyeM9NWRwvGUZ8Hq/vAZjuYJOE+uarXX
         +vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791141; x=1686383141;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mZaxuXVXKRWYI68mRVrlODgQ6nKYMUpThoVp/Nrb0/8=;
        b=KZ83/na3aGMLBjm72qpw+KhdJZqqRx6TflfcFC+n2ykVFNGOCrtEPBxOFA5gg2OWgi
         KSmK7iT/0fREzuYVqaeHn9sCUmREdEj9ryFPvWayjTdNXu9nHQiJ6ZTgMEQed+NX0/n5
         NdF+oE7NHlhtK6597IWoi63fnO82eihhpf8E3wtaJbQ3UBmQ0s42X9RETgZ/JfaqtPnf
         I6K0yNQBy1lsW9hWteHG9IcCTfiB/iXoWNOfs0ws9ohFDcXAjsiH7lV9wQvmrZEONwCh
         CnRB5HMul4UwG3UfZO7rCr0ZpqgHizqYM46qUAPo4EGm9Jcvs8Yz6u3ztm/f5YmXhYO3
         W5ZA==
X-Gm-Message-State: AC+VfDy65uTuaX5/cdui39Q5LYgiDa7WEJtSxuET/29dEDvHSE4Zpjeg
        RiKb9hUNFp23Y5ifmrq6esI=
X-Google-Smtp-Source: ACHHUZ4OrV8f8HD0Yj/Z3cOeR9BP7I9WuqrPj39r/Rjdl7lrl9ewRPoF0OIRlTAlixA6sRH+n4lJQQ==
X-Received: by 2002:a4a:91d2:0:b0:547:6a8d:67b2 with SMTP id e18-20020a4a91d2000000b005476a8d67b2mr4370733ooh.0.1683791141626;
        Thu, 11 May 2023 00:45:41 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d12-20020a05683018ec00b006ab13915cd4sm2821040otf.81.2023.05.11.00.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 00:45:41 -0700 (PDT)
Date:   Thu, 11 May 2023 01:45:40 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <645c9d245c155_16db0a29494@chronos.notmuch>
In-Reply-To: <CABPp-BECZgACeEUqG3pajJpHAaY=-orNwwOUEX5qqzAKVRMFdQ@mail.gmail.com>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <CABPp-BECZgACeEUqG3pajJpHAaY=-orNwwOUEX5qqzAKVRMFdQ@mail.gmail.com>
Subject: Re: [PATCH] merge-tree: load default git config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, May 10, 2023 at 12:33=E2=80=AFPM Derrick Stolee via GitGitGadge=
t
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <derrickstolee@github.com>
> >
> > The 'git merge-tree' command handles creating root trees for merges
> > without using the worktree. This is a critical operation in many Git
> > hosts, as they typically store bare repositories.
> >
> > This builtin does not load the default Git config, which can have
> > several important ramifications.
> >
> > In particular, one config that is loaded by default is
> > core.useReplaceRefs. This is typically disabled in Git hosts due to
> > the ability to spoof commits in strange ways.
> >
> > Since this config is not loaded specifically during merge-tree, users=

> > were previously able to use refs/replace/ references to make pull
> > requests that looked valid but introduced malicious content. The
> > resulting merge commit would have the correct commit history, but the=

> > malicious content would exist in the root tree of the merge.
> =

> Ouch!  So sorry for creating this problem.
> =

> > The fix is simple: load the default Git config in cmd_merge_tree().
> > This may also fix other behaviors that are effected by reading defaul=
t
> > config. The only possible downside is a little extra computation time=

> > spent reading config. The config parsing is placed after basic argume=
nt
> > parsing so it does not slow down usage errors.
> >
> > Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> > ---
> >     merge-tree: load default git config
> >
> >     This patch was reviewed on the Git security list, but the impact =
seemed
> >     limited to Git forges using merge-ort to create merge commits. Th=
e
> >     forges represented on the list have deployed versions of this pat=
ch and
> >     thus are no longer vulnerable.
> >
> >     Thanks, -Stolee
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-153=
0%2Fderrickstolee%2Fstolee%2Frefs-replace-upstream-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1530/d=
errickstolee/stolee/refs-replace-upstream-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1530
> >
> >  builtin/merge-tree.c  |  3 +++
> >  t/t4300-merge-tree.sh | 18 ++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index aa8040c2a6a..b8f8a8b5d9f 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -17,6 +17,7 @@
> >  #include "merge-blobs.h"
> >  #include "quote.h"
> >  #include "tree.h"
> > +#include "config.h"
> >
> >  static int line_termination =3D '\n';
> >
> > @@ -628,6 +629,8 @@ int cmd_merge_tree(int argc, const char **argv, c=
onst char *prefix)
> >         if (argc !=3D expected_remaining_argc)
> >                 usage_with_options(merge_tree_usage, mt_options);
> >
> > +       git_config(git_default_config, NULL);
> > +
> =

> Always nice when it's a simple fix.  :-)
> =

> I am curious though...
> =

> init_merge_options() in merge-recursive.c (which is also used by
> merge-ort) calls merge_recursive_config().  merge_recursive_config()
> does a bunch of config parsing, regardless of whatever config parsing
> is done beforehand by the caller of init_merge_options().  This makes
> me wonder if the config which handles replace refs should be included
> in merge_recursive_config() as well.  Doing so would have the added
> benefit of making sure all the builtins calling the merge logic behave
> similarly.  And if we copy/move the replace-refs-handling config
> logic, does that replace the fix in this patch, or just supplement it?
> =

> To be honest, I've mostly ignored the config side of things while
> working on the merge machinery, so I didn't even know (or at least
> remember) the above details until I went digging just now.  I don't
> know if the way init_merge_options()/merge_recursive_config() is how
> we should do things, or just vestiges of how it's evolved from 15
> years ago.

It's obvious this is not the way we should do things as configurations ar=
e
overriden when they shouldn't be.

Something like this [1] is obviously needed.

[1] https://lore.kernel.org/git/20210609192842.696646-5-felipe.contreras@=
gmail.com/

-- =

Felipe Contreras=

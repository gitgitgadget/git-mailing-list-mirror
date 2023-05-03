Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C7C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjECSAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECSAU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:00:20 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234371708
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:00:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3ef36d814a5so507751cf.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683136818; x=1685728818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6/Ht32WVrT1ZvMxqBE08tl4tl8Yy90UiTXh2iBWmfU=;
        b=JNrOg8hXFOj3Db6U4DCYMGX9EdjRwcXx15975DZtlMXeip+dLa3yZhCRMxHjxFD4Ha
         Oc5Rhz+oM5A7X7jnnLyi+ZjQvkLy+x5pXiKr1x4buLP4jrOIRz3w5hIbK9llRnfYJzkt
         CneTXD3MtIP12JWcscHnr1KaB9iGou5kvAF7fQ5T/dgQHa8WYhXutcz73BXmhfusSDO9
         tje/iA/ohmFy/eyq8X07fPhVWAkoQZjOoaMhgRlqerIgYWq5Q0CzccnKXWgXXK7m+ZBm
         n4gLdFhRMkDU48SDFwh2Luy3lu7zwqJk2S0B9gzSPUs7EWHNTqibRkeJBrmQV283ZCx6
         2Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683136818; x=1685728818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6/Ht32WVrT1ZvMxqBE08tl4tl8Yy90UiTXh2iBWmfU=;
        b=XYCvniuvVR2PS8diwfZoOzEyQ2EoQDGXmMnI+J/NPJUaaVeITBLI8KkVou8Qxr7Zlt
         GhalVknWUzkgtd95VVkxKsv5lqgEWx0WZAicaRSRkz9cd2q50VyQ7o/vCG6JBi1lld8q
         z3gQzE/VkUGSbn0xfKAJnYDymX82A/B446MWeldK7IEbApov9FGMfIvqJmLCpxrmWYge
         upuuJI62q2//oPfPC3cNpJ7RLvK1bmtFZvEvt8A1wpDwaBx1kYPzK+heJy/CIfoSrfeJ
         kgBTwXBSg+3j//UDvyVhXGE8S8WsFCQVCLmEyWHbHBf0ArSHEDWJQFnw5Zb5g+ua8mHF
         kaHQ==
X-Gm-Message-State: AC+VfDz9W0RKQSU6DedF58rtNrjjTy0FE/cSkOtJgVeGWcdKg7tcDFNB
        x8FX8b6qohDODMAU4t6WVhEXS7PcYyLhRJOwuaSfxzz3GH0FvUJvLWI=
X-Google-Smtp-Source: ACHHUZ7BKuWE+NqkU/iFie39zCPc67/YiyXxsvNBm0BHYCjDCmS00+m3PP2dpwReMXTVYqiBPrjVNCM4sT5kmiiEOYA=
X-Received: by 2002:ac8:4e48:0:b0:3ef:404a:b291 with SMTP id
 e8-20020ac84e48000000b003ef404ab291mr461331qtw.7.1683136818095; Wed, 03 May
 2023 11:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com> <CABPp-BFagTvBTe0XbEOM_hO-vDFwVvSSmGOii1q2=7amqerwtQ@mail.gmail.com>
In-Reply-To: <CABPp-BFagTvBTe0XbEOM_hO-vDFwVvSSmGOii1q2=7amqerwtQ@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 3 May 2023 11:00:07 -0700
Message-ID: <CAFySSZAOqX0pESfJ-7bYg9iR2RDB9PL6sC4Kcvr_zitdQ1kD_g@mail.gmail.com>
Subject: Re: [PATCH 0/6] strbuf cleanups
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While moving strbuf_add_separated_string_list() to a separate file
would mean that strbuf would no longer have a dependency on
string-list, I don't think that dependency is problematic to begin
with. Widening the boundary for strbuf as a string manipulation
library to a string and string list manipulation library seems
reasonable to me.


On Tue, May 2, 2023 at 7:37=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Tue, May 2, 2023 at 2:15=E2=80=AFPM Calvin Wan <calvinwan@google.com> =
wrote:
> >
> > Strbuf is a basic structure that should function as a low-level library
> > due to how generic it is. Over time certain functions inside of
> > strbuf.[ch] have been added with dependencies to higher level objects
> > and functions. This series cleans up some of those higher level
> > dependencies by moving the offending functions to the files they
> > interact with. With the goal of eventually being able to stand up strbu=
f
> > as a libary, this series also removes the use of environment variables
> > from strbuf.
> >
> > Calvin Wan (6):
> >   abspath: move related functions to abspath
> >   credential-store: move related functions to credential-store file
> >   object-name: move related functions to object-name
> >   path: move related function to path
> >   strbuf: clarify dependency
> >   strbuf: remove environment variables
> >
> >  abspath.c                  |  36 +++++++++++++
> >  abspath.h                  |  21 ++++++++
> >  add-patch.c                |  12 +++--
> >  builtin/am.c               |   2 +-
> >  builtin/branch.c           |   4 +-
> >  builtin/commit.c           |   2 +-
> >  builtin/credential-store.c |  19 +++++++
> >  builtin/merge.c            |  10 ++--
> >  builtin/notes.c            |  16 +++---
> >  builtin/rebase.c           |   2 +-
> >  builtin/stripspace.c       |   6 ++-
> >  builtin/tag.c              |   9 ++--
> >  fmt-merge-msg.c            |   9 ++--
> >  gpg-interface.c            |   5 +-
> >  hook.c                     |   1 +
> >  object-name.c              |  15 ++++++
> >  object-name.h              |   9 ++++
> >  path.c                     |  20 +++++++
> >  path.h                     |   5 ++
> >  pretty.c                   |   1 +
> >  rebase-interactive.c       |  15 +++---
> >  sequencer.c                |  24 +++++----
> >  strbuf.c                   | 106 +++----------------------------------
> >  strbuf.h                   |  44 ++-------------
> >  tempfile.c                 |   1 +
> >  wt-status.c                |   6 +--
> >  26 files changed, 213 insertions(+), 187 deletions(-)
> >
> > --
> > 2.40.1.495.gc816e09b53d-goog
>
> The series looks pretty good to me.  I left a couple small comments on
> 5/6 and 6/6.  One other high-level note:
>
> As =C3=86var noted over at
> https://lore.kernel.org/git/230501.86a5yohsme.gmgdl@evledraar.gmail.com/,
> strbuf_add_separated_string_list() is currently only used by
> merge-ort.c and merge-recursive.c (both of which include
> merge-recursive.h).  It may make sense to move that function, and that
> would permit you to drop the forward declaration of 'struct
> string_list;' from strbuf.c as well.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AABBC46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 10:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjIRKNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 06:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbjIRKNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 06:13:04 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A155711A
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 03:12:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1d6baffcac2so1145408fac.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695031974; x=1695636774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYSNrO3ky544e9M1GNUnFjH2hrbCgSOSpi5LOCIlptk=;
        b=hG45Ximgn9CODE813BTJHSHagPG4CHBYZZziw1YcNb1CKgtRPfjCm+UHacUwQnqeOK
         GCD+oVKM76ngd1dDdQ6Cg/ykT7basSxo4Lxk74kLrsFx77Lb24DUyg48Ll+5CMFxDaeh
         wcoj/6Vn/n0AvU0kGDBDhq36RmXiAeF5JUw5ElHzDeqKM7jNYkAbsbSdOD4kpThv8yZK
         xHKeX+lTroXRn/0f8dQsHAZ+VYNHpXIauyWYbJbDst0AEZET7gzb1qwodzd37ycNksNC
         toPaSilq+yHsM8K56NdFNkrbvwTI+bWU0SAu7bydGJQvte/nYxgTOQm/52QZpqZWRdVT
         dRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031974; x=1695636774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYSNrO3ky544e9M1GNUnFjH2hrbCgSOSpi5LOCIlptk=;
        b=MhkdsQhfqa7qB6UzrvEn2epXs0FTG/43K5B+8sGm/qoZ0i68I7kAnJ69wIskkoKNzh
         YNqQCVRIghQNFCYAQsvKTAOdCm7kuMXfxYVbtyqG8NoRBlOK3hoMKyGoHX5CUBDzMUbF
         NPf4FKCicfKB5f/6VHEyyKHdYvvskw94Dk7Z90BiraA8ykAV0qm/3t4hXC7LLH05Vbvp
         6hAg+AP98kWGhZKT9fYef32dWaVjCneA4aO2cqrH9ZEvkhiov7i+xtZhFHb+Swm1I84I
         kAjo5vnXYsPF2mTCq3LcpVhd4OezmOG09rVrxiyohSFZUwNV1AHsZlejt+LNoKkMsjzt
         MRCA==
X-Gm-Message-State: AOJu0YyHni+dLI3Rg6UVcO1ajRlLk5vT77lUGAxZuN2Gx5N4ze8jC5DP
        +FcWYgI1lGSgKuFmTWaL82h+Yuk10+ZLd/5AJXh5A89FlKYBoQ==
X-Google-Smtp-Source: AGHT+IEbFPHzsbzcZMqGDl6e+GCNAfkZkon6b+58RD1wLtPaGBQ5T+6480QS1J9eWUkUnwUqQHoQHP9pJ3DRFxy2IYM=
X-Received: by 2002:a05:6870:828c:b0:1d5:987b:e8ca with SMTP id
 q12-20020a056870828c00b001d5987be8camr10145728oae.22.1695031974395; Mon, 18
 Sep 2023 03:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230912155820.136111-1-karthik.188@gmail.com>
 <20230915083415.263187-1-knayak@gitlab.com> <xmqqfs3fe08e.fsf@gitster.g>
In-Reply-To: <xmqqfs3fe08e.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 18 Sep 2023 12:12:28 +0200
Message-ID: <CAOLa=ZQ9ZRmYe5b6R9ZTTpDCzb2L0UmxkeBujb2kOMSeFuwJGA@mail.gmail.com>
Subject: Re: [PATCH v3] revision: add `--ignore-missing-links` user option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 8:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > From: Karthik Nayak <karthik.188@gmail.com>
> >
> > The revision backend is used by multiple porcelain commands such as
> > git-rev-list(1) and git-log(1). The backend currently supports ignoring
> > missing links by setting the `ignore_missing_links` bit. This allows th=
e
> > revision walk to skip any objects links which are missing. Expose this
> > bit via an `--ignore-missing-links` user option.
>
> Given the above "we merely surface a feature that already exists and
> supported to be used by the end users from the command line" claim ...
>
> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index ff715d6918..5239d83c76 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -266,7 +266,8 @@ static int finish_object(struct object *obj, const =
char *name UNUSED,
> >  {
> >       struct rev_list_info *info =3D cb_data;
> >       if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) =
< 0) {
> > -             finish_object__ma(obj);
> > +             if (!info->revs->ignore_missing_links)
> > +                     finish_object__ma(obj);
> >               return 1;
> >       }
>
> ... this hunk is a bit unexpected.  As a low-level plumbing command,
> shouldn't it be left to the user who gives --ignore-missing-links
> from their command line to specify how the missing "obj" here should
> be dealt with by giving the "--missing=3D<foo>" option?  While giving
> "allow-promisor" may not make much sense, "--missing=3Dallow-any" may
> of course make sense (it is the same as hardcoding the decision not
> to call finish_object__ma() at all), and so may "--missing=3Dprint".
>

This is to be expected, in my opinion. In terms of revision.c and setting t=
he
`revs->ignore_missing_links` bit, the traversal will go throw all
objects (commits
and otherwise) and call `show_commit` or `show_object` on them.

Here there is a difference for commits and non-commit objects.
1. Commit objects: commits are parsed in revision.c and after that the
`show_commit`
function is called only when the object is available.
2. Non-commit objects: while trees are parsed in revision.c, blobs are
never parsed and
hence, ` show_object` can be called on missing blobs. This is left to
the user to handle. In
our case, we error out in `rev-list.c`, which is not what we want when usin=
g the
`--ignore-missing-links` option. Hence, this addition.

There is an argument to be made around compatibility between the
`--missing` option
and `--ignore-missing-links` option, but since the former only works
with non-commit objects
I think the latter should be independent, and also the latter is about
ignoring all missing links.
I also don't think the user should again specify what to do with
missing links by adding
`--missing=3Dallow-any` as `--ignore-missing-links` is a superset of it.

> Stepping back a bit, with "--missing=3Dprint", is this change still
> needed?  The missing objects discovered will be shown at the end,
> with the setting, no?
>

The main difference is that the `--missing` options works entirely
with non-commit
objects (I'm assuming this was built with promisor notes in mind). So
if a commit is
missing, git-rev-list(1) will still barf an error, but this error
handling is not in
`builtin/rev-list.c` rather is in a layer above in `revision.c`. So it
wouldn't be trivial for
the `--missing` option to support missing commit links. So that's why we ex=
pose
`--ignore-missing-links` which ensures any kind of object (commits
included) if missing,
is ignored.

Thanks for the review!

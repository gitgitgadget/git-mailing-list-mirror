Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A648E7D0A4
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 18:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjIUShQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIUSgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D932DAFCF
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 11:32:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2745cd2ba68so864378a91.0
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321137; x=1695925937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQwEhoXwkNM1xogF7s92J5dXgQxN6KWwoJHU7VdJ9iw=;
        b=XpcImMOeGB7PKfwGf4WkMSSbhq+dVuhU9RvjLsjRYextZl/XwjGCrA+5yZI/V6eiNE
         GfON1mbyunHwws49CjdM3LUWCivItGd91tb7Ki8yJtP2xBXlGBdNXK0aGWKX9YDPNdgs
         p+xRuZSuL6OnDhn+lPAsYaWNrOwYwHz+YD0lMIdf4vIsM+7TCEmOaUG3dnMdaxGTOJ2O
         ffihzHfBkO38iO3iX/7005FDQI0K8i7gdSLbx6m3BBAo5BRQKxefpDtfr8OwukQ0cF9n
         xMsi/PbJy/qsnGWtYDK4camL61XnUMRDJ+Y3e8scXhyqv3YDcFv8eYhPZMR7Wud8tcrH
         AP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321137; x=1695925937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQwEhoXwkNM1xogF7s92J5dXgQxN6KWwoJHU7VdJ9iw=;
        b=aaf3iOjmQ+3gkiP6b0V9xLoZzAgRp1rSA1rkvYSik11xlBUpQbyr2d8DFKSuYA6xxc
         ABP3lG7JcqeD+jj2vHRjuwNT4xHevuVujlWMpIWAKEFreHorol+ft/PD8Y4vwdqb/Nfh
         ZN32tkPOdYDq/x+Sjc0z4oc3ckxN9VzM/nIjJ71L6IpNy3wYwPd8vSnn1XHETnWjnaGK
         mY/UprkhAoJVW5Zy5M8VPMHqzp/bkXRtEAJTvn0gbzAmKYhzD233JkBgzT8j/e+adOqI
         eDNO2+b+zMlEd4Y1lsQjvJJLT54JNQxvtM26nIg9bkiraG5U2ZbhEPyYPhfVP9T7TAnu
         9Prg==
X-Gm-Message-State: AOJu0YwRiHRM7Zs035rZ+9krNj93LAHXbOGQsH2oUU8hOeAyBH8u6TfC
        GmffDhBK9tsR0XKlEI84gBGWMMXnxAe7rOFmBNlnhm+qZz6fag==
X-Google-Smtp-Source: AGHT+IF75R1LiYHdF6HepdPtcgZpSuukRLRmT2cYbOXwUZlMN5ntKLM34/BR6kKsOE/uynYpr7L12y2x2STehrwgeYg=
X-Received: by 2002:a05:6870:e0cf:b0:1d0:c7c8:323e with SMTP id
 a15-20020a056870e0cf00b001d0c7c8323emr5214291oab.35.1695293616981; Thu, 21
 Sep 2023 03:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230915083415.263187-1-knayak@gitlab.com> <20230920104507.21664-1-karthik.188@gmail.com>
 <xmqqh6noc13c.fsf@gitster.g>
In-Reply-To: <xmqqh6noc13c.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 21 Sep 2023 12:53:11 +0200
Message-ID: <CAOLa=ZT_DVw4Na-rj4mk2ULkrqDyVP2_cOpgdLozFjn3RJbTvg@mail.gmail.com>
Subject: Re: [PATCH v4] revision: add `--ignore-missing-links` user option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2023 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> There needs an explanation of interaction with --missing=3D<action>
> option here, no?  "--missing=3Dallow-any" and "--missing=3Dprint" are
> sensible choices, I presume.  The former allows the traversal to
> proceed, as you described in one of your responses.  Also with
> "--missing=3Dprint", the user can more directly find out which are the
> missing objects, even without using the "--boundary" that requires
> them to sift between missing objects and the objects that are truly
> on boundary.
>
> Here is my attempt:
>
>         --ignore-missing-links::
>                 During traversal, if an object that is referenced does no=
t
>                 exist, instead of dying of a repository corruption, allow
>                 `--missing=3D<missing-action>` to decide what to do.
>         +
>         `--missing=3Dprint` will make the command print a list of missing
>         objects, prefixed with a "?" character.
>         +
>         `--missing=3Dallow-any` will make the command proceed without doi=
ng
>         anything special.  Used with `--boundary`, output these missing
>         objects mixed with the commits on the edge of revision ranges,
>         prefixed with a "-" character.
>
> It might make sense to add
>
>         +
>         Use of this option with other 'missing-action' may probably not
>         give useful behaviour.
>
> at the end, but it may not be useful to the readers to say "we allow
> even more extra flexibility but haven't thought through what good
> they would do".
>

I was thinking about this, but mostly didn't do this, because the
interaction with `--missing`
is only for non-commit objects. Because for missing commits,
`--ignore-missing-links` skips
the commit and the value of `--missing` doesn't make any difference.

It's only for non-commit objects that `--missing` comes into play. So
perhaps change the current
explanation to:

--ignore-missing-links::
       During traversal, if a commit that is referenced does not
       exist, instead of dying of a repository corruption, pretend as
       if the commit itself does not exist. Running the command
       with the `--boundary` option makes these missing commits,
       together with the commits on the edge of revision ranges
       (i.e. true boundary objects), appear on the output, prefixed
       with '-'.

This way `--ignore-missing-links` is specific to commits, combining
this with `--missing=3D...` for
non-commit objects is left to the user. What do you think?

> > +# With `--ignore-missing-links`, we stop the traversal when we encount=
er a
> > +# missing link. The boundary commit is not listed as we haven't used t=
he
> > +# `--boundary` options.
> > +test_expect_success 'rev-list only prints main odb commits with --igno=
re-missing-links' '
> > +     hide_alternates &&
> > +
> > +     git -C alt rev-list --objects --no-object-names \
> > +             --ignore-missing-links --missing=3Dallow-any HEAD >actual=
.raw &&
> > +     git -C alt cat-file  --batch-check=3D"%(objectname)" \
> > +             --batch-all-objects >expect.raw &&
> > +
> > +     sort actual.raw >actual &&
> > +     sort expect.raw >expect &&
> > +     test_cmp expect actual
> > +'
>
> This gives a good baseline.  "--missing=3Dprint" without "--boundary"
> may have more obvious use cases, but is there a practical use case
> for the output from an invocation with "--missing=3Dallow-any" without
> "--boundary"?  Just being curious if I am missing something obvious.
>

Not really, but it's easier to build up the testing, here without
boundary we can
use cat-file to test all objects (commits and others) that are output
by rev-list.

Then we can build on top of this in the next test, where we can also ensure=
 that
boundary commits are printed. This however is very simplistic, as
you've mentioned.
There could be other objects and we don't really check.

> Perhaps add another test that uses "--missing=3Dprint" instead, and
> check that the "? missing" output matches what we expect to be
> missing?  The same comment applies to the other test that uses
> "--missing=3Dallow-any" without "--boundary" we see later.
>

Sure, we can add that too!

> > +# With `--ignore-missing-links` and `--boundary`, we can even print th=
ose boundary
> > +# commits.
> > +test_expect_success 'rev-list prints boundary commit with --ignore-mis=
sing-links' '
> > +     git -C alt rev-list --ignore-missing-links --boundary HEAD >got &=
&
> > +     grep "^-$(git rev-parse HEAD)" got
> > +'
>
> This makes sure what we expect to appear in 'got' actually is in
> 'got', but we should also make sure 'got' does not have anything
> unexpected.
>

Yeah, I can add that in too.

> > +test_expect_success "setup for rev-list --ignore-missing-links with mi=
ssing objects" '
> > +     show_alternates &&
> > +     test_commit -C alt 11
> > +'
> > +
> > +for obj in "HEAD^{tree}" "HEAD:11.t"
> > +do
> > +     # The `--ignore-missing-links` option should ensure that git-rev-=
list(1)
> > +     # doesn't fail when used alongside `--objects` when a tree/blob i=
s
> > +     # missing.
> > +     test_expect_success "rev-list --ignore-missing-links with missing=
 $type" '
> > +             oid=3D"$(git -C alt rev-parse $obj)" &&
> > +             path=3D"alt/.git/objects/$(test_oid_to_path $oid)" &&
> > +
> > +             mv "$path" "$path.hidden" &&
> > +             test_when_finished "mv $path.hidden $path" &&
>
> In the first iteration, we check without the tree object and we only
> ensure that removed tree does not appear in the output---but we know
> the blob that is referenced by that removed tree will not appear in
> the output, either, don't we?  Don't we want to check that, too?
>
> In the second iteration, we have resurrected the tree but removed
> the blob that is referenced by the tree, so we would not see that
> blob in the output, which makes sense.
>

I was implementing this change and just realized that for missing
trees, show_object() is
never called (that is --missing=3Dprint has no effect).

That means we only call show_object() when there is a missing blob.

So this effectively means:
1. missing commits: --ignore-missing-links works, --missing=3D... has no ef=
fect
2. missing trees:      --ignore-missing-links works, --missing=3D... has no=
 effect
3. missing blobs:      --ignore-missing-links works in conjunction
with --missing=3D...

I now think it does make even more sense to hardcode the skipping of
`finish_object__ma` this way
we can state that `--ignore-missing-links` and `--missing` are
incompatible, wherein `--ignore-missing-links`
ignores any missing object (irrelevant of type) and `--missing` is
used to specifically handle missing blobs
and provides options.

This is also how currently `--boundary` and `--missing=3Dprint` is
specific to commits and blobs respectively.
What do you think?

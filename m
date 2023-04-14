Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67E4C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDNRFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNRFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:05:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414BE9
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:05:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50489b16e6aso4346448a12.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681491918; x=1684083918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df2v/MAfh+lA5WLKWOdeP9hxOHzZKhX4Fxu7T9DKeSU=;
        b=GHAUZEzXtZyFOWVYEvERwpK/t91uk9fvSrsXrBqAqWQpdTRaCVjH/2puYYnVFyAL4/
         t/7BRLsJ/1Upq4fueKp39sSDc0whBujblbhGwB5By3+kXbyHikpWRK47E57QtoaG3SmJ
         XRl817p74yE2rgk0AYVAlLTz57oX/7+xxRji4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491918; x=1684083918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df2v/MAfh+lA5WLKWOdeP9hxOHzZKhX4Fxu7T9DKeSU=;
        b=CARiPK4il85AzWKqTSeDTj06S5PFquHLGRUE7r3XHUwP5hRcSxASlpNZpXPxhF1MTv
         9ccirl0ChEpEhOW3OpzTA6gAPrIpgOO9ca/Atly04YJa5VCBerL3/ELMuiHYeHeJ5xkZ
         7LeZ5YwRg4thwP7F4leqORwteO2dDNkuOx6AB0nzH+H83V/Ah4nvkcZAQjTIYhZr8CpH
         priuDmI4Ez69Cvcj0zVI/g9XpQa6bePgwuuRS81mejVpwl/peOIa7d9ozEsFy+DKcLa+
         PAQCg4vJidLNTc9bN8+7QnNpwhYcF/dAkONqNt1ZPj+1T3W9TeKPK5TNfI431xzmnW+s
         FzHA==
X-Gm-Message-State: AAQBX9dp6Cg7HqDKh5hQn0CMPqF/Te3QKYg6VpokzmZg52aockhay4Tc
        37B1EqykcX3iVTblr+slaeAKB3uU+hJb8B7pYQzHlQ==
X-Google-Smtp-Source: AKy350Yq8KJvLCQeT+CFpl5UfirKs5N71vZBWUN7fpQF1hincJ3nxScEI0CVuliq1ROgJ3qZEFCLlA==
X-Received: by 2002:a50:eb4b:0:b0:504:b6a6:cbe0 with SMTP id z11-20020a50eb4b000000b00504b6a6cbe0mr6557527edp.12.1681491918046;
        Fri, 14 Apr 2023 10:05:18 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id bf13-20020a0564021a4d00b005024459f431sm2305527edb.70.2023.04.14.10.05.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 10:05:17 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50489c109f4so5268082a12.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:05:16 -0700 (PDT)
X-Received: by 2002:a50:9f4f:0:b0:4fc:a484:c6ed with SMTP id
 b73-20020a509f4f000000b004fca484c6edmr3442030edf.2.1681491916568; Fri, 14 Apr
 2023 10:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local> <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net> <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
 <20230412074309.GB1695531@coredump.intra.peff.net> <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
 <20230414073035.GB540206@coredump.intra.peff.net> <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
In-Reply-To: <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Apr 2023 10:04:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjr-CMLX2Jo2++rwcv0VNr+HmZqXEVXNsJGiPRUwNxzBQ@mail.gmail.com>
Message-ID: <CAHk-=wjr-CMLX2Jo2++rwcv0VNr+HmZqXEVXNsJGiPRUwNxzBQ@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 5:17=E2=80=AFAM ZheNing Hu <adlternative@gmail.com>=
 wrote:
>
> Jeff King <peff@peff.net> =E4=BA=8E2023=E5=B9=B44=E6=9C=8814=E6=97=A5=E5=
=91=A8=E4=BA=94 15:30=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Apr 12, 2023 at 05:57:02PM +0800, ZheNing Hu wrote:
> > >
> > > I'm still puzzled why git calculated the object id based on {type, si=
ze, data}
> > >  together instead of just {data}?
> >
> > You'd have to ask Linus for the original reasoning. ;)

I originally thought of the git object store as "tagged pointers".

That actually caused confusion initially when I tried to explain this
to SCM people, because "tag" means something very different in an SCM
environment than it means in computer architecture.

And the implication of a tagged pointer is that you have two parts of
it - the "tag" and the "address". Both are relevant at all points.

This isn't quite as obvious in everyday moden git usage, because a lot
of uses end up _only_ using the "address" (aka SHA1), but it's very
much part of the object store design. Internally, the object layout
never uses just the SHA1, it's all "type:SHA1", even if sometimes the
types are implied (ie the tree object doesn't spell out "blob", but
it's still explicit in the mode bits).

This is very very obvious in "git cat-file", which was one of the
original scripts in the first commit (but even there the tag/type has
changed meaning over time: the very first version didn't use it as
input at all, then it started verifying it, and then later it got the
more subtle context of "peel the tags until you find this type").

You can also see this in the original README (again, go look at that
first git commit): the README talks about the "tag of their type".

Of course, in practice git then walked away from having to specify the
type all the time. It started even in that original release, in that
the HEAD file never contained the type - because it was implicit (a
HEAD is always a commit).

So we ended up having a lot of situations like that where the actual
tag part was implicit from context, and these days people basically
never refer to the "full" object name with tag, but only the SHA1
address.

So now we have situations where the type really has to be looked up
dynamically, because it's not explicitly encoded anywhere. While HEAD
is supposed to always be a commit, other refs can be pretty much
anything, and can point to a tag object, a commit, a tree or a blob.
So then you actually have to look up the type based on the address.

End result: these days people don't even think of git objects as
"tagged pointers".  Even internally in git, lots of code just passes
the "object name" along without any tag/type, just the raw SHA1 / OID.

So that originally "everything is a tagged pointer" is much less true
than it used to be, and now, instead of having tagged pointers, you
mostly end up with just "bare pointers" and look up the type
dynamically from there.

And that "look up the type in the object" is possible because even
originally, I did *not* want any kind of "object type aliasing".

So even when looking up the object with the full "tag:pointer", the
encoding of the object itself then also contains that object type, so
that you can cross-check that you used the right tag.

That said, you *can* see some of the effects of this "tagged pointers"
in how the internals do things like

    struct commit *commit =3D lookup_commit(repo, &oid);

which conceptually very much is about tagged pointers. And the fact
that two objects cannot alias is actually somewhat encoded in that: a
"struct commit" contains a "struct object" as a member. But so does
"struct blob" - and the two "struct object" cases are never the same
"object".

So there's never any worry about "could blob.object be the same object
as commit.object"?

That is actually inherent in the code, in how "lookup_commit()"
actually does lookup_object() and then does object_as_type(OBJ_COMMIT)
on the result.

> Oh, you are right, this could be to prevent conflicts between Git objects
> with identical content but different types. However, I always associate
> Git with the file system, where metadata such as file type and size is
> stored in the inode, while the file data is stored in separate chunks.

See above: yes, git design was *also* influenced heavily by
filesystems, but that was mostly in the sense of "this is how to
encode these things without undue pain".

The object database being immutable was partly a security and safety
measure, but it was also very much partly a "rewriting files is going
to be a major pain from a filesystem consistency standpoint - don't do
it".

But even more than a filesystem design, it's an "computer
architecture" design. Think of the git object store as a very abstract
computer architecture that has tagged pointers, stable storage, and no
aliasing - and where the tag is actually verified at each lookup.

The "no aliasing" means that no two distinct pointers can point to the
same data. So a tagged pointer of type "commit" can not point to the
same object as a tagged pointer of type "blob". They are distinct
pointers, even if (maybe) the commit object encoding ends up then
being identical to a blob object.

And as mentioned, that "verified at each lookup" has mostly gone away,
and "each lookup" has become more of a "can be verified by fsck", but
it's probably still a good thing to think that way.

You still have "lookup_object_by_type()" internally in git that takes
the full tagged pointer, but almost nobody uses it any more. The
closest you get is those "lookup_commit()" things (which are fairly
common, still).

              Linus

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7DAC77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 12:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDPMGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPMGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 08:06:05 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8984687
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 05:06:04 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id z16so14621087oib.9
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681646763; x=1684238763;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH1ofToyVP8cyBW/R+W3fjGtL0tHYHVmeGoh1k+SLgo=;
        b=VUZ9d9uKsHymGKVE5csSvu86X5g/Cav32Sa3kTK/7PQxM1o0x8O3h/DbrmgiAaiMU9
         GK/tQLlPEQ79NVUFxzksRtbNwzBtMimx6OU1x+NrKAS/McmpVMQohIW7FySAKavFC+rj
         x7OLfDy1E3wUi4GYhIlxH0v+Y4lNII63G8wlk7JxiYWcnc9aiE4lSEg3IFm1AEXbwyzF
         8ZXhHsQjGX5180Gt/gsC2/HLj8Lwsded7RQdgNStS2EXII2kdunCAHYCyVL4ZRPIZlh1
         oJMD28yyDBwqtqQK2FbW1/hF3plu7057SFsfeTI360uhGHsG6v52Ro+uhXrIQgyvQxua
         Objg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681646763; x=1684238763;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GH1ofToyVP8cyBW/R+W3fjGtL0tHYHVmeGoh1k+SLgo=;
        b=H6U8xTzbE8i6qF8horWmZFZO+TsG0WZpUFENIa1BI2QJkmycA4arnIrYdhvdFVIDch
         Q8rBBLrEHcc/P4MndfD9g4LHpn/JB3dIypZ3xkNq2cEUcZFSdLYMdOk7wsSPlB7c7czY
         bViONgyPpAK/fqqXqMc5Btizr8P7txRT4dt2SrpGx6Vj0JjsxJofICz1dRVbAJRwhz4z
         3PgD7MBky3dXLJ+gHYJ6UgGOGCoYngBpbPh1txhKbq2+tdQLts1+B3F6JDfMBFdNAG7w
         OBwGU0yGgWDHayXGcElFTKAESZxe5ESKbiasfm/G2YHD7YLNC4u+vIfhB+lVES8MKa4F
         aWoQ==
X-Gm-Message-State: AAQBX9ftKUb8KTsnqnrS/QUqZhWoroVwHxYdu9955IXveIr/9OxceEow
        6BLt8/ddy+GYponMA3KNqOw=
X-Google-Smtp-Source: AKy350aqCWoe8vzaDVdweKA7rRP3nwH+aw+laxL4g/JWNrsgZIygPb6T7WubOMG/FIlNw6LP5y8wzg==
X-Received: by 2002:a05:6808:305:b0:38c:229c:f844 with SMTP id i5-20020a056808030500b0038c229cf844mr4454398oie.40.1681646763591;
        Sun, 16 Apr 2023 05:06:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o15-20020a4a2c0f000000b0054574f35b8esm1064629ooo.41.2023.04.16.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 05:06:02 -0700 (PDT)
Date:   Sun, 16 Apr 2023 06:06:02 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        ZheNing Hu <adlternative@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Message-ID: <643be4aa2bdf9_f43d294d9@chronos.notmuch>
In-Reply-To: <CAHk-=wjr-CMLX2Jo2++rwcv0VNr+HmZqXEVXNsJGiPRUwNxzBQ@mail.gmail.com>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
 <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net>
 <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
 <20230412074309.GB1695531@coredump.intra.peff.net>
 <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
 <20230414073035.GB540206@coredump.intra.peff.net>
 <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
 <CAHk-=wjr-CMLX2Jo2++rwcv0VNr+HmZqXEVXNsJGiPRUwNxzBQ@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> On Fri, Apr 14, 2023 at 5:17=E2=80=AFAM ZheNing Hu <adlternative@gmail.=
com> wrote:
> >
> > Jeff King <peff@peff.net> =E4=BA=8E2023=E5=B9=B44=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=94 15:30=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Apr 12, 2023 at 05:57:02PM +0800, ZheNing Hu wrote:
> > > >
> > > > I'm still puzzled why git calculated the object id based on {type=
, size, data}
> > > >  together instead of just {data}?
> > >
> > > You'd have to ask Linus for the original reasoning. ;)
> =

> I originally thought of the git object store as "tagged pointers".
> =

> That actually caused confusion initially when I tried to explain this
> to SCM people, because "tag" means something very different in an SCM
> environment than it means in computer architecture.
> =

> And the implication of a tagged pointer is that you have two parts of
> it - the "tag" and the "address". Both are relevant at all points.
> =

> This isn't quite as obvious in everyday moden git usage, because a lot
> of uses end up _only_ using the "address" (aka SHA1), but it's very
> much part of the object store design. Internally, the object layout
> never uses just the SHA1, it's all "type:SHA1", even if sometimes the
> types are implied (ie the tree object doesn't spell out "blob", but
> it's still explicit in the mode bits).
> =

> This is very very obvious in "git cat-file", which was one of the
> original scripts in the first commit (but even there the tag/type has
> changed meaning over time: the very first version didn't use it as
> input at all, then it started verifying it, and then later it got the
> more subtle context of "peel the tags until you find this type").
> =

> You can also see this in the original README (again, go look at that
> first git commit): the README talks about the "tag of their type".
> =

> Of course, in practice git then walked away from having to specify the
> type all the time. It started even in that original release, in that
> the HEAD file never contained the type - because it was implicit (a
> HEAD is always a commit).
> =

> So we ended up having a lot of situations like that where the actual
> tag part was implicit from context, and these days people basically
> never refer to the "full" object name with tag, but only the SHA1
> address.
> =

> So now we have situations where the type really has to be looked up
> dynamically, because it's not explicitly encoded anywhere. While HEAD
> is supposed to always be a commit, other refs can be pretty much
> anything, and can point to a tag object, a commit, a tree or a blob.
> So then you actually have to look up the type based on the address.
> =

> End result: these days people don't even think of git objects as
> "tagged pointers".  Even internally in git, lots of code just passes
> the "object name" along without any tag/type, just the raw SHA1 / OID.
> =

> So that originally "everything is a tagged pointer" is much less true
> than it used to be, and now, instead of having tagged pointers, you
> mostly end up with just "bare pointers" and look up the type
> dynamically from there.
> =

> And that "look up the type in the object" is possible because even
> originally, I did *not* want any kind of "object type aliasing".
> =

> So even when looking up the object with the full "tag:pointer", the
> encoding of the object itself then also contains that object type, so
> that you can cross-check that you used the right tag.
> =

> That said, you *can* see some of the effects of this "tagged pointers"
> in how the internals do things like
> =

>     struct commit *commit =3D lookup_commit(repo, &oid);
> =

> which conceptually very much is about tagged pointers. And the fact
> that two objects cannot alias is actually somewhat encoded in that: a
> "struct commit" contains a "struct object" as a member. But so does
> "struct blob" - and the two "struct object" cases are never the same
> "object".
> =

> So there's never any worry about "could blob.object be the same object
> as commit.object"?
> =

> That is actually inherent in the code, in how "lookup_commit()"
> actually does lookup_object() and then does object_as_type(OBJ_COMMIT)
> on the result.

This explains rather well why the object type is used in the calculation,=
 and
it makes sense.

But I don't see anything about the object size. Isn't that unnecessary?

-- =

Felipe Contreras=

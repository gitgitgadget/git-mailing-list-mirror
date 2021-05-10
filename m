Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16543C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5361400
	for <git@archiver.kernel.org>; Mon, 10 May 2021 17:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhEJRUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhEJRUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 13:20:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B21C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 10:19:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b25so11220228oic.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LnqEJCBIt1kpseUwqMBPDC6amKWDKOHWvaA6UmcEU9c=;
        b=hV2RNqg70zoSz5eq5L8FeYXUd4TVJr2S6DJ8fHCVO+zgeesyM6eULlJnldyRPBjEYg
         /88GuqiKqLdDW8OdqZraAm33msaLvW/R7KiIxrN0vtNmS7t6WrXqTVmduHdpnB0UZVQF
         1Gs+Lf7QTXg+sqZzLHsLTbB/w4doONxOUPiSlm3V7MRtYBI5S67OtDfSh2s5IiZnYOHO
         uN9fFlsXdPvZnCDE1JNMRPccfC9KUzzp4phiisbSmfbgnAbCPYHQoJTu3+NA/sEImXDm
         IS+P0MwqJAP/rmCBhR3th/wdUK7lHz0P68//gLpHg0xgBqefsffVIYQUI5B60TYUsxmi
         sBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LnqEJCBIt1kpseUwqMBPDC6amKWDKOHWvaA6UmcEU9c=;
        b=Y8Teu+ifsz3yBzv+r+nR2ChmAOJf7Gl+q2XLdrwEui5VDv5IYMJhwbVDKWOd3/U9od
         fePfcZBW6KXf/3DSm9qruU860aqJeMaSajbEmhtB5W+YICvCGSHA7gTLZlGrE/k7intg
         Yy2KLxDRBRLGFzQsvdkXijz0OWaRTIshV8RoPWms5SeGL8DuDw1+sPcwdKtjrL70hHYq
         1vRISeYAk5xwBd4AFQPNOLmXjkRMPOfamH3GoTBW1Xx52VQhNzb3t16MZxX3AP4pSrH2
         jkW5q/yXuWXyXWGWRSjvyfR+qjPFAOAQNgCTlaWnN8CLgJh69ZDh+x0FVn6jFdj6IXv6
         /Ulw==
X-Gm-Message-State: AOAM532OS4b9Gj3lf/uTw1ktzp1RX7iTzecxMKGWzSNSEzB+ztET7qyU
        WZFhfDTGByCAKhG+igCnxCySchSwNsPvRBVFwKlaXrbz
X-Google-Smtp-Source: ABdhPJwFUhlQbLtuQCW2xhkqc9tpVfCsJ/08Wp8q62VUdSZwGOf22/dHRtu2hVI/KxSxyjldvUe9XrEFy5RrKkrVAHo=
X-Received: by 2002:aca:3684:: with SMTP id d126mr18796687oia.129.1620667156150;
 Mon, 10 May 2021 10:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz> <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <YGzoX9OeWMKXpqtf@coredump.intra.peff.net> <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
 <CAD2i4DCtqxziTy5TPjG+U8EGC+8daJGXjpVgxoJwp8__t8fqxQ@mail.gmail.com>
 <20210428085838.GN6564@kitsune.suse.cz> <CAD2i4DASL-ZAsLm=_U53zvqMaAC_AOsGnTe-H=XQsfnftgb=rA@mail.gmail.com>
 <20210428184956.GS6564@kitsune.suse.cz> <CAD2i4DCLpvAuwp5UEDcPA0wzr4Eg_qhs_xXDW1eLiOwYkUvL1g@mail.gmail.com>
 <20210430075924.GB6564@kitsune.suse.cz>
In-Reply-To: <20210430075924.GB6564@kitsune.suse.cz>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Mon, 10 May 2021 12:19:05 -0500
Message-ID: <CAD2i4DBSajgNFCwMMDv_tyQwuKDU095avmHs=BHcrAY1GbCqwA@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Apr 2021 at 02:59, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> On Thu, Apr 29, 2021 at 08:51:07PM -0500, Varun Varada wrote:
> > On Wed, 28 Apr 2021 at 13:49, Michal Such=C3=A1nek <msuchanek@suse.de> =
wrote:
> > >
> > > On Wed, Apr 28, 2021 at 01:15:07PM -0500, Varun Varada wrote:
> > > > On Wed, 28 Apr 2021 at 03:58, Michal Such=C3=A1nek <msuchanek@suse.=
de> wrote:
> > > > >
> > > > > On Tue, Apr 27, 2021 at 07:39:57PM -0500, Varun Varada wrote:
> > > > > > Here's the updated diff:
> > > > >
> > > > > As already said multiple general purpose dictionaries recognize '=
(have)
> > > > > strong effect' as the meaning of 'impact', in some cases even the=
 most
> > > > > common meaning.
> > > >
> > > > There's no contention here. That's the meaning I've been referring =
to as well.
> > > >
> > > > >
> > > > > In case you have some issue with the word 'jargon' Merriam-Webste=
r gives
> > > > > this definition:
> > > > >
> > > > > 1: the technical terminology or characteristic idiom of a special=
 activity or group
> > > > > 2: obscure and often pretentious language marked by circumlocutio=
ns and long words
> > > > > 3a: confused unintelligible language
> > > > > b: a strange, outlandish, or barbarous language or dialect
> > > > > c: a hybrid language or dialect simplified in vocabulary and gram=
mar and used for communication between peoples of different speech
> > > > >
> > > > > which the word 'impact' does not fulfill.
> > > > >
> > > > > Further, you would rarely discuss and document an effect that is
> > > > > negligible so in vast majority of cases '(have) strong effect' (i=
e
> > > > > 'impact') is synonymous to 'affect' and 'affect', respectively.
> > > >
> > > > This is not true, especially in technical contexts. "Affect" doesn'=
t
> > > > mean "has a slight effect on", but simply "has an effect on". This
> > > > suffices in most cases. In cases where one would like to highlight =
the
> > > > overwhelming/awesome/debilitating/marked/strong effect that somethi=
ng
> > > > has, "impact" can be used. To say that every effect is overwhelming=
 or
> > > > strong is jargon.
> > > >
> > > > >
> > > > > If you can pick out a few places where the use is specifically co=
nfusing
> > > > > then please pick out those. Wholesale replacement of one word wit=
h
> > > > > another synonym is not desired. It creates useless churn.
> > > >
> > > > I've actually not done a wholesale replacement blindly; the ones I
> > > > replaced are the places where I couldn't find any case where it is
> > > > referring to a "strong/marked effect". This is especially true in t=
he
> > > > negative constructions. If you could help me find places where you
> > > > think the intended meaning is indeed "a strong/marked effect", I ca=
n
> > > > remove those from the changes.
> > >
> > > As already pointed out before the mere fact that the author of the te=
xt
> > > bothered to document the effect ipmlies that the effect is strong/mar=
ked
> > > unless stated otherwise. At any rate 'strong' is always relative. Unl=
ess
> > > you have a specific reference of average strenth anything can be
> > > considered strong or weak depending on point of view.
> >
> > This doesn't seem like a plausible or strong argument given the
> > context of the places where I'm editing the text. Most of them are
> > negative constructions, where if one were to assume "strongly affect"
>
> That's not the case. There are some which include negation, and many
> that don't. I did not review all of the patch so can't really tell but
> it looks like the onse that include negation are a minority or about
> half of what you replace at best.

There are 27 changes, 16 of which are negation. That's more than half,
and at least all of these need to be replaced.

>
> > was intended, then that raises the question of what actual effect it
> > will have. The only convincing example of this I can see is the one
> > where it reads "which are tight with memory might be badly impacted by
> > this though". All of the other ones seem like they're binary in
> > whether they will have an effect at all or no, not graduated in terms
> > of the degree of the effect it will have.
>
> Which also means that the distinction between 'strong effect' and
> 'effect' is meaningless, and 'affect' vs 'impact' is synonymous.
> Replacing one with the other is useless churn then.

I'm not sure I understand what you mean by "churn". No one would stop
using Git because of these single-word changes.

As for there being no distinction, there's no gradation within the
semantics of this context; this doesn't change the semantics of the
words themselves. Using "impact" when what is meant is just "effect"
or "affect" is incorrect in all such instances.

>
> Also the cases I saw do not really look confusing in any way so the
> change does not improve the documentation in any way.

Saying "will not impact" means "will not strongly affect", as you've
already agreed. This necessarily means it might affect it, albeit not
strongly. This is confusing to anyone reading the documentation, and
is entirely unnecessary. I don't understand the resistance here for
simple one-word changes that remove this confusion. Am I missing
something?

>
> >
> > >
> > > >
> > > > >
> > > > > You could make a case that 'impact' is significantly less frequen=
t word
> > > > > compared to effect/affect and thus makes the text harder to under=
stand
> > > > > for non-native speakers. However, that's not the point you brough=
t up,
> > > > > and even then it is very weak point to make, especially without a=
ny
> > > > > actual source for the frequency data. You could also counter that=
 all of
> > > > > these are common loanwords in many languages and are thus easy to
> > > > > understand to non-native speakers anyway.
> > > > >
> > > > > Thanks
> > > > >
> > > > > Michal
> > > > > >
> > > > > >  Documentation/MyFirstContribution.txt              |  2 +-
> > > > > >  Documentation/MyFirstObjectWalk.txt                |  2 +-
> > > > > >  Documentation/config/pack.txt                      |  2 +-
> > > > > >  Documentation/git-fast-import.txt                  | 14 ++++++=
+-------
> > > > > >  Documentation/git-fetch.txt                        |  2 +-
> > > > > >  .../technical/hash-function-transition.txt         |  2 +-
> > > > > >  Documentation/user-manual.txt                      |  4 ++--
> > > > > >  advice.c                                           |  2 +-
> > > > > >  builtin/fast-import.c                              |  2 +-
> > > > > >  builtin/pack-objects.c                             |  2 +-
> > > > > >  contrib/coccinelle/README                          |  2 +-
> > > > > >  dir.c                                              |  2 +-
> > > > > >  t/perf/p5550-fetch-tags.sh                         |  2 +-
> > > > > >  t/t0008-ignores.sh                                 |  2 +-
> > > > > >  t/t0303-credential-external.sh                     |  2 +-
> > > > > >  t/t2020-checkout-detach.sh                         |  4 ++--
> > > > > >  t/t4013-diff-various.sh                            |  2 +-
> > > > > >  t/t5000-tar-tree.sh                                |  2 +-
> > > > > >  t/test-lib-functions.sh                            |  2 +-
> > > > > >  19 files changed, 27 insertions(+), 27 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/MyFirstContribution.txt
> > > > > > b/Documentation/MyFirstContribution.txt
> > > > > > index af0a9da62e..8372a7e59e 100644
> > > > > > --- a/Documentation/MyFirstContribution.txt
> > > > > > +++ b/Documentation/MyFirstContribution.txt
> > > > > > @@ -592,7 +592,7 @@ Now that you have a usage hint, you can tea=
ch Git
> > > > > > how to show it in the general
> > > > > >  command list shown by `git help git` or `git help -a`, which i=
s generated from
> > > > > >  `command-list.txt`. Find the line for 'git-pull' so you can ad=
d your 'git-psuh'
> > > > > >  line above it in alphabetical order. Now, we can add some attr=
ibutes about the
> > > > > > -command which impacts where it shows up in the aforementioned =
help
> > > > > > commands. The
> > > > > > +command which affects where it shows up in the aforementioned =
help
> > > > > > commands. The
> > > > > >  top of `command-list.txt` shares some information about what e=
ach attribute
> > > > > >  means; in those help pages, the commands are sorted according =
to these
> > > > > >  attributes. `git psuh` is user-facing, or porcelain - so we wi=
ll mark it as
> > > > > > diff --git a/Documentation/MyFirstObjectWalk.txt
> > > > > > b/Documentation/MyFirstObjectWalk.txt
> > > > > > index 2d10eea7a9..fd5bb8fb7d 100644
> > > > > > --- a/Documentation/MyFirstObjectWalk.txt
> > > > > > +++ b/Documentation/MyFirstObjectWalk.txt
> > > > > > @@ -786,7 +786,7 @@ Count all the objects within and modify the=
 print statement:
> > > > > >  By running your walk with and without the filter, you should f=
ind
> > > > > > that the total
> > > > > >  object count in each case is identical. You can also time each=
 invocation of
> > > > > >  the `walken` subcommand, with and without `omitted` being pass=
ed in, to confirm
> > > > > > -to yourself the runtime impact of tracking all omitted objects=
.
> > > > > > +to yourself the runtime effect of tracking all omitted objects=
.
> > > > > >
> > > > > >  =3D=3D=3D Changing the Order
> > > > > >
> > > > > > diff --git a/Documentation/config/pack.txt b/Documentation/conf=
ig/pack.txt
> > > > > > index 3da4ea98e2..00fcc9d7c7 100644
> > > > > > --- a/Documentation/config/pack.txt
> > > > > > +++ b/Documentation/config/pack.txt
> > > > > > @@ -55,7 +55,7 @@ pack.deltaCacheSize::
> > > > > >   This cache is used to speed up the writing object phase by no=
t
> > > > > >   having to recompute the final delta result once the best matc=
h
> > > > > >   for all objects is found.  Repacking large repositories on ma=
chines
> > > > > > - which are tight with memory might be badly impacted by this t=
hough,
> > > > > > + which are tight with memory might be badly affected by this t=
hough,
> > > > > >   especially if this cache pushes the system into swapping.
> > > > > >   A value of 0 means no limit. The smallest size of 1 byte may =
be
> > > > > >   used to virtually disable this cache. Defaults to 256 MiB.
> > > > > > diff --git a/Documentation/git-fast-import.txt
> > > > > > b/Documentation/git-fast-import.txt
> > > > > > index 39cfa05b28..c6d8e4e1d7 100644
> > > > > > --- a/Documentation/git-fast-import.txt
> > > > > > +++ b/Documentation/git-fast-import.txt
> > > > > > @@ -58,7 +58,7 @@ OPTIONS
> > > > > >   allowing fast-import to access the filesystem outside of the
> > > > > >   repository). These options are disabled by default, but can b=
e
> > > > > >   allowed by providing this option on the command line.  This
> > > > > > - currently impacts only the `export-marks`, `import-marks`, an=
d
> > > > > > + currently affects only the `export-marks`, `import-marks`, an=
d
> > > > > >   `import-marks-if-exists` feature commands.
> > > > > >  +
> > > > > >   Only enable this option if you trust the program generating t=
he
> > > > > > @@ -687,7 +687,7 @@ that contains SP the path must be quoted.
> > > > > >
> > > > > >  A `filecopy` command takes effect immediately.  Once the sourc=
e
> > > > > >  location has been copied to the destination any future command=
s
> > > > > > -applied to the source location will not impact the destination=
 of
> > > > > > +applied to the source location will not affect the destination=
 of
> > > > > >  the copy.
> > > > > >
> > > > > >  `filerename`
> > > > > > @@ -708,7 +708,7 @@ that contains SP the path must be quoted.
> > > > > >  A `filerename` command takes effect immediately.  Once the sou=
rce
> > > > > >  location has been renamed to the destination any future comman=
ds
> > > > > >  applied to the source location will create new files there and=
 not
> > > > > > -impact the destination of the rename.
> > > > > > +affect the destination of the rename.
> > > > > >
> > > > > >  Note that a `filerename` is the same as a `filecopy` followed =
by a
> > > > > >  `filedelete` of the source location.  There is a slight perfor=
mance
> > > > > > @@ -1010,7 +1010,7 @@ The `LF` after the command is optional (i=
t used
> > > > > > to be required).
> > > > > >  ~~~~~~~~~~
> > > > > >  Causes fast-import to print the entire `progress` line unmodif=
ied to
> > > > > >  its standard output channel (file descriptor 1) when the comma=
nd is
> > > > > > -processed from the input stream.  The command otherwise has no=
 impact
> > > > > > +processed from the input stream.  The command otherwise has no=
 effect
> > > > > >  on the current import, or on any of fast-import's internal sta=
te.
> > > > > >
> > > > > >  ....
> > > > > > @@ -1035,7 +1035,7 @@ can safely access the refs that fast-impo=
rt updated.
> > > > > >  ~~~~~~~~~~
> > > > > >  Causes fast-import to print the SHA-1 corresponding to a mark =
to
> > > > > >  stdout or to the file descriptor previously arranged with the
> > > > > > -`--cat-blob-fd` argument. The command otherwise has no impact =
on the
> > > > > > +`--cat-blob-fd` argument. The command otherwise has no effect =
on the
> > > > > >  current import; its purpose is to retrieve SHA-1s that later c=
ommits
> > > > > >  might want to refer to in their commit messages.
> > > > > >
> > > > > > @@ -1050,7 +1050,7 @@ this output safely.
> > > > > >  ~~~~~~~~~~
> > > > > >  Causes fast-import to print a blob to a file descriptor previo=
usly
> > > > > >  arranged with the `--cat-blob-fd` argument.  The command other=
wise
> > > > > > -has no impact on the current import; its main purpose is to
> > > > > > +has no effect on the current import; its main purpose is to
> > > > > >  retrieve blobs that may be in fast-import's memory but not
> > > > > >  accessible from the target repository.
> > > > > >
> > > > > > @@ -1366,7 +1366,7 @@ code considerably.
> > > > > >
> > > > > >  The branch LRU builtin to fast-import tends to behave very wel=
l, and the
> > > > > >  cost of activating an inactive branch is so low that bouncing =
around
> > > > > > -between branches has virtually no impact on import performance=
.
> > > > > > +between branches has virtually no effect on import performance=
.
> > > > > >
> > > > > >  Handling Renames
> > > > > >  ~~~~~~~~~~~~~~~~
> > > > > > diff --git a/Documentation/git-fetch.txt b/Documentation/git-fe=
tch.txt
> > > > > > index 9067c2079e..01cf3b3d16 100644
> > > > > > --- a/Documentation/git-fetch.txt
> > > > > > +++ b/Documentation/git-fetch.txt
> > > > > > @@ -113,7 +113,7 @@ on remotes that have themselves deleted tho=
se branches.
> > > > > >  If left to accumulate, these stale references might make perfo=
rmance
> > > > > >  worse on big and busy repos that have a lot of branch churn, a=
nd
> > > > > >  e.g. make the output of commands like `git branch -a --contain=
s
> > > > > > -<commit>` needlessly verbose, as well as impacting anything el=
se
> > > > > > +<commit>` needlessly verbose, as well as affecting anything el=
se
> > > > > >  that'll work with the complete set of known references.
> > > > > >
> > > > > >  These remote-tracking references can be deleted as a one-off w=
ith
> > > > > > diff --git a/Documentation/technical/hash-function-transition.t=
xt
> > > > > > b/Documentation/technical/hash-function-transition.txt
> > > > > > index 7c1630bf83..f4296faffc 100644
> > > > > > --- a/Documentation/technical/hash-function-transition.txt
> > > > > > +++ b/Documentation/technical/hash-function-transition.txt
> > > > > > @@ -42,7 +42,7 @@ mitigations.
> > > > > >
> > > > > >  If SHA-1 and its variants were to be truly broken, Git's hash =
function
> > > > > >  could not be considered cryptographically secure any more. Thi=
s would
> > > > > > -impact the communication of hash values because we could not t=
rust
> > > > > > +affect the communication of hash values because we could not t=
rust
> > > > > >  that a given hash value represented the known good version of =
content
> > > > > >  that the speaker intended.
> > > > > >
> > > > > > diff --git a/Documentation/user-manual.txt b/Documentation/user=
-manual.txt
> > > > > > index fd480b8645..33c60c49d7 100644
> > > > > > --- a/Documentation/user-manual.txt
> > > > > > +++ b/Documentation/user-manual.txt
> > > > > > @@ -302,7 +302,7 @@ Note: checking out 'v2.6.17'.
> > > > > >
> > > > > >  You are in 'detached HEAD' state. You can look around, make ex=
perimental
> > > > > >  changes and commit them, and you can discard any commits you m=
ake in this
> > > > > > -state without impacting any branches by performing another swi=
tch.
> > > > > > +state without affecting any branches by performing another swi=
tch.
> > > > > >
> > > > > >  If you want to create a new branch to retain commits you creat=
e, you may
> > > > > >  do so (now or later) by using -c with the switch command again=
. Example:
> > > > > > @@ -1189,7 +1189,7 @@ their histories forked. The work tree is
> > > > > > overwritten by the result of
> > > > > >  the merge when this combining is done cleanly, or overwritten =
by a
> > > > > >  half-merged results when this combining results in conflicts.
> > > > > >  Therefore, if you have uncommitted changes touching the same f=
iles as
> > > > > > -the ones impacted by the merge, Git will refuse to proceed. Mo=
st of
> > > > > > +the ones affected by the merge, Git will refuse to proceed. Mo=
st of
> > > > > >  the time, you will want to commit your changes before you can =
merge,
> > > > > >  and if you don't, then linkgit:git-stash[1] can take these cha=
nges
> > > > > >  away while you're doing the merge, and reapply them afterwards=
.
> > > > > > diff --git a/advice.c b/advice.c
> > > > > > index 164742305f..9cbbb824a9 100644
> > > > > > --- a/advice.c
> > > > > > +++ b/advice.c
> > > > > > @@ -291,7 +291,7 @@ void detach_advice(const char *new_name)
> > > > > >   "\n"
> > > > > >   "You are in 'detached HEAD' state. You can look around, make =
experimental\n"
> > > > > >   "changes and commit them, and you can discard any commits you=
 make in this\n"
> > > > > > - "state without impacting any branches by switching back to a =
branch.\n"
> > > > > > + "state without affecting any branches by switching back to a =
branch.\n"
> > > > > >   "\n"
> > > > > >   "If you want to create a new branch to retain commits you cre=
ate, you may\n"
> > > > > >   "do so (now or later) by using -c with the switch command. Ex=
ample:\n"
> > > > > > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > > > > > index 3afa81cf9a..24f362d2f4 100644
> > > > > > --- a/builtin/fast-import.c
> > > > > > +++ b/builtin/fast-import.c
> > > > > > @@ -3530,7 +3530,7 @@ int cmd_fast_import(int argc, const char =
**argv,
> > > > > > const char *prefix)
> > > > > >   * We don't parse most options until after we've seen the set =
of
> > > > > >   * "feature" lines at the start of the stream (which allows th=
e command
> > > > > >   * line to override stream data). But we must do an early pars=
e of any
> > > > > > - * command-line options that impact how we interpret the featu=
re lines.
> > > > > > + * command-line options that affect how we interpret the featu=
re lines.
> > > > > >   */
> > > > > >   for (i =3D 1; i < argc; i++) {
> > > > > >   const char *arg =3D argv[i];
> > > > > > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > > > > > index 525c2d8552..749bbca241 100644
> > > > > > --- a/builtin/pack-objects.c
> > > > > > +++ b/builtin/pack-objects.c
> > > > > > @@ -2042,7 +2042,7 @@ static void break_delta_chains(struct obj=
ect_entry *entry)
> > > > > >   /*
> > > > > >   * Mark ourselves as active and see if the next step causes
> > > > > >   * us to cycle to another active object. It's important to do
> > > > > > - * this _before_ we loop, because it impacts where we make the
> > > > > > + * this _before_ we loop, because it affects where we make the
> > > > > >   * cut, and thus how our total_depth counter works.
> > > > > >   * E.g., We may see a partial loop like:
> > > > > >   *
> > > > > > diff --git a/contrib/coccinelle/README b/contrib/coccinelle/REA=
DME
> > > > > > index f0e80bd7f0..92979ec770 100644
> > > > > > --- a/contrib/coccinelle/README
> > > > > > +++ b/contrib/coccinelle/README
> > > > > > @@ -40,4 +40,4 @@ There are two types of semantic patches:
> > > > > >     are ignored for checks, and can be applied using 'make cocc=
icheck-pending'.
> > > > > >
> > > > > >     This allows to expose plans of pending large scale refactor=
ings without
> > > > > > -   impacting the bad pattern checks.
> > > > > > +   affecting the bad pattern checks.
> > > > > > diff --git a/dir.c b/dir.c
> > > > > > index 3474e67e8f..235e26a90e 100644
> > > > > > --- a/dir.c
> > > > > > +++ b/dir.c
> > > > > > @@ -2144,7 +2144,7 @@ static enum path_treatment
> > > > > > treat_path_fast(struct dir_struct *dir,
> > > > > >   /*
> > > > > >   * We get path_recurse in the first run when
> > > > > >   * directory_exists_in_index() returns index_nonexistent. We
> > > > > > - * are sure that new changes in the index does not impact the
> > > > > > + * are sure that new changes in the index does not affect the
> > > > > >   * outcome. Return now.
> > > > > >   */
> > > > > >   return path_recurse;
> > > > > > diff --git a/t/perf/p5550-fetch-tags.sh b/t/perf/p5550-fetch-ta=
gs.sh
> > > > > > index d0e0e019ea..1fcb98443c 100755
> > > > > > --- a/t/perf/p5550-fetch-tags.sh
> > > > > > +++ b/t/perf/p5550-fetch-tags.sh
> > > > > > @@ -8,7 +8,7 @@ follows.
> > > > > >
> > > > > >  The parent repository has a large number of tags which are dis=
connected from
> > > > > >  the rest of history. That makes them candidates for tag-follow=
ing, but we never
> > > > > > -actually grab them (and thus they will impact each subsequent =
fetch).
> > > > > > +actually grab them (and thus they will affect each subsequent =
fetch).
> > > > > >
> > > > > >  The child repository is a clone of parent, without the tags, a=
nd is at least
> > > > > >  one commit behind the parent (meaning that we will fetch one o=
bject and then
> > > > > > diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> > > > > > index a594b4aa7d..95daba4000 100755
> > > > > > --- a/t/t0008-ignores.sh
> > > > > > +++ b/t/t0008-ignores.sh
> > > > > > @@ -315,7 +315,7 @@ test_expect_success_multi 'needs work tree'=
 '' '
> > > > > >  # test standard ignores
> > > > > >
> > > > > >  # First make sure that the presence of a file in the working t=
ree
> > > > > > -# does not impact results, but that the presence of a file in =
the
> > > > > > +# does not affect results, but that the presence of a file in =
the
> > > > > >  # index does unless the --no-index option is used.
> > > > > >
> > > > > >  for subdir in '' 'a/'
> > > > > > diff --git a/t/t0303-credential-external.sh b/t/t0303-credentia=
l-external.sh
> > > > > > index f028fd1418..a9348f655a 100755
> > > > > > --- a/t/t0303-credential-external.sh
> > > > > > +++ b/t/t0303-credential-external.sh
> > > > > > @@ -41,7 +41,7 @@ test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" |=
|
> > > > > >   eval "$GIT_TEST_CREDENTIAL_HELPER_SETUP"
> > > > > >
> > > > > >  # clean before the test in case there is cruft left
> > > > > > -# over from a previous run that would impact results
> > > > > > +# over from a previous run that would affect results
> > > > > >  helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> > > > > >
> > > > > >  helper_test "$GIT_TEST_CREDENTIAL_HELPER"
> > > > > > diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-deta=
ch.sh
> > > > > > index bc46713a43..568c258c5a 100755
> > > > > > --- a/t/t2020-checkout-detach.sh
> > > > > > +++ b/t/t2020-checkout-detach.sh
> > > > > > @@ -202,7 +202,7 @@ test_expect_success 'describe_detached_head=
 prints
> > > > > > no SHA-1 ellipsis when not as
> > > > > >
> > > > > >   You are in 'detached HEAD' state. You can look around, make e=
xperimental
> > > > > >   changes and commit them, and you can discard any commits you =
make in this
> > > > > > - state without impacting any branches by switching back to a b=
ranch.
> > > > > > + state without affecting any branches by switching back to a b=
ranch.
> > > > > >
> > > > > >   If you want to create a new branch to retain commits you crea=
te, you may
> > > > > >   do so (now or later) by using -c with the switch command. Exa=
mple:
> > > > > > @@ -284,7 +284,7 @@ test_expect_success 'describe_detached_head=
 does
> > > > > > print SHA-1 ellipsis when asked
> > > > > >
> > > > > >   You are in 'detached HEAD' state. You can look around, make e=
xperimental
> > > > > >   changes and commit them, and you can discard any commits you =
make in this
> > > > > > - state without impacting any branches by switching back to a b=
ranch.
> > > > > > + state without affecting any branches by switching back to a b=
ranch.
> > > > > >
> > > > > >   If you want to create a new branch to retain commits you crea=
te, you may
> > > > > >   do so (now or later) by using -c with the switch command. Exa=
mple:
> > > > > > diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> > > > > > index 6cca8b84a6..97365a7786 100755
> > > > > > --- a/t/t4013-diff-various.sh
> > > > > > +++ b/t/t4013-diff-various.sh
> > > > > > @@ -109,7 +109,7 @@ test_expect_success setup '
> > > > > >   git checkout -f master &&
> > > > > >
> > > > > >   # Same merge as master, but with parents reversed. Hide it in=
 a
> > > > > > - # pseudo-ref to avoid impacting tests with --all.
> > > > > > + # pseudo-ref to avoid affecting tests with --all.
> > > > > >   commit=3D$(echo reverse |
> > > > > >   git commit-tree -p master^2 -p master^1 master^{tree}) &&
> > > > > >   git update-ref REVERSE $commit &&
> > > > > > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > > > > > index 7204799a0b..33a6efce2f 100755
> > > > > > --- a/t/t5000-tar-tree.sh
> > > > > > +++ b/t/t5000-tar-tree.sh
> > > > > > @@ -379,7 +379,7 @@ test_expect_success 'catch non-matching pat=
hspec' '
> > > > > >  # Pull the size and date of each entry in a tarfile using the =
system tar.
> > > > > >  #
> > > > > >  # We'll pull out only the year from the date; that avoids any =
question of
> > > > > > -# timezones impacting the result (as long as we keep our test =
times away from a
> > > > > > +# timezones affecting the result (as long as we keep our test =
times away from a
> > > > > >  # year boundary; our reference times are all in August).
> > > > > >  #
> > > > > >  # The output of tar_info is expected to be "<size> <year>", bo=
th in decimal. It
> > > > > > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > > > > > index 6348e8d733..ff65f86f50 100644
> > > > > > --- a/t/test-lib-functions.sh
> > > > > > +++ b/t/test-lib-functions.sh
> > > > > > @@ -1379,7 +1379,7 @@ mingw_read_file_strip_cr_ () {
> > > > > >  }
> > > > > >
> > > > > >  # Like "env FOO=3DBAR some-program", but run inside a subshell=
, which means
> > > > > > -# it also works for shell functions (though those functions ca=
nnot impact
> > > > > > +# it also works for shell functions (though those functions ca=
nnot affect
> > > > > >  # the environment outside of the test_env invocation).
> > > > > >  test_env () {
> > > > > >   (
> > > > > > --
> > > > > > 2.17.1
> > > > > >
> > > > > > On Tue, 6 Apr 2021 at 19:06, Varun Varada <varuncvarada@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > On Tue, 6 Apr 2021 at 18:01, Jeff King <peff@peff.net> wrote:
> > > > > > > >
> > > > > > > > On Tue, Apr 06, 2021 at 02:36:27PM -0500, Varun Varada wrot=
e:
> > > > > > > >
> > > > > > > > > > while using "will not impact" in an incorrect or unclea=
r way may be a
> > > > > > > > > > problem the word "impact" in itself is not "jargon".
> > > > > > > > >
> > > > > > > > > The word means "to have a strong or marked effect on" (v.=
) and "a
> > > > > > > > > strong or market influence" (n.) when used figuratively; =
it is not
> > > > > > > > > synonymous with "affect" and "effect", respectively, as s=
hown even by
> > > > > > > > > all of the entries you've cited. Using it as such is the =
incorrect
> > > > > > > > > part, so those are the instances I've changed in the diff=
.
> > > > > > > >
> > > > > > > > Er, is that true? From Michal's definitions:
> > > > > > > >
> > > > > > > > > > From The Collaborative International Dictionary of Engl=
ish v.0.48 :
> > > > > > > > > [...]
> > > > > > > > > >      2. To affect or influence, especially in a signifi=
cant or
> > > > > > > >
> > > > > > > > It literally uses "affect" to define it. The "especially si=
gnificant"
> > > > > > > > does not apply to many, but I don't think that makes it nec=
essarily
> > > > > > > > wrong to use impact to mean "affect".
> > > > > > >
> > > > > > > I was drawing attention to the "especially significant" bit a=
nd the
> > > > > > > like being there in all the entries. I'm not sure about these
> > > > > > > dictionaries, but the definition is hyperbolic / violent / sh=
ocking in
> > > > > > > every reputable dictionary out there: the Oxford English Dict=
ionary,
> > > > > > > Merriam-Webster, and Collins.
> > > > > > >
> > > > > > > >
> > > > > > > > Likewise:
> > > > > > > >
> > > > > > > > > > From WordNet (r) 3.0 (2006) :
> > > > > > > > > [...]
> > > > > > > > > >       v 1: press or wedge together; pack together
> > > > > > > > > >       2: have an effect upon; "Will the new rules affec=
t me?" [syn:
> > > > > > > > > >          affect, impact, bear upon, bear on, touch on,
> > > > > > > > > >          touch]
> > > > > > > >
> > > > > > > > That is likewise listing "impact" and "affect" as synonyms.
> > > > > > > >
> > > > > > > > I do agree the word is over-used in some forms of writing, =
but I don't
> > > > > > > > find anything at all confusing or wrong about the uses that=
 you changed
> > > > > > > > in your patch. I am a native speaker of English. I'm open t=
o the
> > > > > > > > argument that non-native speakers may be more confused by t=
he word. But
> > > > > > > > this seems like mostly a style preference thing, and I'd ge=
nerally
> > > > > > > > prefer to leave the contributions and style of the original=
 writers
> > > > > > > > intact unless there is a good reason not to.
> > > > > > >
> > > > > > > I am a native English speaker as well, and there were multipl=
e places
> > > > > > > where I had to think twice about what the sentences mean. I a=
gree with
> > > > > > > your sentiment about leaving stylistic preferences intact, bu=
t this is
> > > > > > > actually a semantic one. And given that there is a perfectly =
good
> > > > > > > alternative that doesn't have this confusion / jargon status,=
 I wanted
> > > > > > > to make the change to improve it, especially where it says th=
at in the
> > > > > > > output of the git command (`git checkout` when in detached HE=
AD mode).
> > > > > > >
> > > > > > > >
> > > > > > > > Such changes are doubly unwanted in cases like this:
> > > > > > > >
> > > > > > > > > --- a/compat/nedmalloc/malloc.c.h
> > > > > > > > > +++ b/compat/nedmalloc/malloc.c.h
> > > > > > > > > @@ -2952,7 +2952,7 @@ static size_t traverse_and_check(ms=
tate m);
> > > > > > > > >  #endif /* (FOOTERS && !INSECURE) */
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > -/* In gcc, use __builtin_expect to minimize impact of ch=
ecks */
> > > > > > > > > +/* In gcc, use __builtin_expect to minimize affect of ch=
ecks */
> > > > > > > > >  #if !INSECURE
> > > > > > > > >  #if defined(__GNUC__) && __GNUC__ >=3D 3
> > > > > > > > >  #define RTCHECK(e)  __builtin_expect(e, 1)
> > > > > > > >
> > > > > > > > where the text is imported from another project, and we'd p=
refer to stay
> > > > > > > > as close to their version as possible (e.g., to avoid unnec=
essary
> > > > > > > > conflicts when pulling in new versions).
> > > > > > >
> > > > > > > That's fair; I wasn't aware that this was being pulled direct=
ly from
> > > > > > > another project. I can change this back.
> > > > > > >
> > > > > > > >
> > > > > > > > Also, this one should be "effect" anyway, as it is a noun.
> > > > > > >
> > > > > > > This seems to have slipped through, as I used a text search t=
ool.
> > > > > > >
> > > > > > > >
> > > > > > > > -Peff

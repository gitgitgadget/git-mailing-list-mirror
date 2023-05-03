Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B3C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjECSU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjECSUy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:20:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6C1468B
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:20:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6a5f7341850so3953398a34.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138048; x=1685730048;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0EpbgelAgeqCo6cDdWT4RfsS2AqJnOmrMMGavlHvCc=;
        b=Y74Huw1P586FgBzXySfqyXC+qnGdPsqcb3Zav9yUoYliBHnM8YkmirdDgGz2MwjgY2
         dLzghpdL+LrcoroHDkYfGpEtIXaIrjzPM8JbJefSuQDaCavrsoOz7pwKB5xfZa8zmf49
         YY4xT1uNU1PO/Nx7XFWomz62i14m4JcUaG6iXavfYNYqaeVpLO4+J9lD0sLLpkjsFbbj
         qoUWWjaY7MwOATY0Hqyuri116/nQUO7PWPkfOfIfJX3OF+ApHKR0L7auq5CpOvf9PzN0
         eUIm8/0wukYzhi12dEeTyfHmEPZy0T4WOgNkU7WovdssbDpDE1LcHnWADTEPpCvMmI+R
         cyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138048; x=1685730048;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0EpbgelAgeqCo6cDdWT4RfsS2AqJnOmrMMGavlHvCc=;
        b=W5jneB7ycymrAtv49TJxN5xNzTpA2Vo1BhLDJXM5CftRFyxRo2k/V4Kp1c5ygX4MZp
         ogMcyVSqemfZ8y8Q4N8Vf2k5EahpB7w0uE5OCdf0PYWImTjkYpfQ/HzeHvZH45iVTO0A
         9weczLTU/hqFn40Zxzin0DDvhkhrncqHPLi7mzbq6hcMJ79mW8vF6R2u617xEDDZA4Lh
         0w1T7qxLwhxf3nJnS5+pH2LjloI3Hc3tHkv7EV5JgHmwSWPcg83MJmWBRXHPsK+HETpV
         syrzJizRmQbsAbhngQ40Vq9fskn7NaeQ4zV3BI7K57og/mPuMqfyO6jrruYX1ZeWfsa+
         Eggw==
X-Gm-Message-State: AC+VfDyWU7NGbME6QPtN9vXOWEXpXUOFnKCLKoC8BQLu9hZSYWo3PSyx
        NtjOMeDLVgQm7DEcRVbk7rU=
X-Google-Smtp-Source: ACHHUZ61ams1Yv6EE0IZANSEURhkloQ6RRSXbyKjCFwBzrkwzNIbO8DPFdgPCftPSiOBVSULbhxK2Q==
X-Received: by 2002:a9d:68c5:0:b0:6a5:f682:44ca with SMTP id i5-20020a9d68c5000000b006a5f68244camr11710210oto.16.1683138047762;
        Wed, 03 May 2023 11:20:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v23-20020a05683011d700b006a415c6f304sm822900otq.68.2023.05.03.11.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:20:46 -0700 (PDT)
Date:   Wed, 03 May 2023 12:20:45 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     demerphq <demerphq@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Message-ID: <6452a5fdf2bd9_6822945f@chronos.notmuch>
In-Reply-To: <CANgJU+UasufF7-B8ukEMm_Lv8gu4wUpaVKa9AOBacDHJvi7fxQ@mail.gmail.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
 <CANgJU+UasufF7-B8ukEMm_Lv8gu4wUpaVKa9AOBacDHJvi7fxQ@mail.gmail.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq wrote:
> On Wed, 3 May 2023 at 02:17, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Changing the subject as this message seems like a different topic.
> > Jeff King wrote:
> > > On Wed, Apr 26, 2023 at 02:33:30PM -0700, Junio C Hamano wrote:
> > > > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > > >
> > > > >  `GIT_DEFAULT_HASH`::
> > > > >   If this variable is set, the default hash algorithm for new
> > > > >   repositories will be set to this value. This value is current=
ly
> > > > > + ignored when cloning if the remote value can be definitively
> > > > > + determined; the setting of the remote repository is used
> > > > > + instead. The value is honored if the remote repository's
> > > > > + algorithm cannot be determined, such as some cases when
> > > > > + the remote repository is empty. The default is "sha1".
> > > > > + THIS VARIABLE IS EXPERIMENTAL! See `--object-format`
> > > > > + in linkgit:git-init[1].
> > > >
> > > > We'd need to evantually cover all the transports (and non-transpo=
rt
> > > > like the "--local" optimization) so that the object-format and ot=
her
> > > > choices are communicated from the origin to a new clone anyway, s=
o
> > > > this extra complexity "until X is fixed, it behaves this way, but=

> > > > otherwise the variable is read in the meantime" may be a disservi=
ce
> > > > to the end users, even though it may make it easier in the shorte=
r
> > > > term for maintainers of programs that rely on the buggy "git clon=
e"
> > > > that partially honored this environment variable.
> > > >
> > > > In short, I am still not convinced that the above is a good desig=
n
> > > > choice in the longer term.
> > >
> > > I also think it is working against the backwards-compatible design =
of
> > > the hash function transition.
> >
> > To be honest this whole approach seems to be completely flawed to me =
and
> > against the whole design of git in the first place.
> >
> > In a recent email Linus Torvalds explained why object ids were
> > calculated based {type, size, data} [1], and he explained very clearl=
y
> > that two objects with exactly the same data are not supposed to have =
the
> > same id if the type is different.
> =

> He said:
> =

> --- quote-begin ---
> The "no aliasing" means that no two distinct pointers can point to the
> same data. So a tagged pointer of type "commit" can not point to the
> same object as a tagged pointer of type "blob". They are distinct
> pointers, even if (maybe) the commit object encoding ends up then
> being identical to a blob object.
> --- quote-end ---
> =

> As far as I could tell he didn't really explain *why* he wanted this,
> and IMO it is non-obvious why he would care if a blob and a commit had
> the same text, and thus the same ID. He just said he didnt want it to
> happen, not why.

But we don't need to understand why to know it's part of the core design.=


If something is part of the core design as a rule it's better to not
mess with it.

> I can imagine some aesthetic reasons why you might want to ensure that
> no blob has the same ID as a commit, and I can imagine it might make
> debugging easier at certain points, but it seems unnecessary given the
> data is write once.

I don't know, but to me separating objects makes sense not just conceptua=
lly,
but in practice there's a whole class of potential errors that could be
avoided.

For example, I can think of an implementation of `git prune` that would c=
heck
commits first, then trees, then blobs, and the blobs that not reachable f=
rom
any trees are removed. But if a commit can have the same id as a blob, yo=
u have
to think of a different implementation.

If that's not possible, then you just forget about those potential issues=
.

> > If even the tiniest change such as adding a period to a commit messan=
ge
> > changes the object id (and thus semantically makes it a different
> > object), then it makes sense that changing the type of an object also=

> > changes the object id (and thus it's also a different object).
> >
> > And because the id of the parent is included in the content of every
> > commit, the top-level id ensures the integrity of the whole graph.
> >
> > But then comes this notion that the hash algorithm is a property of t=
he
> > repository, and not part of the object storage, which means changing =
the
> > whole hash algorithm of a repository is considered less of a change t=
han
> > adding a period to the commit message, worse: not a change at all.
> =

> I really dont understand why you think having two hash functions
> producing different results for the same data is comparable to a
> single hash producing different results for different data.

That depends on what you consider the "data" to be.

If you consider the content of a blob to be the data, then you wouldn't
have different results if a commit has the same data: it would be the
same id.

If instead you consider the data to be `type+content`, then you would
have different results.

> In one case you have two different continuum of identifiers, with one
> ID per continuum, and in the other you have two different identifiers
> in the same continuum, and  if you a continuum you would have 4
> different identifiers right? Eg, the two cases are really quite
> different at a fundamental level.

That entirely depends on what data you hash.

If you hash `algo+type+size+data` there's only one id per object.
Period.

> > I am reminded of the warning Sam Smith gave to the Git project [2] wh=
ich
> > seemed to be unheard, but the notion of cryptographic algorithm agili=
ty
> > makes complete sense to me.
> >
> > In my view one repository should be able to have part SHA-1 history,
> > part SHA3-256 history, and part BLAKE2b history.
> =

> Isn't this orthagonal to your other points?

Not if you consider changing the hash algorithm of a repository to be an
important part of its history (more important than adding a period to a
commit).

> > Changing the hash algorithm of one commit should change the object id=
 of
> > that commit, and thus make it semantically a different commit.
> >
> > In other words: an object of type "blob" should never be confused wit=
h
> > an object of type "blob:sha-256", even if the content is exactly the
> > same.
> =

> This doesn't make sense to me.  As long as we can distinguish the
> hashes produced by the different hash functions in use we can create a
> mapping of the data that is hashed such that we have a 1:1 mapping of
> identifiers of each type at which point it really doesn't matter which
> hash function is used.

Yes, we *can*, that doesn't mean we *should*.

If you do `git commit --ammend --signoff` to add your `Signed-off-by` to
a commit, there's a 1:1 mapping from the original commit, to the new
one, but conceptually in git they are different objects.

I recall Linus Torvalds mentioned he used Monotone as a guideline of
what *not* to do. In Monotone you could add the equivalent of
`Signed-off-by` without changing the hash of the commit, in fact, you
could add any metadata if I recall correctly. But this opens a whole can
of worms because now how do you know you have all the metadata relevant
to the commit?

Making all the metadata of a commit part of the commit solves the
integrity problem Monotone had at the cost of making git commits
essentially immutable: any change means it's a different commit.

If making *any* change in the object, makes it conceptually a different
object, including the type of the object, how on Earth is changing the
hash algorithm not considered a change?

This object:

  =E2=9D=AF git hash-object -t blob /dev/null
  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

Is considered different from this object:

  =E2=9D=AF git hash-object -t tree /dev/null
  4b825dc642cb6eb9a060e54bf8d69288fbee4904

That's why they have a different hash.

Why would these objects be considered the same?

  =E2=9D=AF git hash-object -t blob /dev/null
  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

  =E2=9D=AF git hash-object -t blob /dev/null
  473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813

It makes *zero* sense that adding a period changes the object, adding a
s-o-b changes the object, changing the type changes the object, but
changing the hash algorithm does not.

> > The fact that apparently it's so easy to clone a repository with
> > the wrong hash algorithm should give developers pause, as it means th=
e
> > whole point of using cryptographic hash algorithms to ensure the
> > integrity of the commit history is completely gone.
> =

> This is a leap too far. The fact that it is "so easy to clone a repo
> with the wrong hash algorithm" is completely orthogonal to the
> fundamental principles of hash identifiers from strong hash functions.

Only if you think changing the hash algorithm is a less important part
of an object than adding a period.

Do you honestly think these two should be considered the same object?

a)

  tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
  author Felipe Contreras <felipe.contreras@gmail.com> 0 -0600
  committer Felipe Contreras <felipe.contreras@gmail.com> 0 -0600

  Initial commit

b)

  tree 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321
  author Felipe Contreras <felipe.contreras@gmail.com> 0 -0600
  committer Felipe Contreras <felipe.contreras@gmail.com> 0 -0600

  Initial commit

> You seem to be deriving grand conclusions from what sounds to me like
> a simple bug/design-oversight.

I think you are dismissing the brilliant idea that made git's object
storage model so successful.

> > I have not been following the SHA-1 -> OID discussions, but I
> > distinctively recall Linus Torvalds mentioning that the choice of usi=
ng
> > SHA-1 wasn't even for security purposes, it was to ensure integrity.
> > When I do a `git fetch` as long as the new commits have the same SHA-=
1
> > as parent as the SHA-1s I have in my repository I can be relatively
> > certain the repository has not been tampered with. Which means that i=
f I
> > do a `git fetch` that suddenly brings SHA-256 commits, some of them m=
ust
> > have SHA-1 parents that match the ones I currently have. Otherwise ho=
w
> > do I know it's the same history?
> =

> So consider what /could/ happen here. You fetch a commit which uses
> SHA-256 into a repo where all of your local commits use SHA-1. The
> commit you fetched says its parent is some SHA-256 ID you don't know
> about as all your ID's are SHA-1. So git then could go and construct
> an index, hashing each item using SHA-256 instead of SHA-1, and using
> the result to build a bi-directional mapping from SHA-1 to SHA-256 and
> back.  All it has to do then is look into the mapping to find if the
> SHA-256 parent id is present in your repo. If it is then you know it's
> the same history.

Yeah, that *could* happen. Doesn't mean it *should*.

> The key point here is that if you ignore SHAttered artifacts (which
> seems reasonable as you can detect the attack during hashing)  you can
> build a 1:1 map of SHA-1 and SHA-256 ids.  Once you have that mapping
> it doesn't matter which ID is used.

It may not matter to you. It matters to me.

> > Maybe that's one of the reasons people don't seem particularly eager =
to
> > move away from SHA-1:
> =

> Maybe, but it doesn't make sense to me.  You seem to be putting undue
> weight on an unnecessary aspect of the git design: there doesn't seem
> to be a reason for Linuses "no aliasing" policy, and it seems like one
> could build a git-a-like without it without suffering any significant
> penalties.

The fact you don't see a reason doesn't mean there isn't one. This is an
argument from ignorance fallacy.

The appendix was considered a vestigial organ because nobody could see a
reason for it. Did that mean it served no puprpose? No.

> Regardless, provided that the hash functions allow a 1:1 mapping of
> ID's (which is assumed by using "collision free hash functions"), it
> seems like it really doesn't matter which hash is used at any given
> time.

People who designed CVS, Subversion, Monotone, and Mercurial didn't see
a reason for many of Git's design choices either.

I'd argue they were wrong.

I think changing the hash algorithm of a commit matters.

Cheers.

-- =

Felipe Contreras=

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4ADC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 07:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjAMH1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 02:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbjAMH0w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 02:26:52 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A236C7E7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 23:22:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v25so31827272lfe.12
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 23:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t15uhPn0/wTssDL8VHRJwe4qQvAmA+bnZr0N9vLrK/E=;
        b=BUv7nAQeY2IMxNWJ6WFx4q9OUWSBO2B0LewMx8VVkvDwVDi6dPLmyGIt1Wpg4iL18z
         bn6pO7pOBbrpnUFHl4ycR8rbB+z9uHVPfSmREYDcz9pUCpCS6jUKi2ko6zf49aqX5fym
         PnJLfllwWF3qvR6TJ6xGnO3LJafTmmKEkYqt/9dTmS04Hg2QTDyDGlX6cBr49X62wYRg
         8ZrvP7DlVQnZnty4Lyb2GUdTjXPz6KN4OF0Z2AdLc5TsK4Jokt9LcFemlFSb395Ck7Gd
         WrVoArq/2dGyCjejPwvTaIXFKDkL8M84id2+4qAm/c36SybG+wYjhbq1abtdSUdFSew6
         QfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t15uhPn0/wTssDL8VHRJwe4qQvAmA+bnZr0N9vLrK/E=;
        b=gdBpA/P0gC2E8pe/6by0vWijQQGYTTmrNzpWkpCmzTvGReoGub/yuEXa223dbuDkjx
         910qJxoxK6iqXtM0G0fjM9R/yN6vhSLqw6uDpWluyrGYxL/bkButV/I4cBwYL4A6mIB9
         M22kryjxTWhOgGPGMWcofP1TFfclfFn69SY0hv0OyLytWtRm7sUg/PRn1z/GslOOIgqo
         s8sGa5aqhIXa/JWuysW9Hd6rzW5ZNIdWdR8jTimaKAp4Ak7k06YcNbED/tPO2tvCg8Ol
         LSMIhCGzdG5vzQ070hfti13f327XA8RsfS1FHt++Pa0qxeHAogU3AuEWzv0SK+Iw6vwI
         +p3A==
X-Gm-Message-State: AFqh2koLWjVrlYoQla1JmYx0NDSaIFtqCZM6C6IMUuF5fNzkb7ObOvHF
        hx4pxyiJJnvHHh6qV2utKioVwm6OWfg3GNz0jFY=
X-Google-Smtp-Source: AMrXdXt4CpMIWQ0DW7TMXx7e7PR1PZEzN5jlh28fZa1khhTPEu4X46oZBNhZ2fzJVEQrWNI1GwcnfVwvtRvjGUI50Dg=
X-Received: by 2002:ac2:5550:0:b0:4ca:fa6a:1506 with SMTP id
 l16-20020ac25550000000b004cafa6a1506mr4963715lfk.32.1673594528050; Thu, 12
 Jan 2023 23:22:08 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com> <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
 <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org> <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
 <CAPkN8x+agKRRD0Zd-pxs_EuYO_Xm8EyE0nJLCWQB4KNuNkvK8Q@mail.gmail.com>
 <CABPp-BH5RhHR-KhhumuhZGy2F4ypUBoqgAatY5MKkQsB46KM4g@mail.gmail.com>
 <CAPkN8xLN_fKdbU8ugxLYJ1YeCJ8CxBWh+kdhAq1mR8hfAe-NAA@mail.gmail.com>
 <CABPp-BEqvmSaqVrK=nQsk-8PNXq6Pzq4Y-=RopYwTDjtyitAuw@mail.gmail.com> <CAPkN8xJ_B_t7L6bErsFB+rp6fzy7PO55myWqyJWPNbTgiQ69ow@mail.gmail.com>
In-Reply-To: <CAPkN8xJ_B_t7L6bErsFB+rp6fzy7PO55myWqyJWPNbTgiQ69ow@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Jan 2023 23:21:55 -0800
Message-ID: <CABPp-BFRBc4sNHcmbEZOvXxA1wVBiQn2VQUkSkbFnpz++yT8hw@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 11, 2022 at 10:30 AM anatoly techtonik <techtonik@gmail.com> wrote:
>
> On Tue, Aug 10, 2021 at 8:58 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Tue, Aug 10, 2021 at 8:51 AM anatoly techtonik <techtonik@gmail.com> wrote:
> > >
> > > On Mon, Aug 9, 2021 at 9:15 PM Elijah Newren <newren@gmail.com> wrote:
> > > >
> >
> > [2] https://lore.kernel.org/git/CABPp-BH4dcsW52immJpTjgY5LjaVfKrY9MaUOnKT3byi2tBPpg@mail.gmail.com/
> >
> > Signed commits is just one issue, and you'll have to add special code
> > to handle a bunch of other special cases if you go down this route.
> > I'd rephrase the problem.  You want to know when _your tool_ (e.g.
> > reposurgeon since you refer to it multiple times; I'm guessing you're
> > contributing to it?) has not modified a commit or any of its
> > ancestors, and when it hasn't, then _your tool_ should remove that
> > commit from the fast-export stream and replace any references to it by
> > the original commit's object id.  I outlined how to do this in [2],
> > referenced above, making use of the --show-original-ids flag to
> > fast-export.  If you do that, then for any commits which you haven't
> > modified (including not modifying any of its ancestors), then you'll
> > keep the same commits as-is with no stripping of gpg-signatures or
> > canonicalization of objects, so that you'll have the exact same commit
> > IDs.  Further, you can do this today, without any changes to git
> > fast-export or git fast-import.
>
> Took me a while to process the reply. Let's recap.
>
> I want to make a roundtrip export/import of
> https://github.com/simons-public/protonfixes which should get exactly
> the same repository.

As I've stated a few times in the thread, this request of yours is
simply impossible for general repositories ([1] contains the best
summary of the reasons).  For the specific repository in question, the
only relevant roadblocker is the presence of a signed commit which
happens to be a root commit.  That opens the door to some workarounds
that could be used with this specific repository.

[1] https://lore.kernel.org/git/CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com/

I provided two workarounds you could try to use for your specific case
at [2] and [3], one of which you ask about below.

[2] https://lore.kernel.org/git/CABPp-BE=9wzF6_VypoR-uEPHsLWdV7zyE13FOgLK0h8NOcMz3g@mail.gmail.com/
[3]  https://lore.kernel.org/git/CABPp-BH4dcsW52immJpTjgY5LjaVfKrY9MaUOnKT3byi2tBPpg@mail.gmail.com/

> # --- fast-export to exported.txt
> git clone https://github.com/simons-public/protonfixes
> git -C protonfixes fast-export --all > exported.txt
> # --- check revision of the repo
> git -C protonfixes rev-parse HEAD
> # 681411ba8ceb5d2d790e674eb7a5b98951d426e6
>
> # --- fast-import into new repo
> git init newrepo
> git -C newrepo fast-import < exported.txt
> # --- checking revision of the new repo
> git -C newrepo rev-parse HEAD
> # 9888762d7857d9721f0c354e7fc187a199754a4b
>
> Hashes don't match. The roundtrip fails.

As expected, given that one of your commits is signed.

> Let's see if --reference-excluded-parents helps.
>
> # --- export below produces the same export stream as above
> git -C protonfixes fast-export --reference-excluded-parents --all >
> exported_parents.txt

--reference-excluded-parents only has effect if there are excluded
parents.  You didn't exclude any parents, so obviously adding this
flag isn't going to change anything.  You should instead first
clone/fetch the part of history up to the commits you want to keep
intact (e.g. the signed commits), and then run a command like
   git -C protonfixes fast-export --reference-excluded-parents
^${BASECOMMIT1} ^${BASECOMMIT2} ^${BASECOMMITN} --all
>exported_only_newer_history.txt | git -C newrepo fast-import

Note that the examples I gave you (e.g. [2] above) all used some
excluded references (e.g. "^master~5").

> Because fast-import/fast-export don't work

You have not yet identified a bug in either, so I disagree with this comment.

>, you propose to keep the old
> repo around until it is clear which commits I am going to modify.


This statement framing looks really weird to me.  You have posed your
problem in the form of doing some kind of export/import operation,
which is fine.  However, in order to do an export operation, you
obviously need the repository in order to export it.  So why are you
calling out that you keep the repo around until you run the
fast-export command?

Anyway, that aside...

I was just saying that
  (1) signed commits exist as a method to ensure to other users that
the commits have not been modified
  (2) fast-export and fast-import exist to allow you to modify history
in some fashion (and are separate steps so people can edit the stream
between running the two commands)
  (3) the above two imply that if you still want users to be able to
verify the signed commits, that signed commits should NOT be sent
through fast-export and fast-import
  (4) therefore, if you want the signed commits kept as-is, you should
simply fetch the history up to and including those, and only send the
remainder of the history through fast-export/fast-import.

But I will add here one additional thing:

If you're weaving repositories together, that likely changes the
parent(s) of some of the commits.  Once you change the parent(s) of a
commit, that alone changes the commit and invalidates any signature it
has.  In your case you seem to only have a root commit that is signed,
and if you keep that signed commit as a root commit, you can avoid
this problem.  But, in general, if signed commits are involved in the
weaving such that they gain new parents, then what you want to do is
simply impossible; you will not be able to keep the signatures in such
a case (and the commit ids will change as well).

> Then
> make a new fast-export starting from the first commit I am going to
> modify with --reference-excluded-parents flag. Is that correct so far?

You have the basic idea, but you are making things excessively complex
with one detail here -- it does not need to start with the first
commit you are going to modify; it can start earlier.  You can simply
export all commits after the one(s) you know you don't want to change.
For example, if the history looks like this:

A---B---C---D---E---F

and commits A and B are the only signed commits (which you want to
preserve) and commit D is the first one you are going to modify, you
could still run fast-export on "^A ^B F" (i.e. C, D, E, and F in this
case) -- that will also include C, but C isn't signed and round-trips
without problems, so it doesn't hurt to include it.

> Then given this partial export and old repo, how to init the new repo
> that fast-import can apply its tail there?

Flag the signed commit(s) with a branch or branches of some sort, then
fetch just those branches into the new repo.

> What if I have multiple commits that I modify, but I don't know which
> of their parents was first?

I wouldn't bother trying to figure out which one(s) is/are first.  (I
mean, you could do some revision walking to figure that out, in which
case you'd have to fetch more than just the history of the signed
commits you want to keep but everything prior to whatever first
commit(s) you want to modify.)

Instead, I'd just do the easier thing I noted above -- use the signed
commits as exclusion markers.

> And when I touch commits from different
> branches, how to recreate their parent history intact in one repo?

Place temporary branches pointing directly to each of the signed
commits you want to keep intact (which also implies you are keeping
all the history behind those commits intact as well), then run:

git -C newrepo fetch PATH_OR_URL_OF_OLD_REPO ${TEMPBRANCH1}
${TEMPBRANCH2} ${TEMPBRANCHN}

Then use the earlier suggestion of

git -C protonfixes fast-export --reference-excluded-parents
^${TEMPBRANCH1} ^${TEMPBRANCH2} ^${TEMPBRANCHN} --all
>exported_only_newer_history.txt | git -C newrepo fast-import

to get the remainder of the history exported/imported.



I will also add that since you are interested in attempting to
round-trip through fast-export/fast-import and still end up with the
same hashes (ignoring a few fundamental shortcomings mentioned earlier
in this thread that won't always permit this to work), you can at
least get closer by adding "--reencode=no" to fast-export (so that it
doesn't alter commit messages) and setting core.ignorecase=false for
at least the fast-import invocation (so that fast-import doesn't make
files which differ in case only clob each other while importing).
But, again, that only addresses like two issues out of half a dozen.
Again, see the link at [1] earlier in this email.

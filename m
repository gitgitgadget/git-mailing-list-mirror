Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F8C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 21:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGKVTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiGKVTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 17:19:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B0E0A3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:19:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so10952085ejr.5
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8+gO6yJMWUUfI0eloBQUhDnE9SPYjsPvQsL+5hykXYA=;
        b=VjvtAOJDvnKkD2fNt1Wzgk/a9aB4KLFI+4K1PA6FCMAL2AXXaqAQL/beELAjNDpXpj
         NT/yz3m6N1+gkdos+sYtGqweH4pO5iHSzCnz8QGzmo2nA6ElHBkd9W46in68AkwWPTHn
         3PpB588tHt9E86ixUAdnnMkIhd+iGOYUGiAtUg7CRl5YXqI6p9YdsaE4u4ASCOb3DTUt
         qe8pVSoBfhbIxxXEc41X7yd9JoKmWZkzJcUYjzbAnWB4ikKqkDmpuQlufcGXtdCsrSN8
         me88MUowGKq50zj1/UDuqhEiszQLqIEPCdMBNgyLRsCT6g69+SyBMNN5kl5B2ItScKAA
         dU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8+gO6yJMWUUfI0eloBQUhDnE9SPYjsPvQsL+5hykXYA=;
        b=h62/J3iRWX25sI5jBDuOClvcs+1RaOR5cH0DD19i+wIoIOy3ZdFfpVzmnKkYueAxjA
         g49pK3aasU4IZ2YrkL8Vm0lxEna4EirMPVfhyo4uKguh+QgTTJDwvDWCbrHS79ocXgYl
         46sf6+lbVt4j7UlbjiwbR9z81KCOpUEtmFamcUJPM66LIDM9sn656sP0C1krEOhZNRk2
         i1Bs3zneZKpavn5iNtCGDacLYN9snluNRsrwU38Q4Xv+i2bf7vbXI2feSxSkY3Gdzxbk
         uOBnEX/vBep1iATIoUzx7HYOi54R9txluNw3xTLHEF8119ArXrFgG9ReaGlGXNzjsznD
         joBA==
X-Gm-Message-State: AJIora/faCWSit9osAoakNIV/wie2ke8VXtdx8SB9ch1mprH5UC1m80O
        zZZQc9ThEAFWeAZl1aYyx/uep9N6IP0V5yk9vSTHuPAR
X-Google-Smtp-Source: AGRyM1s2M9obak0aMxBGQDuyL7odzYMfJrCq0UzJiO47jNtkBleZv29Q7UssVor4XEBuWuxUKN524w5TUoTT9qqIma8=
X-Received: by 2002:a17:907:d18:b0:726:3172:2266 with SMTP id
 gn24-20020a1709070d1800b0072631722266mr20591246ejc.476.1657574354584; Mon, 11
 Jul 2022 14:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <006c01d894aa$3b9f33b0$b2dd9b10$@nexbridge.com> <Yst1tmpBU0DHdi5P@tapette.crustytoothpaste.net>
 <007f01d894c5$8b1cd3a0$a1567ae0$@nexbridge.com> <CABPp-BF0vCE4pzKEhjzNaJAOQYkYQ3Wvt+H5guzD3aZLdMO8kQ@mail.gmail.com>
 <220711.86pmib5r8z.gmgdl@evledraar.gmail.com>
In-Reply-To: <220711.86pmib5r8z.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jul 2022 14:19:02 -0700
Message-ID: <CABPp-BGDQDHtvr_XmyoaSaipKGFw4xTQZuT3GrkZh9E61yXAyA@mail.gmail.com>
Subject: Re: Automatic code formatting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 1:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Jul 11 2022, Elijah Newren wrote:
>
> > On Sun, Jul 10, 2022 at 6:31 PM <rsbecker@nexbridge.com> wrote:
> >>
> >> On July 10, 2022 8:59 PM, brian m. carlson wrote:
> >> >On 2022-07-10 at 22:13:01, rsbecker@nexbridge.com wrote:
> >> >>
> >> >> Being one of the platforms that will be specifically excluded from
> >> >> this proposal, I would like to offer an alternative. Before that,
> >> >> please remember that not everything is Linux. My suggestion is to
> >> >> create infrastructure to automatically format on add/commit. This
> >> >> could be pluggable relatively simply with clean filter that is
> >> >> language specific - perhaps with a helper option that installs the
> >> >> formatter easily (because clean filters are notoriously painful to
> >> >> install for newbies from my observations). It would be nice to have
> >> >> something in perl that is more portable and pervasive than clang -
> >> >> although perl could launch clang where available. I think having
> >> >> infrastructure for code formatting that is built into git is actual=
ly
> >> >> highly desirable - assuming that it is not unduly difficult to inst=
all
> >> >> those. It would extend beyond git contributions, but the contributo=
rs
> >> >> could be told (Contributor's Guide) that then need to follow standa=
rd
> >> >> X, which may very well be clang format. There are java formatters, =
php
> >> >> and perl formatters, even COBOL and TAL formatters. My position is
> >> >> that having a standard way to plug these in is a more general plan
> >> >> that would reach a larger community. Git contributions could then j=
ust
> >> >> leverage standard git functionality.
> >> >
> >> >I am willing to acknowledge the fact that not everybody has clang on =
their
> >> >preferred platform.  However, I assume you do have a laptop or deskto=
p with
> >> >which you access your platform (since I believe it's a server
> >> >platform) and that you can install software there, or that you have t=
he ability to
> >> >run some sort of virtualization framework on some system.
> >> >
> >> >I am in general not very willing to say that we can't use or have use=
ful developer
> >> >tools because of uncommon platforms.  Linux, Windows, macOS, and (I b=
elieve)
> >> >FreeBSD, NetBSD, and OpenBSD all support clang and related tools, and=
 I don't
> >> >think it's unreasonable for us to expect that someone can have access=
 to such a
> >> >system as part of development, even if that's in a VM.  Those six ope=
rating
> >> >systems plus Chrome OS constitute the overwhelming majority of deskto=
p and
> >> >laptop systems, and there are several options which are free (both as=
 in speech
> >> >and beer).
> >> >
> >> >Moreover, clang and LLVM are extremely portable[0].  As a practical m=
atter, any
> >> >platform wanting to support software written in Rust (a popular and g=
rowing
> >> >language) will likely need LLVM, and there is also a lot of software =
in C and C++
> >> >that only supports GCC-compatible compilers.  I do feel that providin=
g support for
> >> >modern toolchains is an important part of providing a viable OS port,=
 and that we
> >> >should be able to rely on porters for that OS to do that work.  I rea=
lize that LLVM is
> >> >not yet ported to your system, but I believe it's going to functional=
ly need to
> >> >happen sooner or later.  When it does, you'll be able to send patches=
 directly
> >> >without needing to copy to another OS to format the code.
> >>
> >> I should point out that gcc will *never* according to our latest
> >> intel, be supported on my platforms. *Never* is, of course, an
> >> indeterminate definition, but until various matters I cannot legally
> >> discuss change, which are not likely for at least 5 years, anything
> >> depending on gcc is out of the picture and unavailable, including
> >> clang. I understand the position regarding git contributions, but I
> >> am trying to get the point across that formatting code to a standard
> >> is a more general desire than just git contributions. It is a broad
> >> desire/requirement that should be considered. Rather than making
> >> processes git-contribution-specific, providing a more general
> >> solution that git contributors can use is more effective.
> >
> > I don't understand why this matters to the proposal, though.  My
> > experience with projects adopting code-formatting is that there are
> > always some people who just don't use it (e.g. because they use a
> > different IDE that doesn't integrate with it, or they never bother
> > installing the extra tool, etc.).  Such users run the risk of having
> > automated CI jobs flag their code with a problem, and then they have
> > to go back and fix it, but it's still a net win because reviewers
> > don't have to spend time catching those problems, and the original
> > folks would have had to fix their code anyway.  In fact, in some
> > projects, I've been one of those users and having the project use a
> > code formatter that I didn't want to bother to set up and run didn't
> > negatively impact me at all.
> >
> > Whether or not we have an automatic formatter, you're still
> > responsible to fix your code to match the project's guidelines.  I
> > don't think that becomes any harder, because if we have an automatic
> > formatter, the _most_ that changes is there's a flag day where the
> > style is adjusted slightly.  After that point, all you have to do is
> > the same as today: look at the surrounding code to see the format and
> > follow it.  So, from what I can see, you lose nothing from this
> > proposal if it is implemented.
>
> I'm not saying I'm against this for the git project, but I think this is
> a rather rosy view of how automated code formatting tends to go. I've
> also seen all of:
>
>  * It used to be trivial-ish to submit a patch to the project, and as my
>    RFC series a lot of these minor formatting issues slide through the
>    cracks, and we're not really worse for wear, but now it becomes a
>    matter of automated enforcement.
>
>    Which can be good, but also...

I think here you are just arguing that it's a huge pile of work to
switch to using an automatic code formatter.  I totally agree and
estimate it at multiple man months, and predict that it'd involve
adopting a different style (because no code formatter seems to produce
exactly what the project wants).  And there's always exclusions to
deal with, such as generated code, "vendored code", and
don't-you-dare-touch-this-low-level-thing-last-touched-by-someone-no-longer=
-involved-in-the-project,
or whatever.  I've seen many scars from other projects.  The cost of
switching can be formidable and may itself be a compelling reason to
not go through the effort.  But I was responding to the objection
raised, which wasn't about the cost of switching, but about the
end-state after switching.

I don't see how, once we've made the switch, that the barrier to
submitting patches is any higher.

>  * I think what's being pointed out upthread here is that it's also
>    important that we pick development tools that are portable, because
>    yes you'll find out about the issue eventually, but it's much faster
>    if the turnaround is on your own computer.

Currently, no one can find out about such issues on their own
computer.  The suggested change to use an automatic formatter would
let 90% (number pulled from thin air) of contributors find out.  I
agree that it is better if 100% of contributors can find out about
these issues on their own computer, so portable tools would be
beneficial, but I don't see why letting 0% of contributors find out on
their own computer is better than letting 90% find out.

>    Some people who submit patches to git.git also don't use GitHub CI at
>    all, so they'd find out about it after it hits "seen".

Much as they also do for a variety of other issues.  What's the
problem with that?

>    You might argue that we'll catch it otherwise, but I have a "make"
>    command you can run to get a ~30k diff that demonstrates otherwise :)

And I think here you might be arguing against using "portable" tools
without realizing it.  I totally believe your 30k diff number without
even having tried it, due to the other battle scars I've seen in other
projects.  If adopting automatic code formatting was trivial, everyone
would have done it years ago.  It's a huge lift, and the odds of
trying to get it to work with the code style that already exists are
slim to none.  I suspect that writing a versatile code formatter is
pretty close to writing a compiler for many languages, so if I were
choosing one, I would bias very heavily towards using one associated
with a compiler for the language I'm using. (e.g. clang-format,
rustfmt, gofmt, etc.).

>  * For e.g. the struct alignment exceptions I pointed out in the RFC
>    cover letter I have myself (and seen others) written code that looks
>    visually pleasant, but the code formatter happens to hate it
>    (e.g. when you want to align a table in a certain way).
>
>    Yes, you can usually use whatever the magic "format off" incantation
>    is. But if you thought we had bikeshedding about code nits now, wait
>    until we have long threads about whether something is or isn't the
>    right time & place to override the automated formatting logic, and
>    whether clang-format is buggy or whatever :)
>
> In any case, per the RFC I sent I really think we should step more
> gently into this area.
>
> I was trying to find out if clang-format could be run in some mode where
> it could only adjust one bit of its configured formatting,
> e.g. "}\n\telse {" to "} else {", but I didn't find a way to do that.
>
> That would also be a way to phase it in, and see how helpful
> v.s. annoying it would be to e.g. run it in CI.

Yeah, I think we're in full agreement that switching is much harder
than it often looks on the surface, and may well have some costs in
terms of changing the existing style in some places.

I'd be (very) surprised if switching was easy, but if someone else
wants to do the work of switching, then I'm all for it.

Especially since from past experience in other projects, even if _I_
don't use the automatic code formatting tools, the end result is still
better than the starting state.

But, yeah, I'm not volunteering to help with the transition.  Just
voicing that I think if others are willing to put in the effort, then
I think they should get a green light to go for it.

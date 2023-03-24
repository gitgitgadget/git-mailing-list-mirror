Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA8C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 22:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjCXWaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 18:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCXW36 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 18:29:58 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355514993
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:29:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5416698e889so59367487b3.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679696996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5rKXh5468WehfGSBuZSGj/V9JF/0z4RBWy18jgWWOo=;
        b=UYkvRqYguaz4WbfnN2/ZgmaBy0S8we2CdSADbMMf/ROjJXmQU4f8lSRwYk60ofAkFL
         qgCNni0PjbOKRWLqhYaGABz4tCjtj13bcqlevkQZwm4Vyk7DxI4kuwavrvhbjrYYO7sc
         BNIuJ1/ASkWC+kTDCOc/1Cd3fQemJra/uTm2ARDclUvJTBXudR4eb6KczcwJASmI4I4p
         5W1+UHpRZNTPqnpUUuCtXTRo7MlDxlITdWmGA1zzutngeZGC7MrvNfrJ/Lt7l+HKVxXj
         zSqOsX/+6so94tG0KJAoWLOTABA04c+K67EfKq0kCKcfDlNt2kleMdyyt6paFnlXea5j
         PZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679696996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5rKXh5468WehfGSBuZSGj/V9JF/0z4RBWy18jgWWOo=;
        b=U+FSQW60GfOXTkGuSkwAc+HYApt6eUJEZdnC2sAGcgziCOIcO/1ndN3lCjy08SMDdw
         i2if8Z3fMi6yv4o+7N7KqEI/uu1ANwqQgIW9A9dMKnBfclF+IxmOlnrPGbKw2Ccxa2th
         8zpeTMJNntAxcyWYXcUCcT4KuzG97Juni8JtuFXXzNDs1d+u0V6nTR78JkDXDHNHN1HW
         QfLQDgs28Vrw87h74E8jK35/PXlYxLa9pBjmBOIpQL9VAdsO8PuGazBomeRD2btVcEQK
         EkBeQIjnql17UWaiDf4XS40DB4hH3Kp4qEIBByRN+yIf0/E1mrppyI+2NCgNKDxrTLP6
         aEIQ==
X-Gm-Message-State: AAQBX9dKYxYB6Ro5XMkywMVQFpbtw+2TxSBPpQq1nvBZChF2wgVNb8vm
        rqhtisT0MOqPknXDSZvXxp1KdY42wuKZRE/LC2xA7X923pc=
X-Google-Smtp-Source: AKy350ZUwVZOkl8IyRBSUfbyYwLNM9wwaNqvw5lIW0Z4vGcz8P+ciLnySANy1os24+3J/Oj+L7AvUvTMNcXDKAire2c=
X-Received: by 2002:a81:e308:0:b0:532:e887:2c23 with SMTP id
 q8-20020a81e308000000b00532e8872c23mr1811290ywl.9.1679696995838; Fri, 24 Mar
 2023 15:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g> <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
 <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk> <CAMP44s1Qqd2cYcf7OGxz1-PY-8TF2KG+9jPEWMrnCaCfPe_1sw@mail.gmail.com>
 <008101d95ddf$7863d900$692b8b00$@nexbridge.com> <CAMP44s1X6LGpFfA_Zb_GakXehBJDeGrfFcehPgv+YM++xKHN3A@mail.gmail.com>
 <008201d95de1$359285c0$a0b79140$@nexbridge.com> <CAMP44s3Gk67rPEPjoAxLHS4KrCQBb6VoPJ6Rqm-FTK+8PTaRRQ@mail.gmail.com>
 <004d01d95e86$bd355d40$37a017c0$@nexbridge.com> <CAMP44s3fXYcOsq-XRNZX0y6D=W37=ONELUpTBtkzv4KLbym2iA@mail.gmail.com>
 <005601d95e9c$dc20b360$94621a20$@nexbridge.com>
In-Reply-To: <005601d95e9c$dc20b360$94621a20$@nexbridge.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 24 Mar 2023 16:29:44 -0600
Message-ID: <CAMP44s3kNSctpOhuLHkCE6tLV9-9-5LpVoORSyWt-Ov5FJ=cow@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     rsbecker@nexbridge.com
Cc:     phillip.wood@dunelm.org.uk, demerphq <demerphq@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 4:06=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Friday, March 24, 2023 5:22 PM, Felipe Contreras wrote:
> >On Fri, Mar 24, 2023 at 1:28=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >>
> >> On Thursday, March 23, 2023 7:55 PM, Felipe Contreras wrote:
> >> >On Thu, Mar 23, 2023 at 5:43=E2=80=AFPM <rsbecker@nexbridge.com> wrot=
e:
> >> >>
> >> >> On Thursday, March 23, 2023 7:35 PM, Felipe Contreras wrote:
> >> >> >On Thu, Mar 23, 2023 at 5:30=E2=80=AFPM <rsbecker@nexbridge.com> w=
rote:
> >> >> >>
> >> >> >> On Thursday, March 23, 2023 7:22 PM, Felipe Contreras wrote:
> >> >> >> >On Sat, Feb 18, 2023 at 5:12=E2=80=AFAM Phillip Wood
> >> >> >> ><phillip.wood123@gmail.com>
> >> >> >wrote:
> >> >> >> >>
> >> >> >> >> On 18/02/2023 01:59, demerphq wrote:
> >> >> >> >> > On Sat, 18 Feb 2023 at 00:24, Junio C Hamano
> >> >> >> >> > <gitster@pobox.com>
> >> >wrote:
> >> >> >> >> >>
> >> >> >> >> >> Emily Shaffer <nasamuffin@google.com> writes:
> >> >> >> >> >>
> >> >> >> >> >>> Basically, if this effort turns out not to be fruitful as
> >> >> >> >> >>> a whole, I'd like for us to still have left a positive im=
pact on the
> >codebase.
> >> >> >> >> >>> ...
> >> >> >> >> >>> So what's next? Naturally, I'm looking forward to a
> >> >> >> >> >>> spirited discussion about this topic - I'd like to know
> >> >> >> >> >>> which concerns haven't been addressed and figure out
> >> >> >> >> >>> whether we can find a way around them, and generally
> >> >> >> >> >>> build awareness of this effort with the
> >> >> >community.
> >> >> >> >> >>
> >> >> >> >> >> On of the gravest concerns is that the devil is in the det=
ails.
> >> >> >> >> >>
> >> >> >> >> >> For example, "die() is inconvenient to callers, let's
> >> >> >> >> >> propagate errors up the callchain" is an easy thing to
> >> >> >> >> >> say, but it would take much more than "let's propagate err=
ors up"
> >> >> >> >> >> to libify something like
> >> >> >> >> >> check_connected() to do the same thing without spawning a
> >> >> >> >> >> separate process that is expected to exit with failure.
> >> >> >> >> >
> >> >> >> >> >
> >> >> >> >> > What does "propagate errors up the callchain" mean?  One
> >> >> >> >> > interpretation I can think of seems quite horrible, but
> >> >> >> >> > another seems quite doable and reasonable and likely not
> >> >> >> >> > even very invasive of the existing code:
> >> >> >> >> >
> >> >> >> >> > You can use setjmp/longjmp to implement a form of "try", so
> >> >> >> >> > that errors dont have to be *explicitly* returned *in* the =
call chain.
> >> >> >> >> > And you could probably do so without changing very much of
> >> >> >> >> > the existing code at all, and maintain a high level of
> >> >> >> >> > conceptual alignment with the current code strategy.
> >> >> >> >>
> >> >> >> >> Using setjmp/longjmp is an interesting suggestion, I think
> >> >> >> >> lua does something similar to what you describe for perl.
> >> >> >> >> However I think both of those use a allocator with garbage
> >> >> >> >> collection. I worry that using longjmp in git would be more
> >> >> >> >> invasive (or result in more memory leaks) as we'd need to to
> >> >> >> >> guard each allocation with some code to clean it up and then
> >> >> >> >> propagate the error. That means we're back to manually
> >> >> >> >> propagating errors up the call
> >> >chain in many cases.
> >> >> >> >
> >> >> >> >We could just use talloc [1].
> >> >> >>
> >> >> >> talloc is not portable.
> >> >> >
> >> >> >What makes you say that?
> >> >>
> >> >> talloc is not part of a POSIX standard I could find.
> >> >
> >> >It's a library, like: z, ssl, curl, pcre2-8, etc. Libraries can be
> >> >compiled on different platforms.
> >>
> >> talloc adds additional *required* dependencies to git, including pytho=
n3 - required
> >to configure and build talloc - which is not available on the NonStop ia=
64 platform
> >(required support through end of 2025). I must express my resistance to =
what would
> >amount to losing support for git on this NonStop platform.
> >
> >That is not true. You don't need python3 for talloc, not even to build i=
t, it's just a
> >single simple c file, it's easy to compile.
> >
> >The only reason python is used is to run waf, which is used to build Sam=
ba, which is
> >much more complex, but you don't need to run it, especially if you know =
the
> >characteristics of your system.
> >
> >This simple Makefile builds libtalloc.so just fine:
> >
> >  CC :=3D gcc
> >  CFLAGS :=3D -fPIC -I./lib/replace
> >  LDFLAGS :=3D -Wl,--no-undefined
> >
> >  # For talloc.c
> >  CFLAGS +=3D -DTALLOC_BUILD_VERSION_MAJOR=3D2
> >-DTALLOC_BUILD_VERSION_MINOR=3D4 -DTALLOC_BUILD_VERSION_RELEASE=3D0
> >  CFLAGS +=3D -DHAVE_CONSTRUCTOR_ATTRIBUTE -DHAVE_VA_COPY -
> >DHAVE_VALGRIND_MEMCHECK_H -DHAVE_INTPTR_T
> >
> >  # For replace.h
> >  CFLAGS +=3D -DNO_CONFIG_H -D__STDC_WANT_LIB_EXT1__=3D1
> >  CFLAGS +=3D -DHAVE_STDBOOL_H -DHAVE_BOOL -DHAVE_STRING_H -
> >DHAVE_LIMITS_H -DHAVE_STDINT_H
> >  CFLAGS +=3D -DHAVE_DLFCN_H -DHAVE_UINTPTR_T -DHAVE_C99_VSNPRINTF -
> >DHAVE_MEMMOVE -DHAVE_STRNLEN -DHAVE_VSNPRINTF
> >
> >  libtalloc.so: talloc.o
> >    $(CC) $(LDFLAGS) -shared -o $@ $^
> >
> >But of course, most of those defines are not even needed with a simple "=
replace.h"
> >that is less than 10 lines of code.
>
> The 2.4.0 version is substantially more complex than one .c file. The ver=
sion I just unpacked has 61 C and H files, and requires more than a trivial=
 makefile.

Not to build libtalloc.so, it doesn't.

> config.h requires that the ./configure script runs (which it does not bec=
ause of python3). replace.h is over 1000 lines in this version.

Neither config.h nor replace.h are needed.

> This also gets into git supply chain issues where people who want to buil=
d git, outside of specific platforms, need to modify the build environment =
associated with talloc, which changes the delivered signature.

The same happens with -lssl and many other libraries Git relies on.

People who can't or won't use the ssl library can *alternatively* use
block-sha1/sha1.c, the same can be done with talloc, which the Git
project can easily embed.

> Speaking purely from a selfish standpoint, this is more than a trivial am=
ount of work at least for me (the above Makefile does not satisfy 2.4.0) th=
at is proposed in order to make talloc a seamless addition.

Nobody is asking you to do anything.

> Running the talloc test suite, which I consider a requirement to adding t=
his as a dependency, is also problematic for the reasons I previously indic=
ated.

Nobody is proposing to make this a dependency.

> We may just have to agree to disagree, but I stand by my concern that thi=
s suggestion will cause maintenance issues given the current state of the t=
alloc code - and I do not have the cycles to become a community maintainer =
of that code also.

That is simply not true. You have no idea what maintenance issues
could be caused by a hypothetical patch, because no such patch has
been put forward, and likely never will.

The fact is that the suggestion is perfectly *doable*.

--=20
Felipe Contreras

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA93C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 21:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCXVVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 17:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCXVVq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 17:21:46 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F89718140
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 14:21:45 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5456249756bso56396477b3.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679692904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASzZQnECEqWHTzaiiVX9ExDSUXpx3pdE5LdZgG3zIlg=;
        b=XeBZWImFOrvjstOT6nN/r+pYgD2pZkpZNtAd+rYmwGk1BHgRmHNUXhzDEKFkoy6+l+
         C8nkQOXKVvDKi702zh0dGumFXOoEhqfxR3IB48ljnEbwKaICKM/MxdHqHADxH+LSTwaR
         r9GCyakLzTc0ob6A9skutYARBcmNh+ZmKrBZQGbZ03IJ5THGe1JbuwNpuaczhkrou1ws
         Av5p9J/EKMTsm5TE3BgxGnvdjhtkvVP5PxJtjxqoYFMX8uojfVTnuP4SGV9Bc9DLfjLq
         w4HqKKcrWongzxuEQ+1thktWljQlj3Tb0CbUl7Uu32VBvx593RfJ/xykIQlmYCmODrUj
         ASKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679692904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASzZQnECEqWHTzaiiVX9ExDSUXpx3pdE5LdZgG3zIlg=;
        b=mCmbRcA6eNa09ejkN65LJiMtBUb8KUupC/XxzgCn0LrESKk0W55aArO0qmTmjv1i51
         qfNGxsJu3RqOqGwzz4JzSpCQD+Gjks1eJBuWAjn8WEcfIiAvWaZh5qTBXTUeSNzbZceM
         hcyW64BiwTcpvfRbcjS0gg9pnm0E8bho3V6r+HKmWnnFMTGWhkezGptGpD2sXliHXWdb
         t4AHjFKhwriPVXm627wFHtKyiBSuOrTbEwkd/YrMQki3y3pQ0zgJV8yqpjHsYrtloBVw
         ytqyrdcbU1n3fq8CprsECpweVfVyoVGKFBEdBd/CQ6CFJ6KspfhMMv5Ud9Ky4QCVZOtG
         YdjA==
X-Gm-Message-State: AAQBX9fQb0Aflr+EhkiHziK1KrSCPaGs77mT8TQEG4I5G1kOGTR3aXLN
        tO1B/IbrVmZfpGYov19PYc5Nu63EsbSkR3xbc2Y=
X-Google-Smtp-Source: AKy350ZCzIQSF3N78JWx/pUkLA9L+JuypmKZyuPM8OAvBt8k6Qq7cHzEe2PGHrf/s84N8P2pKgsFXVrSv0qF3E264z0=
X-Received: by 2002:a81:c84a:0:b0:541:753d:32f9 with SMTP id
 k10-20020a81c84a000000b00541753d32f9mr1690820ywl.9.1679692904378; Fri, 24 Mar
 2023 14:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g> <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
 <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk> <CAMP44s1Qqd2cYcf7OGxz1-PY-8TF2KG+9jPEWMrnCaCfPe_1sw@mail.gmail.com>
 <008101d95ddf$7863d900$692b8b00$@nexbridge.com> <CAMP44s1X6LGpFfA_Zb_GakXehBJDeGrfFcehPgv+YM++xKHN3A@mail.gmail.com>
 <008201d95de1$359285c0$a0b79140$@nexbridge.com> <CAMP44s3Gk67rPEPjoAxLHS4KrCQBb6VoPJ6Rqm-FTK+8PTaRRQ@mail.gmail.com>
 <004d01d95e86$bd355d40$37a017c0$@nexbridge.com>
In-Reply-To: <004d01d95e86$bd355d40$37a017c0$@nexbridge.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 24 Mar 2023 15:21:32 -0600
Message-ID: <CAMP44s3fXYcOsq-XRNZX0y6D=W37=ONELUpTBtkzv4KLbym2iA@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 1:28=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Thursday, March 23, 2023 7:55 PM, Felipe Contreras wrote:
> >On Thu, Mar 23, 2023 at 5:43=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >>
> >> On Thursday, March 23, 2023 7:35 PM, Felipe Contreras wrote:
> >> >On Thu, Mar 23, 2023 at 5:30=E2=80=AFPM <rsbecker@nexbridge.com> wrot=
e:
> >> >>
> >> >> On Thursday, March 23, 2023 7:22 PM, Felipe Contreras wrote:
> >> >> >On Sat, Feb 18, 2023 at 5:12=E2=80=AFAM Phillip Wood
> >> >> ><phillip.wood123@gmail.com>
> >> >wrote:
> >> >> >>
> >> >> >> On 18/02/2023 01:59, demerphq wrote:
> >> >> >> > On Sat, 18 Feb 2023 at 00:24, Junio C Hamano <gitster@pobox.co=
m>
> >wrote:
> >> >> >> >>
> >> >> >> >> Emily Shaffer <nasamuffin@google.com> writes:
> >> >> >> >>
> >> >> >> >>> Basically, if this effort turns out not to be fruitful as a
> >> >> >> >>> whole, I'd like for us to still have left a positive impact =
on the codebase.
> >> >> >> >>> ...
> >> >> >> >>> So what's next? Naturally, I'm looking forward to a spirited
> >> >> >> >>> discussion about this topic - I'd like to know which
> >> >> >> >>> concerns haven't been addressed and figure out whether we
> >> >> >> >>> can find a way around them, and generally build awareness of
> >> >> >> >>> this effort with the
> >> >community.
> >> >> >> >>
> >> >> >> >> On of the gravest concerns is that the devil is in the detail=
s.
> >> >> >> >>
> >> >> >> >> For example, "die() is inconvenient to callers, let's
> >> >> >> >> propagate errors up the callchain" is an easy thing to say,
> >> >> >> >> but it would take much more than "let's propagate errors up"
> >> >> >> >> to libify something like
> >> >> >> >> check_connected() to do the same thing without spawning a
> >> >> >> >> separate process that is expected to exit with failure.
> >> >> >> >
> >> >> >> >
> >> >> >> > What does "propagate errors up the callchain" mean?  One
> >> >> >> > interpretation I can think of seems quite horrible, but
> >> >> >> > another seems quite doable and reasonable and likely not even
> >> >> >> > very invasive of the existing code:
> >> >> >> >
> >> >> >> > You can use setjmp/longjmp to implement a form of "try", so
> >> >> >> > that errors dont have to be *explicitly* returned *in* the cal=
l chain.
> >> >> >> > And you could probably do so without changing very much of the
> >> >> >> > existing code at all, and maintain a high level of conceptual
> >> >> >> > alignment with the current code strategy.
> >> >> >>
> >> >> >> Using setjmp/longjmp is an interesting suggestion, I think lua
> >> >> >> does something similar to what you describe for perl. However I
> >> >> >> think both of those use a allocator with garbage collection. I
> >> >> >> worry that using longjmp in git would be more invasive (or
> >> >> >> result in more memory leaks) as we'd need to to guard each
> >> >> >> allocation with some code to clean it up and then propagate the
> >> >> >> error. That means we're back to manually propagating errors up t=
he call
> >chain in many cases.
> >> >> >
> >> >> >We could just use talloc [1].
> >> >>
> >> >> talloc is not portable.
> >> >
> >> >What makes you say that?
> >>
> >> talloc is not part of a POSIX standard I could find.
> >
> >It's a library, like: z, ssl, curl, pcre2-8, etc. Libraries can be compi=
led on different
> >platforms.
>
> talloc adds additional *required* dependencies to git, including python3 =
- required to configure and build talloc - which is not available on the No=
nStop ia64 platform (required support through end of 2025). I must express =
my resistance to what would amount to losing support for git on this NonSto=
p platform.

That is not true. You don't need python3 for talloc, not even to build
it, it's just a single simple c file, it's easy to compile.

The only reason python is used is to run waf, which is used to build
Samba, which is much more complex, but you don't need to run it,
especially if you know the characteristics of your system.

This simple Makefile builds libtalloc.so just fine:

  CC :=3D gcc
  CFLAGS :=3D -fPIC -I./lib/replace
  LDFLAGS :=3D -Wl,--no-undefined

  # For talloc.c
  CFLAGS +=3D -DTALLOC_BUILD_VERSION_MAJOR=3D2
-DTALLOC_BUILD_VERSION_MINOR=3D4 -DTALLOC_BUILD_VERSION_RELEASE=3D0
  CFLAGS +=3D -DHAVE_CONSTRUCTOR_ATTRIBUTE -DHAVE_VA_COPY
-DHAVE_VALGRIND_MEMCHECK_H -DHAVE_INTPTR_T

  # For replace.h
  CFLAGS +=3D -DNO_CONFIG_H -D__STDC_WANT_LIB_EXT1__=3D1
  CFLAGS +=3D -DHAVE_STDBOOL_H -DHAVE_BOOL -DHAVE_STRING_H
-DHAVE_LIMITS_H -DHAVE_STDINT_H
  CFLAGS +=3D -DHAVE_DLFCN_H -DHAVE_UINTPTR_T -DHAVE_C99_VSNPRINTF
-DHAVE_MEMMOVE -DHAVE_STRNLEN -DHAVE_VSNPRINTF

  libtalloc.so: talloc.o
    $(CC) $(LDFLAGS) -shared -o $@ $^

But of course, most of those defines are not even needed with a simple
"replace.h" that is less than 10 lines of code.

--=20
Felipe Contreras

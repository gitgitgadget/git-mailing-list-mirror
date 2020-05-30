Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF19C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F690204EF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I48kfyih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgE3Su5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 14:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3Su4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 14:50:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E548C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 11:50:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so2648446qvb.10
        for <git@vger.kernel.org>; Sat, 30 May 2020 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+AyyFhDqU+RnxvN+DSwdL+iFLc94yoS62QqDrtbmBg=;
        b=I48kfyih3RZVsIaij0Nr22M5AlE8scxfnN/6d0kIyaRM92VVStoHGfcoV4qXp7zWkd
         7Z5LxT3JKQlhCZvfrTBJGm/REF0pZWrRX7Ul2l3q2Eisp5y/7XUOc2Z8sILl+XP3z7mq
         CropvLtBYR3j55YZ2iNUfz7V6AUhtMuFBB5s3FVPAWTAogsMbtwg8qi/J2zUtO4xgDKU
         Klz7T3e1zxVTq2sOPgMNyz5pSF2qbgWnFqoV4PGHOxSnjFoxKP3FCbJmwsKXMqVcTIeH
         nZsi5P9A4O2kiL6p9YuHUMWTAAGmAmPsarf1rT0KS71tZFRiCtBvgfbObSUfgS+2AFA1
         LZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+AyyFhDqU+RnxvN+DSwdL+iFLc94yoS62QqDrtbmBg=;
        b=r8C1FPZx+eYI4+xp8QV+NNDKQOoyavHlJwOy4WEsePTjUaDEPGo47hH9HZtYAyLNwj
         +AF4t3Clcq6eQeEHQ+sKdGN+ouMDF58oxxKcmwNG4OhvORPTK0miSlRIKIfkrId0tOf5
         49fwOO8BM3aQwVCq9RZ+qRanmPUntXjvc52AfDBq8OpzGpByfpRyoxb3Jz/bqc7z1uOf
         y6UMlN/myjfDTeSno2r4gWwOMna+wWhyiijlXEJkztpKNMjFA5IRRYXUwS8aiyW7mjcq
         A4ecm2XX/J9JTOg67saPrvXLTm5/YBtvM8sHr7YaMVSUrRdK7hkgZ3orGB6LbzbXqMzH
         QsKA==
X-Gm-Message-State: AOAM531YPzDiIn70n+lvBNL6LpLJhVycf7DaGP7SY96GIb/QBqdmi6xO
        obb5BKrQIt6rhFvQ5r12UhAm+ec7hWPEdek4vJs=
X-Google-Smtp-Source: ABdhPJx3ko+vTgN/7kdxyYox1AXijboKDaDawBvozt7eYyhD67xt2Ehlbv6r3eu44tjq/6L2vK8jYLdkYC/FCp4S8IY=
X-Received: by 2002:a0c:e711:: with SMTP id d17mr4987055qvn.56.1590864655438;
 Sat, 30 May 2020 11:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com> <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com>
 <xmqqy2pay216.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2pay216.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 31 May 2020 00:20:43 +0530
Message-ID: <CAKiG+9WWqHJNz_fEaQ+Rw3sRJSFOutCt772v1mbZeOS2rWpDOA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] Introduce CMake support for configuring Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > At the moment, the recommended way to configure Git's builds is to
> > ...
> > Note: this patch asks for the minimum version v3.14 of CMake (which is
> > not all that old as of time of writing) because that is the first
> > version to offer a platform-independent way to generate hardlinks as
> > part of the build. This is needed to generate all those hardlinks for
> > the built-in commands of Git.
>
> All of the above reads reasonable.
>
> > Changes
> > The CMake script parses the Makefile for:
> > LIB_OBJS
> > BUILTIN_OBJS
> > XDIFF_OBJS
> > VCSSVN_OBJS
> > TEST_BUILTINS_OBJS
> >
> > By doing this we avoid duplication of text between the Makefile and
> > the CMake script.
> >
> > The CMake script has been relocated to contrib/buildsystems.
> >
> > The CMake script uses GIT-VERSION-GEN to determine the version of Git
> > being built.
>
> Everything after the "Changes" line does not belong to the commit
> log, as it is no use for those who read "git log" output and
> encounter the "first" attempt to add CMake support there.  There is
> no need to tell them that you did things differently from this
> version in the past, as they simply do not know what you did in the
> previous iterations, nor particularly care about them.
>
> These *do* help reviewers who saw previous iterations, and the space
> after the three-dash line below is the right/recommended place for
> them.
>
> The above applies to other patches in this series.

Do you mean this line '---' below?
If so how do I place the changelog below them?
I just do `/submit` at gigitgadet/git.

>
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 575 ++++++++++++++++++++++++++++
> >  1 file changed, 575 insertions(+)
> >  create mode 100644 contrib/buildsystems/CMakeLists.txt
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> > new file mode 100644
> > index 00000000000..8e2b27f44a6
> > --- /dev/null
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -0,0 +1,575 @@
> > +#
> > +#    Copyright (c) 2020 Sibi Siddharthan
> > +#
> > +
> > +#[[
> > +
> > +Instructions to run CMake:
> > +
> > +cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
>
> The readers can infer from `relative-path-to-CMakeLists` that they
> can run this command from anywhere, e.g.
>
>         $ cd $HOME
>         $ tar xf /var/tmp/git-2.7.0.tar
>         $ cd /tmp
>         $ cmake $HOME/git/contrib/buildsystems/CMakeLists.txt
>
> but when given the freedom/flexibility to use it from "anywhere",
> they are faced by an extra choice to make.  It may be helpful to
> readers to elaborate a bit more to help them decide where in the
> directory hierarchy they would want to run this command.  In the
> above example sequence, I chose /tmp, but if I used /var/tmp as the
> starting place instead, what becomes different?  The answer might
> be "resulting 'git' binary is stored in the directory you run the
> 'cmake' command in", and by spelling it out, it helps readers to
> make an informed decision.
>

Okay

> > +Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
> > +compiler flags
> > +Debug : -g
> > +Release: -O3
> > +RelWithDebInfo : -O2 -g
> > +MinSizeRel : -Os
> > +empty(default) :
> > +
> > +NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
> > +this option is ignored
>
> Quite helpful.
>
> > +This process generates a Makefile(Linux) , Visual Studio solution(Windows) by default.
> > +Run `make` to build Git on Linux.
> > +Open git.sln on Windows and build Git.
> > +
> > +NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
>
> The above makes it sound as if Linux and VS are the only two systems
> we care about, but is it really Linux, or UNIX-flavoured systems in
> general?  In other words, are we excluding friends on BSD and macOS
> with the above?
>
> The above is not a complaint about "exclusion", but is a complaint
> about unclarity.
>

Will specify for other systems as well.

> > +to use another tool say `ninja` add this to the command line when configuring.
> > +`-G Ninja`
> > +
> > +]]
> > +cmake_minimum_required(VERSION 3.14)
> > ...
> > +check_c_source_compiles("
>
> The "source" given to check_c_source_{compiles,runs} may be allowed
> to be anything, but I'd prefer to see it follow some consistent
> style, preferrably our CodingGuidelines (except for git specific
> bits like "do not include standard system file but instead just use
> git-compat-util.h", which of course should not apply).  This is a
> comment not only about the two instances below I use as examples,
> but all C-source snippets in this patch.
>
> > +#include <alloca.h>
> > +int
> > +main ()
> > +{
>
>         int main(void)
>         {
>
> is how we start this function.
>
> > +char *p = (char *) alloca (2 * sizeof (int));
>
> And the decl of function local variable here would be indented by a
> HT like the remainder of the function.  No SP between function name
> and the parentheses around its arguments.  NP SP after sizeof,
> either.
>
> > +     if (p) return 0;
> > +     return 0;
> > +}"
> > +HAVE_ALLOCA_H)
> > ...
> > +check_c_source_runs("
> > +#include<stdio.h>
> > +#include<stdarg.h>
> > +#include<string.h>
> > +#include<stdlib.h>
> > +int test_vsnprintf(char *str, size_t maxsize, const char *format, ...)
> > +{
> > +     int ret;
> > +     va_list ap;
> > +
> > +     va_start(ap, format);
> > +     ret = vsnprintf(str, maxsize, format, ap);
> > +     va_end(ap);
> > +     return ret;
> > +}
> > +
> > +int
> > +main ()
> > +{
>
> Likewise.
>
> > +     char buf[6];
> > +     if (test_vsnprintf(buf, 3, \"%s\", \"12345\") != 5
> > +             || strcmp(buf, \"12\")) return 1;
> > +     if (snprintf(buf, 3, \"%s\", \"12345\") != 5
> > +             || strcmp(buf, \"12\")) return 1;
> > +
> > +     return 0;
> > +}"
>

Will format the checks.

Thank You,
Sibi Siddharthan

> Thanks.

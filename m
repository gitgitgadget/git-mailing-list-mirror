Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF76C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB63420776
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilU2xs4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXW4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXW4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:56:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1465C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:56:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t4so4280031plq.12
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SkUXtAwLGsXYyATZzISLXeUMRGcLlzzkMYpraYVfRZ0=;
        b=ilU2xs4Vy1hcoCDjR4SZsPsaf9ytjGFSCFfgCRE2nWfffRqDr010WlniXe8q17s4lV
         cz5x66wPMjtHLAbTzBAswyIr+iaGKekFKedCZd9dHVWfMGhcWQFF39UARji4vRXfUdTH
         mZNFQd3r2ZfuiYTpZSoFxSRg2J2L9yL6xDTJogJp90dUSEeeQ7/lJZGqLh8xCo3P6sgp
         GKYutkGKB1miSLAZ5oUWB9XTkXici+JKDqV1zenArNO1cpkcD4+ptY7cZgZKD6vBAaIx
         iCe2wtwxitNacykwzuAMuhFkrVEg7B9ivmMOiROBs0eqDSexe7qsKEEgwfhGx46NoFvX
         abYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SkUXtAwLGsXYyATZzISLXeUMRGcLlzzkMYpraYVfRZ0=;
        b=pf5gaDwISkjP+3PratE0PcirLXi8GBxHrdW9d0cc4yzq1pPgxXa2h/xVKGt+KOxhza
         Q8ook1nZyLjLR0mjyk4veN9jP9sBysnQiuT1FYzpRyXdz/AQnSuJJ9Hf8auHQMZVAIl6
         gIEzojmIFgHkBoMABWS9VkYw/D+/cgzs427lj77ouiI3g4PEHhQccjws3cxtGBvEzigi
         6q5KB5oEH4iY/wPYnGR3boWQ0IHE9H1uwO9k0SUYli2XDC0UGP4OfVQy/moWA6ZqXboO
         eh6hBcZGQ2kPmzorFSru3Dhwgy1qdTbg1D3QhN6LKw92VFdHLt/O0M1razrja3AKybYS
         lanQ==
X-Gm-Message-State: AGi0PuYTau3ucZfIW2XT79DwbmuEolNMDHVpDT+15MKMIkNKVqoN0wyy
        gdqqTSXCOX5tuc0qHz316p8=
X-Google-Smtp-Source: APiQypJSq0WPn79fLYi+f9OS5ZqiWF7LWtWBF2RvhXGq6r1Jpo2AHjZgzYMDOUT2A/rMS69+wEzjqw==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr9386171pje.83.1587768984037;
        Fri, 24 Apr 2020 15:56:24 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id y186sm5779506pgb.69.2020.04.24.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:56:23 -0700 (PDT)
Date:   Sat, 25 Apr 2020 05:56:21 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/8] Introduce CMake support for configuring Git on Linux
Message-ID: <20200424225621.GD721@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <70ab1f03dd5413256166bf9db47be47b746ea6b1.1587700897.git.gitgitgadget@gmail.com>
 <20200424170540.GH1949@danh.dev>
 <CAKiG+9VxPkqq-iLCu9pj=jf_4Lgq+05aFb9avfH8dtDtNVzy4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiG+9VxPkqq-iLCu9pj=jf_4Lgq+05aFb9avfH8dtDtNVzy4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-25 02:36:12+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> Yes it does,
> all you have to do is -DZLIB_ROOT=/path/to/zlib/root

OK, I need to learn this syntax

> > > +find_package(EXPAT)
> > > +find_package(Iconv)
> > > +find_package(Intl)
> > > +
> >
> > > +if(NOT Intl_FOUND)
> > > +     add_compile_definitions(NO_GETTEXT)
> >
> > find_package(Gettext)?
> >
> 
> find_package(Gettext) does not define libintl and libintl.h.
> If NO_GETTEXT is not defined, it means that libintl.h is present.
> So, we use find_package(Intl) for libintl

People do weird things.

But, I bet that a lot of people have system that have libintl.h
installed, but they don't install gettext tools. ;-)

Anyway, can I override NO_GETTEXT from command line?

Let's say, I want to bootstrap a new distro?
In the boostrap step, I don't want to build any i18n things,
because the bootstrap package will be thrown away and rebuild again.
I don't want to waste time on building such translation things.

> 
> > > +     if(NOT Iconv_FOUND)
> > > +             add_compile_definitions(NO_ICONV)
> > > +     endif()
> > > +endif()
> >
> > ICONV_OMITS_BOM?
> >
> 
> Forgot about this, will add it.

Thanks, my platform relies on this definition!

> > > +
> > > +include_directories(SYSTEM ${ZLIB_INCLUDE_DIRS})
> > > +if(CURL_FOUND)
> > > +     include_directories(SYSTEM ${CURL_INCLUDE_DIRS})
> > > +endif()
> > > +if(EXPAT_FOUND)
> > > +     include_directories(SYSTEM ${EXPAT_INCLUDE_DIRS})
> > > +endif()
> > > +if(Iconv_FOUND)
> > > +     include_directories(SYSTEM ${Iconv_INCLUDE_DIRS})
> > > +endif()
> > > +if(Intl_FOUND)
> > > +     include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
> > > +endif()
> > > +
> > > +find_program(SH_EXE sh)
> >
> > We want to find usable sh, not just sh, no?
> >
> > It's matter on Solaris, HP-UX
> >
> 
> How do I check for this, can you help?

Sorry, Please ask someone else, check Makefile to see who fixed build
for Solaris and HP-UX.

> Also, the script is not supported on Solaris and HP-UX.

If Solaris or HP-UX is out of equation,
I'll just write: SH_EXE=/bin/sh ;-)


> 
> > > +
> > > +#default behaviour
> > > +include_directories(${CMAKE_SOURCE_DIR})
> > > +add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
> > > +add_compile_definitions(SHA256_BLK INTERNAL_QSORT RUNTIME_PREFIX)
> > > +add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
> > > +                     SHA1DC_INIT_SAFE_HASH_DEFAULT=0
> > > +                     SHA1DC_CUSTOM_INCLUDE_SHA1_C="cache.h"
> > > +                     SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
> > > +list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
> > > +
> > > +
> > > +add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
> > > +                     ETC_GITATTRIBUTES="etc/gitattributes"
> > > +                     ETC_GITCONFIG="etc/gitconfig"
> > > +                     GIT_EXEC_PATH="libexec/git-core"
> > > +                     GIT_LOCALE_PATH="share/locale"
> > > +                     GIT_MAN_PATH="share/man"
> > > +                     GIT_INFO_PATH="share/info"
> > > +                     GIT_HTML_PATH="share/doc/git-doc"
> > > +                     DEFAULT_HELP_FORMAT="html"
> > > +                     DEFAULT_GIT_TEMPLATE_DIR="share/git-core/templates"
> > > +                     GIT_VERSION="${PROJECT_VERSION}.GIT"
> > > +                     GIT_USER_AGENT="git/${PROJECT_VERSION}.GIT"
> > > +                     BINDIR="bin"
> > > +                     GIT_BUILT_FROM_COMMIT="")
> >
> > I wish I could verify this.
> > Have you check this part on a default build system for a Linux distro,
> > FreeBSD? For things started with "etc/"
> >
> 
> These are the values I got when I looked at the build logs from the
> Makefile (make -n) in Linux and Windows.
> Don't know about FreeBSD

Linux will install configuration to /etc, Windows (by using msys),
will also do that.

*BSD port installs git with /usr/local prefix, and install
configuration to /usr/local/etc

> 
> > > +
> > > +set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> > > +add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> > > +
> > > +add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> >
> > /proc/self/exe is Linux only, no?
> >
> 
> Yes, it is. This first patch only supports Linux build.
> 
> > > +list(APPEND compat_SOURCES unix-socket.c)
> > > +
> > > +#header checks
> > > +check_include_file(libgen.h HAVE_LIBGEN_H)
> > > +if(NOT HAVE_LIBGEN_H)
> > > +     add_compile_definitions(NO_LIBGEN_H)
> > > +     list(APPEND compat_SOURCES compat/basename.c)
> > > +endif()
> > > +
> > > +check_include_file(sys/sysinfo.h HAVE_SYSINFO)
> > > +if(HAVE_SYSINFO)
> > > +     add_compile_definitions(HAVE_SYSINFO)
> > > +endif()
> > > +
> > > +check_c_source_compiles("
> > > +#include <alloca.h>
> > > +int
> > > +main ()
> > > +{
> > > +char *p = (char *) alloca (2 * sizeof (int));
> > > +     if (p) return 0;
> > > +     return 0;
> >
> > All code path will return 0?
> >
> 
> This check is for a working alloca.h.
> Some systems define alloca in malloc.h (Windows)

Does CMake have a macro for check function in which include files?

> 
> > > +}"
> > > +HAVE_ALLOCA_H)
> > > +if(HAVE_ALLOCA_H)
> > > +     add_compile_definitions(HAVE_ALLOCA_H)
> > > +endif()
> > > +
> > > +
> > > +if(CURL_FOUND)
> > > +     set(remote_exes
> > > +             git-remote-https git-remote-ftp git-remote-ftps)
> > > +     foreach(s ${remote_exes})
> > > +             file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http ${s})\n")

Now, I looked at this again.
I didn't see the creatation of CreateLinks.cmake anywhere!

> > > +             list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s})
> > > +     endforeach()
> > > +endif()
> > > +
> > > +add_custom_command(OUTPUT ${git_links} ${git_http_links}
> > > +             COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
> > > +             DEPENDS git git-remote-http)
> > > +add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
> > > \ No newline at end of file
> >
> > No new line at end of line always leave a bad taste in my mount!
> >

-- 
Danh

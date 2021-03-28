Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD7BC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834F861945
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhC1BFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhC1BE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 21:04:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23866C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 18:04:55 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e8so9224770iok.5
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=adfOHr2F+RnOX4xMIShnJp+AX1D0148uB13txy21ZBo=;
        b=HjySJqH7+yESIEe4lwDr2hqf29uhG4dwTnJM2BwL8to134Hc8iltlz0rSxk11SNAuI
         4MS0eXzEI6XNdXAZSIskLVKSsFxDwZbxSE74He2VTTyC600lXsX30FEEkDTnpDRThGrE
         EfF1WyNsKIkpxT1j1Y4xRaEbuVfc85zpGkDSvdmb7TlHJNXG6pDZXsTQR2K0rSrCKqxC
         +2977tkvPxOSr18YweIqy2LJ2aR7j0WtR/BlB6NMLrOXLWShkMtdPt76KkS0lJofaY7J
         GQVM9I2Bw6JKP5AG6p/QiJUynjXPywKSileWT3rrZM6vqzfqIZ/pSummJ2f4ksLJZEXm
         Rmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=adfOHr2F+RnOX4xMIShnJp+AX1D0148uB13txy21ZBo=;
        b=FnMEUdOxUgSXsqsKCoruKa58sfyZihWL1XHSFHTHMtk8qb/U9fwAiRmXjsJDw13WNa
         mZ7ZlTOaVvKEXjmGfcpPylGxWvBseHEachlAIcu7Bys2byudltxXi+qJMDfYJdDsUXr0
         /v5NyUMjpbwBXyzD8q/HQVGjdXBCPs0m7N8Yhm53iNq/J+HBUfpgAH5SPqTfnwhVSPSZ
         Q51UPxTLYKpPPFP+OGMWqMq2Z+PJGAeueEXIudii/Hk2cGO42wswkhW89OEcA7TwIlnc
         6U2CCOmdOvvWnDkEskyvBFjgPHdXF4qy2PNxMQ61Vph+zv4NfAug3lT0yLpxOgzUjCce
         egqQ==
X-Gm-Message-State: AOAM532tEVPZmFam4qUbHciem0HA78cM02lffB+5imktUaAXgGrbyxjY
        nTuAmXrUDSw+Zyh5KehNGRb29IuqqfdLZSurl4U=
X-Google-Smtp-Source: ABdhPJzOEypIFiVxGMT08GzVcnPOwErV0i3CN23JW8SHkeL8kNwNEnxcWJjOsNnJSYg4FZw4/meQjA2fdpvJf8EHTVI=
X-Received: by 2002:a02:6a5a:: with SMTP id m26mr17939611jaf.17.1616893494576;
 Sat, 27 Mar 2021 18:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nUpHP4iX-iQqMqX4wR6sMZO2MQv9fBVVTSys67_oGX0A@mail.gmail.com>
 <YF/RtL+TS6+DNCTk@camp.crustytoothpaste.net>
In-Reply-To: <YF/RtL+TS6+DNCTk@camp.crustytoothpaste.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 27 Mar 2021 21:04:32 -0400
Message-ID: <CAH8yC8mSMZDjhbidruAh9t7QFsv6Yxqi1poNEXBT=Nn9+sB2hA@mail.gmail.com>
Subject: Re: Git 2.31.1, Solaris and error: conflicting types for 'inet_ntop'
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 27, 2021 at 8:45 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-03-28 at 00:18:37, Jeffrey Walton wrote:
> > Hi Everyone,
> >
> > I'm building the latest Git on Solaris 11.3. I use this patch for
> > Solaris: https://github.com/noloader/Build-Scripts/blob/master/patch/git.patch.
> > It ensures -lresolv -lsocket -lnsl (in that order).
> >
> > The build is having some trouble:
> >
> > /bin/gcc -o kwset.o -c -MF ./.depend/kwset.o.d -MQ kwset.o -MMD -MP
> > -I/usr/local/include -DNDEBUG -DNO_UNALIGNED_LOADS=1 -g2 -O2 -m64
> > -march=native -fPIC -pthread -I. -D__EXTENSIONS__ -D__sun__
> > -DGIT_HOST_CPU="\"i86pc\"" -DUSE_LIBPCRE2 -I/usr/local/include
> > -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
> > -I/usr/local/include -I/usr/local/include -I/usr/local/include
> > -I/usr/local/include -DNO_D_TYPE_IN_DIRENT -DNO_INET_NTOP
>
> So you're defining NO_INET_NTOP.
>
> > -DNO_INET_PTON -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES
> > -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0
> > -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\""
> > -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
> > -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H -DHAVE_STRINGS_H
> > -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC
> > -DHAVE_GETDELIM  -DFREAD_READS_DIRECTORIES -Icompat/regex
> > -DSHELL_PATH='"/bin/bash"' -DPAGER_ENV='"LESS=FRX LV=-c"'  kwset.c
> > In file included from cache.h:4:0,
> >                  from json-writer.c:1:
> > git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
> >  const char *inet_ntop(int af, const void *src, char *dst, size_t size);
>
> So we're defining one here.
>
> > In file included from cache.h:4:0,
> >                  from ident.c:8:
> > git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
> >  const char *inet_ntop(int af, const void *src, char *dst, size_t size);
> >              ^
> > In file included from git-compat-util.h:226:0,
> >                  from cache.h:4,
> >                  from ident.c:8:
> > /usr/include/arpa/inet.h:43:20: note: previous declaration of
> > 'inet_ntop' was here
> >  extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
>
> And then so are your system headers.  You probably want to avoid setting
> that option, and then things will probably work better.

I see what happened... I stopped Autoreconfing so the configure.ac
changes were not picked up. The original configure is being used.

I think Git is getting itself into that state.

Without the Autoreconf, I was able to sidestep the issue with:

if [[ "${IS_SOLARIS}" -eq 1 ]]; then
    CONFIG_OPTS+=("ac_cv_func_inet_ntop=yes")
    CONFIG_OPTS+=("ac_cv_func_inet_pton=yes")
fi

Jeff

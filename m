Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED21C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 04:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiDEEab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiDEEa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 00:30:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECADB27B
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 21:28:29 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a5so9187523qvx.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YspmoQq+EtonVkOgQD5xqyvkE6AVjIxHHubtkUpFtSA=;
        b=qy/wJ/Bzmdz8o7hk8ntbKkws5xJP62nW7uoP82RNT1D+jydxDrjgBLWBV00EB65aHm
         nVdqDT+c+MTM/R+BxPgNGUnbaQy448Na0MdgHgKBKuD80P3BD6D+LQljvEpAQmyU5OCd
         +4dZ+kiIJltVlzKfStMvDYekCHAsYNEFm9jsQuibkVOrSizPSuaHJ19v7EtR8yZPO6k6
         oNtLEwGWat8EAepSLAwztfkG+ibfvJYOWI1LWSOOtj7ars06w+/1H32kw14dnpM3/VCX
         Mr7cZ+jF8vvZDiTzE0jQ6pj815RMrUjOOs2f2tAhJaiSoSDAJ8zfgrQvL88TTZA6Grn6
         anpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YspmoQq+EtonVkOgQD5xqyvkE6AVjIxHHubtkUpFtSA=;
        b=Vc51A8QhP1xcxvliqrnm8tVWyfnD0V8/EWyCR3tEwXUSsaQ/mBEKQVd39WeGgTPrF5
         cvH1BEK9wkt/x3FpsVVMmEd/s5uZWRL2DLZJwi5RszvDo3/UhVk5zeArTYNLtw+Yy//k
         /Ea6Diog6KslZLOfcTNq0qsVUvZy9441pr+GpkgJljbrd1T99Ei0ift5kmI04EnDZ4lJ
         maJhkvinfVWpA/3CNavmwvspObX24cOmTTcPFUNb3s5YLpgJNd749s/fjaVpaR+klWhF
         qUZc8X7gWcKO/5XnzzvUWV5/5Vp5bcBICxZXcyY2YyqvXJWMv+fPmZLbIfDkLm7UtyFm
         ffzA==
X-Gm-Message-State: AOAM533CTlJFrfrxD9BUQYrwZFqBl/gUlXTGisGG5Cm5NxOTX2nPxO1a
        icltFlN6z4jN9qDhGHeDXSk=
X-Google-Smtp-Source: ABdhPJzFBPNvYzQ0aE05oWLtOxB7k0oZQlNGFTeJp5ZcJtwEabkQXIAYwU2c/fN/5BF/SiJptpk4Qg==
X-Received: by 2002:a0c:a942:0:b0:443:a395:cc1f with SMTP id z2-20020a0ca942000000b00443a395cc1fmr1137701qva.68.1649132908987;
        Mon, 04 Apr 2022 21:28:28 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm9324988qtw.7.2022.04.04.21.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 21:28:28 -0700 (PDT)
Date:   Mon, 4 Apr 2022 21:28:26 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Message-ID: <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
 <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
 <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
 <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
 <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan>
 <035b01d84899$3cdc5b20$b6951160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <035b01d84899$3cdc5b20$b6951160$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 04, 2022 at 10:59:54PM -0400, rsbecker@nexbridge.com wrote:
> On April 4, 2022 8:54 PM, Carlo Marcelo Arenas Belón wrote:
> >On Mon, Apr 04, 2022 at 05:26:10PM -0700, Carlo Marcelo Arenas Belón wrote:
> >> On Mon, Apr 04, 2022 at 06:40:35PM -0400, rsbecker@nexbridge.com wrote:
> >> > On April 4, 2022 6:33 PM, Junio C Hamano wrote:
> >> > >To: Randall S. Becker <rsbecker@nexbridge.com>
> >> > >Cc: Git Mailing List <git@vger.kernel.org>;
> >> > >git-packagers@googlegroups.com
> >> > >Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
> >> > >
> >> > >CSPRNG_METHOD?
> >> >
> >> > We already have
> >> >
> >> >         CSPRNG_METHOD = openssl
> >> >
> >> > In the config for NonStop. Should that not have worked?
> >>
> >> only if you are not telling your openssl to hide that function[1]
> >>
> >> Carlo
> >>
> >> [1] https://www.openssl.org/docs/manmaster/man3/RAND_bytes.html
> >
> >nevermind, it seems we forgot to track this header somehow, so will need
> >something like (untested and likely to need changes to support NO_OPENSSL)
> >
> >Carlo
> >--- >8 ---
> >diff --git a/git-compat-util.h b/git-compat-util.h index 4d444dca274..68a9b9cd975
> >100644
> >--- a/git-compat-util.h
> >+++ b/git-compat-util.h
> >@@ -525,6 +525,10 @@ void warning_errno(const char *err, ...)
> >__attribute__((format (printf, 1, 2)));  #include <openssl/x509v3.h>  #endif /*
> >NO_OPENSSL */
> >
> >+#ifdef HAVE_OPENSSL_CSPRNG
> >+#include <openssl/rand.h>
> >+#endif
> >+
> > /*
> >  * Let callers be aware of the constant return value; this can help
> >  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
> 
> I was able to make the build work, adding the above patch and libcrypto.so and libssl.so to our LDFLAGS.

Adding libcrypto wasn't enough?; of course it will depend on your linker
but when tested in Linux and macOS the only "U" symbol that got pulled
was RAND_bytes and -lcrypto was all that was needed.

Official patch including both libraries below, but it would be ideal to
only pull one if possible.

Carlo
-- >8 --
Subject: [PATCH] git-compat-util: really support openssl as a source of entropy

05cd988dce5 (wrapper: add a helper to generate numbers from a CSPRNG,
2022-01-17), configure openssl as the source for entropy in NON-STOP
but doesn't add the needed header or link options.

Since the only system that is configured to use openssl as a source
of entropy is NON-STOP, add the header unconditionally, and -lcrypto
to the list of external libraries.

An additional change is required to make sure a NO_OPENSSL=1 build
will be able to work as well (tested on Linux with a modified value
of CSPRNG_METHOD = openssl), and the more complex logic that allows
for compatibility with APPLE_COMMON_CRYPTO or allowing for simpler
ways to link (without libssl) has been punted for now.

Reported-by: Randall Becker <rsbecker@nexbridge.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile          | 1 +
 git-compat-util.h | 4 ++++
 imap-send.c       | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 91738485626..f8bccfab5e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1972,6 +1972,7 @@ endif
 
 ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
 	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
+	EXTLIBS += -lcrypto -lssl
 endif
 
 ifneq ($(PROCFS_EXECUTABLE_PATH),)
diff --git a/git-compat-util.h b/git-compat-util.h
index 4d444dca274..68a9b9cd975 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -525,6 +525,10 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 #include <openssl/x509v3.h>
 #endif /* NO_OPENSSL */
 
+#ifdef HAVE_OPENSSL_CSPRNG
+#include <openssl/rand.h>
+#endif
+
 /*
  * Let callers be aware of the constant return value; this can help
  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
diff --git a/imap-send.c b/imap-send.c
index 5ac6fa9c664..a50af56b827 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -27,7 +27,7 @@
 #include "exec-cmd.h"
 #include "run-command.h"
 #include "parse-options.h"
-#ifdef NO_OPENSSL
+#if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif
 #ifdef USE_CURL_FOR_IMAP_SEND
-- 
2.35.1.505.g27486cd1b2d


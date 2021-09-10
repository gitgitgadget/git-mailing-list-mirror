Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ADFC433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F6A611BF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhIJLFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhIJLFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4062C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b6so2024907wrh.10
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmTkuyEw2AaVmWuxu0TZM7TMrpb6+Dn4O7GPAqSY9iA=;
        b=h0/jSbCIWoif0iZ/k2WxBVCvJ81wmikgMLcLRCszEwn43Ofk+I7ExVB6zZzKvEVPXi
         BnVTiWrvP3IHQuFe9VWNxVZUOpVlh8RgpghrHt2HeJolxGc03yPL/dh4b1mu5NuNYXMi
         CoSO96hlAGswK66+nSVzv4t0Gg0NtEinydrM+/tMmpLQka+fh5U9KS4b6OaxUu2cCxAK
         0+t194MlhVR7la/b8iLx8E3ZEBanl2vPshYzTrb4YvCZFcGz+ureOCPtQ+tHDQzVcojB
         SXxKQPXi0o6lAGDMLYMnrW2sWBckEnlcKiRh3FaooN6VnfimtftuSu8XJcUl5tfE0iTT
         fP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmTkuyEw2AaVmWuxu0TZM7TMrpb6+Dn4O7GPAqSY9iA=;
        b=q6KDWy7tM7WUr7XEdxYG8XdUNe/yfKPEB3/WzBX3wQGxaRrJur3+gC1bgMBrfSqOpE
         NC/CO/WU/ZgtHOpLDrmYaeQksohj5UVVjKU9WOcAnN2VtgsfaAtgBy/M4NxQpDTPcC+y
         fEKcCgYxCB7YmYSg+hMWEMkI2jqnTRXTvF3MOFWn+fjus6X+Px8BL6vxm1Un3QMe02Xh
         ZQYostKMkHlXDFxCnTwK+shb784jWiwAEdoHt+1tcMtLO8ZSgD3qw6KytHNAtyF9pmGf
         kOb8c3HEktb1ugAKdbf0m1qSTMWujeLmF6LT3HF8fL2GCKSFfmZVBhw42tjVd9FpnyAR
         VYHw==
X-Gm-Message-State: AOAM5334vla+rlPvkZyJmmA/M2msa2boe/BMlpTxCnPgpBzgqVYOOxSo
        CEk0fxBzkRpYcakr2mUaAMEuFDrhWmGq3g==
X-Google-Smtp-Source: ABdhPJxhThrI2moyPfDWPS7J4TRe99HD2n6d6jKA14O+Y++FsbxYgWGBTj5bCCuTdj3CUUjRQIz1jQ==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr8724293wrr.376.1631271876808;
        Fri, 10 Sep 2021 04:04:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl" follow-up
Date:   Fri, 10 Sep 2021 13:04:25 +0200
Message-Id: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the already-integrated topic for dropping
support for older curl versions submitted before the v2.33 release[1].

Version 1 of this had a really bad bug where we'd effectively make all
supported curl versions act like 7.19.4, i.e. the oldest supported
version except for a couple of our supported features. This is because
most of the things checked with the "ifdef" checks are enum fields,
not macros. So basically the "devil's advocate" Jeff King pointed out
in [2] was already the case. Oops!

In this v2 we're instead checking LIBCURL_VERSION_NUM consistently,
even in those cases where we are checking things that are defined via
macros.

This means that anyone on an older distro with backported features
will need to -DGIT_CURL_HAVE_* if their version of curl supports some
of these via a backport, not ideal, but an acceptable trade-off. If we
cared about this we could have some "detect-curl" script similar to my
proposed "detect-compiler"[3] (or another homegrown autoconf
replacement).

This also corrects commit messages, removes already-dead code from the
Makefile that we'd missed, and mentions the oldest supported version
in the INSTALL document.

The part where we left behind a potentially warning "ssl_pinnedkey"
variable is also gone, although due to another bug in v1 we'd
unconditionally use it (for config) with the "centralize the
accounting" change there.

1. https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com/ [1]
2. http://lore.kernel.org/git/YTkPfyAYTU4ZgRgb@coredump.intra.peff.net
3. https://lore.kernel.org/git/87bl6aypke.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (8):
  INSTALL: don't mention the "curl" executable at all
  INSTALL: mention that we need libcurl 7.19.4 or newer to build
  Makefile: drop support for curl < 7.9.8 (again)
  http: drop support for curl < 7.18.0 (again)
  http: correct version check for CURL_HTTP_VERSION_2
  http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
  http: centralize the accounting of libcurl dependencies
  http: don't hardcode the value of CURL_SOCKOPT_OK

 INSTALL           |  13 +++--
 Makefile          |  11 +---
 git-curl-compat.h | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 http.c            |  35 ++++++------
 imap-send.c       |   2 +-
 5 files changed, 161 insertions(+), 33 deletions(-)
 create mode 100644 git-curl-compat.h

Range-diff against v1:
-:  ----------- > 1:  ac11cf8cfd1 INSTALL: don't mention the "curl" executable at all
-:  ----------- > 2:  4b653cee2d3 INSTALL: mention that we need libcurl 7.19.4 or newer to build
-:  ----------- > 3:  76c2aa6e78d Makefile: drop support for curl < 7.9.8 (again)
1:  3ffa2f491dd = 4:  e73a9ff1780 http: drop support for curl < 7.18.0 (again)
3:  d8192164937 ! 5:  2567b888c3d http: correct version check for CURL_HTTP_VERSION_2_0
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    http: correct version check for CURL_HTTP_VERSION_2_0
    +    http: correct version check for CURL_HTTP_VERSION_2
     
         In d73019feb44 (http: add support selecting http version, 2018-11-08)
    -    a dependency was added on CURL_HTTP_VERSION_2_0, but this feature was
    +    a dependency was added on CURL_HTTP_VERSION_2, but this feature was
         introduced in curl version 7.43.0, not 7.47.0, as the incorrect
         version check led us to believe.
     
    @@ Commit message
         dependency on CURL_HTTP_VERSION_2TLS, but the corresponding version
         check was not corrected.
     
    +    The newest symbol we depend on is CURL_HTTP_VERSION_2. It was added in
    +    7.33.0, but the CURL_HTTP_VERSION_2 alias we used was added in
    +    7.47.0. So we could support an even older version here, but let's just
    +    correct the checked version.
    +
         1. https://lore.kernel.org/git/pull.69.git.gitgitgadget@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
2:  511534ce17a ! 6:  397d54a1352 http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
    @@ Commit message
         but the relevant code depended on CURLOPT_PINNEDPUBLICKEY, introduced
         in 7.39.0.
     
    -    Let's also remove the macro check before we declare the ssl_pinnedkey
    -    variable, the pattern for other such variables is to declare the
    -    static variable unconditionally, we just may not use it on older
    -    versions. This reduces macro verbosity.
    -
    -    The reduction in verbosity comes at the small cost of issuing a
    -    warning about the unused variable if this code is compiled with curl
    -    versions older than 7.39.0. I think that's an acceptable trade-off,
    -    anyone compiling a new git with a 2014-era toolchain likely has at
    -    least other warning that'll have prompted them not to use -Werror, and
    -    if not maybe this'll prompt them to compile their new git with a more
    -    modern libcurl.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## http.c ##
    @@ http.c: static struct {
      static const char *ssl_capath;
      static const char *curl_no_proxy;
     -#if LIBCURL_VERSION_NUM >= 0x072c00
    ++#if LIBCURL_VERSION_NUM >= 0x072700
      static const char *ssl_pinnedkey;
    --#endif
    + #endif
      static const char *ssl_cainfo;
    - static long curl_low_speed_limit = -1;
    - static long curl_low_speed_time = -1;
     @@ http.c: static int http_options(const char *var, const char *value, void *cb)
      	}
      
4:  47b513a261b ! 7:  8e57a8409c5 http: centralize the accounting of libcurl dependencies
    @@ Commit message
     
         As discussed in 644de29e220 (http: drop support for curl < 7.19.4,
         2021-07-30) checking against LIBCURL_VERSION_NUM isn't as reliable as
    -    checking specific defines in curl, as some distros have been known to
    -    backport features. Furthermore as shown in the preceding commit doing
    -    these version checks makes for hard to read and possibly buggy code,
    -    as shown by the bug fixed there where we were conflating base 10 for
    -    base 16 when comparing the version.
    +    checking specific symbols present in curl, as some distros have been
    +    known to backport features.
     
    -    Let's instead add a new git-curl-compat.h header that'll keep track of
    -    these dependencies. Following this pattern will also make it much
    -    easier to track when we should deprecate curl versions in the future,
    -    as we just did post-v2.33 e48a623dea0 (Merge branch
    -    'ab/http-drop-old-curl', 2021-08-24).
    +    However, while some of the curl_easy_setopt() arguments we rely on are
    +    macros, others are enum, and we can't assume that those that are
    +    macros won't change into enums in the future.
    +
    +    So we're still going to have to check LIBCURL_VERSION_NUM, but by
    +    doing that in one central place and using a macro definition of our
    +    own, anyone who's backporting features can define it themselves, and
    +    thus have access to more modern curl features that they backported,
    +    even if they didn't bump the LIBCURL_VERSION_NUM.
    +
    +    More importantly, as shown in a preceding commit doing these version
    +    checks makes for hard to read and possibly buggy code, as shown by the
    +    bug fixed there where we were conflating base 10 for base 16 when
    +    comparing the version.
    +
    +    By doing them all in one place we'll hopefully reduce the chances of
    +    such future mistakes, furthermore it now becomes easier to see at a
    +    glance what the oldest supported version is, which makes it easier to
    +    reason about any future deprecation similar to the recent
    +    e48a623dea0 (Merge branch 'ab/http-drop-old-curl', 2021-08-24).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ git-curl-compat.h (new)
     @@
     +#ifndef GIT_CURL_COMPAT_H
     +#define GIT_CURL_COMPAT_H
    ++#include <curl/curl.h>
     +
     +/**
     + * This header centralizes the declaration of our libcurl dependencies
    @@ git-curl-compat.h (new)
     + * inform decisions about removing support for older libcurl in the
     + * future.
     + *
    ++ * The oldest supported version of curl is documented in the "INSTALL"
    ++ * document.
    ++ *
     + * The source of truth for what versions have which symbols is
     + * https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions;
     + * the release dates are taken from curl.git (at
     + * https://github.com/curl/curl/).
     + *
    -+ * For each X symbol we need from curl we check if it exists and
    -+ * declare our own GIT_CURL_HAVE_X, or if it's for both X and Y
    -+ * GIT_CURL_HAVE_X_and_Y, where the "Y" in "X_and_Y" is only the part
    -+ * of the symbol name that "X" and "Y" don't have in common.
    -+ *
    -+ * We avoid comparisons against LIBCURL_VERSION_NUM, enterprise
    -+ * distros have been known to backport symbols to their older curl
    -+ * versions.
    ++ * For each X symbol we need from curl we define our own
    ++ * GIT_CURL_HAVE_X. If multiple similar symbols with the same prefix
    ++ * were defined in the same version we pick one and check for that name.
     + *
     + * Keep any symbols in date order of when their support was
     + * introduced, oldest first, in the official version of cURL library.
    @@ git-curl-compat.h (new)
     +/**
     + * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
     + */
    -+#ifdef CURLOPT_TCP_KEEPALIVE
    ++#if LIBCURL_VERSION_NUM >= 0x071900
     +#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
     +#endif
     +
    @@ git-curl-compat.h (new)
     +/**
     + * CURLOPT_LOGIN_OPTIONS was added in 7.34.0, released in December
     + * 2013.
    ++ *
    ++ * If we start requiring 7.34.0 we might also be able to remove the
    ++ * code conditional on USE_CURL_FOR_IMAP_SEND in imap-send.c, see
    ++ * 1e16b255b95 (git-imap-send: use libcurl for implementation,
    ++ * 2014-11-09) and the check it added for "072200" in the Makefile.
    ++
     + */
    -+#ifdef CURLOPT_LOGIN_OPTIONS
    ++#if LIBCURL_VERSION_NUM >= 0x072200
     +#define GIT_CURL_HAVE_CURLOPT_LOGIN_OPTIONS 1
     +#endif
     +
    @@ git-curl-compat.h (new)
     + * CURL_SSLVERSION_TLSv1_[012] was added in 7.34.0, released in
     + * December 2013.
     + */
    -+#if defined(CURL_SSLVERSION_TLSv1_0) && \
    -+    defined(CURL_SSLVERSION_TLSv1_1) && \
    -+    defined(CURL_SSLVERSION_TLSv1_2)
    -+#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0_and_1_and_2
    ++#if LIBCURL_VERSION_NUM >= 0x072200
    ++#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
     +#endif
     +
     +/**
     + * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
     + * 2014.
     + */
    -+#ifdef CURLOPT_PINNEDPUBLICKEY
    ++#if LIBCURL_VERSION_NUM >= 0x072c00
     +#define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
     +#endif
     +
     +/**
     + * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
    ++ *
    ++ * The CURL_HTTP_VERSION_2 alias (but not CURL_HTTP_VERSION_2_0) has
    ++ * always been a macro, not an enum field (checked on curl version
    ++ * 7.78.0)
     + */
    -+#ifdef CURL_HTTP_VERSION_2
    ++#if LIBCURL_VERSION_NUM >= 0x072b00
     +#define GIT_CURL_HAVE_CURL_HTTP_VERSION_2 1
     +#endif
     +
     +/**
     + * CURLSSLOPT_NO_REVOKE was added in 7.44.0, released in August 2015.
    ++ *
    ++ * The CURLSSLOPT_NO_REVOKE is, has always been a macro, not an enum
    ++ * field (checked on curl version 7.78.0)
     + */
    -+#ifdef CURLSSLOPT_NO_REVOKE
    ++#if LIBCURL_VERSION_NUM >= 0x072c00
     +#define GIT_CURL_HAVE_CURLSSLOPT_NO_REVOKE 1
     +#endif
     +
     +/**
     + * CURLOPT_PROXY_CAINFO was added in 7.52.0, released in August 2017.
     + */
    -+#ifdef CURLOPT_PROXY_CAINFO
    ++#if LIBCURL_VERSION_NUM >= 0x073400
     +#define GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO 1
     +#endif
     +
    @@ git-curl-compat.h (new)
     + * CURLOPT_PROXY_{KEYPASSWD,SSLCERT,SSLKEY} was added in 7.52.0,
     + * released in August 2017.
     + */
    -+#if defined(CURLOPT_PROXY_KEYPASSWD) && \
    -+    defined(CURLOPT_PROXY_SSLCERT) && \
    -+    defined(CURLOPT_PROXY_SSLKEY)
    -+#define GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY 1
    ++#if LIBCURL_VERSION_NUM >= 0x073400
    ++#define GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD 1
     +#endif
     +
     +/**
     + * CURL_SSLVERSION_TLSv1_3 was added in 7.53.0, released in February
     + * 2017.
     + */
    -+#ifdef CURL_SSLVERSION_TLSv1_3
    ++#if LIBCURL_VERSION_NUM >= 0x073400
     +#define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3 1
     +#endif
     +
    @@ git-curl-compat.h (new)
     + * CURLSSLSET_{NO_BACKENDS,OK,TOO_LATE,UNKNOWN_BACKEND} were added in
     + * 7.56.0, released in September 2017.
     + */
    -+#if defined(CURLSSLSET_NO_BACKENDS) && \
    -+    defined(CURLSSLSET_OK) && \
    -+    defined(CURLSSLSET_TOO_LATE) && \
    -+    defined(CURLSSLSET_UNKNOWN_BACKEND)
    -+#define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS_and_OK_and_TOO_LATE_and_UNKNOWN_BACKEND 1
    ++#if LIBCURL_VERSION_NUM >= 0x073800
    ++#define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
     +#endif
     +
     +#endif
    @@ http.c: static struct {
      	{ "sslv3", CURL_SSLVERSION_SSLv3 },
      	{ "tlsv1", CURL_SSLVERSION_TLSv1 },
     -#if LIBCURL_VERSION_NUM >= 0x072200
    -+#if GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0_AND_1_AND_2
    ++#ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
      	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
      	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
      	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
      #endif
     -#if LIBCURL_VERSION_NUM >= 0x073400
    -+#if GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3
    ++#ifdef GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_3
      	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
      #endif
      };
    + static const char *ssl_key;
    + static const char *ssl_capath;
    + static const char *curl_no_proxy;
    +-#if LIBCURL_VERSION_NUM >= 0x072700
    ++#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
    + static const char *ssl_pinnedkey;
    + #endif
    + static const char *ssl_cainfo;
     @@ http.c: static int http_options(const char *var, const char *value, void *cb)
      	}
      
      	if (!strcmp("http.pinnedpubkey", var)) {
     -#if LIBCURL_VERSION_NUM >= 0x072700
    --		return git_config_pathname(&ssl_pinnedkey, var, value);
    --#else
    -+#ifndef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
    ++#ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
    + 		return git_config_pathname(&ssl_pinnedkey, var, value);
    + #else
      		warning(_("Public key pinning not supported with cURL < 7.39.0"));
    --		return 0;
    - #endif
    -+		return git_config_pathname(&ssl_pinnedkey, var, value);
    - 	}
    - 
    - 	if (!strcmp("http.extraheader", var)) {
     @@ http.c: static int has_cert_password(void)
      	return 1;
      }
      
     -#if LIBCURL_VERSION_NUM >= 0x073400
    -+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY
    ++#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD
      static int has_proxy_cert_password(void)
      {
      	if (http_proxy_ssl_cert == NULL || proxy_ssl_cert_password_required != 1)
    @@ http.c: static CURL *get_curl_handle(void)
      			curl_easy_setopt(result,
      				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
     -#if LIBCURL_VERSION_NUM >= 0x073400
    -+#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD_and_SSLCERT_and_SSLKEY
    ++#ifdef GIT_CURL_HAVE_CURLOPT_PROXY_KEYPASSWD
      		else if (starts_with(curl_http_proxy, "https")) {
      			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
      
    @@ http.c: void http_init(struct remote *remote, const char *url, int proactive_aut
      	string_list_clear(&config.vars, 1);
      
     -#if LIBCURL_VERSION_NUM >= 0x073800
    -+#ifdef GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS_and_OK_and_TOO_LATE_and_UNKNOWN_BACKEND
    ++#ifdef GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
      	if (http_ssl_backend) {
      		const curl_ssl_backend **backends;
      		struct strbuf buf = STRBUF_INIT;
5:  4f42c0e48b0 ! 8:  465ab33ebda http: don't hardcode the value of CURL_SOCKOPT_OK
    @@ Commit message
     
      ## git-curl-compat.h ##
     @@
    -  * GIT_CURL_HAVE_X_and_Y, where the "Y" in "X_and_Y" is only the part
    -  * of the symbol name that "X" and "Y" don't have in common.
    +  * GIT_CURL_HAVE_X. If multiple similar symbols with the same prefix
    +  * were defined in the same version we pick one and check for that name.
       *
     + * We may also define a missing CURL_* symbol to its known value, if
     + * doing so is sufficient to add support for it to older versions that
     + * don't have it.
     + *
    -  * We avoid comparisons against LIBCURL_VERSION_NUM, enterprise
    -  * distros have been known to backport symbols to their older curl
    -  * versions.
    -@@
    +  * Keep any symbols in date order of when their support was
       * introduced, oldest first, in the official version of cURL library.
       */
      
     +/**
     + * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
    ++ *
    ++ * This should be safe as CURL_SOCKOPT_OK has always been a macro, not
    ++ * an enum field (checked on curl version 7.78.0, released on July 19,
    ++ * 2021). Even if that were to change the value of "0" for "OK" is
    ++ * unlikely to change.
     + */
     +#ifndef CURL_SOCKOPT_OK
     +#define CURL_SOCKOPT_OK 0
-- 
2.33.0.873.g125ff7b9940


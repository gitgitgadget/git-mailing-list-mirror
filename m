Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72595C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4415B60F36
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 01:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKOB1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 20:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhKOB1T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 20:27:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D983C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 17:24:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so28011292edu.4
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 17:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=L95HGmuOlwEcpUCdkBgyEyBgAQz+MsYoYEkwyL/hYYo=;
        b=OYlUzuWTmojsvY/bm+XwJG0QMs+9ufCEa2WR2uFqvV/xSfNceWJOl7nNk3X39XpYgU
         fnhHLBLlK/s/Ouh3W1dC6Bnel0YAlKMN5z1fxt+vixf/kod/jveR1R3NZJjsmCZGnSns
         XRhQ930IwhlXBrok0txdot697HU3F+FdSV003bIvkkInVQx2iHvmt5l4WZutAzOW7KRK
         FXv8ZZfpBmzj5V1rkTQi79y0+iIwOl/eQ3+BpgxSnphvJCrtgWip7ZoSF79xYw3u3OyI
         SLLdn85cN3bcB3frp7KZAJJl9SV7EGqu3WDr4I8hoqweMwHH8ftxj5P1EKuWXDLtgAay
         /juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=L95HGmuOlwEcpUCdkBgyEyBgAQz+MsYoYEkwyL/hYYo=;
        b=fMKvvAJbwlIEOkPxJWNC4BsEu9DAAcAkPlkDpxqg/V1Y72U97rRllWGsdsNCpF0Poq
         /LHqCEnN3thUbFmPbq1EP9HZlZUvXwNDvV8EEDNmGV3EVLOTwpkpgpbGAyKJ42FX5WxD
         8S2Ou9spq9WW8pysEe2Mkav/Uya+hVtZVVvfi0IMvfx2EMLTv2pCYH9+it73DkPRWGF1
         17i6WwMzngNxVaazRQFMJq2Trl4FVqsHtdwWQtGUM3efM2rpQy0oUW5P7C1yJstciR4V
         RAfeRztC3uvN6owAkQiImxRiTHODolCs9nEPP7btZzUGFDChcOG+A21HH31IzeW5Nusr
         ldeg==
X-Gm-Message-State: AOAM533ALFweSqYAfTJ6OawBK7vAe/w4bJXzf4wvy2nItc3Nply2bS5t
        6bCeQBPpn00zsxkRJ9r6NDW7EOT0YLw=
X-Google-Smtp-Source: ABdhPJxPg75zs9BDBljU4XYeqYLQi+Nwoy2CdplDWMCbtORe+ZqXlEENqZw7lWXgvlJn2vx+2kupmA==
X-Received: by 2002:a17:906:b84f:: with SMTP id ga15mr42448324ejb.4.1636939462890;
        Sun, 14 Nov 2021 17:24:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l26sm1378428eda.20.2021.11.14.17.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 17:24:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmQjO-000zrs-2S;
        Mon, 15 Nov 2021 02:24:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
Date:   Mon, 15 Nov 2021 02:14:42 +0100
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211114212437.1466695-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211114212437.1466695-2-sandals@crustytoothpaste.net>
Message-ID: <211115.86v90urz21.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 14 2021, brian m. carlson wrote:

> The C99 standard was released in January 1999, now 22 years ago.  It
> provides a variety of useful features, including variadic arguments for
> macros, declarations after statements, variable length arrays, and a
> wide variety of other useful features, many of which we already use.
>
> We'd like to take advantage of these features, but we want to be
> cautious.  As far as we know, all major compilers now support C99 or a
> later C standard, such as C11 or C17.  POSIX has required C99 support as
> a requirement for the 2001 revision, so we can safely assume any POSIX
> system which we are interested in supporting has C99.

I like this direction.

> Sparse is also updated with a reference to the gnu99 standard, without
> which it defaults to C89.

Do we really need it in SPARSE_FLAGS though...

> @@ -1204,7 +1204,7 @@ endif
>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>  # tweaked by config.* below as well as the command-line, both of
>  # which'll override these defaults.
> -CFLAGS = -g -O2 -Wall
> +CFLAGS = -g -O2 -Wall -std=gnu99
>  LDFLAGS =
>  CC_LD_DYNPATH = -Wl,-rpath,
>  BASIC_CFLAGS = -I.
> @@ -1215,7 +1215,7 @@ ARFLAGS = rcs
>  PTHREAD_CFLAGS =

Since $(CFLAGS) ends up in:

    ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)

...

>  # For the 'sparse' target
> -SPARSE_FLAGS ?=
> +SPARSE_FLAGS ?= -std=gnu99
>  SP_EXTRA_FLAGS = -Wno-universal-initializer

... and this will be used for this rule:

$(SP_OBJ): %.sp: %.c %.o
        $(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
                -Wsparse-error \
                $(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< [...]

I.e. unless it needs to be later on the command-line the $(ALL_CFLAGS)
should put it there already.

Also (and this pre-dates this patch) it's unfortunate that CFLAGS is a
mixed bag of compiler tweaking and "mandatory" flags. I think the below
would be a better approach, particurly since our own config.mak.uname
will override CFLAGS in some cases, and probably everyone who works on
git to any degree has a local config.mak which sets it to something
already.

But why gnu99 and not c99?

diff --git a/Makefile b/Makefile
index 12be39ac497..7470d627165 100644
--- a/Makefile
+++ b/Makefile
@@ -1204,10 +1204,14 @@ endif
 # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
 # tweaked by config.* below as well as the command-line, both of
 # which'll override these defaults.
+#
+# The MANDATORY_CFLAGS can be similarly overridden, but really
+# shouldn't.
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
 CC_LD_DYNPATH = -Wl,-rpath,
-BASIC_CFLAGS = -I.
+BASIC_CFLAGS =
+MANDATORY_CFLAGS = -I. -std=gnu99
 BASIC_LDFLAGS =
 
 # library flags
@@ -1249,7 +1253,7 @@ ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
 ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
 endif
 
-ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
+ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(MANDATORY_CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
 comma := ,

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58864C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiCCQFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiCCQFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6B197B78
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:04:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d3so8588545wrf.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSfaNHB9ocGs2+lwGPpPltKLUnQZPaMfGhAwyMrr7ec=;
        b=JRFqhCaesM47fVQh1g74IIevFJ5XMeKjDMfi01ZLHkm6ARw1LKceBqoRcybjMWJzYR
         5lUXaWlzpAtbqsNhXWQ/Z4kP9Cac6M41hp3kQWz8mfuVHafEb2de74ilz+nJMczrFjg5
         28l2rasj454jYfSKgEUldvrJqQf4bOc2JMHpdnAwOcgAu9aDWjVPEa+pH5CuTTIhhz3r
         9QJ3iEf/E2YweQLDt22rOiGtyK0lc5qImEaExz/itJe9CIVsNPLG/TZTYbKbklzoZjh+
         CtL+eRpJT3ApDcjXb9Aguqfp8zhzGLJZdMLQC94cJKx1M90oa06+jAVGbk5dEqGa6vsG
         o/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSfaNHB9ocGs2+lwGPpPltKLUnQZPaMfGhAwyMrr7ec=;
        b=41T6oWpP1jczlhXzJeg0nYRQlRXjyUbTzKmavxOQ/KJDhihNb+oNeZXTCQAAlTw7jX
         EvTBjU+QODy2HlHCxMUcIJKrO1w4ZIHl0ybMNiqLg+ofa9qcrMK3i5TA4EYOTxLOc7xl
         tkXc4XL+1RcWj1hjxD5IH1KsJXSXFQab0cmgaxiyG0ObSfON0zjaiv+RwogmcP38frsh
         Y8VTZIDBC//BsaSbODYiR1HUprPvgLzrK/+PsulErjRYpBafT15rfSZjIY2hMjtQxHRe
         xhuoYi+YIoqY4kR2/2i1hkB6TMVsmUD8vtAIddcwhpU0PPgYQtPnOQ2+iJ0/6OmOXHT/
         9+tg==
X-Gm-Message-State: AOAM533PHMJv7v/vWxJlbPhsmuf+umOfhlj10QayDrUxondLCaVh/vO4
        Ko6QsQBE1H4cKFwfV2V/Jjhj3tzTMg0UEA==
X-Google-Smtp-Source: ABdhPJyebR9KKrNSd3l1O8JHzsnX8nLiHLRja+4TqLdawxpQ8XLSbZ+g0EiUm3MP2ImTIbEKCmcYMQ==
X-Received: by 2002:a5d:4528:0:b0:1ee:ea7f:b97d with SMTP id j8-20020a5d4528000000b001eeea7fb97dmr25635309wra.593.1646323485310;
        Thu, 03 Mar 2022 08:04:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm4040667wmq.35.2022.03.03.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:04:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/8] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Thu,  3 Mar 2022 17:04:16 +0100
Message-Id: <patch-v5-5.8-18e0a6985f1-20220303T160155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was added in 30248886ce8 (Makefile: disable default implicit
rules, 2010-01-26), let's move it to the top of "shared.mak" so it'll
apply to all our Makefiles.

This doesn't benefit the main Makefile at all, since it already had
the rule, but since we're including shared.mak in other Makefiles
starts to benefit them. E.g. running the 'man" target is now faster:

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C Documentation man' 'make -C Documentation -j1 man'
    Benchmark 1: make -C Documentation -j1 man' in 'HEAD~1
      Time (mean ± σ):     121.7 ms ±   8.8 ms    [User: 105.8 ms, System: 18.6 ms]
      Range (min … max):   112.8 ms … 148.4 ms    26 runs

    Benchmark 2: make -C Documentation -j1 man' in 'HEAD~0
      Time (mean ± σ):      97.5 ms ±   8.0 ms    [User: 80.1 ms, System: 20.1 ms]
      Range (min … max):    89.8 ms … 111.8 ms    32 runs

    Summary
      'make -C Documentation -j1 man' in 'HEAD~0' ran
        1.25 ± 0.14 times faster than 'make -C Documentation -j1 man' in 'HEAD~1'

The reason for that can be seen when comparing that run with
"--debug=a". Without this change making a target like "git-status.1"
will cause "make" to consider not only "git-status.txt", but
"git-status.txt.o", as well as numerous other implicit suffixes such
as ".c", ".cc", ".cpp" etc. See [1] for a more detailed before/after
example.

So this is causing us to omit a bunch of work we didn't need to
do. For making "git-status.1" the "--debug=a" output is reduced from
~140k lines to ~6k.

1. https://lore.kernel.org/git/220222.86bkyz875k.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 2 --
 shared.mak | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1ac924bd844..ce362720947 100644
--- a/Makefile
+++ b/Makefile
@@ -2580,8 +2580,6 @@ ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
-.SUFFIXES:
-
 $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
diff --git a/shared.mak b/shared.mak
index 29f0e69ecb9..1dda948df09 100644
--- a/shared.mak
+++ b/shared.mak
@@ -9,6 +9,11 @@
 %:: s.%
 %:: SCCS/s.%
 
+## Likewise delete default $(SUFFIXES). See:
+##
+##     info make --index-search=.SUFFIXES
+.SUFFIXES:
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.35.1.1230.ga6e6579e98c


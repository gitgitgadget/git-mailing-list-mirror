Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF24C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbiCBMuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiCBMu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2518F9A5
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so2595340wrg.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33EBdKeE0xZyRr7lrvljkP0kw1TulBlXZjjBTOOMxY8=;
        b=KUngjAYL0XYDh8YbgQA04ybStJsaBir0u0q7AGORECjhGbEuAocqUsmTHY6ECTgQuf
         lVyzW082E6md80z6Z/ToYXBTx7CibhnQD1L/V27UAGKofSPw+PofOHe53ke7OrT5nmKY
         nPdVmfnoyQMmfAbc8wzh9/0EiBtcYRy5WMiDl3E3f5DMZvyz7psPJELvyE+uUpomf45n
         QhO2z9ovn3zF4zxX0R5tPe6W3Qzl7igWQt27qKDHl/H+0Fd6keoKjDcfotyFVg2hCGqv
         a4u1wgy6/jmmARdMi5mgdN4n4R91vMVYsYAFSt8wZPyCbrnDe9Z7Eqb/auv+9UmQhjDJ
         iJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33EBdKeE0xZyRr7lrvljkP0kw1TulBlXZjjBTOOMxY8=;
        b=axpNricFLn1OKVNDLywfajCd1NUk8ujMGt8tgmq7xEvF6Y3PS4ieR9IGpYOgmLVdN8
         jGi95d2mf7i7CL13WaPIO7P1OJcax6oPzE0XA+awUSXUTA/RHqNwwXBRvO7Qf50/qf/D
         8hJ4h5Mm6c2dZaMDgfRKyEnxQoBhI2WOxZskPYeFeiV/0repLBKiKkhLq+WHUV0NtEkC
         Zcrvfpqm0Up6FR7Bz9poCV08yIv75JYZNxs1/mbkElpHtdkDDh+Tt9jdrrIq3FTU/zgI
         lP9f5zxWAerhao3TiBi6U80pWUW1VZBl/G3WmGCxl245TryQMzPAQ5cFSzBnKaUHtIGv
         xziA==
X-Gm-Message-State: AOAM530tv7Lpus1AXjxPWSMNP93Q/QnDvayWvHSpky8X4ReF+Le0lJND
        /SUXAqWRHhK9Qmll1x/uFCXMQKoKtmn3xg==
X-Google-Smtp-Source: ABdhPJzKmlZ9lT3bhlRdhNBccztWyCZkWrfnvWYbqBp5ynmKVMmTWljr2JSGFPbDGT96TM3OK2c6SA==
X-Received: by 2002:adf:dd0e:0:b0:1ed:d3c2:6f23 with SMTP id a14-20020adfdd0e000000b001edd3c26f23mr23785194wrm.277.1646225383232;
        Wed, 02 Mar 2022 04:49:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:42 -0800 (PST)
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
Subject: [PATCH v4 5/9] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Wed,  2 Mar 2022 13:49:13 +0100
Message-Id: <patch-v4-5.9-c2339694cf7-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
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
2.35.1.1228.g56895c6ee86


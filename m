Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0033C433FE
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B923A6109E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhIVWJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhIVWJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:09:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3924C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:08:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q26so11203138wrc.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZaTSnhjrt/Fc6TJFuuLorhijZlBPY/6QYCw3jHBTM8=;
        b=ccbyl6DHmgfYCoR4ZLuyQPGIbmZtiachCRpb4c+GdsXi/0fcMhn4oXpPmM9Z20AD9v
         E0hOkR78J/+2zCjLhHT33xYoyASNbNUDe6DCNz/Sq3qB/P12aFTbSESPCQFeo5rINEsN
         hqS+7ff3KJ3iRsN9FgqflFQFkY4Ba2JoyBhel7HBh1WzykB4N9LI79iuh+pW8p7vFK7P
         3fAz6+9suW+z/WqGa2Bxk4TLjW6Ddo16HuxJsw5wpIz9OtxoEgvib9F2tftZIoCPOKz/
         qie7ipQ9j8zrLsTavh+yW0HjPEufyO44uIyMEDHa+JYinZyZ077Eix3A5rYMHHJdg+Z0
         9VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZaTSnhjrt/Fc6TJFuuLorhijZlBPY/6QYCw3jHBTM8=;
        b=Q4K2lWoXUT8dB5iVISyGRdt2YNIdot6CEOKdTInfBqm6wyv2X8zD4Uqfe+PuW2eJWB
         pvYdX7Pc6UAdRz0KI61GQIpHsm6AEbhVKX9XaYnxw2UmjZqvJ8f8sJxm3umiT+9Du4yz
         XZzruPfkHmw3OGvGhDZFEWtQP/cnarAeh8CKPa2RqGVea/iQMrSs8XjsUzjFYxpwtNi4
         MA8d+lOBWn+P4paW0+lrl1jYf2Bu+taWRvAjvtZMQ8e+N6UApn1/fx4PsCdGDTmrfVfX
         CjDAf0QSEieIYvjpuaGzupaAJZri8gZnSiRBsMtqauumqffSwbs7PO1Gbyc+wubQ2QGq
         Zvrw==
X-Gm-Message-State: AOAM533hRxPftCoMfbX020f2VeWuK2vdHKSfJxqv6GbWRD+X/9N2EfhC
        BZSGZRtfELJg3wCKGNXxZ9RF17o5G1XJKw==
X-Google-Smtp-Source: ABdhPJwWdg3uyDdM/w4wn+9Gj3KB89fZiGGL4Ckdfax74d7ZUtPyM79vtEIwMQKZxZfakcXhU7h5ZA==
X-Received: by 2002:adf:f8cc:: with SMTP id f12mr1318188wrq.195.1632348484149;
        Wed, 22 Sep 2021 15:08:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm3466336wrb.5.2021.09.22.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:08:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] Makefile: "pedantic" fallout on .depend and "compdb"
Date:   Thu, 23 Sep 2021 00:08:00 +0200
Message-Id: <cover-v2-0.2-00000000000-20210922T220532Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this v2 I just added an unconditional -Wno-pedantic and omitted the
change to spew error on STDERR. This more narrowly fixes the immediate
issue and doesn't get into whether we should use /dev/null or whatever
as input.

I then noticed that the same bug was present in
"GENERATE_COMPILATION_DATABASE=yes", so there's now a 2nd patch to fix
that.

Ævar Arnfjörð Bjarmason (2):
  Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with
    DEVOPTS=pedantic
  Makefile: pass -Wno-pendantic under GENERATE_COMPILATION_DATABASE=yes

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

Range-diff against v1:
1:  3ff8ea12bf3 ! 1:  31c871e9bf6 Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic
    @@ Commit message
         Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic
     
         The "COMPUTE_HEADER_DEPENDENCIES" feature added in [1] was extended to
    -    use auto-detection in [2]. Then when -Wpedantic support was added to
    -    DEVOPTS in [3] we started passing -Wpedantic in combination with
    -    -Werror to the compiler here.
    +    use auto-detection in [2], that "auto" detection has always piped
    +    STDERR to /dev/null, so any failures on compilers that didn't support
    +    these GCC flags would silently fall back to
    +    "COMPUTE_HEADER_DEPENDENCIES=no".
     
    -    This broke the auto-detection, but since we'd quieted it in [4] we
    -    didn't find out. It was emitting all of this on STDERR under GCC:
    +    Later when -Wpedantic support was added to DEVOPTS in [3] we started
    +    passing -Wpedantic in combination with -Werror to the compiler
    +    here. Note (to the pedantic): [3] actually passed "-pedantic", but it
    +    and "-Wpedantic" are synonyms.
    +
    +    Turning on -Wpedantic in [3] broke the auto-detection, since this
    +    relies on compiling an empty program. GCC would loudly complain on
    +    STDERR:
     
             /dev/null:1: error: ISO C forbids an empty translation unit
             [-Werror=pedantic]
    @@ Commit message
             earlier diagnostics
             cc1: all warnings being treated as errors
     
    -    Let's fix that bug by maintaining a NON_DEVELOPER_CFLAGS, it's like
    -    ALL_CFLAGS but without anything we add in config.mak.dev, and
    -    furthermore stop redirecting STDERR to /dev/null, this means that
    -    someone whose compiler doesn't support this will see this output, but
    -    also this new message:
    +    But as that ended up in the "$(dep_check)" variable due to the "2>&1"
    +    in [2] we didn't see it.
     
    -        Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect
    +    Then when [4] made DEVOPTS=pedantic the default specifying
    +    "DEVELOPER=1" would effectively set "COMPUTE_HEADER_DEPENDENCIES=no".
    +
    +    To fix these issues let's unconditionally pass -Wno-pedantic after
    +    $(ALL_CFLAGS), we might get a -Wpedantic via config.mak.dev after, or
    +    the builder might specify it via CFLAGS. In either case this will undo
    +    current and future problems with -Wpedantic.
     
    -    It's also possible that some compilers will emit warnings but still
    -    give a zero exit code, anyone using a compiler like that will
    -    potentially get more verbose output from the Makefile until they set
    -    COMPUTE_HEADER_DEPENDENCIES=no. E.g. on AIX's xlc we'll now emit:
    +    I think it would make sense to simply remove the "2>&1", it would mean
    +    that anyone using a non-GCC-like compiler would get warnings under
    +    COMPUTE_HEADER_DEPENDENCIES=auto, e.g on AIX's xlc would emit:
     
             /opt/IBM/xlc/13.1.3/bin/.orig/xlc: 1501-208 (S) command option D is missing a subargument
             Non-zero 40 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect
    @@ Commit message
             cc: refused to overwrite input file by output file: /dev/null
             Non-zero 1 exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect
     
    -    Both are quieted by setting COMPUTE_HEADER_DEPENDENCIES=no as
    -    suggested.
    -
    -    I considered piping the output and the exit code to a variable
    -    instead, but e.g. under GCC that would lose the coloring in the error
    -    messages.
    +    Both could be quieted by setting COMPUTE_HEADER_DEPENDENCIES=no
    +    explicitly, as suggested, but let's see if this'll fix it without
    +    emitting too much noise at those that aren't using "gcc" or "clang".
     
         1. f2fabbf76e4 (Teach Makefile to check header dependencies,
            2010-01-26)
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
    - ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
    - endif
    - 
    --ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
    -+NON_DEVELOPER_CFLAGS = $(CPPFLAGS) $(CFLAGS)
    -+ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(NON_DEVELOPER_CFLAGS)
    - ALL_LDFLAGS = $(LDFLAGS)
    - 
    - comma := ,
    -@@ Makefile: COMPUTE_HEADER_DEPENDENCIES = auto
    - endif
    +@@ Makefile: endif
      
      ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
    --dep_check = $(shell $(CC) $(ALL_CFLAGS) \
    -+dep_check = $(shell $(CC) $(NON_DEVELOPER_CFLAGS) \
    + dep_check = $(shell $(CC) $(ALL_CFLAGS) \
    ++	-Wno-pedantic \
      	-c -MF /dev/null -MQ /dev/null -MMD -MP \
    --	-x c /dev/null -o /dev/null 2>&1; \
    -+	-x c /dev/null -o /dev/null; \
    + 	-x c /dev/null -o /dev/null 2>&1; \
      	echo $$?)
    - ifeq ($(dep_check),0)
    - override COMPUTE_HEADER_DEPENDENCIES = yes
    - else
    -+$(info Non-zero $(dep_check) exit with COMPUTE_HEADER_DEPENDENCIES=auto, set it to "yes" or "no" to quiet auto-detect)
    - override COMPUTE_HEADER_DEPENDENCIES = no
    - endif
    - endif
-:  ----------- > 2:  6b18bd08894 Makefile: pass -Wno-pendantic under GENERATE_COMPILATION_DATABASE=yes
-- 
2.33.0.1225.g9f062250122


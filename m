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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0192CC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D574761131
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 00:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhIWAIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhIWAIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 20:08:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DBC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 17:07:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so11974426wrq.4
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83E0zLKZqnMTCoK+sK2GEEXIvN8cFmKXMMYeDEEDPw8=;
        b=CiQwFt+bgy/h5fwGMZ5dXTdSK4HLHpUf3JPM9jLYTPIUxmghNtJiQ5/AXgU1Ws/dw3
         Yst9Mu1YDgLEluc88W64qRfj8NGkjPn1UtkXx2Qsq7lhTZa2lDnmCbrMvDAscEm3fzRa
         11zoxkFqRKjl/VZ4smeRGxMfK0oxoDRyhv1EuUjDpDqE2/empcj/OHyul9ZjCrN1LvLZ
         K/yQc+4EH7+ndLlzLsZ9BfGDH7ZRSE6e7Fi76hDxPIp1R40m9waXkcwAH4ib0biXutj/
         4c6NBVv1vjuMkallvKfAl3Gpu36mxsFj+avI4SxW5U5gGHNXchs5H8KcFCbuInwtneTX
         iUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83E0zLKZqnMTCoK+sK2GEEXIvN8cFmKXMMYeDEEDPw8=;
        b=qxA/sV+Yvz69KpYaUDd2duZPSrA26hFcdUJiz1QwT3A9Ybc+kVgFcrdZQ4FRBhkTW6
         LAanyY2dXutxHBwrke+NauH0xfufiwko4dmQMQEGXDJbS82qdodNjY/gV15euBVLyD+U
         xIBww6L5J+epU8p8YawIOPluV0QBinv8/87vxFf9cXI6Qvftb+zLQBnIdc+bJQQH1FT8
         iW0yjuFN9kHmHkYCtlpxH+1iyeDxcX00ceHvwwSTv350UMbRp0JTnQvhUO3K+BcQvtok
         Kq0tiGimxdleRICA/yWyO1wpZiEIdY5Dm1jIRmTsFarbGpbAwxKe3d+YPDhDFjfEascN
         ZpOQ==
X-Gm-Message-State: AOAM532ODExIhXFlQ3oNkrYhBFv+d4HR7z4uAcWuxnPO2sgaSuqFlDpM
        Qp+e530sNDh5FUavSOEpMXEB6kPp4vCBTw==
X-Google-Smtp-Source: ABdhPJwtCO5lgjuV8FAVTYkDeDiIpkMioqoPwaCv4LbV5Q6nrJrwsr7yI4dlrML3/MM4DaWZ57LPyA==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr1573544wmj.144.1632355639552;
        Wed, 22 Sep 2021 17:07:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t126sm7323324wma.4.2021.09.22.17.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 17:07:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
Date:   Thu, 23 Sep 2021 02:07:16 +0200
Message-Id: <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "sparse" target and its *.sp dependencies to be
non-.PHONY. Before this change "make sparse" would take ~5s to re-run
all the *.c files through "cgcc", after it it'll create an empty *.sp
file sitting alongside the *.c file, only if the *.c file or its
dependencies are newer than the *.sp is the *.sp re-made.

We ensure that the recursive dependencies are correct by depending on
the *.o file, which in turn will have correct dependencies by either
depending on all header files, or under
"COMPUTE_HEADER_DEPENDENCIES=yes" the headers it needs.

This means that a plain "make sparse" is much slower, as we'll now
need to make the *.o files just to create the *.sp files, but
incrementally creating the *.sp files is *much* faster and less
verbose, it thus becomes viable to run "sparse" along with "all" as
e.g. "git rebase --exec 'make all sparse'".

On my box with -j8 "make sparse" was fast before, or around 5 seconds,
now it only takes that long the first time, and the common case is
<100ms, or however long it takes GNU make to stat the *.sp file and
see that all the corresponding *.c file and its dependencies are
older.

See 0bcd9ae85d7 (sparse: Fix errors due to missing target-specific
variables, 2011-04-21) for the modern implementation of the sparse
target being changed here.

It is critical that we use -Wsparse-error here, otherwise the error
would only show up once, but we'd successfully create the empty *.sp
file, and running a second time wouldn't show the error. I'm therefore
not putting it into SPARSE_FLAGS or SP_EXTRA_FLAGS, it's not optional,
the Makefile logic won't behave properly without it.

Appending to $@ without a move is OK here because we're using the
.DELETE_ON_ERROR Makefile feature. See 7b76d6bf221 (Makefile: add and
use the ".DELETE_ON_ERROR" flag, 2021-06-29). GNU make ensures that on
error this file will be removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  e03fde1b642 ! 1:  059829f2195 Makefile: make the "sparse" target non-.PHONY
    @@ Commit message
         Makefile: make the "sparse" target non-.PHONY
     
         Change the "sparse" target and its *.sp dependencies to be
    -    non-.PHONY. It's now viable to run it as part of a normal compilation
    -    target, as we'll only re-generate these checks if the source *.c file
    -    has changed.
    +    non-.PHONY. Before this change "make sparse" would take ~5s to re-run
    +    all the *.c files through "cgcc", after it it'll create an empty *.sp
    +    file sitting alongside the *.c file, only if the *.c file or its
    +    dependencies are newer than the *.sp is the *.sp re-made.
     
    -    On my box with -j8 it was fast before, or around 5 seconds, now it
    -    only takes that long the first time, and the common case is <100ms, or
    -    however long it takes GNU make to stat the *.sp file and see that all
    -    the corresponding *.c files are older.
    +    We ensure that the recursive dependencies are correct by depending on
    +    the *.o file, which in turn will have correct dependencies by either
    +    depending on all header files, or under
    +    "COMPUTE_HEADER_DEPENDENCIES=yes" the headers it needs.
    +
    +    This means that a plain "make sparse" is much slower, as we'll now
    +    need to make the *.o files just to create the *.sp files, but
    +    incrementally creating the *.sp files is *much* faster and less
    +    verbose, it thus becomes viable to run "sparse" along with "all" as
    +    e.g. "git rebase --exec 'make all sparse'".
    +
    +    On my box with -j8 "make sparse" was fast before, or around 5 seconds,
    +    now it only takes that long the first time, and the common case is
    +    <100ms, or however long it takes GNU make to stat the *.sp file and
    +    see that all the corresponding *.c file and its dependencies are
    +    older.
     
         See 0bcd9ae85d7 (sparse: Fix errors due to missing target-specific
         variables, 2011-04-21) for the modern implementation of the sparse
    @@ Makefile: check-sha1:: t/helper/test-tool$X
      SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
      
     -$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
    -+$(SP_OBJ): %.sp: %.c GIT-CFLAGS
    ++$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
      	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
     -		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
     +		-Wsparse-error \
    @@ Makefile: check-sha1:: t/helper/test-tool$X
      sparse: $(SP_OBJ)
      
      EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
    +@@ Makefile: clean: profile-clean coverage-clean cocciclean
    + 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
    + 	$(RM) $(TEST_PROGRAMS)
    + 	$(RM) $(FUZZ_PROGRAMS)
    ++	$(RM) $(SP_OBJ)
    + 	$(RM) $(HCC)
    + 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
    + 	$(RM) -r po/build/
2:  9c4cedacdce < -:  ----------- Makefile: do one append in %.hcc rule
3:  e2ad1700f9e < -:  ----------- Makefile: make the "hdr-check" target non-.PHONY

 .gitignore | 1 +
 Makefile   | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 311841f9bed..b02250a50c4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -224,6 +224,7 @@
 *.lib
 *.res
 *.sln
+*.sp
 *.suo
 *.ncb
 *.vcproj
diff --git a/Makefile b/Makefile
index a9f9b689f0c..0bae65889fe 100644
--- a/Makefile
+++ b/Makefile
@@ -2896,11 +2896,13 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
-$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
+$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
-		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
+		-Wsparse-error \
+		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
+	>$@
 
-.PHONY: sparse $(SP_OBJ)
+.PHONY: sparse
 sparse: $(SP_OBJ)
 
 EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
@@ -3227,6 +3229,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
+	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
-- 
2.33.0.1225.g9f062250122


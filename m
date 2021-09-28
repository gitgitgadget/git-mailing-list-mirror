Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3180C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 01:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75044611EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 01:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbhI1BQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhI1BQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 21:16:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0542C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 18:15:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i23so55115571wrb.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4VyUwmNG/wF+ubYxLC2R1MjSlqQ/so5eeBSVcaieXog=;
        b=T+t2yydDjEZqhppRU/g9gT1piOQeNt87TAjdOeQLiIwwuBTJ/6zFB1sS+w41jax5Qq
         TKgTKMn8lTqmdY8Ah1kD+1br57X0Vc+l2TZ5Yd0pyBJ7EjxPNoA9fdBkeR0Y1jk1/wgc
         KIyxgVvCAE68emfkRcAZ4ZRychVbr76NsQnQuh6Kh8dC/NTObtwYMWN6dsmSL1EuF2e5
         sYM0DYq4k8hfNcfX4RcPX60k9psER1rot6IBXn7O9ECEP3OlvNZpa+yEW60xcrSpOEkL
         8ZqF9n400AZ0tVRJh6/NNNuconTWcLTthl16ASg2dKAnCtefbjkF4HFhL+rY6fPiUq8r
         4Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4VyUwmNG/wF+ubYxLC2R1MjSlqQ/so5eeBSVcaieXog=;
        b=z/mKzEIJf7Hdd5Ad5pDL7P8Md0TDKr7jpasl2LJmakOmAdf6rIvARdYMWeSd12D+ti
         Ih21neL5gqaVpBV7m+SffK378yuX2hDGZP8boO/CmGLS/nZLSGhu6mAkXRNGP9vlpq+e
         TNHYVkFCBj9CPZPsOtufz0OtILwsJCRduxeRJ4tx6TK82f9TsJCPnCxeVWlCAkJrUWHe
         7WHVCRUtdsoWKN2SRaVbu3dEZ0RgPJwf9T8PC6OPlGWb2JFDmxEGWzWGbeCNEAl0ulTD
         xbfHVveZIg4xDK/FdvyHXivWv29DR/f3uU1V4uHWjggcSTxdP95u25NHIhfKKj2hIgjx
         imOQ==
X-Gm-Message-State: AOAM530K45TPEvotctIu5xJvo1o93gFgfjgGtslJJB29YWGitkwFEQSi
        C7zzex+RNUAdbPM1juMKXyXgGxLxzo5DZw==
X-Google-Smtp-Source: ABdhPJyoDe2fDNNB6oOwE9OE4AVsdhDN6k3ldEKHPPEJ42sHqRtBR4et4N4N8IIbmKQKavyJ2GHXLA==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr3298029wrv.405.1632791706755;
        Mon, 27 Sep 2021 18:15:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm2869798wrs.75.2021.09.27.18.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 18:15:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] Makefile: add a non-.PHONY "sparse-incr" target
Date:   Tue, 28 Sep 2021 03:15:02 +0200
Message-Id: <patch-v3-1.1-b6ba99ca4cc-20210928T011319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1326.g5e4342b7bef
In-Reply-To: <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
References: <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "sparse-incr" target to compliment the existing "sparse"
target. The new "sparse-incr" target doesn't depend on "FORCE", and
will create empty *.sp files as markers for the corresponding *.c file
having been checked.

Those *.sp files in turn depend on the *.o files, so we can be certain
that the dependencies are correct by either depending on all header
files, or under "COMPUTE_HEADER_DEPENDENCIES=yes" the headers the
relevant file needs.

The "sparse-incr" target is slower on a fresh git.git checkout, as it
depends on the creation of the *.o files. But once the *.o and *.sp
files are built it's able to incrementally update them. It's thus
viable to run:

    make all sparse-incr

As part of a regular edit/compile/test cycle, or as a fast "git rebase
--exec" command.

On my box (with -j8) the initial run of the "sparse" target takes ~5s,
but ~16s for "sparse-incr". When using CC="ccache cc" the difference
between the two is negligible.

Running e.g.:

    make grep.sp

Will behave the same way and will always re-run "cgcc", we'll only use
the new dependency chain of "sparse-incr" is part of the MAKECMDGOALS.

I think it would make sense to just remove the "sparse" target
entirely, and to say that anyone who cares about the speed of an
initial "sparse" run should use "CC='ccache cc'". But per [1] and [2]
there are existing users of "make sparse" and "make <file>.sp" that
prefer the current semantics.

I.e. per [2] want "make <file>.sp" to *always* run "sparse", even
though a corresponding "make <file>.o" would only re-run the "real"
compilation if needed. I don't think that makes any sense, especially
in combination with DEVELOPER=1 which'll ensure that -Werror would
have made any errors in a "make <file>.sp" sticky.

But since we have existing users relying on it, and I don't really
care at al about "make <file>.sp", I just want an incremental target I
can use, let's create this new "make sparse-incr" instead of "fixing"
the existing "make sparse".

See 0bcd9ae85d7 (sparse: Fix errors due to missing target-specific
variables, 2011-04-21) for the modern implementation of the "sparse"
target being changed here.

Appending to $@ without a move is OK here because we're using the
.DELETE_ON_ERROR Makefile feature. See 7b76d6bf221 (Makefile: add and
use the ".DELETE_ON_ERROR" flag, 2021-06-29). GNU make ensures that on
error this file will be removed.

1. https://lore.kernel.org/git/xmqqtuib199x.fsf@gitster.g/
2. https://lore.kernel.org/git/457ec039-1e26-9da9-55f6-9ea79b962bfe@ramsayjones.plus.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v2:
1:  059829f2195 ! 1:  b6ba99ca4cc Makefile: make the "sparse" target non-.PHONY
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: make the "sparse" target non-.PHONY
    -
    -    Change the "sparse" target and its *.sp dependencies to be
    -    non-.PHONY. Before this change "make sparse" would take ~5s to re-run
    -    all the *.c files through "cgcc", after it it'll create an empty *.sp
    -    file sitting alongside the *.c file, only if the *.c file or its
    -    dependencies are newer than the *.sp is the *.sp re-made.
    -
    -    We ensure that the recursive dependencies are correct by depending on
    -    the *.o file, which in turn will have correct dependencies by either
    -    depending on all header files, or under
    -    "COMPUTE_HEADER_DEPENDENCIES=yes" the headers it needs.
    -
    -    This means that a plain "make sparse" is much slower, as we'll now
    -    need to make the *.o files just to create the *.sp files, but
    -    incrementally creating the *.sp files is *much* faster and less
    -    verbose, it thus becomes viable to run "sparse" along with "all" as
    -    e.g. "git rebase --exec 'make all sparse'".
    -
    -    On my box with -j8 "make sparse" was fast before, or around 5 seconds,
    -    now it only takes that long the first time, and the common case is
    -    <100ms, or however long it takes GNU make to stat the *.sp file and
    -    see that all the corresponding *.c file and its dependencies are
    -    older.
    +    Makefile: add a non-.PHONY "sparse-incr" target
    +
    +    Add a "sparse-incr" target to compliment the existing "sparse"
    +    target. The new "sparse-incr" target doesn't depend on "FORCE", and
    +    will create empty *.sp files as markers for the corresponding *.c file
    +    having been checked.
    +
    +    Those *.sp files in turn depend on the *.o files, so we can be certain
    +    that the dependencies are correct by either depending on all header
    +    files, or under "COMPUTE_HEADER_DEPENDENCIES=yes" the headers the
    +    relevant file needs.
    +
    +    The "sparse-incr" target is slower on a fresh git.git checkout, as it
    +    depends on the creation of the *.o files. But once the *.o and *.sp
    +    files are built it's able to incrementally update them. It's thus
    +    viable to run:
    +
    +        make all sparse-incr
    +
    +    As part of a regular edit/compile/test cycle, or as a fast "git rebase
    +    --exec" command.
    +
    +    On my box (with -j8) the initial run of the "sparse" target takes ~5s,
    +    but ~16s for "sparse-incr". When using CC="ccache cc" the difference
    +    between the two is negligible.
    +
    +    Running e.g.:
    +
    +        make grep.sp
    +
    +    Will behave the same way and will always re-run "cgcc", we'll only use
    +    the new dependency chain of "sparse-incr" is part of the MAKECMDGOALS.
    +
    +    I think it would make sense to just remove the "sparse" target
    +    entirely, and to say that anyone who cares about the speed of an
    +    initial "sparse" run should use "CC='ccache cc'". But per [1] and [2]
    +    there are existing users of "make sparse" and "make <file>.sp" that
    +    prefer the current semantics.
    +
    +    I.e. per [2] want "make <file>.sp" to *always* run "sparse", even
    +    though a corresponding "make <file>.o" would only re-run the "real"
    +    compilation if needed. I don't think that makes any sense, especially
    +    in combination with DEVELOPER=1 which'll ensure that -Werror would
    +    have made any errors in a "make <file>.sp" sticky.
    +
    +    But since we have existing users relying on it, and I don't really
    +    care at al about "make <file>.sp", I just want an incremental target I
    +    can use, let's create this new "make sparse-incr" instead of "fixing"
    +    the existing "make sparse".
     
         See 0bcd9ae85d7 (sparse: Fix errors due to missing target-specific
    -    variables, 2011-04-21) for the modern implementation of the sparse
    +    variables, 2011-04-21) for the modern implementation of the "sparse"
         target being changed here.
     
    -    It is critical that we use -Wsparse-error here, otherwise the error
    -    would only show up once, but we'd successfully create the empty *.sp
    -    file, and running a second time wouldn't show the error. I'm therefore
    -    not putting it into SPARSE_FLAGS or SP_EXTRA_FLAGS, it's not optional,
    -    the Makefile logic won't behave properly without it.
    -
         Appending to $@ without a move is OK here because we're using the
         .DELETE_ON_ERROR Makefile feature. See 7b76d6bf221 (Makefile: add and
         use the ".DELETE_ON_ERROR" flag, 2021-06-29). GNU make ensures that on
         error this file will be removed.
     
    +    1. https://lore.kernel.org/git/xmqqtuib199x.fsf@gitster.g/
    +    2. https://lore.kernel.org/git/457ec039-1e26-9da9-55f6-9ea79b962bfe@ramsayjones.plus.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .gitignore ##
    @@ Makefile: check-sha1:: t/helper/test-tool$X
      SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
      
     -$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
    -+$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
    ++define cmd_run_sparse
      	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
    --		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
    -+		-Wsparse-error \
    -+		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
    -+	>$@
    + 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
    ++endef
    ++
    ++ifneq ($(filter sparse-incr,$(MAKECMDGOALS)),sparse-incr)
    ++ifneq ($(filter sparse,$(MAKECMDGOALS)),)
    ++$(error The sparse and sparse-incr targets cannot be combined!)
    ++endif
    ++$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
    ++	$(cmd_run_sparse)
    ++else
    ++$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
    ++	$(cmd_run_sparse) >$@
    ++endif
      
     -.PHONY: sparse $(SP_OBJ)
    -+.PHONY: sparse
    ++.PHONY: sparse sparse-incr
      sparse: $(SP_OBJ)
    ++sparse-incr: $(SP_OBJ)
      
      EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
    + ifndef GCRYPT_SHA256
     @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
      	$(RM) $(TEST_PROGRAMS)

 .gitignore |  1 +
 Makefile   | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

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
index a9f9b689f0c..59270d5b056 100644
--- a/Makefile
+++ b/Makefile
@@ -2896,12 +2896,25 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
-$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
+define cmd_run_sparse
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
+endef
+
+ifneq ($(filter sparse-incr,$(MAKECMDGOALS)),sparse-incr)
+ifneq ($(filter sparse,$(MAKECMDGOALS)),)
+$(error The sparse and sparse-incr targets cannot be combined!)
+endif
+$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
+	$(cmd_run_sparse)
+else
+$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
+	$(cmd_run_sparse) >$@
+endif
 
-.PHONY: sparse $(SP_OBJ)
+.PHONY: sparse sparse-incr
 sparse: $(SP_OBJ)
+sparse-incr: $(SP_OBJ)
 
 EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
@@ -3227,6 +3240,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
+	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
-- 
2.33.0.1326.g5e4342b7bef


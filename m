Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4CCC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 01:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467576120A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbhI1BqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 21:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbhI1BqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 21:46:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB9CC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 18:44:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s24so2069800wmh.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 18:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkDdpQ+3CQxZ+/n4n2lM/5O84n4oCUd8yMRe4umgtmE=;
        b=boMGVQzboasKkkKg/zautr77nFpmOnbo1x866Zt++Q5rJX7W0RPDXHjj+nc/fXqf6v
         1y/dEyYy6ekG99KC9cypwZqA1F18Sop9xbvzKgk9ayYPAlceERRQhIFSGwH6x1e7VExz
         h1wfOjYc4wVpE52VI7ea1MWJfnGo+JVb2H3VzcJvNDym778dc8ltkaCZbWN6VX4JMBiv
         Kf5fOrggwF1l7r/31baSdKvgQXGlZUU9Hsin4SVvUlq3vlaoGSazBl3q6pjuS1aR0B1c
         PpItDSkP2Y4UMkIBizNrlmXInEWun1i6xTqWfxvH7lj2Kao60DcX945fHm1yGpufnx57
         7xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkDdpQ+3CQxZ+/n4n2lM/5O84n4oCUd8yMRe4umgtmE=;
        b=M0KuG7m24xhRyt/O1pKoO8Rd5IYyrNu1LZi+zThVlSyvIm4f9NqiYp8Ut2uFlW6zo+
         OJQISz4/oSWKiLFiE5jwmZ3+LgFayOjiNP/AmpqNv5kKfg+rZVcoFXIqdyWoyGXLbrOY
         MMXxqiiWiCxhE1Au2NCl3GID6uxjwbPF0UCbVsEqH9Ur/ABJhrOSmxmVcLlqBdk0ZUf9
         dLGFIgMUr/9oO1TlUMgtcOcjNCMVJPrb2mLjb0EthxxUGOITIMNELRKvt/zFHC/abPnn
         b0xYaUkI31sFO8L14wYTp8h9TF/daY/93Fik7UgcPB+vn9kQ/f+I6gV9RKnEHm1ehutW
         47Og==
X-Gm-Message-State: AOAM531IZbvw62EPZMp4Ue9PonoPQPCX3UTmvrbLVz/mfArSYbfqo1Ln
        XJYMLv2hFXuDYdFAK5G5iVVn2/HBvHnx+g==
X-Google-Smtp-Source: ABdhPJxFW/II/3FWiKSEKEpOvcAjlBsM9fy/v8eLFr4TNqgnfdh1de/fimOQ9/kRDnw+6668oMazAw==
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr2085773wmg.100.1632793463061;
        Mon, 27 Sep 2021 18:44:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m4sm21006616wrx.81.2021.09.27.18.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 18:44:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4] Makefile: add a non-.PHONY "sparse-incr" target
Date:   Tue, 28 Sep 2021 03:43:31 +0200
Message-Id: <patch-v4-1.1-f31fa3e8282-20210928T014023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1326.g5e4342b7bef
In-Reply-To: <patch-v3-1.1-b6ba99ca4cc-20210928T011319Z-avarab@gmail.com>
References: <patch-v3-1.1-b6ba99ca4cc-20210928T011319Z-avarab@gmail.com>
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

Not so long since v3, it was hopelessly broken, sorry. I was doing
some last-minute tweaking of the ifeq/ifneq conditions, so any target
in the Makefile that wasn't "sparse" or "sparse-incr" broke.

Now we do the right thing by just splitting up the check, if you
supply "sparse" and "sparse-incr" (in any order, and even among other
targets) we'll error, they're incompatible.

Then we separately check if the "sparse-incr" target has been
specified, if it has we'll use the new dependency mechanism, if not
we'll use the old behavior.

Range-diff against v3:
1:  b6ba99ca4cc ! 1:  f31fa3e8282 Makefile: add a non-.PHONY "sparse-incr" target
    @@ Makefile: check-sha1:: t/helper/test-tool$X
      		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
     +endef
     +
    -+ifneq ($(filter sparse-incr,$(MAKECMDGOALS)),sparse-incr)
    -+ifneq ($(filter sparse,$(MAKECMDGOALS)),)
    ++ifeq ($(sort $(filter sparse sparse-incr,$(MAKECMDGOALS))),sparse sparse-incr)
     +$(error The sparse and sparse-incr targets cannot be combined!)
     +endif
    ++
    ++ifneq ($(filter sparse-incr,$(MAKECMDGOALS)),sparse-incr)
     +$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
     +	$(cmd_run_sparse)
     +else

 .gitignore |  1 +
 Makefile   | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

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
index a9f9b689f0c..fd623523394 100644
--- a/Makefile
+++ b/Makefile
@@ -2896,12 +2896,26 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
-$(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
+define cmd_run_sparse
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
+endef
+
+ifeq ($(sort $(filter sparse sparse-incr,$(MAKECMDGOALS))),sparse sparse-incr)
+$(error The sparse and sparse-incr targets cannot be combined!)
+endif
+
+ifneq ($(filter sparse-incr,$(MAKECMDGOALS)),sparse-incr)
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
@@ -3227,6 +3241,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
+	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
-- 
2.33.0.1326.g5e4342b7bef


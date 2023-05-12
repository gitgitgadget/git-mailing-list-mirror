Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65EC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 22:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbjELWwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 18:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbjELWwE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 18:52:04 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5CDE
        for <git@vger.kernel.org>; Fri, 12 May 2023 15:52:02 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ab1f0b6abeso3873617a34.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683931921; x=1686523921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvqE1x7AsXStvej58b8v7otdY8V64NU70e7e2cJq7BE=;
        b=OoRew+jJ6ZdMuE6irRI9b22FNHX8ybWRt91O8UK2VL7fx2huliWK8cYEZz26Jccy7v
         OuAgoAzk5ICBE1Re2bVvrXOFNOibjUsJdoNKPNztKSGeUz3FT9Ub1YQk6z9AOCz7BH68
         RjPitYfmgU+bzbObrgbREcdw4UwLvIb+iH5WiTfR9j3IiJkPUPVI/iOwHSbbIDK5jFk9
         R6YBQB1iRv2bay+nZ6q1Z4QbL4e3FuvXDD1HVEIea5142dNp9AreRmVv2zCzABrLhxIo
         76ijZqIZZ6mbCr1Wc1eFkQL9MxXBjea8bDRnTGbmaabrAu4pquDoaAlCqanoEvLeFEMs
         B/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683931921; x=1686523921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvqE1x7AsXStvej58b8v7otdY8V64NU70e7e2cJq7BE=;
        b=aoYUvg9LFofI+8asSSJNzDND7P/M4Q/mqzZuA/VEBzjII7fWqgaTeOfOacrpdKKtOy
         mLtiqwnBDwJvvecF5Mr204tQ9vxsKMlA/E6Kyhc9QQOvskk7JPu+0uTSKSImZMJwSl+y
         JlB7NhuwC2S+uGLJcRTDUdleFyNIdQdlb6LJbos4iS0/thHf/KST8XC8TI5hFJryhWDb
         LMIRQw4IInizTQMQrEVGfd9yuUbVPxGnbEEwrhM1LY5MbXhqV5xC6VSaKVZUDp7nbYgU
         9mhXyvIxiGcLOB0mI8yHVE++SpXfTZewX4PXUK1UKUX2lUCO2Fz8CBSRt3tCu0DaAHHd
         xFpw==
X-Gm-Message-State: AC+VfDwB4NKOkRiBFPnhDvD9eYogbGEneSthTTxlrJr/jMB1UIUKTOfo
        JxhRwB0pXMa6/IdsBb/ir/2YZ+pk1gY=
X-Google-Smtp-Source: ACHHUZ7Kp7aO7pWrlmLIa5dThhNAx3kv6ZR5x3cMUnhjyrqdfXPNum0r+JXFy54vSBDudhGTHVFRAA==
X-Received: by 2002:a05:6830:11c9:b0:6a5:e895:1bd3 with SMTP id v9-20020a05683011c900b006a5e8951bd3mr8167933otq.31.1683931921549;
        Fri, 12 May 2023 15:52:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d694c000000b006ab04994a1csm5789132oto.65.2023.05.12.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 15:52:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>
Subject: [PATCH] lib: add new libgit-builtin
Date:   Fri, 12 May 2023 16:52:00 -0600
Message-Id: <20230512225200.2214534-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since its creation in 0a02ce72d9 (Clean up the Makefile a bit.,
2005-04-18), libgit.a has been used as dumping ground for everything all
git commands use.

When the code was split between `*.c` and `builtin/*.c` it was never
clarified what belongs in what category.

The code in `*.c` can be shared by all builtins, but so can the code in
`builtin/*.c`.

There's no practical difference.

In order to attempt to start decoupling libgit.a from the `git` binary,
let's create a new libgit-builtin.a library meant only for the code in
`builtin/*.c`.

Ideally eventually libgit.a would not contain code that is specific to
`git`, only code that is generic and could be used by projects outside
git.git.

This is an essential step that has to be done if there's any hope of
ever having a public libgit.so library.

The choice of notes-utils.c is mostly arbitrary, but its functions had
been discussed before as a roadblock for a proper libgit. In particular
something like `init_copy_notes_for_rewrite("am")` does not seem like
something anyone outside `git` would want to call.

Cc: Emily Shaffer <nasamuffin@google.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

After re-reading a previous thread about the lbification of git [1], I
realized `init_copy_notes_for_rewrite()` and others which now belong in
notes-utils.c are good candidates to start splitting away from what
eventually should be a public libgit.so library.

[1] https://lore.kernel.org/git/1370712574-27688-1-git-send-email-felipe.contreras@gmail.com/

 Makefile | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index e440728c24..84cbb35828 100644
--- a/Makefile
+++ b/Makefile
@@ -668,6 +668,7 @@ FUZZ_OBJS =
 FUZZ_PROGRAMS =
 GIT_OBJS =
 LIB_OBJS =
+BUILTIN_LIB_OBJS =
 SCALAR_OBJS =
 OBJECTS =
 OTHER_PROGRAMS =
@@ -916,6 +917,7 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
+BUILTIN_LIB_FILE = libgit-builtin.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
 REFTABLE_TEST_LIB = reftable/libreftable_test.a
@@ -1071,7 +1073,6 @@ LIB_OBJS += negotiator/noop.o
 LIB_OBJS += negotiator/skipping.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
-LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
 LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
@@ -1194,6 +1195,8 @@ LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 
+BUILTIN_LIB_OBJS += notes-utils.o
+
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
@@ -1332,7 +1335,7 @@ THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+GITLIBS = common-main.o $(LIB_FILE) $(BUILTIN_LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2655,6 +2658,7 @@ TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST
 test-objs: $(TEST_OBJS)
 
 GIT_OBJS += $(LIB_OBJS)
+GIT_OBJS += $(BUILTIN_LIB_OBJS)
 GIT_OBJS += $(BUILTIN_OBJS)
 GIT_OBJS += common-main.o
 GIT_OBJS += git.o
@@ -2809,6 +2813,9 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(BUILTIN_LIB_FILE): $(BUILTIN_LIB_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3651,7 +3658,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
+	$(RM) $(LIB_FILE) $(BUILTIN_LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
-- 
2.40.0+fc1


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3222C433E4
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB43619AA
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhC2QUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhC2QU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:20:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137AC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x16so13449806wrn.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXfE85x6C+7PaJh9Ha6dlijv9zUFqAt8ENYpTIF2VOk=;
        b=VUhM/vQceFaLWX37/Iq8LjdoKXibEOXnGGRBW9CeOwxOshAiBZLe6hueU6vW1HaamT
         psbzKSEFOr9m9wSsjNCv25kzBVi6VMwRH3rqJheOk+axaMP6BT19mx1g8RztrElG9IeL
         pi2hn4QRrCUcC+goHlEXncopO7QJTFDvDF9J6mfgnrHBKPCkDtgrMdhc49zcN8c6o3Aj
         mGVyaFnGttG5QqUx0T2qzD781U3oiwHN5qng5nKiZQa4GZX61urnp1S418SiQDddDNi0
         /pL1/kPYcssMGtSVOwKiJCx3X92Wys2HyRWcCd8puEwlpOwny3ID0F56be4mXNZsWfNC
         FQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXfE85x6C+7PaJh9Ha6dlijv9zUFqAt8ENYpTIF2VOk=;
        b=VkDD66sjQ8gGFo/0oYfZU/a7J2O9ZhLAISVdKhrb/aLzZwfQN+8ty04NRLJs+Fm00S
         c5OwOAFJBU9KDeyfOH4zvADGoapL/w31mmLZFateLjJQDnoLaEffIwYkrZP8Vg60Q/sy
         pqMtKdw82+6Bx45PuZMXuyEHBMRU2DvLf0/R4i1WilnVOrc4JYLSGqkVLI7+8N8ShYp2
         f7P43wzczlD+NhFv0E137/tEbZN7stXmuR6Az6XCfO7WAY5A7FChil4qgfEhOFF1UKei
         vAUKaiF1KA3KX6AzPFttYjwWXEy0PymdblbXssI/E7SzeEhiIDV0/uN0UGr145SYkp00
         jYJQ==
X-Gm-Message-State: AOAM530S64/0B9+7J0IGUpRvQPbpF5srnrtscF5KTKAsnwvdRnOnwJ1U
        //qyeqQPt1+K/P+QgUjtzWaZ4atksQGGew==
X-Google-Smtp-Source: ABdhPJxJa+ZJK0fdtGIzUvH9WsKBsnaznu/g2ClwHHusslKVF6ufpnq6J96q5qYY3U7EYKQYVUd82g==
X-Received: by 2002:adf:9261:: with SMTP id 88mr28435643wrj.270.1617034826768;
        Mon, 29 Mar 2021 09:20:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm31835353wrf.41.2021.03.29.09.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:20:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] Makefile: rename scripts in-place, don't clobber
Date:   Mon, 29 Mar 2021 18:20:09 +0200
Message-Id: <patch-2.6-49dbd54d0ff-20210329T161723Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
References: <20210307132001.7485-1-avarab@gmail.com> <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the rules that generate auxiliary files such as
GIT-BUILD-OPTIONS, *.s and other non-object files to use the same
in-place move pattern as we use for object files as of the preceding
commit.

Unlike the change in the preceding commit, this one isn't isn't needed
for AIX portability. I think it makes sense to do this for
consistency, we'll now use the same pattern for object and non-object
generation.

It'll also guard against any weird issues with e.g. a command that
wants to read GIT-PERL-DEFINES to generate one of the %.perl scripts
racing with either a concurrent instance of "make" that has partially
updated the file, or test-lib.sh dying with some particularly weird
error because GIT-BUILD-OPTIONS was partway through being updated when
it ran.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index b0dbf5888b7..ef2d4a9973b 100644
--- a/Makefile
+++ b/Makefile
@@ -2246,7 +2246,8 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 	$(QUIET_RC)$(RC) \
 	  $(join -DMAJOR= -DMINOR= -DMICRO= -DPATCHLEVEL=, $(wordlist 1, 4, \
 	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
-	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
+	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@+ && \
+	mv $@+ $@
 
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
@@ -2293,7 +2294,8 @@ GIT-PERL-DEFINES: FORCE
 	@FLAGS='$(PERL_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
 		echo >&2 "    * new perl-specific parameters"; \
-		echo "$$FLAGS" >$@; \
+		echo "$$FLAGS" >$@+; \
+		mv $@+ $@; \
 	    fi
 
 GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
@@ -2455,7 +2457,8 @@ $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 %.s: %.c GIT-CFLAGS FORCE
-	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+	$(QUIET_CC)$(CC) -o $@+ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $< && \
+	mv $@+ $@
 
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
@@ -2478,9 +2481,8 @@ endif
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
 all:: compile_commands.json
 compile_commands.json:
-	@$(RM) $@
-	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json > $@+
-	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
+	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json >$@+ && \
+	mv $@+ $@
 endif
 
 exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
@@ -2673,11 +2675,13 @@ perl/build/lib/%.pm: perl/%.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
-	< $< > $@
+	< $< >$@+ && \
+	mv $@+ $@
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
-	pod2man $< $@
+	pod2man $< $@+ && \
+	mv $@+ $@
 
 FIND_SOURCE_FILES = ( \
 	git ls-files \
@@ -2805,7 +2809,8 @@ GIT-PYTHON-VARS: FORCE
 	@VARS='$(TRACK_PYTHON)'; \
 	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
 		echo >&2 "    * new Python interpreter location"; \
-		echo "$$VARS" >$@; \
+		echo "$$VARS" >$@+; \
+		mv $@+ $@; \
             fi
 endif
 
@@ -2817,8 +2822,9 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
-	chmod +x $@
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
 
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
@@ -2866,8 +2872,9 @@ HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 HCC = $(HCO:hco=hcc)
 
 %.hcc: %.h
-	@echo '#include "git-compat-util.h"' >$@
-	@echo '#include "$<"' >>$@
+	@echo '#include "git-compat-util.h"' >$@+ && \
+	@echo '#include "$<"' >>$@+ && \
+	mv $@+ $@
 
 $(HCO): %.hco: %.hcc FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
-- 
2.31.1.461.gd47399f6574


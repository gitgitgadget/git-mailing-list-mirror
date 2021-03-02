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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C88C433E9
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051E064ED9
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355387AbhCCGfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1840023AbhCBUwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 15:52:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B2C061756
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 12:51:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h10so26953561edl.6
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUCmw+8TTz/rP3fAWMHG5cJN7leU0O27qXW8cEHfW+M=;
        b=PzKCphL3AXcsllMOdIqRSqYG2S5aoI65KfV8Ua6XsDTFMCszYuCMoOYOnZajea9CpN
         TzQJ/KsYzBeXSjopj2OBfWWpK3Jo2KJePxV4Uc7fS3+Sk/nXFRDZJeqW+SVxd+V1Q+bZ
         sA4wl5va+aasYp3afCGO2GNrkKm5tGGptWPsd2V13VXEyxoxlvDmoEh5ezN6WT9l06/A
         uPBp0Dcfb9a3gXhlal/6rWgFgoJHeRu07uJD3qItqLTOerl9Y+VXXtjBknfXHnAdjF2c
         yZOzq90e+T3xUiq6HVFnN0Tmmu9XJVMcl+HVY8e3qnaw2n7EZtDWWSyMn8IthS+Yh7gT
         Yu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUCmw+8TTz/rP3fAWMHG5cJN7leU0O27qXW8cEHfW+M=;
        b=WmvwmDcoWCNs0B7Gpoc1AnEiKMD4uqdD+E1DAyOYbZBg8iZb8i6y3j5b4JM3a/7VEX
         wnyXrNleq4VC2VA/PmFLCdmK5ENRzeD3F1j3Wx2iVOvFkdGnFvHG8hbBG8Bu6pjcjFr/
         lWxwG6u5VYmQMV544ci9bQF9mm+hrVtiwuvWDIQR8E4gmn2745S8zP+1F90VoY/D41cD
         OuenLnzn2sjjrgmM70zh3uiubYe+39zw10G7MI/cqNP573uJGnXnM4jV3Rag/GJSMCbb
         fctCA2GdW0OA+yEYaAONoYMOrzMGINzmcRe3Jgx6mm2Z21HvN9aYyI7xYZmw4sYmTAw3
         onZQ==
X-Gm-Message-State: AOAM531o6S5N0/FqcgpZv8xkzi/txc5oXhdXqC9WlDn0DBpBEKRmtINc
        CjbSfgvUZjGumCrIaXQp1EGtoGtaTSyBYQ==
X-Google-Smtp-Source: ABdhPJyTOc6qzD8hp/L6+HYo+4/BAvTfwuejogd5fiwWJyCG9GY+Ru8nGSqYY2/Y0zWhaDh0Uh4ZUw==
X-Received: by 2002:a50:e80c:: with SMTP id e12mr22648728edn.229.1614718278759;
        Tue, 02 Mar 2021 12:51:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm19231513edt.35.2021.03.02.12.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 12:51:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: fix bugs in coccicheck and speed it up
Date:   Tue,  2 Mar 2021 21:51:03 +0100
Message-Id: <20210302205103.12230-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20190506234334.GA13296@sigill.intra.peff.net>
References: <20190506234334.GA13296@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've often wondered why "make coccicheck" takes so long. This change
speeds it up by ~2x and makes it use much less memory. Or a reduction
of a max of around ~2GB per-process (under the old
SPATCH_BATCH_SIZE=0) to around ~200MB.

Running the full "make coccicheck" now takes ~50 seconds with -j8 on
my machine, v.s. ~2x of that before. I've got 64GB of memory on that
machine, or it would be much slower.

Why has it been so slow? Because I think we've always been running it
in entirely the wrong mode for what we wanted, and much of the
previous fixing of this target has involved re-arranging the deck
chairs on that particular Titanic.

What we really want to do with coccicheck is to do search/replacements
in all our *.c and *.h files. This is now what we do, and we'll
process a default of 64 files at a time.

What we were doing before was processing all our *.c files, and for
each of those *.c files we'd recursively look around for includes and
see if we needed to search/replace in those too.

That we did that dates back to [1] when we were only processing *.c
files, and it was always very redundant. We'd e.g. visit the likes of
strbuf.h lots of times since it's widely used as an include.

Then in the most recent attempt to optimize coccicheck in [2] this
anti-pattern finally turned into a bug.

Namely: before this change, if your coccicheck rule applied to
e.g. making a change in strbuf.h itself we'd get *lots* of duplicate
hunks applying the exact same change, as concurrent spatch processes
invoked by xargs raced one another. In one instance I ended up with 27
copies of the same hunk in a strbuf.patch.

Setting SPATCH_BATCH_SIZE=0 and processing all the files in one giant
batch mitigated this. I suspect the author of [2] either mostly ran in
that mode, or didn't test on changes that impacted widely used header
files.

So since we're going to want to process all our *.c and *.h let's just
do that, and drop --all-includes for --no-includes. It's not spatch's
job to find our sources, we're doing that. If someone is manually
tweaking COCCI_SOURCES they can just tweak SPATCH_FLAGS too.

I'm entirely removing SPATCH_BATCH_SIZE. If you want to tweak it you
can tweak SPATCH_XARGS_FLAGS to e.g. "-n 256", or "-P 4 -n 128". But
in my testing it isn't worth it to tweak SPATCH_XARGS_FLAGS for a full
"make coccicheck".

I'm also the whole "cat $@.log" introduced in [3]. Since we don't call
this in a loop anymore (and xargs will early-exit) we can just rely on
standard V=1 for debugging issues.

1. a9a884aea5 (coccicheck: use --all-includes by default, 2016-09-30)
2. 960154b9c1 (coccicheck: optionally batch spatch invocations,
   2019-05-06)
3. f5c2bc2b96 (Makefile: detect errors in running spatch, 2017-03-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index dd08b4ced0..2108df8913 100644
--- a/Makefile
+++ b/Makefile
@@ -1195,11 +1195,20 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
-# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
-# usually result in less CPU usage at the cost of higher peak memory.
-# Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes --patch .
-SPATCH_BATCH_SIZE = 1
+SPATCH_FLAGS = --no-includes --patch .
+# For the 'coccicheck' target; Tweaking SPATCH_XARGS_FLAGS is
+# generally not neccesary with a top-level -jN.
+#
+# To get concurrency when targeting a single
+# contrib/coccinelle/%.patch use e.g. "-P" if your xargs(1) supports
+# it:
+#
+#    make contrib/coccinelle/strbuf.cocci.patch SPATCH_XARGS_FLAGS="-P 8 -n 64"
+#
+# Or a combination of the two:
+#
+#    make -j4 coccicheck SPATCH_XARGS_FLAGS="-P 2 -n 64"
+SPATCH_XARGS_FLAGS =
 
 include config.mak.uname
 -include config.mak.autogen
@@ -2852,24 +2861,18 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
-	if test $(SPATCH_BATCH_SIZE) = 0; then \
-		limit=; \
-	else \
-		limit='-n $(SPATCH_BATCH_SIZE)'; \
-	fi; \
-	if ! echo $(COCCI_SOURCES) | xargs $$limit \
-		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
-		>$@+ 2>$@.log; \
-	then \
-		cat $@.log; \
-		exit 1; \
-	fi; \
-	mv $@+ $@; \
+	$(RM) $@+ $@.log && \
+	echo $(COCCI_SOURCES) | \
+		xargs \
+			-n 32 $(SPATCH_XARGS_FLAGS) \
+			$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
+		>>$@+ 2>>$@.log && \
+	mv $@+ $@ && \
 	if test -s $@; \
 	then \
 		echo '    ' SPATCH result: $@; \
-- 
2.31.0.rc0.126.g04f22c5b82


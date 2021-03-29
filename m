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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D737C433E5
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764FB619A9
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhC2QUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhC2QU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:20:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EAAC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so13513936wrn.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVnRstTIQ36HjUyvgPST921UoSBisteenWnNzHh2+B0=;
        b=Pf5q6JWV+ucgEoF1VVRjvGXS/MmU4BggoxKSL5j0gHKFxOZswTsKsJiJCmZSDDCF2t
         nnU6aL71wEzAhlzNaHjNvIU5a57UBMsUiDskqGXFmgGo9NunRIDQltDiQkO6elTCK3Ra
         r6FSdCCFgI7WcHFdA1cVsj88IicioEDtTDOBce6Qn4Lz20FcFwjKkmVS2UAflP95SbSz
         GvqfZ5igljec0qDQN7XLGoDqBn1dmp2U2z9S5aJmOg/hQISbDRhd+iOXSo8bXojcIdLP
         hmlwi1aYVOwqLcEhb3St6GQoID90OfPLzZQcfClmKPHD0ug7YOSn2caJxdfVXshUH6Bm
         vEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVnRstTIQ36HjUyvgPST921UoSBisteenWnNzHh2+B0=;
        b=U+eamkX5OUMdSX8zdd3z3fbyYnjurdmuKdINQgs60dtXnHLkDGweemQfEXYfpR0dt9
         HKn+tBXsdGiaswihyrcMVRNWSCOouwLZgRw0OrpA6b8x6HjqcIiGPKsEmgTThPuMh4dX
         RE4f7bQ5mv/uHgBsKtyRQq4loqcYkU8ud/vm8/nLO4uWqLZG/+LkyZgQC05WApjBSpP1
         A2nPKAsNzdbyX4Sd12iGEVkch1kGgTmNE4P2jMAMxgSn4uZkYUn1n4fE0RahgLR9rsth
         ZyGHXgLK61djOzTWNDkH8q8qhtdfrJS/Aaxa+MdoIR/D4uiXj3PfQ8iZed5UxHjltwvE
         e1zA==
X-Gm-Message-State: AOAM530LumqrLgF3gkRA5QEBRCKA04tW0RbU1yQw5LO1lbCDdpwVxKTW
        EkshrLCJ2vVVMVpA8pi07VdbOww5Iw5SLg==
X-Google-Smtp-Source: ABdhPJyXJRhoUmHgLKcaYQE8ZvJ6c9XMqCcDigUvBmSbiK1SNrvNW7ati39ZsChwJFXwLCX6+gzKdQ==
X-Received: by 2002:adf:a1ce:: with SMTP id v14mr29678229wrv.228.1617034825819;
        Mon, 29 Mar 2021 09:20:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm31835353wrf.41.2021.03.29.09.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:20:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] Makefile: rename objects in-place, don't clobber
Date:   Mon, 29 Mar 2021 18:20:08 +0200
Message-Id: <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
References: <20210307132001.7485-1-avarab@gmail.com> <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the established "[...] -o $@+ && mv $@+ $@" pattern in the
Makefile for those rules that don't use it already.

This improves portability on OS such as AIX that complain if object
files in-use are clobbered (but not if they're rm'd, or renamed
away). On e.g. AIX 7.2 running a "./git log" in one terminal and
trying to clobber the "git" object in another will yield:

    $ >git
    bash: git: Cannot open or remove a file containing a running program.

And trying to recompile "git" will likewise fail:

    LINK git
    ld: 0711-851 SEVERE ERROR: Output file: git
        The file is in use and cannot be overwritten.

It's perfectly happy to have the file renamed or removed from under it
though:

    $ mv git git2
    $ >git2
    bash: git2: Cannot open or remove a file containing a running program.
    $ rm git2
    rm: Remove git2? y
    $ file git2
    file: 0653-900 cannot open git2.

On AIX the test suite is still a dumpster fire. I'm running into this
because an orphaned "git-daemon" is sometimes left running, causing
subsequent compilation to fail without manual intervention. It's also
annoying not to be able to run some ad-hoc command using the built git
without holding up subsequent compilation until any such programs are
stopped.

This pattern of not clobbering, but rather generating a "$@+" object
to rename in-place to "$@" has been present in the Makefile since
6a2e50f9dfd (git --version tells which version of git you have.,
2005-09-07), it just hasn't been consistently used for all the rules
that generated objects.

Per the log of changes to the Makfile and Junio's recent comment about
[1] why that pattern got introduced it was for a different reason
entirely, i.e. ("[]" edits are mine, for brevity):

    [T]hat age old convention [...] is spelled [as]:

    	thing:
    		rm -f thing thing+
    		prepare contents for thing >thing+
    		mv thing+ thing

    It protects us from a failure mode where "prepare contents for
    thing" step is broken and leaves a "thing" that does not work, but
    confuses make that make does not need to rebuild it, if you wrote it
    as such:

    	thing:
    		prepare contents for thing >thing

    [It might leave behind a corrupt 'thing'.] In any case, it is not
    "we are trying to make thing available while it is being
    rewritten" at all.

That makes perfect sense for shellscripts, but as this change shows
there's other good reasons to use this age old convention that weren't
considered at the time.

1. http://lore.kernel.org/git/xmqqpn097e9o.fsf@gitster.c.googlers.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 55c8035fa80..b0dbf5888b7 100644
--- a/Makefile
+++ b/Makefile
@@ -2166,8 +2166,9 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIBS) && \
+	mv $@+ $@
 
 help.sp help.s help.o: command-list.h
 
@@ -2526,18 +2527,22 @@ compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
 endif
 
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) && \
+	mv $@+ $@
 
 git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(IMAP_SEND_LDFLAGS) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(IMAP_SEND_LDFLAGS) $(LIBS) && \
+	mv $@+ $@
 
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(CURL_LIBCURL) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(CURL_LIBCURL) $(LIBS) && \
+	mv $@+ $@
 git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS) && \
+	mv $@+ $@
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
@@ -2546,14 +2551,17 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	cp $< $@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS) && \
+	mv $@+ $@
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+	$(QUIET_AR)$(AR) $(ARFLAGS) $@+ $^ && \
+	mv $@+ $@
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+	$(QUIET_AR)$(AR) $(ARFLAGS) $@+ $^&& \
+	mv $@+ $@
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
@@ -2834,7 +2842,8 @@ perf: all
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS) && \
+	mv $@+ $@
 
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
@@ -3333,6 +3342,7 @@ FUZZ_CXXFLAGS ?= $(CFLAGS)
 
 $(FUZZ_PROGRAMS): all
 	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
-		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
+		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@+ && \
+	mv $@+ $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
-- 
2.31.1.461.gd47399f6574


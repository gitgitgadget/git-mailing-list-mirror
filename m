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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50848C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB1B610A0
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhHDWzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhHDWy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:54:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C3C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:54:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so1677147wms.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqwR3YadnjLmLy7n0n4ZP4IoEw5DkozcQdT1YwCHJBM=;
        b=MxeBPy57M5Yr+Gttv3y0VHlqs1voJl0+sELO0yJqoGWnc8Vl2hBIHjKimTYd8h29lW
         pzz9lfMk7dO9i5hAdAtrzhatDFPsGC0mivWn3boVmkwrra5Qmy3AeEHRugcsT36D+1BW
         bF7P6Li54Q06jitHNiiikSNHmza+dlXZJoEhnzLiSEVnDqL0mUeptzCIGmXNtC6kMwBB
         COH4jVJENoEIuRMYb3ep7zaNaYHcra8Z1nljzK1zgjndCs4BN348fjogJibGLZmynPcG
         IK7Q3CQDmVPFJ51t8frRSJtlQRiZCNVZLqu67p/Q4l4RQy2m3+virZIeY//lammVJ8ht
         dbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqwR3YadnjLmLy7n0n4ZP4IoEw5DkozcQdT1YwCHJBM=;
        b=fe1WXsLvpE2Aubo3pa+4hrVZ+1RCUqduNhKl+2hiRSMOBAHq4YaiPXkjLB75GbJs20
         rketfDdmBI1rOHmyP1csCJ8oRkiYVeP3fMVx1AwrKIMb6v/doaoTLYI10VuSM7WAeCKq
         FE+Hfz9rSqY5+5GQmroitx0RzPkbhGPQ1++xfI1PjyR/pRgTYbc6u4iN4BwTSeomU4QF
         GclhP8BW1RURKbJfJHJbUqIkv8ycjS0n8tWl+p3HYP/3jq0JE1BCJzZDV7wOv0hN1HFX
         TJWQio/sEENJkPq6NDzqm9b6V0rMGYkJvOlKVwRvcIdmdi6jWxQ4X2A0sxgNCiM05fyY
         qlGw==
X-Gm-Message-State: AOAM532ZMtVFj9bVit7E2CGrMbNLZ7tuiojIQLRdsGwrgikqAoWvzllC
        umkYID5RM+UDM3UjtRnmstULGCPvuVA=
X-Google-Smtp-Source: ABdhPJx9TsUnYXugERs25wSER+Tg6TY8x8x6rnGrYR8MNJwgv5Tz/agF72DXIMEkGjbmInLbeASyRw==
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr1620103wmf.141.1628117683220;
        Wed, 04 Aug 2021 15:54:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u11sm3968190wrt.89.2021.08.04.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:54:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/5] Makefile: "make tags" fixes & cleanup
Date:   Thu,  5 Aug 2021 00:54:35 +0200
Message-Id: <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The big win here is that none of the tags targets depend on "FORCE"
anymore, so we'll only re-generate them if our sources change.

For v3, see:
https://lore.kernel.org/git/cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com/

This addresses the feedback about the cscope* v.s. cscope.out rule in
.gitignore and "make clean", i.e. those rules are not being changed
anymore. I also changed a stray cscope.out to $@ in 4/5, which was
missed in v3.

Ævar Arnfjörð Bjarmason (5):
  Makefile: move ".PHONY: cscope" near its target
  Makefile: add QUIET_GEN to "cscope" target
  Makefile: don't use "FORCE" for tags targets
  Makefile: remove "cscope.out", not "cscope*" in cscope.out target
  Makefile: normalize clobbering & xargs for tags targets

 Makefile | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

Range-diff against v3:
1:  6b4ddc126d9 = 1:  2ee725e2fba Makefile: move ".PHONY: cscope" near its target
2:  d3d5d332e92 = 2:  2122cb25633 Makefile: add QUIET_GEN to "cscope" target
3:  9dd69d68178 = 3:  8649716772b Makefile: don't use "FORCE" for tags targets
4:  f8d151f1f6a ! 4:  643c514e12a Makefile: the "cscope" target always creates a "cscope.out"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: the "cscope" target always creates a "cscope.out"
    +    Makefile: remove "cscope.out", not "cscope*" in cscope.out target
     
    -    In the preceding commit the "cscope" target was changed to be a phony
    -    alias for the "cscope.out" target.
    +    Before we generate a "cscope.out" file, remove that file explicitly,
    +    and not everything matching "cscope*". This doesn't change any
    +    behavior of the Makefile in practice, but makes this rule less
    +    confusing, and consistent with other similar rules.
     
         The cscope target was added in a2a9150bf06 (makefile: Add a cscope
    -    target, 2007-10-06), and has always referred to cscope* instead of to
    -    cscope.out.
    +    target, 2007-10-06). It has always referred to cscope* instead of to
    +    cscope.out in .gitignore and the "clean" target, even though we only
    +    ever generated a cscope.out file.
     
    -    As far as I can tell this ambiguity was never needed. The
    -    "-fcscope.out" (note, no whitespace) argument is enabled by default,
    -    but let's provide it explicitly for good measure.
    +    This was seemingly done to aid use-cases where someone invoked cscope
    +    with the "-q" flag, which would make it create a "cscope.in.out" and
    +    "cscope.po.out" files in addition to "cscope.out".
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    But us removing those files we never generated is confusing, so let's
    +    only remove the file we need to, furthermore let's use the "-f" flag
    +    to explicitly name the cscope.out file, even though it's the default
    +    if not "-f" argument is supplied.
    +
    +    It is somewhat inconsistent to change from the glob here but not in
    +    the "clean" rule and .gitignore, an earlier version of this change
    +    updated those as well, but see [1][2] for why they were kept.
     
    - ## .gitignore ##
    -@@
    - /.vscode/
    - /tags
    - /TAGS
    --/cscope*
    -+/cscope.out
    - /compile_commands.json
    - *.hcc
    - *.obj
    +    1. https://lore.kernel.org/git/87k0lit57x.fsf@evledraar.gmail.com/
    +    2. https://lore.kernel.org/git/87im0kn983.fsf@evledraar.gmail.com/
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
     @@ Makefile: tags: $(FOUND_SOURCE_FILES)
    @@ Makefile: tags: $(FOUND_SOURCE_FILES)
      cscope.out: $(FOUND_SOURCE_FILES)
     -	$(QUIET_GEN)$(RM) cscope* && \
     -	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
    -+	$(QUIET_GEN)$(RM) cscope.out && \
    ++	$(QUIET_GEN)$(RM) $@ && \
     +	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
      
      .PHONY: cscope
      cscope: cscope.out
    -@@ Makefile: clean: profile-clean coverage-clean cocciclean
    - 	$(RM) $(HCC)
    - 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
    - 	$(RM) -r po/build/
    --	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
    -+	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope.out
    - 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
    - 	$(RM) $(GIT_TARNAME).tar.gz
    - 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
5:  f3ff76d0e98 ! 5:  1eaf3416329 Makefile: normalize clobbering & xargs for tags targets
    @@ Makefile: FIND_SOURCE_FILES = ( \
     +	mv $@+ $@
      
      cscope.out: $(FOUND_SOURCE_FILES)
    --	$(QUIET_GEN)$(RM) cscope.out && \
    +-	$(QUIET_GEN)$(RM) $@ && \
     -	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
     +	$(QUIET_GEN)$(RM) $@+ && \
     +	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@+ -b && \
-- 
2.33.0.rc0.597.gc569a812f0a


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC5C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8EB6108B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhGUWmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhGUWmh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:42:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B492C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n4so2258189wms.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvULxN+QwPHN5Zpxrknw2Fb5HLcKhaTnYKNazj5qzoU=;
        b=Vb+Uv9k2FvjjHLdRAJUkgMD/ZJKe29BrPqlQOFXrktDdZRMiAXtCeLCspAiVdkEtO/
         1Gmu8tbY1m2FKhgmG8o5U0j9GbWc+DA9S0ndnCsDV5s7ZTuzJC1d38AhbWl36rQK5dCh
         QJFS0unSD6IFRMhTVgnveGssrKSF/kzX3rhQPcEdwz8pdVL8AXg2f+/GzwqPPj9Ercub
         3mx52Zy2yMG5iuot4iy+/C+k69mC39Lpu5VJBqRxQDFvNY8pyVKJyN0MXWkUpIkZuPhg
         P9anYJFMqFD7kJEXU3A9sD/uuvzwki5bCVVshy9AI2/Ls15Q6aEWHY22PaosrRGsnZ1p
         yttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvULxN+QwPHN5Zpxrknw2Fb5HLcKhaTnYKNazj5qzoU=;
        b=bx83BWpUUH/HkxUl1P85a0rf4H3EU+uP2hkBoirl9xWRev5gIvk4qq4uDtlQKIMQk2
         0+BZHfz4DeKfWYHQkiV6GO9+Ahkxk+Q7DMUolCjxn3W7cTa8SiZSnI0AS7K8W4S6L0aG
         rZKACIg4R9rqVEHhlOOUGRSGWAfZxcGExddPEZPfNTvJHCMAK4J0xu9IX7nmSSfoAde/
         xfwAydzXWlOCfCzRJuXyvuy3QMHzFR2//6CZ/lTrM05tzlX4yP0yrkP5VM92WesWkfFN
         QmVPZdHhM1hZarLnYGWGWduUkTw3EwlNOPzqnhVx3+AHhzqiWqc+zYclZcSCmbMABVbk
         dI1g==
X-Gm-Message-State: AOAM531v77LtE8J8rBclRB8l3dIa5bn8hZD0Uq3EHFgqcnoexLQgfJ57
        klFo8EavdACyV4g48pyD06Ndk11BKK/QUQ==
X-Google-Smtp-Source: ABdhPJzZ9lyJ7R4lRYKzHuy4s8lGoinVP4Og264v883lt3uYg4Mvw7IXXtlDqtA1BdW0bJP91dkFdQ==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr41177905wme.48.1626909790934;
        Wed, 21 Jul 2021 16:23:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v11sm27690260wrs.4.2021.07.21.16.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:23:10 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Makefile: "make tags" fixes & cleanup
Date:   Thu, 22 Jul 2021 01:23:01 +0200
Message-Id: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The big win here is that none of the tags targets depend on "FORCE"
anymore, so we'll only re-generate them if our sources change.

For v2, see
https://lore.kernel.org/git/cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com/

This fixes the series per feedback from Jeff King and Ramsay Jones,
i.e:

 * In v2 the 3/5 broke things in a way that 4/5 fixed, that's now
   re-arranged and fixed.

 * I now use $(FOUND_SOURCE_FILES) instead of $(FIND_SOURCE_FILES)
   consistently. I was redundantly re-running the "find" command.


Ævar Arnfjörð Bjarmason (5):
  Makefile: move ".PHONY: cscope" near its target
  Makefile: add QUIET_GEN to "cscope" target
  Makefile: don't use "FORCE" for tags targets
  Makefile: the "cscope" target always creates a "cscope.out"
  Makefile: normalize clobbering & xargs for tags targets

 .gitignore |  2 +-
 Makefile   | 34 ++++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 15 deletions(-)

Range-diff against v2:
1:  dd6cfd6022c = 1:  6b4ddc126d9 Makefile: move ".PHONY: cscope" near its target
2:  56daa09738f = 2:  d3d5d332e92 Makefile: add QUIET_GEN to "cscope" target
4:  b924cc3f566 ! 3:  9dd69d68178 Makefile: don't use "FORCE" for tags targets
    @@ Metadata
      ## Commit message ##
         Makefile: don't use "FORCE" for tags targets
     
    -    Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope.out"
    +    Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope"
         targets, instead make them depend on whether or not the relevant
         source files have changed.
     
    +    For the cscope target we need to change it to depend on the actual
    +    generated file while we generate while we're at it, as the next commit
    +    will discuss we always generate a cscope.out file.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    @@ Makefile: FIND_SOURCE_FILES = ( \
     +
     +$(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
      	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
    - 	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
    +-	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
    ++	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
      	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
      
     -tags: FORCE
     +tags: $(FOUND_SOURCE_FILES)
      	$(QUIET_GEN)$(RM) tags+ && \
    - 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
    +-	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
    ++	echo $(FOUND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
      	mv tags+ tags
      
    --cscope.out:
    +-.PHONY: cscope
    +-cscope:
     +cscope.out: $(FOUND_SOURCE_FILES)
    - 	$(QUIET_GEN)$(RM) cscope.out && \
    --	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
    -+	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
    + 	$(QUIET_GEN)$(RM) cscope* && \
    +-	$(FIND_SOURCE_FILES) | xargs cscope -b
    ++	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
    ++
    ++.PHONY: cscope
    ++cscope: cscope.out
      
    - .PHONY: cscope
    - cscope: cscope.out
    + ### Detect prefix changes
    + TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
     @@ Makefile: check: config-list.h command-list.h
      		exit 1; \
      	fi
3:  35c8b839048 ! 4:  f8d151f1f6a Makefile: fix "cscope" target to refer to cscope.out
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: fix "cscope" target to refer to cscope.out
    +    Makefile: the "cscope" target always creates a "cscope.out"
     
    -    The cscope target added in a2a9150bf06 (makefile: Add a cscope target,
    -    2007-10-06) has for some reason been referring to cscope* instead of
    +    In the preceding commit the "cscope" target was changed to be a phony
    +    alias for the "cscope.out" target.
    +
    +    The cscope target was added in a2a9150bf06 (makefile: Add a cscope
    +    target, 2007-10-06), and has always referred to cscope* instead of to
         cscope.out.
     
    -    Let's generate the cscope.out file directly so we don't need to
    -    speculate. The "-fcscope.out" (note, no whitespace) argument is
    -    enabled by default on my system's cscope 15.9, but let's provide it
    -    explicitly for good measure.
    +    As far as I can tell this ambiguity was never needed. The
    +    "-fcscope.out" (note, no whitespace) argument is enabled by default,
    +    but let's provide it explicitly for good measure.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ .gitignore
      *.obj
     
      ## Makefile ##
    -@@ Makefile: tags: FORCE
    - 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
    +@@ Makefile: tags: $(FOUND_SOURCE_FILES)
      	mv tags+ tags
      
    -+cscope.out:
    -+	$(QUIET_GEN)$(RM) cscope.out && \
    -+	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
    -+
    - .PHONY: cscope
    --cscope:
    + cscope.out: $(FOUND_SOURCE_FILES)
     -	$(QUIET_GEN)$(RM) cscope* && \
    --	$(FIND_SOURCE_FILES) | xargs cscope -b
    -+cscope: cscope.out
    +-	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
    ++	$(QUIET_GEN)$(RM) cscope.out && \
    ++	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
      
    - ### Detect prefix changes
    - TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
    + .PHONY: cscope
    + cscope: cscope.out
     @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(HCC)
      	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
5:  5195d99e25c ! 5:  f3ff76d0e98 Makefile: normalize clobbering & xargs for tags targets
    @@ Metadata
      ## Commit message ##
         Makefile: normalize clobbering & xargs for tags targets
     
    -    Since the "tags", "TAGS" and "cscope.out" targets rely on ping into
    +    Since the "tags", "TAGS" and "cscope.out" targets rely on piping into
         xargs with an "echo <list> | xargs" pattern, we need to make sure
         we're in an append mode.
     
    -    Unlike recent changes of mine to make use of ".DELETE_ON_ERROR" we
    -    really do need the "rm $@+" at the beginning (note, not "rm $@").
    +    Unlike my recent change to make use of ".DELETE_ON_ERROR" in
    +    7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
    +    2021-06-29), we really do need the "rm $@+" at the beginning (note,
    +    not "rm $@").
     
    -    This is because the xargs command may decide on multiple invocations
    -    of the program. We need to make sure we've got a union of its results
    +    This is because the xargs command may decide to invoke the program
    +    multiple times. We need to make sure we've got a union of its results
         at the end.
     
         For "ctags" and "etags" we used the "-a" flag for this, for cscope
    @@ Makefile: FIND_SOURCE_FILES = ( \
      
      $(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
     -	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
    --	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
    +-	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
     -	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
     +	$(QUIET_GEN)$(RM) $@+ && \
     +	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o $@+ && \
    @@ Makefile: FIND_SOURCE_FILES = ( \
      
      tags: $(FOUND_SOURCE_FILES)
     -	$(QUIET_GEN)$(RM) tags+ && \
    --	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
    +-	echo $(FOUND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
     -	mv tags+ tags
     +	$(QUIET_GEN)$(RM) $@+ && \
     +	echo $(FOUND_SOURCE_FILES) | xargs ctags -a -o $@+ && \
-- 
2.32.0.955.ge7c5360f7e7


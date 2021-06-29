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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D2AC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1CF61DD2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhF2LPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhF2LPt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:15:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13A1C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i94so25366635wri.4
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ahe5cxkfzlgy4yHocCIMHiffT91An0/N5h5Q6/PXKo=;
        b=LYv1hsMU++U5oka+J+lBkczC53w29YrvrVcKvjvrYBEJ88941LFdaGMf8XEoETabZ7
         acG/9y5Db/s0gKfZYQsFI+BWuZfLGQftS/ny9FG/A2/J4qW3dD6Vse2Ihuj+1atlDS8j
         WX1R5VNAVOj3rjCjxr4KwdBsnvwukFcM/K1NELNxjPItU42eQv8f4+Z6wQ/HijrjvJa9
         QT8xuXxiwqVAy2pCUrsoRHa0H3cL6o9XHxeaF+QGmHbtZlgTC0nW/NpCDPNWEx/QgLV+
         9pWPNtrI8MudEmFN5/+9em6b4QkibkJfBZ+PxOy1IulCZ+to0MH7A77CttxFBJKczRgv
         5ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ahe5cxkfzlgy4yHocCIMHiffT91An0/N5h5Q6/PXKo=;
        b=WARI0OqNGecaDtfxVb6om74KKVp0gfgub5sd3I6eUtR1AY7DcXgjbl19nJ3feyoVwt
         rl9A+R4RvRa3fY9ijhfqltukmyrxqSVRPZZc8rwKGe+fw2WaL0ySNHSfiGC/bvAGbgp7
         kNdcmyjR1TzjPI0gwFFozX5vZdWs5iOn6jOBI2nFrJQIjLeUD11UfPgudTHDcGF0WGmF
         XOsWITnZPj+A+feR8VipB9hB3tUWI0e1v8IMSfrfvb5aerKPahRbWRc2luMqLsGiTVlr
         uFS4WY6PzefmTqBNEpDmklIbirtUDk35zIuU9eIT+efUZhNCJU+haK05DAY+KOJMcevE
         i8ig==
X-Gm-Message-State: AOAM530Ag0dj9/LkvyNk7MXo1y3rmmqPX9J/fmjgJY9GW20msxRpa2JZ
        et/Y/0N/Dq8BkE/lZyBSEkHGsmA2GKyjsw==
X-Google-Smtp-Source: ABdhPJzyqSPkUpeeNMOTtW3/qbA95h/jkoWg03b7EywYw6f+9GQ3NZ14VY+idVyuZhYEorUvJ6Fmtg==
X-Received: by 2002:a5d:48ca:: with SMTP id p10mr32815149wrs.87.1624965199314;
        Tue, 29 Jun 2021 04:13:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1sm2499370wmn.10.2021.06.29.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:13:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] Makefile: "make tags" fixes & cleanup
Date:   Tue, 29 Jun 2021 13:12:54 +0200
Message-Id: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g20d5ce26552
In-Reply-To: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2 of my fixes to the tags targets. This no longer depends on my
.DELETE_ON_ERROR change, and goes directly on top of "master". See [2]
for the just-submitted v2 of that other series.

The big win here is that none of the tags targets depend on "FORCE"
anymore, so we'll only re-generate them if our sources change.

I missed the interaction of the "-a" flag and xargs splitting the
arguments into am implicit -n, so in v1 of this we could end up with
incomplete tag files. In this v2 we more incrementally reach similar
ends, but in the end result retain our rm/gen/mv dance, since it's
needed in this case.

1. http://lore.kernel.org/git/cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com
2. https://lore.kernel.org/git/patch-1.1-2557117855-20210629T084356Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  Makefile: move ".PHONY: cscope" near its target
  Makefile: add QUIET_GEN to "cscope" target
  Makefile: fix "cscope" target to refer to cscope.out
  Makefile: don't use "FORCE" for tags targets
  Makefile: normalize clobbering & xargs for tags targets

 .gitignore |  2 +-
 Makefile   | 34 ++++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 15 deletions(-)

Range-diff against v1:
1:  383a90c8ac = 1:  dd6cfd6022 Makefile: move ".PHONY: cscope" near its target
-:  ---------- > 2:  56daa09738 Makefile: add QUIET_GEN to "cscope" target
2:  ea39f1f5cd ! 3:  35c8b83904 Makefile: fix "cscope" target to refer to cscope.out
    @@ Commit message
     
         The cscope target added in a2a9150bf06 (makefile: Add a cscope target,
         2007-10-06) has for some reason been referring to cscope* instead of
    -    cscope.out. Let's generate the cscope.out file directly so we don't
    -    need to speculate.
    +    cscope.out.
     
    -    The "-fcscope.out" (note, no whitespace) argument is enabled by
    -    default on my system's cscope 15.9, but let's provide it explicitly
    -    for good measure.
    +    Let's generate the cscope.out file directly so we don't need to
    +    speculate. The "-fcscope.out" (note, no whitespace) argument is
    +    enabled by default on my system's cscope 15.9, but let's provide it
    +    explicitly for good measure.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: tags: FORCE
      	mv tags+ tags
      
     +cscope.out:
    ++	$(QUIET_GEN)$(RM) cscope.out && \
     +	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
     +
      .PHONY: cscope
     -cscope:
    --	$(RM) cscope*
    +-	$(QUIET_GEN)$(RM) cscope* && \
     -	$(FIND_SOURCE_FILES) | xargs cscope -b
     +cscope: cscope.out
      
3:  67fc87665d ! 4:  b924cc3f56 Makefile: don't use "FORCE" for tags targets
    @@ Commit message
         targets, instead make them depend on whether or not the relevant
         source files have changed.
     
    -    I'm also removing the "-o" option from them, that seems to have been
    -    cargo-culted when they were initially added in f81e7c626f3 (Makefile:
    -    Add TAGS and tags targets, 2006-03-18). It would make sense to use
    -    that option if we had been appending to tag files, it doesn't make any
    -    sense that it was used after we'd just removed the files file being
    -    appended to.
    -
    -    This will potentially cause a partial file to be left behind if the
    -    command dies, but my in-flight series to use the ".DELETE_ON_ERROR"
    -    flag in the Makefile[1] will make that problem go away. I think even
    -    without that it's not problem we need to worry about in these cases.
    -
    -    1. https://lore.kernel.org/git/patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com/
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    @@ Makefile: FIND_SOURCE_FILES = ( \
      	)
      
     -$(ETAGS_TARGET): FORCE
    --	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
    --	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
    --	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
     +FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
    ++
    ++$(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
    + 	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
    + 	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
    + 	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
      
     -tags: FORCE
    --	$(QUIET_GEN)$(RM) tags+ && \
    --	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
    --	mv tags+ tags
    -+$(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
    -+	$(QUIET_GEN)echo $(FOUND_SOURCE_FILES) | \
    -+	xargs etags -o $@
    -+
     +tags: $(FOUND_SOURCE_FILES)
    -+	$(QUIET_GEN)echo $(FOUND_SOURCE_FILES) | \
    -+	xargs ctags -o $@
    + 	$(QUIET_GEN)$(RM) tags+ && \
    + 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
    + 	mv tags+ tags
      
    - cscope.out:
    +-cscope.out:
    ++cscope.out: $(FOUND_SOURCE_FILES)
    + 	$(QUIET_GEN)$(RM) cscope.out && \
     -	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
    -+	$(QUIET_GEN)echo $(FOUND_SOURCE_FILES) | \
    -+	xargs cscope -f$@ -b
    ++	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
      
      .PHONY: cscope
      cscope: cscope.out
-:  ---------- > 5:  5195d99e25 Makefile: normalize clobbering & xargs for tags targets
-- 
2.32.0.613.g20d5ce26552


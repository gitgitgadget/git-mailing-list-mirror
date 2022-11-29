Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E2AC46467
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 14:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiK2OJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiK2OJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 09:09:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D52A40D
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so33997170ejb.13
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg/WXmMe4GVcp6/l0bMhvcNVXgOxZx5OfKAeakn1EdI=;
        b=Gb/tXkvjT2dArq8ga0uam6xyrwJ6My0mrYntTQ3Xxe5YM4Yoff3vpGqgmHd5XQET6a
         +OU2Jfj/ZUmHvSpuzOrbeEE1v0z8Tn+QNnLwdv0553NSTnQkO/gutLoklxwfkYyL5OEO
         tEXFsRyZ75Iu5/mn9vr1/oXDV6Ey2j7naeh+ThooO2dfMYFax+t9LCFOltE2uaKpvn/5
         7rKv8t2QeLN+YyUVpKCrQgePua+QIMTkBU21jlp5QBTJaETGgijmpgB+0OTS9ClrNmtW
         WqpLnUGXEqdkUTHVDz9MPIZSlJkxn4rE4juTJqJ48V6VTj/ez5s0V7BkgGXGYMZ/Jce1
         I6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg/WXmMe4GVcp6/l0bMhvcNVXgOxZx5OfKAeakn1EdI=;
        b=SF25szogP2NSRuBj6NQg/hyPurElqz/6SZ1TNthHge8cfvxWg2he9OvEqsK4Ohpswr
         G+SxXW7jOXDpqwKqZLd3Og43esPZrRN/B//vM+w/EcF9k+CIigOVzF78zjiz96IyKimy
         TAgOLDB+VZwZo1uchR6Av27hThWle1SSRKQTc8o/TbnZzF5DkRTW5Jy0nCwOO+bMGbnj
         hLMhrQGCHBuQDDrXbxhRZImEVfV/plxxki2m3QICNoCYp4LvX4yuiZ2JRXLrz72l0Xeu
         rtrTtVjnz9e2Z/lrcg8mhETsizch4gAUsdu231dDobdCVAD1VyimQ5jijvEDmVxhhx1J
         Aclg==
X-Gm-Message-State: ANoB5pmnnW1IkBe0JnK0KWIDglnhejJOtQh0wrcacQWbBFG9c6CuBU5T
        mR7UrRV08AfxY1+rN0ePubZaqh+ZWQcnHg==
X-Google-Smtp-Source: AA0mqf5A22iMaMtkHfzI1QFR4SEY5G6I9ch0c7n3phOCJQIadW8K1K1B5KNO8IMFpdbUNZBvZAB1OA==
X-Received: by 2002:a17:906:6aca:b0:7ad:dfb5:a3f2 with SMTP id q10-20020a1709066aca00b007addfb5a3f2mr34309870ejs.351.1669730959490;
        Tue, 29 Nov 2022 06:09:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id be14-20020a0564021a2e00b00463597d2c25sm6307907edb.74.2022.11.29.06.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:09:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Smith <psmith@gnu.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] Makefiles: GNU make 4.4 fixes
Date:   Tue, 29 Nov 2022 15:09:13 +0100
Message-Id: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.993.g0c499e58e3b
In-Reply-To: <20221127224251.2508200-1-psmith@gnu.org>
References: <20221127224251.2508200-1-psmith@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GNU Make 4.4 was released just about a month ago[1], this series picks
up & amends a change from Paul Smith (the GNU make maintainer), and
then fixes another bug in our Makefiles as a result of a
backwards-incompatible change in how $(MAKEFLAGS) works in 4.4.

Junio: I think this is worth considering for merging down in the rc
peried. We can limp along without these fixes, but not being able to
build the docs to completion (as far as make is concerned) and the new
warnings fixed by 2/4 will probably break things for or annoy some
packagers.

The 3/4 then fixes the output being always-verbose for our
sub-Makefiles for the affected targets. 4/4 is pure-refactoring, but I
think should help build confidence in the preceding changes.

1. https://lwn.net/Articles/913253/

Paul Smith (1):
  Documentation/Makefile: avoid multiple patterns when generating one
    file

Ævar Arnfjörð Bjarmason (3):
  Documentation/Makefile: de-duplicate *.[157] dependency list
  Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4
  Documentation/Makefile: narrow wildcard rules to our known files

 Documentation/Makefile | 15 ++++++++++++---
 git-gui/Makefile       |  2 +-
 shared.mak             |  4 ++--
 3 files changed, 15 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  115d79fe1fc ! 1:  42b4f241c97 Avoid multiple patterns when recipes generate one file
    @@
      ## Metadata ##
    -Author: Paul Smith <psmith@gnu.org>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Avoid multiple patterns when recipes generate one file
    +    Documentation/Makefile: de-duplicate *.[157] dependency list
     
    -    A GNU make pattern rule with multiple targets has always meant that
    -    a single invocation of the recipe will build all the targets.
    -    However in older versions of GNU make a recipe that did not really
    -    build all the targets would be tolerated.
    +    Use the "DOC_MAN[157]" variables combined into a new "DOC_MANN" to
    +    declare that e.g. "git-am.1" depends on "manpage-base-url.xsl"
    +    etc. This change helps to make a subsequent change smaller.
     
    -    Starting with GNU make 4.4 this behavior is deprecated and pattern
    -    rules are expected to generate files to match all the patterns.
    -    If not all targets are created then GNU make will not consider any
    -    target up to date and will re-run the recipe when it is run again.
    -
    -    Modify Documentation/Makefile to split the man page-creating pattern
    -    rule into a separate pattern rule for each pattern.
    -
    -    Reported-by: Alexander Kanavin <alex.kanavin@gmail.com>
    -    Signed-off-by: Paul Smith <psmith@gnu.org>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
    +@@ Documentation/Makefile: ARTICLES_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
    + HTML_FILTER ?= $(ARTICLES_HTML) $(OBSOLETE_HTML)
    + DOC_HTML = $(MAN_HTML) $(filter $(HTML_FILTER),$(ARTICLES_HTML) $(OBSOLETE_HTML))
    + 
    ++DOC_MANN =
    + DOC_MAN1 = $(patsubst %.txt,%.1,$(filter $(MAN_FILTER),$(MAN1_TXT)))
    ++DOC_MANN += $(DOC_MAN1)
    + DOC_MAN5 = $(patsubst %.txt,%.5,$(filter $(MAN_FILTER),$(MAN5_TXT)))
    ++DOC_MANN += $(DOC_MAN5)
    + DOC_MAN7 = $(patsubst %.txt,%.7,$(filter $(MAN_FILTER),$(MAN7_TXT)))
    ++DOC_MANN += $(DOC_MAN7)
    + 
    + prefix ?= $(HOME)
    + bindir ?= $(prefix)/bin
     @@ Documentation/Makefile: $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
      manpage-base-url.xsl: manpage-base-url.xsl.in
      	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
      
     -%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
    --	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
    -+
    -+manpage-prereqs := manpage-base-url.xsl $(wildcard manpage*.xsl)
    -+manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
    -+
    -+%.1 : %.xml $(manpage-prereqs)
    -+	$(manpage-cmd)
    -+%.5 : %.xml $(manpage-prereqs)
    -+	$(manpage-cmd)
    -+%.7 : %.xml $(manpage-prereqs)
    -+	$(manpage-cmd)
    ++$(DOC_MANN): manpage-base-url.xsl $(wildcard manpage*.xsl)
    ++%.1 %.5 %.7 : %.xml
    + 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
      
      %.xml : %.txt $(ASCIIDOC_DEPS)
    - 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
-:  ----------- > 2:  e232f308e40 Documentation/Makefile: avoid multiple patterns when generating one file
-:  ----------- > 3:  6db7dd74e52 Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4
-:  ----------- > 4:  f1bc3c16904 Documentation/Makefile: narrow wildcard rules to our known files
-- 
2.39.0.rc0.993.g0c499e58e3b


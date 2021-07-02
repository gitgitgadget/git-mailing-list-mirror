Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F45C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306DB6141D
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhGBMBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGBMBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 08:01:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943F1C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 04:58:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m9-20020a05600c3b09b02901f246b43bbeso6208686wms.3
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkOINdz4ayE/MhcaBd/umdF89rOui0Iw9vUkYtZCQto=;
        b=Z4wvP7iDrKYA4vyP1OkWOy0K/sUigAXSc9f3kqDckJq17GwLLI1VmThoh9A24c1yfs
         BIy0LFvRbQjhmaZSDP7dDv2uU3RvtoNLTnKuou9qVLoxSIjz9TNh+UmLy3kWSRuSdDyr
         2i0Kxaz6zitertImB30w8NnEJ/4vYm45FXhdK688ML8/NJ//LVo2yS4v/IRTCpfxHzYP
         Id6/FvRVNvOo3AufwB1dYXq9LsNqFDOEZrEm6M7tmqU+vumxuJVIj6wA3nKAB4uD8+gc
         8FXgpwHbfG+b5H1ky+UOemxCEY/CcQrQ26lpA3ioCOGl9UHUhlfh0CrZ7OHn2bNdz1wx
         O80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkOINdz4ayE/MhcaBd/umdF89rOui0Iw9vUkYtZCQto=;
        b=tmjdC9xyge97hL4iQkgU2u9czonkqx6EqH5x6rqi+el/5zW2LZ/ruJFmkm+qj3oH7R
         +xQnfu+uXObxb9dTq/s2HnLvGHvCGj3jV+JafKaEK1Vp0rp6WNY3H0B970SsCLaxnkCg
         pB5f6kIS9VAKDU7Pde87zx0Zuw8H9efxBj76tJkldTDPFlosMt+cDKVdN4mAZPKm/91N
         KbSf85ffvMer9b8GQGblC42tmQfJ2KyzVLvUrdfv0dLR1Y9OPfGNcuRFXFmGNZaAqVX4
         DmysfsXqVANtV4MVa5wUzqKMIE1rbY1t4kbpM6gh35KpC1JuEsNwP6TnXvAbezZNFchY
         yuQA==
X-Gm-Message-State: AOAM530G3vuBvq4hYmgOEvypegpmo+cJUAcXGLT/eF56pTdoweskEDSD
        RSmK+1Y88brRX+lH2vHgh6DaDT1VAMUudw==
X-Google-Smtp-Source: ABdhPJwrtLMq91SZ7fGOM+EjSDi0qZBXZxErIicL7OBDjpkJEKljmLGqHVgTA2prQfrbmy5uQdKARA==
X-Received: by 2002:a7b:cc08:: with SMTP id f8mr5066259wmh.58.1625227137711;
        Fri, 02 Jul 2021 04:58:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm3842641wrn.62.2021.07.02.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:58:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Documentation/Makefile: don't re-build on 'git version' changes
Date:   Fri,  2 Jul 2021 13:58:47 +0200
Message-Id: <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.634.g284ac724283
In-Reply-To: <874kdn1j6i.fsf@evledraar.gmail.com>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 9a71722b4df (Doc: auto-detect changed build flags, 2019-03-17)
we've been eagerly re-building the documentation whenever the output
of "git version" (via the GIT-VERSION file) changed. This was never
the intention, and was a regression on what we intended in
7b8a74f39cb (Documentation: Replace @@GIT_VERSION@@ in documentation,
2007-03-25).

So let's add an ASCIIDOC_MANVERSION variable that we exclude from
ASCIIDOC_COMMON. The change in 9a71722b4df was only intending to catch
cases where we e.g. switched between asciidoc and asciidoctor, not to
undo the logic in 7b8a74f39cb and force a re-build every time our HEAD
changed in the repository.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As a follow-up to
https://lore.kernel.org/git/874kdn1j6i.fsf@evledraar.gmail.com/ I cut
"make man" out of my "rebase -x" invocations, I could swear it didn't
used to take so long. Turns out it didn't, and that its eagerness is a
recent-ish regression.

This is what we used to do before v2.22.0, so I'm not too worried
about the edge case discussed in the comment here. I think an
improvement on this might be to e.g. force all the flags with a "make
dist" or one of the install targets.

In practice I don't think there's many/any people who build releases
that matter to anyone out of the checkout they've been using for their
own development.

 Documentation/Makefile | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767f..6b3f0bb6c8b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -137,11 +137,12 @@ ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-amanversion=$(GIT_VERSION) \
 		-amanmanual='Git Manual' -amansource='Git'
+ASCIIDOC_MANVERSION = -amanversion=$(GIT_VERSION)
+ASCIIDOC_ALL = $(ASCIIDOC_COMMON) $(ASCIIDOC_MANVERSION)
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
-TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
-TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
+TXT_TO_HTML = $(ASCIIDOC_ALL) -b $(ASCIIDOC_HTML)
+TXT_TO_XML = $(ASCIIDOC_ALL) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO = xmlto
 XMLTO_EXTRA =
@@ -333,6 +334,16 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
 	date >$@
 
+# We use $(ASCIIDOC_COMMON) here, and not $(ASCIIDOC_ALL). We don't
+# want to include $(ASCIIDOC_MANVERSION) and have the documentation
+# re-built every time HEAD changes.
+#
+# This is a trade-off requiring a "clean" build of the documentation
+# for release purposes, in the future we might include the version if
+# there's a cheaper way to re-insert the "Source" version during
+# re-builds. If we detect that that's the only thing we changed we
+# could insert it with a cheap search/replacement against the existing
+# files.
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
 
 GIT-ASCIIDOCFLAGS: FORCE
-- 
2.32.0.634.g284ac724283


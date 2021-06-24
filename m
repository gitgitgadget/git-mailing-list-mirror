Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C08C49EAB
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7B36120D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhFXTm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhFXTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:42:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C550C06175F
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n23so4768696wms.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3BHz3R6ao2lRXBxIoaaC6tGq4r+WR/zyqTWR5GVT18=;
        b=J5OeYfd+XrML5qT43nCYOo/hTyDX9xPep0MZdkSnXJcwKyZurfm6HzPMeOFCranuNC
         33bBBwvfcifGaMhiXEKjG6e/j/B7vHGpuwFZFYfMUmH1ZTPA3nOkZXbR3SU4sW2/nspP
         a1C/328NNYmUm2wrCCWpwHRzJFbd0q/VTp0E2ThmDksedBcabi032NvjIsyy1MaITIDe
         lx26xVsM7z1VYQDfq+dklepC3gtRzMVR+I/t29bqPL7aML7cGfJIW/8rxLDcUbrb32fr
         fRolzwXakMXb2IdeSAAlhXnTKUSgZXKa+S99sDHHjosvd68i6GjVVMzLLUzhRnAe4g2e
         6COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3BHz3R6ao2lRXBxIoaaC6tGq4r+WR/zyqTWR5GVT18=;
        b=kTLNgkPFeddoeRSWUuRshS9Gbw+brZQl5svF3pqpZBSQ8e2RsxqjMfzvT2TxMucx9B
         3ZMGxAOQM78C4XDLXuEWAcaUrSQlxg7uwF/VlYpZ//9knGzR3bIPzT4T05MnrYNYOm1y
         VVOQCUt8bR32N2+5bwn7PqYWSdVo/LEJTqbTLy1IHchGdztZ9Qjbs4IaFRyjZ0Yu8AOp
         Z9AWqxG+gC7l6quoTHVVRXkMN6IXwGW6Q9lRE8eUT+dNSVfFJfTB3LVr9t7yrHe7UzK/
         iVH0dvbSf0UWCzsVKwZWwO6yl5v5s2tameD7Id3veAHsvW2IMH7eV9qntZCW/DHEXnMc
         l0MQ==
X-Gm-Message-State: AOAM530YL3nPl/snzIiA6xdzh3nQyVJRO2C8RiWIsBGe/XXNBqc1aJ3Y
        2Kiu5GCdUOXEmdTWHj/3N8j8HSnPm9XPfg==
X-Google-Smtp-Source: ABdhPJx7ZcLsDLlMpTDKudrxPp4+I2U5a1Luav5LNtabja1GS515Jx9fYoffEoy3oxfAvs2pucik4g==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr6206173wma.126.1624563631960;
        Thu, 24 Jun 2021 12:40:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm9286057wmi.31.2021.06.24.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:40:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] bundle doc: split out thin v.s. not discussion from <rev-arg>
Date:   Thu, 24 Jun 2021 21:40:27 +0200
Message-Id: <patch-2.3-63f871a0c72-20210624T193730Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.610.gd639e370050
In-Reply-To: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
References: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com> <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the discussion of why you should or should not create "thin
bundles" into a new section, away from the discussion of our handling
of the rev-args syntax.

See 2e0afafebd (Add git-bundle: move objects and references by
archive, 2007-02-22) for the introduction of the documentation being
changed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b02f8b7468..f231f42b12f 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -42,7 +42,8 @@ header indicating what references are contained within the bundle. The
 header is (mostly) in the format emitted by linkgit:git-show-ref[1].
 
 Like the the packed archive format itself bundles can either be
-self-contained or thin (see "--thin" in linkgit:git-pack-objects[1]).
+self-contained or thin, see the "OPEN (THIN) AND CLOSED BUNDLES"
+section below.
 
 See link:technical/bundle-format.html[the `bundle-format`
 documentation] for more details.
@@ -139,7 +140,20 @@ contained in the union of the given bases.  Each basis can be
 specified explicitly (e.g. `^master~10`), or implicitly (e.g.
 `master~10..master`, `--since=10.days.ago master`).
 
-It is very important that the basis used be held by the destination.
+OPEN (THIN) AND CLOSED BUNDLES
+------------------------------
+
+When creating bundles it is possible to create bundle tips that are
+either closed or open under reachability, i.e. those that contain all
+the history needed to get to a given point (closed), and those that do
+not (open). A revision such as "master" will produce a closed tip, a
+range such as "master~2..master" will not (unless the full history is
+contained within that range).
+
+Another name for "open" bundles might be "thin bundles", as in the
+`--thin` option to linkgit:git-pack-objects[1]. Under the hood that's
+what `git bundle create` uses to write bundles. When thin bundles
+it is very important that the basis used be held by the destination.
 It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
@@ -152,6 +166,11 @@ If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
 
+See the the `--thin` option to linkgit:git-pack-objects[1] noted
+above, and the discussion of "thin pack" in
+link:technical/pack-format.html[the pack format documentation] for
+further details.
+
 EXAMPLES
 --------
 
-- 
2.32.0.610.gd639e370050


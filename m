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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1B0C11F69
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF6C613F7
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhGBL3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhGBL3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 07:29:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7AC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 04:27:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f14so11684244wrs.6
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+Q5Gg6LZo0fCDNyjw9HcVHVwre0dDJifCku9AuMwUM=;
        b=DFfRVLi5YFrcmejy+wOyUdvbVVDpVfTUvg2cxVqxrYrn1KGFv+CV2UzunSM6RxyPs3
         el9jWjDY5QvBepKn952zQ46jqu49vpOcLG/BNpo0C4qZLZO/5yrUVDjcLY5ZsSPtwfag
         BkvZNzwliISYaIwxUX6R2K1Egf45EVXCnbl2AkxmNKLG11m6OQWv1snPmhXqrW4bKn0z
         /ix8a7emwCyLScnVSoBprdDjcrbZeVOYgPdLBDE9DWOps+PGCxLSv/IFLYHnNIHXOEk4
         qjytQliHNnQPbi+l6S4RL3NSz9KUQEfQ4+OCe71aQHNgzcJpqbyQDzU5ezAA7yAT/gHJ
         QhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+Q5Gg6LZo0fCDNyjw9HcVHVwre0dDJifCku9AuMwUM=;
        b=NZk+M0N7Uw0ERZd4CJAd5ori0VXA8q6EsQtA0l/rXSpsKS5Bz2twPQodC1qV+g/KSx
         thajDP9nVdO5hF/n78Z8xAmyIHIjDslOiWHE4xd4UEjJM2OTgnq/7WaVDrQbM1ZG5R6Q
         zC5LsjfsoZVgNrPQsXaCOcCQfdYujbwyctQ/qvXtT4Za5EJocwcq47kBYMVD2TTbGHO/
         Hza0mKerY3JmBMTG9mwvs6EY+Wi9s2f6kZ3Z1Lp/3EcK1CDn+h9GjufQIxElXpqEcPVx
         DXYvh4nPJEwCW4YQVwZY/S03cyGegacAe04tE6hJB1DzmoCG7IdOih3kwltxOhDDzXC1
         WqCQ==
X-Gm-Message-State: AOAM5304tb07w1+CqW7c4Nbqm+ICFZ+lusi4vSLnB/Qy/nsfjjkPam+O
        68rFjtxfmmAYyTELEo170XbhTaS0sax/IA==
X-Google-Smtp-Source: ABdhPJwi3iA9X+cRchgaHmat7e72QBq9D2dYXWIdRCB0jNQd10429Jbak7EQOofDVZoebT/7B0TKQw==
X-Received: by 2002:adf:f292:: with SMTP id k18mr5185914wro.265.1625225218807;
        Fri, 02 Jul 2021 04:26:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m18sm2763887wmq.45.2021.07.02.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:26:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/3] bundle doc: elaborate on object prerequisites
Date:   Fri,  2 Jul 2021 13:26:54 +0200
Message-Id: <patch-2.3-444b06740bc-20210702T112254Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g49a94b9226d
In-Reply-To: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com> <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the discussion bout "object prerequisites" into its own
section, and add some more examples of the common cases.

See 2e0afafebd (Add git-bundle: move objects and references by
archive, 2007-02-22) for the introduction of the documentation being
changed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 9c743aed49f..f5430029b8c 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -45,6 +45,7 @@ header is (mostly) in the format emitted by linkgit:git-show-ref[1].
 
 Like the the packed archive format itself bundles can either be
 self-contained, or be created using exclusions.
+See the "OBJECT PREREQUISITES" section below.
 
 Bundles created using revision exclusions are "thin packs" created
 using the `--thin` option to linkgit:git-pack-objects[1], and
@@ -153,19 +154,38 @@ contained in the union of the given bases.  Each basis can be
 specified explicitly (e.g. `^master~10`), or implicitly (e.g.
 `master~10..master`, `--since=10.days.ago master`).
 
-It is very important that the basis used be held by the destination.
+OBJECT PREREQUISITES
+--------------------
+
+When creating bundles it is possible to create a fully self-contained
+bundle with all the prerequisite objects, as well as providing
+negative revisions to exclude prerequisite objects.
+
+A revision such as `new` will produce a tip with all the prerequisite
+objects needed for the `new` reference.
+
+A revision range such as `old..new` will produce a bundle tip that'll
+require any objects existing before `new` to already be present in the
+repository performing the 'git bundle unbundle' operation.
+
+A self-contained bundle without any prerequisites can be extracted
+into anywhere, even into an empty repository, or be cloned from
+(i.e., `new`, but not `old..new`).
+
 It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-`git clone` can use any bundle created without negative refspecs
-(e.g., `new`, but not `old..new`).
 If you want to match `git clone --mirror`, which would include your
 refs such as `refs/remotes/*`, use `--all`.
 If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
 
+The 'git bundle verify' command can be used to check whether your
+recipient repository has the required prerequisite commits for a
+bundle.
+
 EXAMPLES
 --------
 
-- 
2.32.0.632.g49a94b9226d


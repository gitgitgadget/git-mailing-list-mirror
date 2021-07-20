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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A93C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC98B610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhGTNq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhGTNlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 09:41:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2FBC0613E4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:20:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c12so8187773wrt.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzcSN5UCtKe5cDLGyIdRxSeAmRBRvotZ+8JtHSlx2Ss=;
        b=ZVvq+sNWvVEExf4b9Q8kW0m933CS+jCooBFOlhwKpgi3EdE0IYu9OFo1c1yYCv77Gv
         wdtItgsxrtW4Z4NqUbG3PUlZkARgpCxttS1Wo/PzhrXnSOs2XjXsfpHpYRO+oFoB7/S2
         VEb2FoRhmrnu9bfZifNTZ1T7bAUR4klw5kir6MXk4cuTGoBuqo4G2WKELtpTToNfXEbP
         zxRXFrFgf9mcdqKhVLEkl5lmqOIoJY0zMYCSnqLaytgW7fpGlWDhKM9zI04ZgAfWSU2t
         0b5Z1TW8wWPCeiQesBA1TrGK1QZQIDiF8bkumcWTRFxfYQHNNJjrJKPqCR6eehd35ePt
         /JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzcSN5UCtKe5cDLGyIdRxSeAmRBRvotZ+8JtHSlx2Ss=;
        b=YxWWNK2UcsO+6SSqxhqbt7HLXPz3KHqfcrDD0fjuUWcPMWRamC1A3sIOFcvXVpHjtH
         VHf7nEfQbA3mee/ldFza2ncOQKn5+aIQIob43Uh/GxDb/x/vUuUYlDgaLmaOWoq8hSMY
         0ab34g8evQRdwwMdQsqF2eBI9TySBym0FoPTLmE9cI2ZNjxViT2twgc7O7o9zGbeyZEL
         rEvQayHyZypEpFv4GvnfUhDXFSjHBqnBhfcCDyGKhtt6AWTyPkm6ZaxzgrJCSI81faRR
         /tm/Gby0jOxivw5JzblSq6vfJsaN+gGbn4cOHkfXWFwH6vE/NxheLNW4EUuyR3X/dOCw
         VnFA==
X-Gm-Message-State: AOAM532qRyAZksN4ubjsEIpWR3GyArOv5UoGzZ0CZrKqOdvTw2Sm8RB2
        5kfI3HZ8qef2m5suIbVtCHs+OoJNCxefkQ==
X-Google-Smtp-Source: ABdhPJywn75SkA6CcwL7jisLCJqpRwhDhW65iTCBoOXNKlJhZH2BRS61enThSpLR0MOsho8T+y/mkQ==
X-Received: by 2002:adf:f68c:: with SMTP id v12mr36805036wrp.360.1626790833525;
        Tue, 20 Jul 2021 07:20:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm23785370wrn.28.2021.07.20.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:20:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 3/3] bundle doc: elaborate on rev<->ref restriction
Date:   Tue, 20 Jul 2021 16:20:26 +0200
Message-Id: <patch-3.3-6d66d4480ff-20210720T141611Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com> <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elaborate on the restriction that you cannot provide a revision that
doesn't resolve to a reference in the "SPECIFYING REFERENCES" section
with examples.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 47 ++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index d5627b8cc51..e7a685e533e 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -145,14 +145,45 @@ unbundle <file>::
 SPECIFYING REFERENCES
 ---------------------
 
-'git bundle' will only package references that are shown by
-'git show-ref': this includes heads, tags, and remote heads.  References
-such as `master~1` cannot be packaged, but are perfectly suitable for
-defining the basis.  More than one reference may be packaged, and more
-than one basis can be specified.  The objects packaged are those not
-contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g. `^master~10`), or implicitly (e.g.
-`master~10..master`, `--since=10.days.ago master`).
+Revisions must accompanied by reference names to be packaged in a
+bundle, since the header of the bundle is in a format similar to 'git
+show-ref'.
+
+More than one reference may be packaged, and more than one basis can
+be specified.  The objects packaged are those not contained in the
+union of the given bases.
+
+The 'git bundle create' command resolves the reference names for you
+using the same rules as `git rev-parse --abbrev-ref=loose`. Each
+basis can be specified explicitly (e.g. `^master~10`), or implicitly
+(e.g. `master~10..master`, `--since=10.days.ago master`).
+
+All of these simple cases are OK (assuming we have a "master" and
+"next" branch):
+
+----------------
+$ git bundle create master.bundle master
+$ echo master | git bundle create master.bundle --stdin
+$ git bundle create master-and-next.bundle master next
+$ (echo master; echo next) | git bundle create master-and-next.bundle --stdin
+----------------
+
+And so are these (and the same but omitted `--stdin` examples):
+
+----------------
+$ git bundle create recent-master.bundle master~10..master
+$ git bundle create recent-updates.bundle master~10..master next~5..next
+----------------
+
+A revision name or a range whose right-hand-side cannot be resolved to
+a reference is not accepted:
+
+----------------
+$ git bundle create HEAD.bundle $(git rev-parse HEAD)
+fatal: Refusing to create empty bundle.
+$ git bundle create master-yesterday.bundle master~10..master~5
+fatal: Refusing to create empty bundle.
+----------------
 
 OBJECT PREREQUISITES
 --------------------
-- 
2.32.0.874.ge7a9d58bfcf


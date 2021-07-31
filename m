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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ACBC4320A
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FB560F39
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhGaIX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhGaIXU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 04:23:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16129C0613D3
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so7840662wms.0
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmXQghiUngzCbpZCA03C1W+Q3Rx5LmUsBiZxDFAv5yk=;
        b=iXOlRVWgfuEtxTmsrpaVkGCLTj7ym9CeOLjcTNJCKs4BrLSw6CDiaE8/VmsqVJRrWN
         OsnMso8phuEfy3+5lq4MRs3nGdBCWDNH5mRQYzFFv3HfHVC8SorwH8s8xThIJk8YH6q1
         25VvOrbEie6HvtcyoAD03AzzofEXSJpXhp6iL0Jxx5AJvPxgT9AehtZL73TZVxp1bPNw
         qAW186OZRqhUcw282lgNz4+5N+I2h3d+a56P4IMmA7zaftuxoIX3A/hC0IAPlRJoYIpJ
         GWzVlG2VGxA9NERwI2u/phVTXD0vqA4UkibYA+zEo+xZCp7YX7bJp5hfrk9uFIjY3XsM
         K24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmXQghiUngzCbpZCA03C1W+Q3Rx5LmUsBiZxDFAv5yk=;
        b=jVqY/I0zQeIOJVLvhW4GhjDrZZCaK1aHGfdcSx8g6VhKgA6YXSmrzbuuI2RdDxbNbm
         6AvUQEpprgf5T09Cu5oe8wUXkt9lepAPfjVQnNi6sJu7OmWccHeCluJHzDwS4FuSwPOI
         6T9jTkKVxlfw9xO9L+rRkPuhCJqR6cb8adnHmAKNyChgYYG9TZM88KbmACseRVgSBTcd
         NduAHmE+FVemFLLZ/XP/IEykkX5JCalnteczEJ/X7Zm1NPFaAU951jfLrO8b3Sr9FJA5
         cj0rTCZldnQ9Kxn3yaJHecQw1c+HqkG245bk3Mt7ribaXzdHDD2CtN8HTCyTFrSrV9Ki
         OvAA==
X-Gm-Message-State: AOAM531UktPMxtO97qwNXwyXN7O6IBxCIL+b6YCqIS9r0arfY4zODrIO
        JtW3jp20vt35QvlM7tVO/M+QD9f7sJHckA==
X-Google-Smtp-Source: ABdhPJz8qi/ZdxODDJJFAf59pRtrCtXzhkepnIx3p00zqdGW9KVZXlS53dpbwDw0NKfOzEp1wd7Itw==
X-Received: by 2002:a05:600c:4141:: with SMTP id h1mr6911707wmm.83.1627719792477;
        Sat, 31 Jul 2021 01:23:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm4877548wrs.81.2021.07.31.01.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:23:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 3/4] bundle doc: elaborate on rev<->ref restriction
Date:   Sat, 31 Jul 2021 10:23:06 +0200
Message-Id: <patch-v8-3.4-0e702337c7f-20210731T082120Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g545f0888808
In-Reply-To: <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com> <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
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
 Documentation/git-bundle.txt | 46 +++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index f1f84ce2c42..f36939ab014 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -144,14 +144,44 @@ unbundle <file>::
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
+bundle.
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
2.32.0.1069.g545f0888808


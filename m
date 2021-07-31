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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684F6C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF5260F39
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhGaIX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhGaIXV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 04:23:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00EC0613D5
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so7840678wms.0
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxCjJUYxP/oT3e7qiXs1xIlVmX7K4tlRHed4RoLOLcw=;
        b=FVs2iQFGjA+alKyzIGK9MMiA5FO6t9AhCUr9eh9vPtCVOLM2m5CnXRgf25nYoHYjqM
         v3hSNo9g44EUG99qLJGJIcRX6Zv2JjeOctIpgkfd+7SmpsUY2ZPB5R4lyN1Sh3BglC5a
         TTAhUytYb0xipZWcqbVbbW71VwPvMHmFe1SrK4j58+cnJxy6Davbmu4kS8YCDg0AWnhY
         zgmqFHqW32j6CVU/OLxGf+3+E4Rem6ngAY/J1mLB5k29NYW5BhUgpJ23B7oFxBkIhPO1
         +LDJCDtgjPQgFn06OGHE/Q3V26gV8FNJipcSakd29v4LLW4eowRWpcgxdyAZFhcDYBgs
         Iz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxCjJUYxP/oT3e7qiXs1xIlVmX7K4tlRHed4RoLOLcw=;
        b=m7U0CDRGIGjbjoluKIvWXZoYVszh9vogs7Q/eJKbhpNwCRmQMRbrSzGrVzLjZPyKfx
         pna3MRu9uwnSvyRenstqetoekQ4WVtsYt2TyUY6DcLIEAALfDhc7sT0sZfuI/nwniOY/
         UTmgpjpGVQ4TFWs3Rx8aRD/raldUbQDaa4ERlvk2nYD1W4wEB0Imt7QxKHUGlWzBl6mJ
         fapzzG7+g7xIA1IAGEyyWUdsukVeMBUztzv+VtRbClGkx43x3qrANpVGiqYUwsfLWNi7
         MgS0i+7DlBzC+MQemL2cbfnHN8WeIz4hLIk1kbfCMinUN9QJYjhptfkLRr44bo/hL6ls
         Q5aA==
X-Gm-Message-State: AOAM530sui7717UuZN/s7NEiYQIrYSwAFeY59gBxAUxtuYCGryEClITH
        rmZvLPCM/Xg/172SJEGm9FiWzBw5nxJwtA==
X-Google-Smtp-Source: ABdhPJwC4PjBjyOJI1mXeFRaYoJwNY6fuvyBYcSnaRt2XMjA2y+V2Uz8+9MrkC53eNzVoNN9StdmGw==
X-Received: by 2002:a1c:a98a:: with SMTP id s132mr6856737wme.131.1627719793164;
        Sat, 31 Jul 2021 01:23:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm4877548wrs.81.2021.07.31.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:23:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 4/4] bundle doc: replace "basis" with "prerequsite(s)"
Date:   Sat, 31 Jul 2021 10:23:07 +0200
Message-Id: <patch-v8-4.4-1f3dcd42863-20210731T082120Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g545f0888808
In-Reply-To: <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com> <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commits we introduced new documentation that talks
about "[commit|object] prerequsite(s)", but also faithfully moved
around existing documentation that talks about the "basis".

Let's change both that moved-around documentation and other existing
documentation in the file to consistently use "[commit|object]"
prerequisite(s)" instead of talking about "basis". The mention of
"basis" isn't wrong, but readers will be helped by us using only one
term throughout the document for this concept.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index f36939ab014..ac0d0038350 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -147,13 +147,13 @@ SPECIFYING REFERENCES
 Revisions must accompanied by reference names to be packaged in a
 bundle.
 
-More than one reference may be packaged, and more than one basis can
+More than one reference may be packaged, and more than one set of prerequisite objects can
 be specified.  The objects packaged are those not contained in the
-union of the given bases.
+union of the prerequisites.
 
 The 'git bundle create' command resolves the reference names for you
 using the same rules as `git rev-parse --abbrev-ref=loose`. Each
-basis can be specified explicitly (e.g. `^master~10`), or implicitly
+prerequisite can be specified explicitly (e.g. `^master~10`), or implicitly
 (e.g. `master~10..master`, `--since=10.days.ago master`).
 
 All of these simple cases are OK (assuming we have a "master" and
@@ -236,7 +236,7 @@ but we can move data from A to B via some mechanism (CD, email, etc.).
 We want to update R2 with development made on the branch master in R1.
 
 To bootstrap the process, you can first create a bundle that does not have
-any basis. You can use a tag to remember up to what commit you last
+any prerequisites. You can use a tag to remember up to what commit you last
 processed, in order to make it easy to later update the other repository
 with an incremental bundle:
 
@@ -287,7 +287,7 @@ machineB$ git pull
 
 If you know up to what commit the intended recipient repository should
 have the necessary objects, you can use that knowledge to specify the
-basis, giving a cut-off point to limit the revisions and objects that go
+prerequisites, giving a cut-off point to limit the revisions and objects that go
 in the resulting bundle. The previous example used the lastR2bundle tag
 for this purpose, but you can use any other options that you would give to
 the linkgit:git-log[1] command. Here are more examples:
@@ -298,7 +298,7 @@ You can use a tag that is present in both:
 $ git bundle create mybundle v1.0.0..master
 ----------------
 
-You can use a basis based on time:
+You can use a prerequisite based on time:
 
 ----------------
 $ git bundle create mybundle --since=10.days master
@@ -311,7 +311,7 @@ $ git bundle create mybundle -10 master
 ----------------
 
 You can run `git-bundle verify` to see if you can extract from a bundle
-that was created with a basis:
+that was created with a prerequisite:
 
 ----------------
 $ git bundle verify mybundle
-- 
2.32.0.1069.g545f0888808


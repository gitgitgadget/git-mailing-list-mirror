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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F6C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995E560F6E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhGZXoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhGZXoD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:44:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B95C061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u15so3021486wmj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAufCCFBLA47ou8BtLBDm1yVN7AVOO2kz0ntvGKJAhA=;
        b=s3c6U1Boqr13jW+z2bBIGiPlV/RXaSXxNUrtfc9PVuifjP/rh1KCx6nDX7TebMBEBa
         0QRyHh3vNzQ0YEFJ4dWRSNEUTmC0NeiFtacS2lLw+5fFtICwDf8v46spy20wJyGJCNjE
         +UfO2HwcuNcEz6jql/Y54H/XoPkS5xY1IjjtP4FcnLNCNBfKUPOeVATiP/WlBLKoU2Dh
         qvxxAaxFTqURYqSNyBCBF+9AuwiW5VHpCPcV2NCgbmqYDHCPkhM/SsqpvzOlDbtM7iUo
         tgy8jTPxbHYlLV9a4/LXrBzm4ewx6mUqAf9Dnp/assIMxOcT50GQhT8RU/M0XCKssSL+
         hnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAufCCFBLA47ou8BtLBDm1yVN7AVOO2kz0ntvGKJAhA=;
        b=m935stIVOBeIjClZWDJIpSdCEI+5GcnMtedMduj3ntj3hqGrLYxB7pU6WaHreQfljv
         9Nj65OJgImgmrysu2PNJ4C0fUxpoJ+hgjW2OrBlVqREaklDgAGy7w1UcvcfTLx3adOhM
         KuBmq21DVj+ZTNKya4EYZqLrp6nJL1JQiWIzb+LIlYPSxy7Lr81A9DWWkxgk7BlJ1ir+
         +UeneH2WO9l8Ypb8wqT0CtHjEQa5UB0WQc+dyM95NJ35Dzo1nNarzgQBL3UP4RePtmw7
         HtFULjpPaV2WOTrUDweFK42z/LQVFAOzDa3YUpjsZ0GrSRdzKeSpaoi4n5utBT80XwQm
         T+LA==
X-Gm-Message-State: AOAM530Oc0ljoYOolH75/ywQXA0Lk+VIlDltQpt+qeqoNnHz1CBzEF9q
        v6dldxYXXZjbsKJwmRQHsHQiBnUJi2hAng==
X-Google-Smtp-Source: ABdhPJysvXr/MD5Rk1LNms3biD4ZG+j/rSAkEeJTgQLp4bL1KL9UOOVxOUMLAXXcrqhIYUU1GJq3fQ==
X-Received: by 2002:a05:600c:3795:: with SMTP id o21mr5460573wmr.90.1627345469026;
        Mon, 26 Jul 2021 17:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm1115872wmq.0.2021.07.26.17.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:24:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 3/3] bundle doc: elaborate on rev<->ref restriction
Date:   Tue, 27 Jul 2021 02:24:21 +0200
Message-Id: <patch-3.3-88e7ad1cf4-20210727T002001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com> <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
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
index f1f84ce2c4..0f28c41409 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -144,14 +144,45 @@ unbundle <file>::
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
2.32.0.988.g1a6a4b2c5f


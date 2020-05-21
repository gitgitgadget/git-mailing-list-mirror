Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04141C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6063207F9
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSDnai4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEUAYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 20:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgEUAYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 20:24:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA86C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i5so5548267qkl.12
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmRPTfGhGckUbxtxMFoydA96+ewIKgDpsTOGOR783Hk=;
        b=ZSDnai4D9UOV1GQRw4O2N5NdVecnzGAKlH5DgyKb2+SLZHPHxOTdU2BH3VtaCvx1tf
         wyHcs2L0FV9YrfYb5P5SDZ6DMRd7h+UTrsGWYST2fAYKZ3F1U8UlRLDqWItChhPPQ7uG
         qCMXDwufVP0Whg45yeCKoLjo+7EN/J2Bh/9uYrWutD04a/9Jx+R/5tiKOd2V3rRgc7Uy
         BQBQo5V4GFeX3HOw5gPLxFSlM5BUvQAsYiTTvA7ROFQCfe2cGZcI+uKLd538MvTRbKh1
         BR0yAUtFxhxegM4E3XbKki/w2BseiE+EonBrgCBnLjrwnH/bNftL/dhadq57bscy1O1N
         nkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmRPTfGhGckUbxtxMFoydA96+ewIKgDpsTOGOR783Hk=;
        b=JesaHm8PqJPyHn4eE95nTf7NttTARZV2kZU0vsvOMPr7ezla8OL6QYblLCcaD7LOoW
         9vFf5dfb8tCNxX3itAPghIBKbSfbrCM04MWMOOeD8dreKR/xLLtGuIktYUyKk2rBBfWP
         DflWdaiRGUPr37DqdYICYKYT934CLFn/L9WP9tNs11YKnmodUjD3v7VrJ4NileDsyzdX
         ciQ/6Og+Xs6TxR67btZlFMbNetUnZuGJVMAInY4ozOOEvxVJs2peJTXWE+/8lpmfQZnN
         dN5kimH3FBlDiPmlXKxD61nSNStEE8E15AhF4Jqph/L3CboD4HRNA9H2UTaCFeu2P3MY
         +sSQ==
X-Gm-Message-State: AOAM531slBSKtRRVZQX3OzzQQxu72+ACajtsqPaTP5ntgylKIqoy/0fV
        DSQJgWj1Fl8tw4o08dDlqYPOP/dl
X-Google-Smtp-Source: ABdhPJzLjRReqjPSQfAcOnOjO79u9riN/P3oFaQ8UlzBciVHVx3EO8s501o9jlW9sflE6G4G5QYgfg==
X-Received: by 2002:a37:8883:: with SMTP id k125mr701626qkd.14.1590020685486;
        Wed, 20 May 2020 17:24:45 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id w67sm3539023qkb.102.2020.05.20.17.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:24:44 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] lib-submodule-update: consolidate --recurse-submodules
Date:   Wed, 20 May 2020 20:24:16 -0400
Message-Id: <16d0a3eb9ac8dcda701433a9e67cde5103949432.1590019226.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.114.g141fe7d276
In-Reply-To: <cover.1590019226.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com> <cover.1590019226.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both test_submodule_switch_recursing_with_args() and
test_submodule_forced_switch_recursing_with_args() call the internal
function test_submodule_recursing_with_args_common() with the final
argument of `--recurse-submodules`. Consolidate this duplication by
appending the argument in test_submodule_recursing_with_args_common().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 122554acd6..bb36287803 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -630,7 +630,7 @@ test_submodule_forced_switch () {
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
 test_submodule_recursing_with_args_common () {
-	command="$1"
+	command="$1 --recurse-submodules"
 
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
@@ -809,7 +809,7 @@ test_submodule_recursing_with_args_common () {
 # test_submodule_switch_recursing_with_args "$GIT_COMMAND"
 test_submodule_switch_recursing_with_args () {
 	cmd_args="$1"
-	command="git $cmd_args --recurse-submodules"
+	command="git $cmd_args"
 	test_submodule_recursing_with_args_common "$command"
 
 	RESULTDS=success
@@ -927,7 +927,7 @@ test_submodule_switch_recursing_with_args () {
 # away local changes in the superproject is allowed.
 test_submodule_forced_switch_recursing_with_args () {
 	cmd_args="$1"
-	command="git $cmd_args --recurse-submodules"
+	command="git $cmd_args"
 	test_submodule_recursing_with_args_common "$command"
 
 	RESULT=success
-- 
2.27.0.rc0.114.g141fe7d276


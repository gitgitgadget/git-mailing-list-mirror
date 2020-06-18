Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89473C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9F20EDD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVhMzilc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgFRItc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgFRItV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:49:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E40C0613EE
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:49:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so1748984qts.5
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2y7mFB0gE9guERvhw+Ck90cqDpvNTnrJ078+V80sl4=;
        b=WVhMzilcvB09rKd5TQ3sCIJFXxXTB8ZSM0hDuAkHY1v4n11gbAyhUcCblUNf1nTeE6
         iZVZE7VYbcPj4MMMrhzaqO6GWBynL6COYpF7Ba2pRqVyx7vkVHCPaBJ/ukLyjZXfZUEG
         iAz16sPH23R65lZ3IvUF2ITnuZwpUgp+V8mMOW3pFnr1z6P8w8XDnwhy2f8fdG1YTsVy
         i9bhBG3DVQfuyTMaJtWIIrDD8Q//qbI1ler90Ff/dPqa9lQr34z43rdw5HJdQyPonchz
         F0A/aO16HuDTqzCvRBD4m/krwFDHn24fZPc4YiNjP6+yigXzmtB79r7ukOXBmJaUYRu1
         88Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2y7mFB0gE9guERvhw+Ck90cqDpvNTnrJ078+V80sl4=;
        b=QESWYTDQMf9m8aSmr0lb5/jtdEerC5BamHkOL/RQxUIdQc4uDHFBUJX5/2rytjD+XH
         A3X3YDpLDv7eo73WaShoHfWEnrIi/mHdTeJ0MN7nuskGwdgBIeQdrPadeQL+jTeqr7Sl
         EGMFvTdVK+5q88NW1zB1uIcU2nHBmzoPuccBVI08XMHOMq6q4SsuCWQhMtMjut8uCKXR
         icqKGLMFMjPcolxbiajp+A6aguyLQkQebLTydTyFuOmDoyD5UrZVUb/Yzz6bm2CwXrre
         7GHkeruepELyBO/oInrq9gh8a9mGWSCNT4lymrL7LeElzxJvdOtwee04iFXOwiOQLoQT
         SIxw==
X-Gm-Message-State: AOAM532wxRZW86ZdGrTCkWagbnCtdv973tfPwRwFErRkouSKmU5YmyZt
        hagZmasVxJm+ekb7agV7ac81c9fDKZE=
X-Google-Smtp-Source: ABdhPJwYWK8YXkxSxa3wjysQWapYNLxVIJkRzabxMR4zb4Mv0Tbw2lhWg9Lqq7MEU/G9pgIHWem7mw==
X-Received: by 2002:aed:3fa4:: with SMTP id s33mr3411839qth.148.1592470160451;
        Thu, 18 Jun 2020 01:49:20 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id p11sm2733082qtb.4.2020.06.18.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:49:19 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v4 2/4] lib-submodule-update: consolidate --recurse-submodules
Date:   Thu, 18 Jun 2020 04:49:12 -0400
Message-Id: <16d0a3eb9ac8dcda701433a9e67cde5103949432.1592470068.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592470068.git.liu.denton@gmail.com>
References: <cover.1591897173.git.liu.denton@gmail.com> <cover.1592470068.git.liu.denton@gmail.com>
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
2.27.0.132.g321788e831


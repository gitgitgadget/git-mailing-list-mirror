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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C7C433E1
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8545205CB
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6bLqcWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgEUAYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgEUAYo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 20:24:44 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A653C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:44 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n22so4131408qtv.12
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9vrEXNrlvsTF7iXXpc+ogGPqRX1gDZ1dUMWxM/1a7s=;
        b=J6bLqcWlk935B5fj18VJOXjcUDuysyWwToRX+SQfdxjkr1HJcj+9M6peVKz7JFf6Ji
         4smp/vdbCHXrD3Ayvv09dfAwbXuW1UvL60VJB/7lbJpwAbk0cMXdsK8F91+KixzNx3lk
         i6Yi3oB6ZOZll54B5Cburdi9tTHxJrRsC2PdewmonmHAoY9c6rbcHRuOAW5GKJF7646+
         xDyDO+iZCl/9uyfpM39zh23ssC+wJ9lQdoReG5f/iye5O4IXKWvQAQD8thXoCJ7PKXf9
         U+s+xo+gqg/jH21wXNZ8cwrgqaCvOkuzVqqIuAqGbHseuxDvQX4EMQUOH1VCafjr4p1l
         ziFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9vrEXNrlvsTF7iXXpc+ogGPqRX1gDZ1dUMWxM/1a7s=;
        b=pWHks3ComccI6Rtxav+QEkEQEzmql+u6Qo2k6LcTGDY0TDNnoFh9qJq1L+W8TSS3IC
         3qca+SsjEoSp7TC0gwQ+64S/33VOS6G9urY3qrdxtf3SokKPHNBJS1UH8FnWa3WkZGsW
         cp3CfQJu0pzxasVLcyV4riTLACojj459Aae+zrcbrC0/zTFIkkbOd+YaVYfvlyQYQAaX
         GDZ5pvppUzGgbauOKqi2d+m1EAAlhj6/4mgk15Z+SwCAZu6UubaeIwUO30ljLLahgGRf
         hgKED331LoUor0YFMGvrn+ExLxFPTvODcTVTPEz8qujSHnlIcQoGrEW19JYadcSFxCY1
         1VtQ==
X-Gm-Message-State: AOAM531riIf5UE0SII9PnrCfYeJ8+vGTRKr6SxwP2vRBjdtHi5ONY7RA
        fYbtSvd5pM58HAuklAJHF5MoL31L
X-Google-Smtp-Source: ABdhPJybWrhM3R/ACrIZWG9kksITZhOPX5xBygolaUkP1L+ogbfgi7mMntggCRr+Y6+0m51xGLPvQQ==
X-Received: by 2002:aed:2d44:: with SMTP id h62mr8088823qtd.217.1590020683587;
        Wed, 20 May 2020 17:24:43 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id w67sm3539023qkb.102.2020.05.20.17.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:24:43 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] lib-submodule-update: add space after function name
Date:   Wed, 20 May 2020 20:24:15 -0400
Message-Id: <ba2f642e0f505730d5d740207128036448787c8c.1590019226.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.114.g141fe7d276
In-Reply-To: <cover.1590019226.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com> <cover.1590019226.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the shell scripts in this codebase, the usual style is to include a
space between the function name and the (). Add these missing spaces to
conform to the usual style of the code.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1dd17fc03e..122554acd6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -183,7 +183,7 @@ test_git_directory_is_unchanged () {
 	)
 }
 
-test_git_directory_exists() {
+test_git_directory_exists () {
 	test -e ".git/modules/$1" &&
 	if test -f sub1/.git
 	then
@@ -309,7 +309,7 @@ test_submodule_content () {
 
 # Internal function; use test_submodule_switch() or
 # test_submodule_forced_switch() instead.
-test_submodule_switch_common() {
+test_submodule_switch_common () {
 	command="$1"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
@@ -629,7 +629,7 @@ test_submodule_forced_switch () {
 
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
-test_submodule_recursing_with_args_common() {
+test_submodule_recursing_with_args_common () {
 	command="$1"
 
 	######################### Appearing submodule #########################
-- 
2.27.0.rc0.114.g141fe7d276


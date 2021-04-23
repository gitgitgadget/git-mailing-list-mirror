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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B22C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C80613F6
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhDWHWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbhDWHWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9DCC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx20so55213204edb.12
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eAGV+SGgl4/D6wWoMy5/26yub/JJ7qeBPPHXgpF7SY=;
        b=U1rFOm5pyEjb5D9+gg1DO0SYSuo2eJm8jYGXpI3u+8MRO5tuKNJgDsytaXQlLiT2CC
         MoFUphnKgkeVzPs07rpo1NElcVm+ZnQl20DlMmFwOOdco45cQgXqxJrG5/7/Oby9Kw0l
         SFq0EHCJvg7XxQC+qKoUuPyzTmc0hLlxGdsPwXLHYXqTD6XoAa62FON+XzYe8RqJCAhZ
         rx98TfsrU1Dj+iFRU98mOoQXS4r+26vWxocuxkw81ZWwhiIZhvP9auammnZs63uN+Y1x
         0xVkAgMBCw1KaIJDjcl5DrBcMKB7udpFG+1fUuYJvUA0Yw0Dtr1wOlCQl6oQBtnoZc5b
         e/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eAGV+SGgl4/D6wWoMy5/26yub/JJ7qeBPPHXgpF7SY=;
        b=eXtdow2Ka/w/fGUfcJEcyMuq0nqVjHCZ8jU2ny3k9E5cdjczAT75YH4ezztxbglBeW
         y8hOnGtuE9opbw9lSsnOXAL8gaLNDhMUEd7FEITZjT7bTLVN1RcNqv6FjaIolmuszmxY
         2xQOlHi3IQHMdXgPGlXyNMdngMfTUEyVCeZJAbAcaSyKgNsNRC1G0ZPhwDetKuUdTTYJ
         htTz2fEdpeKrnS+bMYUo+sGbFalugjZ9IZyHPNtAMSvyMG35LJF+wq2pYIVdycrdG9IS
         gs4Rd0okvboN+hq++Af8T1nUHXNgQNQ/IKFrMi8apUxXs4eu9DtFpBpY339zpRt10TrW
         gMjQ==
X-Gm-Message-State: AOAM531vLi76J5cMX5p6UPCsu5iXtTRXvVRn7h8kX3aziOM4rOXNDS3J
        ij45elUq8j/YFcgUPC+wRCOVlTaM1DIGTw==
X-Google-Smtp-Source: ABdhPJy7pwujbeH/ogTM2KCOYfyQV/WdpfoTGDh3eZF7R6yUBZx3ywP3BbVQSoTl80RJq4prJ3634g==
X-Received: by 2002:aa7:cb4b:: with SMTP id w11mr2787639edt.216.1619162484927;
        Fri, 23 Apr 2021 00:21:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/11] test-lib-functions: reword "test_commit --append" docs
Date:   Fri, 23 Apr 2021 09:21:07 +0200
Message-Id: <patch-03.11-361e34654e9-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation for "test_commit --append" added in my
3373518cc8 (test-lib functions: add an --append option to test_commit,
2021-01-12).

A follow-up commit will make the "echo" part of this configurable, and
in any case saying "echo >>" rather than ">>" was redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b823c140271..1f787ff0726 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -172,8 +172,7 @@ debug () {
 #   --notick
 #	Do not call test_tick before making a commit
 #   --append
-#	Use "echo >>" instead of "echo >" when writing "<contents>" to
-#	"<file>"
+#	Use ">>" instead of ">" when writing "<contents>" to "<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
-- 
2.31.1.737.g98b508eba36


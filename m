Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B2C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB0610E7
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhJTSm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhJTSmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B007C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so308354wrg.5
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQD3CMDfIeH/mwS1ngP0BuQ7NtSnurP6XeD0kmpdUko=;
        b=LEjLdzSK2zmoH+zeC9enyKffb5GMcUZ1ii2hTiEdl88WLFQCw0Vt+qB41vCHrs7D5B
         n2vPm6tt+1rHlF6xpatvBBPs703J0ZRAxJNJE6U0AENO5KF7Ecl5cGA32eW+RhDbBogl
         iucDb2IGw9md3n/5DGgTlNMwZ1DUz1j7S/B6r9FsVUO93XPFI7utfABUcUiuB/ZOerVH
         lyMrxdtOuyq49PPZyDPc24/QDm+2zdk6tUyf7YIluLNnGE1eAVYUq9WTXQ3o6AIE1vPM
         tYu3XY5ZuJV3djQPAet8lCIOgdEmjkCwc0WrKoUPCjklF+A8LOwbIw7yoXZ6PkiF2TQx
         3SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQD3CMDfIeH/mwS1ngP0BuQ7NtSnurP6XeD0kmpdUko=;
        b=TuoDzPLnf35I51V7Q/3NgOXYTA5qLI/hPSHjjsf7FK4za8XfZs3L+mefFEkiTG417n
         jPDiHzCov8Jv933M3Qu4Rf1K6yt9vwABUNkvYz6s/eMzgl3kVYVKT8yMW0OuLTZ+66y7
         9cv6097pXNXMkalPwiH6p3y9CwJFyEYdBHh+3CjXoY/b0oOn7CLka3YozpsOk8nv+Cbi
         n/8gRPJItvb0G/cAVaIJF1IA7PAw3KQO+HftwTx0o7HI1ZyIqKxer7+p8G2aZXCWoxJP
         6Vwh4G6qllvxEvb4PacmvJHSO6EB2p87Trpf29Di0zTjveTnFKi5uEy9W3dzZe6CcsML
         GYjQ==
X-Gm-Message-State: AOAM532dHVdrszdN7g9gwEDeDOSVeZ3dSeQR5mmPpuJvOHROzpdMcHG4
        Z2Wvx6H0wP9ypwuTTvu98Rh6b4L1dHwyZw==
X-Google-Smtp-Source: ABdhPJzBn1hjiKmr+3k/FsrpGFnOmaLky95JqLeqxoVm4hQdm719ESYz/1QP3Tdd0e7bMF7fNSAgqQ==
X-Received: by 2002:adf:b1d4:: with SMTP id r20mr1162787wra.308.1634755208639;
        Wed, 20 Oct 2021 11:40:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
Date:   Wed, 20 Oct 2021 20:39:57 +0200
Message-Id: <patch-6.8-e0b11514b8d-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

This is just a small code reduction. There is a small probability that
the new code breaks when the category list is empty. But that would be
noticed during the compile step.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index e517c33710a..a1ab2b1f077 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -67,10 +67,7 @@ print_command_list () {
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		for cat in $(echo "$rest" | get_category_line)
-		do
-			printf " | CAT_$cat"
-		done
+		printf " | CAT_%s" $(echo "$rest" | get_category_line)
 		echo " },"
 	done
 	echo "};"
-- 
2.33.1.1338.g20da966911a


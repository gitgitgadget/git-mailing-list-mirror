Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E7C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8202417F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 00:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7erQ9vA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507440AbgJVAVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 20:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507435AbgJVAVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 20:21:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEFAC0613D2
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:21:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i1so5290751wro.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 17:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ai9JYqlJh47JBTVfqyQu0+EgkRZlNcwR2sfJrzvRFSQ=;
        b=W7erQ9vAVgi9/ZrE35hMOeEYz1eKwkySAWG1NE4SSOae1FE0s2UpmoD15IH0C1tKvv
         r6nrFn4iFmYu5dYEFkLGmLlNM959yfEE87YsbVGCctkqgo8y9lNBzMXiCV4OTqY200YW
         VpxxM4bva8V/hecQdGQkcwP1gjHObUh9Xa8fIowcRx7upOIOEqLkOh5gvywAafE67uXP
         BPBMWYtgkEuLYaPHkpyUIq2lwIMkk9lElXRbXuKL0Bc2EQXiGEaHquBo11V5B99O1aZx
         T8cbU8dEFVZR4+qIq5s2hDSNNCP2f2XL10rOQNY4NWdl6SpAzt26ISmsM7yjquRm7/Hn
         h0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ai9JYqlJh47JBTVfqyQu0+EgkRZlNcwR2sfJrzvRFSQ=;
        b=dfLIe9kiqbtuYD4R0GNzWRa2GQ2aJh4PbyZWcV2yFFPBN91BSfsH2HgwByAWG5A4Hc
         KcJz63BHz1u0sFBNyD5jsxnuyZi+0ZlcmHohmjNSbFQZNVf+/mKWtSuBRf0ugrRSbush
         Mfn1wZBs8uIhNFF9NqjJ4IJBP5UY8k/CO+OKfrn3avTbWbpUAzGgoqZSTSZqpR9cFmnn
         7F8nV7a0n01AbfKO+obx0KYYLuPuIU9QeF15ZUVuZSc+ERgf0f1YuOWQidi0HFw5KSwo
         B4bjwJ7UEzlatMo1Yzfq6rzSVmGfY1Ok6Af0JXra3E3bSvRrB1OrOBukdV01hDirACdX
         9SnA==
X-Gm-Message-State: AOAM5322y8s+1xNY2CK+tQ0VeBxEqsYV0ZXcCD407zXra46ZQeq90jNp
        t+gqgGJ4llIBIw6rH1DbIuyJd9pJK+8=
X-Google-Smtp-Source: ABdhPJzj/agdfuVZZS6V6bbz3aLFN3KbWJyXFfOqc3dLMybKMQ6IyTabZQ7Wbzwntmv5TYuziVLvlg==
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr7431940wrr.255.1603326069541;
        Wed, 21 Oct 2020 17:21:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm6473442wrm.2.2020.10.21.17.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 17:21:09 -0700 (PDT)
Message-Id: <8ff657ded147f23e9db96c21205771e09dac9dca.1603326066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
        <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Oct 2020 00:21:06 +0000
Subject: [PATCH v2 2/2] fsmonitor: make output of test-dump-fsmonitor more
 concise
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Vandiver <alexmv@dropbox.com>

After displaying one very long line, summarize the contents of that
line.  The tests do not currently rely on any content except the first
line ("no fsmonitor" / "fsmonitor last update").

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/helper/test-dump-fsmonitor.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 975f0ac890..a42e402bf8 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -4,7 +4,7 @@
 int cmd__dump_fsmonitor(int ac, const char **av)
 {
 	struct index_state *istate = the_repository->index;
-	int i;
+	int i, valid = 0;
 
 	setup_git_directory();
 	if (do_read_index(istate, the_repository->index_file, 0) < 0)
@@ -15,8 +15,18 @@ int cmd__dump_fsmonitor(int ac, const char **av)
 	}
 	printf("fsmonitor last update %s\n", istate->fsmonitor_last_update);
 
-	for (i = 0; i < istate->cache_nr; i++)
+	for (i = 0; i < istate->cache_nr; i++) {
 		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
+		if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID)
+			valid++;
+	}
+
+	printf("\n  valid:   %d\n", valid);
+	printf("  invalid: %d\n", istate->cache_nr - valid);
+
+	for (i = 0; i < istate->cache_nr; i++)
+		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
+			printf("   - %s\n", istate->cache[i]->name);
 
 	return 0;
 }
-- 
gitgitgadget

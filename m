Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F33C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiKCRIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiKCRHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773426E7
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i21so3999844edj.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc9bInq/pziQp1bsPl/ALZO1xBl8du8NZpAOAtQysSc=;
        b=ajd36UR/3xR5v8kVBLOut8kYtsNsujsZsRv8IURtWLY8aGC90JrXcS3cMC2ZkBnA6y
         AwoScvHNPoUV1nRaf88MT8b7YHXmSm4cyadxg5I2oR7BUyKM9KVt1sO+ahydq60aeaKe
         e0LUTKKts0/SPxV7vAQ7gq9iwm1rTVpJIKvJ5bDfpqtAEUN6YEyw07i4E7V2+MCu3SMg
         SJoE3yQv8O8hKb1abAVN8lkJM2jiJCG1yQxefTEyEOSdCI00LqQrWH6xN+lfhR3Tzib5
         /dN+METNaX3jOjCpWcvt034jw6effHZjB/KQqFRFe8zyssZg415eR7udZl5xUnCpjU7W
         cWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc9bInq/pziQp1bsPl/ALZO1xBl8du8NZpAOAtQysSc=;
        b=4hJLvy6unRXs/GJlRXDE5XufLFZOANFUhVyB3n2pIpLS+sDfkf3hCq71gElELXlnMr
         YKAFcAeOdj5Cb50CqDNMF1nr27mMt92eiaI8OZhAm7dGBgBcmAmQSJpfBgSBKB4ZdZBQ
         MV4Nu8B/fjXXBrkO3shmNc8xwzEE3ixt/XD+QgVlrRfhn9hjJ2hOGYj8uFcEO+V6kQ9u
         pKdFJNEhJeiVanX4fTDxCEBzdzS0sEc3Ex0Kj+csuwDQzo1K6DtryscZNVi6lppesXIs
         3P9rIh9AfowcVWcuS1ZgC5umR83paQitvsUP5SydQ7smbI+pPxbvQsSK1QfVke+hsyKn
         1tqg==
X-Gm-Message-State: ACrzQf0W/V0mIoELxp2bG4zLEKfhcLtlcnCgY5BOwsQI6vcesRU0cl8B
        zckCtEOgp2Id5EnVs8z/rQM7SyDId9BEjQ==
X-Google-Smtp-Source: AMsMyM5kbGM8IcYVlSSNZV5S4yYWbNX6cmLKBABOAiLh2OZx43opP9WE1GHDxr105RkrxesUly/vAA==
X-Received: by 2002:a05:6402:440d:b0:450:de54:3fcf with SMTP id y13-20020a056402440d00b00450de543fcfmr30457612eda.312.1667495193248;
        Thu, 03 Nov 2022 10:06:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/17] cherry-pick: free "struct replay_opts" members
Date:   Thu,  3 Nov 2022 18:06:14 +0100
Message-Id: <patch-15.17-c9f51abf0e2-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call the release_revisions() function added in
1878b5edc03 (revision.[ch]: provide and start using a
release_revisions(), 2022-04-13) in cmd_cherry_pick(), as well as
freeing the xmalloc()'d "revs" member itself.

This is the same change as the one made for cmd_revert() a few lines
above it in fd74ac95ac3 (revert: free "struct replay_opts" members,
2022-07-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index ee32c714a76..0f81c8a795a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -261,6 +261,9 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
+	if (opts.revs)
+		release_revisions(opts.revs);
+	free(opts.revs);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
-- 
2.38.0.1451.g86b35f4140a


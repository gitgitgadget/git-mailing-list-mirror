Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDEEC432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E76206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6i14c9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUWUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40621 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKUWUa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so5477187wmi.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O4PZbbpNP8/K2E2AaCmUrYDEXvuy3j4vP7qs7Pp0jLU=;
        b=R6i14c9W4wFtv/X4jOxUFcYElfRN59Y/MxJ0/I9nEnsvOXQCFffdcDlR5qEannRI4e
         9JQuSOMbZxwLx4Ih34BpL+JS5Nh71HJISyDCRY1Affzu/Tr4diZMNGbSirOPBuh8fFtV
         L3EyoY4nl62pNn+mLG3iY6EUZN9Fy8M3iId8H3GibU1JGI9Q8JcG2y4LBPc/vLC2A2eK
         5j56YI+v65OuxDRiE018yxvZKJ8d1AwCMgDANT+uyo8tH6kd/pCLjWhcb87fFI4q5tDs
         HUe155PKwvxdQNXx0TbZCaLQU5KH1zdzXSdw3I+LzHVvjOhFJ59sVMy4exj4/prEImba
         KEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O4PZbbpNP8/K2E2AaCmUrYDEXvuy3j4vP7qs7Pp0jLU=;
        b=OJdH93h0fQdu7PL5UL6JE+mA4L+61iX6tMUZB4JvQNN0fmc81gaTumWd0dQ9nXbb1J
         ItWgC3zXfHLPFYY8Gw0Sq/xXkFQRJ+dsuu8w6u00nXWjNJWgsY8zSKFzkcccL/LvCsUF
         L2zm2L5r/cl1nL3MSptfKmOty5ejp8Kar/m+Fl89ZF1v/yYswi8B3othf8WjP3DY5oyM
         x4XICOrWoYIE+VAsJMMiojuFlJZfabiVrLLMRX7ikR6TAcV+KQ0DJ1yz7I3E7Yym3zpF
         qhGM2zPFJTFIASa1T4UNOcCwEy/ud0bY+707EYlSF8NxdErCfWuuTZhv8Pdzkpd0vPFt
         xxRg==
X-Gm-Message-State: APjAAAVaNvxt5mP2XZXZzD+M6M3fBmH1nugO+apW43BiTVdHqLDpRiAw
        Dg3vw1cR8rY1h293xrOY4Fv62yDi
X-Google-Smtp-Source: APXvYqyhPT1I78djhlbZBDrWtNukU6SGO5XVRwxYvCfQ2Jnpsd35P9PjzwCtvedckOLwgKjPXLpMNA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr1707565wmb.40.1574374828098;
        Thu, 21 Nov 2019 14:20:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm4897169wrq.22.2019.11.21.14.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:27 -0800 (PST)
Message-Id: <9bf5a803e6d44ce1ff03225e57933c97c8841327.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:16 +0000
Subject: [PATCH 01/11] fsmonitor: disable in a bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

t0003-attributes.sh

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.c b/config.c
index 3900e4947b..f6d4e2fae3 100644
--- a/config.c
+++ b/config.c
@@ -2339,6 +2339,11 @@ int git_config_get_max_percent_split_change(void)
 
 int git_config_get_fsmonitor(void)
 {
+	if (!the_repository->worktree) {
+		core_fsmonitor = 0;
+		return 0;
+	}
+
 	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
 		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
 
-- 
gitgitgadget


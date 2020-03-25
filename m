Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F141AC2D0E7
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8274207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlsmz5Ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCYVKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:10:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37960 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVKa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:10:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id l20so4668589wmi.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3EDFLKFA2lY6Vn4x7Nvt/53dnVdj+Mn8Zmo1y3f5RU=;
        b=mlsmz5Hta/R93hMUixrLtvzGkRjkBIttHHWmWIJ7kH8UJh1S7D3di2unj0WMIbQwUp
         /zkcfS/iSceH6XaQjKmE3FInWduQg/tY5TZDkvFVK/LHnc/C8NGaUjlHxV+SCGrhkYSB
         CJ3DIuEaol8RrqGkBuBFgh0E/oVyD84ZQEvqlqwtl8mlaxI4rVIC9LNzrpr6iXRiNKn/
         fktXRFxAzFkuER8p0oenhJ/U6zMUeokePYXptKGLEJYhg+++9yomWYqwIHNKlwpJFbhb
         nm9BQewhesihPVTuv3xUUqzqYh3+mmyCrB4MN8w8wi8erA6uY9Ty5QxKXOk0IeTzxR4z
         RjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3EDFLKFA2lY6Vn4x7Nvt/53dnVdj+Mn8Zmo1y3f5RU=;
        b=cFiEvmQx9E6aiBcKa6wssdIVLlSqjsLgUvruG/VBDhKfhGtebiJAIBTWbTVNo10WK3
         BmBRurCXzi1S1BBMw3F2L2Yv1SYtJM5ItrvuItVYHmf2aWAVQuP5KkhPaKvfy5XqpLnz
         cL6Qj91SbdoDsCh+cCXeUOMvATGeLvRN4149Vtyyk2WkaiOQxqvl9y6Mf2mHbHtKB67V
         C16P8lX7mgkqfqWFVO0RGHE12AmG9TDc2J75PoRlm7DN6Jydn0hl+k+vE4aFEBUNcG1b
         nZhkkskRWZ9srsvekepmhs6VEAQu+u6k6SL1NUn+AS6/53pDSleaCpfdpOWvudhMqNaT
         riYg==
X-Gm-Message-State: ANhLgQ3+/BKhh+/xeObYWCX+YOhWu1yT/va6+Xf1LQV7JjsLWXdFMMop
        56It47sYQduqlZ7VDjwFL4MhqSJJ+98=
X-Google-Smtp-Source: ADFU+vu38V7V3aMNFgpC/CSjSL4a3+DnLns0NM++ypww5vB27JrnQlVHFCpAkzv8irR2GuC8TPqpOg==
X-Received: by 2002:a1c:2e04:: with SMTP id u4mr5673439wmu.185.1585170627948;
        Wed, 25 Mar 2020 14:10:27 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id u16sm352760wro.23.2020.03.25.14.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:10:26 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v4 3/5] doc: explain how to deactivate submodule.recurse completely
Date:   Wed, 25 Mar 2020 22:09:41 +0100
Message-Id: <20200325210943.339240-4-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
References: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/submodule.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 5962f41ead..d7a63c8c12 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -63,6 +63,13 @@ submodule.recurse::
 	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
 	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.
+	When set to true, it can be deactivated via the
+	`--no-recurse-submodules` option. Note that some Git commands
+	lacking this option may call some of the above commands affected by
+	`submodule.recurse`; for instance `git remote update` will call
+	`git fetch` but does not have a `--no-recurse-submodules` option.
+	For these commands a workaround is to temporarily change the
+	configuration value by using `git -c submodule.recurse=0`.
 
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
-- 
Patched on top of v2.26.0 (git version 2.25.2)


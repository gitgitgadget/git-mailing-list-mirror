Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EAFC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351981AbiCOVcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351340AbiCOVcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:32:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140DD5BE48
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t11so378280wrm.5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VMEUndPqaZqgnJ/fjVlg4dlleAN5tgf3inMupsE+RpY=;
        b=gr7J0kvQBIA/L/21qWVlT0rWgQ6ObVXnOnpCRYvP9Vg6H4dSxEaP+y1jEvyfGnS/jK
         jCUxXMEoz1+/diVz8Sgpl/sGtVZzeOJoAfuyUS/dJCfhN8nVBZMmCa0YCWJTPMWudje8
         hZFMX3AhEIItMDZICCc6g00BZlHUuzE+/b8Eg18IEGF0R1WiZuFl61oR8BpJxIT8czCy
         dvSKHIY0JZY/La7czKpiiwOfLZ0V72dqzhvJNbgyTE29TktRdXhGW9yZf1II99EXjOcX
         lk1YFpL+8CRnofRU5qJ7HnCxDXB12mGD4Zd5shVvk65UBFujRjs4Ffrz7ewROpnlyH/1
         TwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VMEUndPqaZqgnJ/fjVlg4dlleAN5tgf3inMupsE+RpY=;
        b=rfmJnaHH90u9zCWiKntsoBzeqZ1xMw0pO2b6uRBa7sxkIFx+CHWRwwHKvBHKlYP/6j
         Kp70NBkDHYUJ+WqQuPQqSWd579appkuaavlBOoFmmDt5BYuUozOfecfdItyn+YJYalv6
         I2sEWVz8CX2LCOaL3gCSQ4nEJZ3E8bREn4tRfka8WaskVYgGgx6g17uMbkZ/GEnETneN
         Roz6lDtM/BxxXzwIzXFL3rP/Kldo9sqp6e/LGPijFIJNStR/kG6VvMG+pwHeA8/ySRut
         KMQrclnCRceF1JhIWa4HYbGHwz4uaTNMXcJccAAxlvCrOsEpBlg2YIUn7b0VK7nE97pY
         MjGg==
X-Gm-Message-State: AOAM530Fm6+PU70MjpgzPYe83m3+PTe1FFpavNn3WUOe6gSIaX4VTVvw
        pCbVMlmF0oSFbcLQUpZTiUWwLzPRdRE=
X-Google-Smtp-Source: ABdhPJzkPpFxx657elMqcUfEvFvgDxT2FFvIhSRkns9thuCmTMtmvVduZ6w6iPhV1/wOF3OjPuH01g==
X-Received: by 2002:a05:6000:1549:b0:1f1:e566:eb87 with SMTP id 9-20020a056000154900b001f1e566eb87mr21204800wry.87.1647379863546;
        Tue, 15 Mar 2022 14:31:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0038b5162260csm9087wmq.23.2022.03.15.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:31:03 -0700 (PDT)
Message-Id: <b0480f0c814ae1c726d51af172bf5833fc74f010.1647379859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:55 +0000
Subject: [PATCH 3/7] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables bulk-checkin for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
batch fsync functionality.

There is some risk with this change, since under batch fsync, the object
files will be in a tmp-objdir until update-index is complete.  This
usage is unlikely, since any tool invoking update-index and expecting to
see objects would have to synchronize with the update-index process
after passing it a file path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 75d646377cc..38e9d7e88cb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1110,6 +1111,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	the_index.updated_skipworktree = 1;
 
+	/* we might be adding many objects to the object database */
+	plug_bulk_checkin();
+
 	/*
 	 * Custom copy of parse_options() because we want to handle
 	 * filename arguments as they come.
@@ -1190,6 +1194,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/* by now we must have added all of the new objects */
+	unplug_bulk_checkin();
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
gitgitgadget


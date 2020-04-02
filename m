Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DDCC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 22:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2159920784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An1JT5r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgDBW63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:58:29 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52654 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388630AbgDBW63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 18:58:29 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so2149472pjb.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fio2RuDilttLx5vh16ocKAz1ciT2Ui369ibPfDPrqJs=;
        b=An1JT5r0vdmHf/v92M+of+Kk40iI3gwvlhPIOKT6siVKGvzoP8VrRUKvyXqwosBsyt
         DDx2Po/VgDdGeA+2wXjSIb3qu6eUJLMECCGY1gmTT0XVhPQ8OSKaKMdLNyb3s2NpZOfc
         RPgMAMNTmqPUKmpkLehsjeb85YvdqexCMOCcK3rpJhZ8b8NNbM36lPs3kAQCRxOoSCBV
         KS6yg/oRKZiIoKIS0mjvz0fLtxykjcJHTihYyHiHce3rk5Hd2pheP9/HtPhgSw9QjDwe
         ibndHdgC/7GsSNXJNBMkyW5D3Z2Ih1J/0bQ1tlIMcqRGUIEDfQFME6njE6V7AxYD9fiz
         oQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fio2RuDilttLx5vh16ocKAz1ciT2Ui369ibPfDPrqJs=;
        b=AxrAQn6zq6HL7I/cNPFgFX7m82/6T6SkqgINi1GVCoRPFCDyasvLi0D1MfNW6lOYv5
         BozryVPFrv33dmyNW8PsXJxI8YPOkef4mmt2I9EpwxNUkX0mDPNdWYgn4N97lcDhEN7q
         egUyTYvNlFSv1jir/Sj1oAS7xtPUu2UAYcEWWjMHnrQbOCc0NsCZHHbkJ17Co5YxfCmi
         7/ofQZrl1TfLNXBKF4fdGklu6D5JKbsu0ab0uaVmf++ni/n5wuUNJ4SodGTvQ+T7/tIf
         1daBRtdSKkOp8dDSnZshE5IZAOsqAE/bYuD+V+qwz8dcaoD3ykw18nGsruDQJD/Y/WTY
         s+zg==
X-Gm-Message-State: AGi0PuZ84g5AGCYgrYKyKSVSnSV9e8nutjk47MVna6H7bQ9K4jCwM3Ef
        tLZqgjRI1ny9qVZMcxzUHGovfFwgLpwOiw==
X-Google-Smtp-Source: APiQypKk1DmfEag1YiQDBYstdXIav4zvgBMgw9ifVm2odjJfv0Mf1EY9dAO6N5XW/tmDCvEH/6ItkQ==
X-Received: by 2002:a17:902:728b:: with SMTP id d11mr5079252pll.32.1585868305771;
        Thu, 02 Apr 2020 15:58:25 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id w16sm4536373pfj.79.2020.04.02.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 15:58:24 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 1/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
Date:   Fri,  3 Apr 2020 04:28:07 +0530
Message-Id: <20200402225807.8603-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402225807.8603-1-shouryashukla.oo@gmail.com>
References: <20200402225807.8603-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'submodule--helper.c', the structures and macros for callbacks belonging
to any subcommand are named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
respectively.

This was an exception for the subcommand 'foreach' of the command
'submodule'. Rename the aforementioned structures and macros:
'struct cb_foreach' to 'struct foreach_cb' and 'CB_FOREACH_INIT'
to 'FOREACH_CB_INIT'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7d5996d3b3..a21e48730d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,19 +444,19 @@ static void for_each_listed_submodule(const struct module_list *list,
 		fn(list->entries[i], cb_data);
 }
 
-struct cb_foreach {
+struct foreach_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
 	int quiet;
 	int recursive;
 };
-#define CB_FOREACH_INIT { 0 }
+#define FOREACH_CB_INIT { 0 }
 
 static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 				       void *cb_data)
 {
-	struct cb_foreach *info = cb_data;
+	struct foreach_cb *info = cb_data;
 	const char *path = list_item->name;
 	const struct object_id *ce_oid = &list_item->oid;
 
@@ -557,7 +557,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
-	struct cb_foreach info = CB_FOREACH_INIT;
+	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 
-- 
2.20.1


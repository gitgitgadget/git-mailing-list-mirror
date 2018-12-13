Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B194B211B3
	for <e@80x24.org>; Thu, 13 Dec 2018 19:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeLMTC4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:02:56 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53826 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMTCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:02:54 -0500
Received: by mail-yb1-f201.google.com with SMTP id o196so1581592yba.20
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WBzdyxy4970kwSspUeRHxR8XE8KBYibhTtsIWTLhT/M=;
        b=W5X1pzAJRgZNgvg2OupiAjDVrJEbhCOly9rAdHd7c277k5CR5Wi3ledvVovr9G54EE
         mAGrWeTuOaqppQU0exQUemGGdmncQyVKrZJb7df00D49GVZCVEQi3Db2kE6Rq6CUs8HV
         5p+FGotdYQ1HDXhy3XBWh0+kgN0og59+atC8vk69F8q5xmqCdjc2rrj1BVShGYIN5nZt
         nwcuu3X06aHfwRr8xXlDsuK/xOUQc7c/mz3ZhSMqvy9h0i/jWRu3kxLZ82Ewm0li0VdQ
         H1+pWrAjQxjh7m3l7+0PVaCZwCfxOwWMTCFOIw+2k6i6NP7wDSgQYFhyVwVo+uHkliqA
         WYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WBzdyxy4970kwSspUeRHxR8XE8KBYibhTtsIWTLhT/M=;
        b=eKdcEWb/U29P60TIxsGzcCwAJJntD7A13qCLEyVHWCWuQ9VLu9k5hyAUx89eVQhqDB
         OUag08xnGhEkmwoxBNYaJGvrZUrQD2+CusZQDxFQQwGT7GOV1STtQYKxJ0eTWfYRgEZj
         4cxz+HAnKA450f8p12/oqPlXXsUSrOTmM/fgNIJ+F31I0VLtwFSwrAtNTXPRK5YxjoOL
         2PD02MrCwGFgQ4QLzg1gWIm9iLZcSjnVmBdNPeRGYjIPkUpYEiJNmVdy/QE0YYCsdckH
         +1RQNOurYUk3UuCEIJ3zQlQBvcp5fbEthYRUz3H32VHW2oDvTfRpHOuYAN2DxoVV23a4
         22PQ==
X-Gm-Message-State: AA+aEWaRziEl1vsJknFnP4L7vxxqFNNlhDsdkEVm4x1F4CZXkVoD2Rs5
        2DMbAEycimsXd9g9yFJn560ghTwNRBUj
X-Google-Smtp-Source: AFSGD/VOu+AqgOTg+lX1aBaHt8omKyT0mc6DzwiCg0Kf1q/QThi/otkMVvjjtve1h21pr0mnsEpV8RwFbO8Q
X-Received: by 2002:a25:be86:: with SMTP id i6-v6mr14739176ybk.40.1544727773352;
 Thu, 13 Dec 2018 11:02:53 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:02:48 -0800
In-Reply-To: <CAGZ79kYsk8YEUUhMVF9fBC++fop3CPyobXTgHTuF2Lgikf9CJA@mail.gmail.com>
Message-Id: <20181213190248.247083-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kYsk8YEUUhMVF9fBC++fop3CPyobXTgHTuF2Lgikf9CJA@mail.gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.230.gc28305e538
Subject: [PATCH] submodule update: run at most one fetch job unless otherwise set
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sjon@parse.nl
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

In a028a1930c (fetching submodules: respect `submodule.fetchJobs`
config option, 2016-02-29), we made sure to keep the default behavior
of a fetching at most one submodule at once when not setting the
newly introduced `submodule.fetchJobs` config.

This regressed in 90efe595c5 (builtin/submodule--helper: factor
out submodule updating, 2018-08-03). Fix it.

Reported-by: Sjon Hortensius <sjon@parse.nl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 +-
 t/t5526-fetch-submodules.sh | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..1f8a4a9d52 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1551,7 +1551,7 @@ struct submodule_update_clone {
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
-	NULL, 0, 0, 0, NULL, 0, 0, 0}
+	NULL, 0, 0, 0, NULL, 0, 0, 1}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba2..a0317556c6 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -524,6 +524,8 @@ test_expect_success 'fetching submodules respects parallel settings' '
 	git config fetch.recurseSubmodules true &&
 	(
 		cd downstream &&
+		GIT_TRACE=$(pwd)/trace.out git fetch &&
+		grep "1 tasks" trace.out &&
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
 		grep "7 tasks" trace.out &&
 		git config submodule.fetchJobs 8 &&
-- 
2.20.0.rc2.230.gc28305e538


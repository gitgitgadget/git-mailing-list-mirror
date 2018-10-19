Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF0B1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJTAT3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:19:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42744 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeJTAT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:19:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id j46-v6so38878330qtc.9
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RafJZrSVIwfb9lBFq8Y4u0oa5Ww9W19YFPsDy/lATdk=;
        b=IkOe6g7LB/SuDXnIZWtAsqCNx5ycYa6osV4G7adz248SsUYX1PbAtIT5lR3W96x8gy
         Nzy7/rpEOXINkT8695b9gTCJNSLs42tqnHefnJ/xmrAyrBwUVAo1Af2ejWI6s6mEX76s
         pHnQzbVsZfrjlIwHIFF9jY6aYG1iKQtEKwryUelDzd7cHlqTjUQCtBfbjqCq4OanKWF3
         mU0D9KGW14spobjykktEiqnOLNFVfYbt7DIvOX4FLlLkMuvUXXfN8hwQ/x2sfpXc6i63
         dnviDy2JWj1+hSRA+NDXmm8dUEuQXEsDrzpLOrTixcKzkHbGS4tpka0w7IoMa/QTpwqD
         8CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RafJZrSVIwfb9lBFq8Y4u0oa5Ww9W19YFPsDy/lATdk=;
        b=S7JDJ05iKyB9qHwUwqKgNY4BBTS3mnHMOP9UuXIdYReLHn17qYsuuu8GqMYxPIxMvi
         0LVMeighVk9Q6xm8f4HnO01U94i5W6zFalxZcnhqlyRwQycA6EHq/+kzazdCO6s/xAXw
         V8EqadVHw0xw04IwX+cLurOOkREZMdsDBHqGhn9oLLa3dOt0lJEghPonrnbX2CuXIz2B
         AgFIZYj1CNPseTh0hYbvaC05OiCyM+3KvL0xuCCtW90793yJXI2KqCf0H1dT45QhUORF
         B0rf3migv3w74fDzhsbEzFfT9WzBSdbPcbSVjaCyzVRLPyoSaklO2CEw77zFCpozsd55
         Ij0w==
X-Gm-Message-State: ABuFfoh/73lg/yoOGaz4jkxx5ZbIpfe9CudpGHaCC8/u+1jH7geZqsJw
        VTW5rh7LYKaNpwDiPtUw+qmnm78N5Po=
X-Google-Smtp-Source: ACcGV62UOnpM0uIp6kQFfFpKGqvgWvQl82zV3mh6paZMstKmUkiYs/XPQr7RaXiqVz7voLHg5vhgRw==
X-Received: by 2002:ac8:7287:: with SMTP id v7-v6mr34308002qto.126.1539965562653;
        Fri, 19 Oct 2018 09:12:42 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l27-v6sm3666485qkj.79.2018.10.19.09.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:12:41 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v2 3/3] reset: warn when refresh_index() takes more than 2 seconds
Date:   Fri, 19 Oct 2018 12:12:28 -0400
Message-Id: <20181019161228.17196-4-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181019161228.17196-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181019161228.17196-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

refresh_index() is done after a reset command as an optimization.  Because
it can be an expensive call, warn the user if it takes more than 2 seconds
and tell them how to avoid it using the --quiet command line option or
reset.quiet config setting.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/reset.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 3b43aee544..d95a27d52e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,8 @@
 #include "submodule.h"
 #include "submodule-config.h"
 
+#define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
+
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
@@ -376,9 +378,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
-			if (!quiet && get_git_work_tree())
+			if (!quiet && get_git_work_tree()) {
+				uint64_t t_begin, t_delta_in_ms;
+
+				t_begin = getnanotime();
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
+				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
+				if (t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
+						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
+						"to make this the default."), t_delta_in_ms / 1000.0);
+				}
+			}
 		} else {
 			int err = reset_index(&oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-- 
2.18.0.windows.1


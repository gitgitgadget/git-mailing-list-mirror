Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C4E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 23:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376194AbdD1Xy2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 19:54:28 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36362 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753520AbdD1XyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 19:54:17 -0400
Received: by mail-pg0-f53.google.com with SMTP id t7so21628233pgt.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBxn/arHwXW26v733qef7NJQKH5YBSdvTPhVDSk/sRk=;
        b=MPsFytrpZ86AtkNVprKnDr2BZZNX6sFzDci/wVUYLFDSeaLLL7LS0nURAuR+J277sS
         Q/2zBW2IFehQn3muRLCdd3zFIWfc3XVm61nncBTDISa9Y2jUIzvtU6Uc0HOVD9b64YnC
         qySOlbt2PDOrjBVpvN6F9E9GbjJ7/DDnCY6GxUEUgfTivaWFo90/XvDKq6F81Y6rUNfa
         o3czYJULaY+YnXrRzezR6GbPh4Yf/G2j3sA8JpsUBy/RHjlSveTVHcRbtHoCqOWY8REy
         Wr55PrLEpmQXSlvmn4t9XUrp1xfVN6ESuS2JWmDOmqyJss1V1sKD7/QCWtcQZoBzIpfv
         RXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBxn/arHwXW26v733qef7NJQKH5YBSdvTPhVDSk/sRk=;
        b=sw0G3LpTpDzeaoPXjJY74J5AO0kbJGH0xiiuRcDzZewre52ZQb8AjysuZyxxyHoDgk
         WT0aGKrKdZQrBkSV9gEaRK1dNVwdIE7qIpt/q8jJQolzeniQOVht2z/z/Ek2A0BaCkgl
         fKksQgX3bFHvalrlmYxvjciI7ufd8v54zaOEPuBXtGBRab04s+B7dfwc+iAZJQgtiVNs
         n+JLTfn4C7bPaAaTUX+9ziJfAwaIOSkhsmBW/0iGggqVmkLR1Lvd0ZTCpSS7DmYz/O3L
         8wjPHrvtd4aSbOrkOvLuNvTwKsLkcuiHx0NJCwqocLl/NWsYHV38tsU8jeZzSqHE3sjL
         4pwQ==
X-Gm-Message-State: AN3rC/7Y9X29MNQCkxa9xLSwkQYpGm/VuiCyRhiIdxsSdXbsA+Bd0xeo
        h17aALh0aJmdFiT0Dzi/6Q==
X-Received: by 10.98.63.220 with SMTP id z89mr14586809pfj.129.1493423656490;
        Fri, 28 Apr 2017 16:54:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 188sm5332429pfu.15.2017.04.28.16.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Apr 2017 16:54:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 4/6] submodule: change string_list changed_submodule_paths
Date:   Fri, 28 Apr 2017 16:54:00 -0700
Message-Id: <20170428235402.162251-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170428235402.162251-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eliminate a call to 'xstrdup()' by changing the string_list
'changed_submodule_paths' to duplicated strings added to it.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7baa28ae0..3bcf44521 100644
--- a/submodule.c
+++ b/submodule.c
@@ -20,7 +20,7 @@
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int parallel_jobs = 1;
-static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
+static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
@@ -939,7 +939,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 			struct string_list_item *path;
 			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
 			if (!path && !is_submodule_commit_present(p->two->path, p->two->oid.hash))
-				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
+				string_list_append(&changed_submodule_paths, p->two->path);
 		} else {
 			/* Submodule is new or was moved here */
 			/* NEEDSWORK: When the .git directories of submodules
-- 
2.13.0.rc0.306.g87b477812d-goog


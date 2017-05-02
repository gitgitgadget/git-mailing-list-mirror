Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567AD207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdEBBDD (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:03:03 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33863 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdEBBDB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:03:01 -0400
Received: by mail-pg0-f43.google.com with SMTP id v1so52294436pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eieQFLCgi8H1ODAjf+8ElCkQN8LBgMVRzh3rJfkYYEg=;
        b=puorbK9SXCLYoJ3O5vlhVRxR7r4J5EOuck+N/gbYUgUI+bemq9TAsEUsQJz50r/sYj
         VZLo4aN6EjjOGuuhfk3CnFir1kc3y/n2mgtV5qUJoLll/WKVHrvo+coZblrdcyKCsoVr
         cgnS61UN9GSBsa8trxUjuZdhAX+vgHMTGaBC176cFZrEHlLHWXLxe+cdSPkzfv2gEUSI
         3czV+pJ2EofEiu/IkXfd4vQikh2fg3BwxN7jOdKnoW4x9TRBI5CKY3M6pNOSZJv2UJAP
         HWCqKGQ3sKJJWeebxSr2hzIUww5q7DRqoPo8V2GekZ7fhbiI20ATtCFcq9nJNOd5838a
         pJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eieQFLCgi8H1ODAjf+8ElCkQN8LBgMVRzh3rJfkYYEg=;
        b=R/pc5e9eB7M4jl/GzE6sqgCtJoCyCsmwrwfYBsl8eE7Jn1hmT/++Sgv2l0+MjBPETS
         dz039RxGGf65lKrNG5euDhbtS4OgGTVGP1l6V/id764NX8MiBLBQ7rnwAo6XpscEY4uL
         wIHRKGucwJNtvaiZJ+VVNfGp4lTOS8+lVKEJ7qhBX045+5QVc5sKRY2HB/jlpkqvuZzr
         z6XsuQufrRIPbi2J55tgGXIAztZOVqs6JHs2HUEKDwnmmvrdAbgMnwpqh6CQoj87pZxQ
         DJCTUKZETmahNOaw30zA6ata7CDynGyFsNs9GaGq9Sr/zs8DPN1I3HruSzY5UfvudRTu
         ssfA==
X-Gm-Message-State: AN3rC/4AR2rINreg0PP+3+Poh1NcWsrxzWhylk5LqogIoBefrrf6jEuS
        sTjnRgotlLXVOVJE
X-Received: by 10.98.63.85 with SMTP id m82mr29350949pfa.143.1493686970800;
        Mon, 01 May 2017 18:02:50 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm13532526pfa.56.2017.05.01.18.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:02:49 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 4/6] submodule: change string_list changed_submodule_paths
Date:   Mon,  1 May 2017 18:02:37 -0700
Message-Id: <20170502010239.179369-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170502010239.179369-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eliminate a call to 'xstrdup()' by changing the string_list
'changed_submodule_paths' to duplicated strings added to it.

Change-Id: Id4b53837a6e209c0c0837c9f5ba06c70df2ffe06
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
2.13.0.rc1.294.g07d810a77f-goog


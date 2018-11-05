Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E961F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbeKFEtN (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:49:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35977 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbeKFEtN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:49:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so16905831qkf.3
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gAED6Bi/iY7vFn8v9iKKEWsskINknLSWXlQqAe0ueao=;
        b=o+zNuE46wtmDj/JNVuF8Pfh3v7JZxXaM4tzTmBTXuxwYr+xhhnDOo3mnheW2VzXg+D
         kVKo8T3v81R10wSHl8u4HzS+dvO/5hvOm+USnjPsPumvpASegJmO9XlfCUeiedBGqZbY
         NEeBvKONqrqE9wq2GPC3hVYuuzs8X9ZXwn2t1iytdzJzabFkmQGCNztywPO4airQmUvz
         R0Mj+DWQPExYCQpVjP3dw+4iEnpMuN9mTKMLAIY9oTiKesqfZvpDLT+DhTEZmEa0YGpF
         aKyQLcQiV6lmbHobgRc6M4FDE2csnV/ppkxXS2LCQMlvAs4TDNbQpA8diyLTbQg+rxRx
         oRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gAED6Bi/iY7vFn8v9iKKEWsskINknLSWXlQqAe0ueao=;
        b=duzSlCf+5dUadj760zTNDTJipqYoztK2mbGCCvm2yQWAhHR0tLpaio+eQhI+GAnxRS
         MsRdtkHtK2Bh9XwpVlVUncYMuVLojci/cFDZ8HZhomIODdL4YY83qckWfXN5NMpg6+AM
         grNGCYZKNFQ/9Q1smOoCz27CWbYvQK+JWVx8Gt2EE998VmdO+zdKVRiJSskDiO2/03Dx
         yIKgMQ8g7IGwNyrHpJbdB4dRQXDMMWTr+vLqJByVdriI6Wh1tVYDkl2bOI+iVPRXchML
         z18XETCJL8Ka/znZb+QN385DBOK0nEQo9Mz6gM14XMaPVKpnZX3o7qLWABChGlTSqnZ6
         6Xhg==
X-Gm-Message-State: AGRZ1gIxUkbk6ofQ+f96dfj3Eh5aBPuHLZW+et8u543SvMtftNA3UWcC
        PnjDaNdW7wqFenpsgtd4QazfrhfT
X-Google-Smtp-Source: AJdET5c49Nc9N1fEvgo/Ks5sDq6CGG7ICd+UbC0Vv4qC9Xiab2XDRp4a67fu7xghNdfsoH6GfQZcoQ==
X-Received: by 2002:a0c:8aa8:: with SMTP id 37mr22631256qvv.23.1541446081366;
        Mon, 05 Nov 2018 11:28:01 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w201sm4469678qkw.11.2018.11.05.11.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:28:00 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com
Subject: [PATCH v1] refresh_index: remove unnecessary calls to preload_index()
Date:   Mon,  5 Nov 2018 14:27:51 -0500
Message-Id: <20181105192751.11948-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

With refresh_index() learning to utilize preload_index() to speed up its
operation there is no longer any benefit to having the caller preload the
index first. Remove those unneeded calls by calling read_index() instead of
the preload variant.

There is no measurable performance impact of this patch - the 2nd call to
preload_index() bails out quickly but there is no reason to call it twice.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref:
    Web-Diff: https://github.com/benpeart/git/commit/384f7fed53
    Checkout: git fetch https://github.com/benpeart/git no-index-preload-v1 && git checkout 384f7fed53

 builtin/commit.c       | 2 +-
 builtin/describe.c     | 2 +-
 builtin/update-index.c | 2 +-
 sequencer.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 074bd9a551..96d336ec3d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1363,7 +1363,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (status_format != STATUS_FORMAT_PORCELAIN &&
 	    status_format != STATUS_FORMAT_PORCELAIN_V2)
 		progress_flag = REFRESH_PROGRESS;
-	read_index_preload(&the_index, &s.pathspec, progress_flag);
+	read_index(&the_index);
 	refresh_index(&the_index,
 		      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
 		      &s.pathspec, NULL, NULL);
diff --git a/builtin/describe.c b/builtin/describe.c
index c48c34e866..cc118448ee 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -629,7 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			struct argv_array args = ARGV_ARRAY_INIT;
 			int fd, result;
 
-			read_cache_preload(NULL);
+			read_cache();
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
 			fd = hold_locked_index(&index_lock, 0);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 07c10bcb7d..0e1dcf0438 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -782,7 +782,7 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
-	read_cache_preload(NULL);
+	read_cache();
 	*o->has_errors |= refresh_cache(o->flags | flag);
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..ab2048ac3a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1919,7 +1919,7 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 {
 	struct lock_file index_lock = LOCK_INIT;
 	int index_fd = hold_locked_index(&index_lock, 0);
-	if (read_index_preload(&the_index, NULL, 0) < 0) {
+	if (read_index(&the_index) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
 			_(action_name(opts)));

base-commit: 095c8dc8c2a9d61783dbae79a7f6e8d80092696f
-- 
2.18.0.windows.1


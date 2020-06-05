Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989D9C433E1
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5E52075B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+JhEtwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFENAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFENAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC32C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so9672855wrv.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=52m4I66oRxjVjq1V7trVOCeeZbpnpnqW3DPNXYyiuJY=;
        b=t+JhEtwGQ62uAj8DNi0dKZbdOyjgePP1LHLefKhaqNs/V8YXIUOCKKZXuTmvh8opG9
         LQNHGQiA7lXe8QeCK/N7u2QyC+tDWDeyZNo+i84L9BC5WqhhbZxreY6HtjPEXUNIp+dB
         bXzTUWKEbp856+vTQWqZiEx17jL0iVDcK3x5P+qKf/IFbYsLiMmaFvAIwazUjzQ0MUOt
         eVOzerOb+5gEEBy28icjncfCoY/6ZHJkFDSTWY0u+nAECx8Q0TiqSJ+R2WTBQEz1GwiH
         5ohDvvXGmSuU/nvQPdtdbPBDn3CZBmbeSvdfXrKAkKqwFcabdRWouYtTaDc9XkNIBtfl
         gJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=52m4I66oRxjVjq1V7trVOCeeZbpnpnqW3DPNXYyiuJY=;
        b=bC1/OmWECTLcPUMwh4t5/X4cyQ5QC5CMC0TyL8ZtROsbMzh0DQDtabCLyV+IJIEmli
         Ds0QfjDQcRBfaiPTf+2O9SYxOH2hyrvsxIuPRpT2KcAPUvtrD8JSgF7kgA5YTQbM78UJ
         H0DowTV14msUOodjCmilJOYeNeBsn21GiXQwMJZdJqy+d2Kk92rtVSawjKh7yR2bS/t5
         lDSc3MZRNLy7y8ZsAAW3fSoec75zqgnN90X8INZyv/W88cSvf4kCbWrS/WC9Zo6ntU7s
         lsqFwEFB9vYMd8j+UYqafuwjsLsCSq8NzA15+bEBhVPZYsL2uN/WGn0iD3QTKQmTqZvi
         tpzg==
X-Gm-Message-State: AOAM533XjOramgwXfwhr0BirkhN9Z/SowzALUBg0xg4t4FV5Bpn0MLlE
        17P7SSprNynHrnhRyUrqt6WH6A8E
X-Google-Smtp-Source: ABdhPJxezhEEml6Izw44YZNkZegsmVm0rSxLklYF25bpeFRMqRIg5PVMVmpV1gsH6p0FtReb/ZRoUw==
X-Received: by 2002:adf:9507:: with SMTP id 7mr9449716wrs.63.1591362041573;
        Fri, 05 Jun 2020 06:00:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c65sm11712295wme.8.2020.06.05.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:40 -0700 (PDT)
Message-Id: <636c20696592cc8f3ed6d300daa13f51cab360d7.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:28 +0000
Subject: [PATCH 06/10] commit-graph: clean up #includes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Our CodingGuidelines says that it's sufficient to include one of
'git-compat-util.h' and 'cache.h', but both 'commit-graph.c' and
'commit-graph.h' include both.  Let's include only 'git-compat-util.h'
to loose a bunch of unnecessary dependencies; but include 'hash.h',
because 'commit-graph.h' does require the definition of 'struct
object_id'.

'commit-graph.h' explicitly includes 'repository.h' and
'string-list.h', but only needs the declaration of a few structs from
them.  Drop these includes and forward-declare the necessary structs
instead.

'commit-graph.c' includes 'dir.h', but doesn't actually use anything
from there, so let's drop that #include as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 4 +---
 commit-graph.h | 6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7807d945626..6ed649388d6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,7 +1,5 @@
-#include "cache.h"
-#include "config.h"
-#include "dir.h"
 #include "git-compat-util.h"
+#include "config.h"
 #include "lockfile.h"
 #include "pack.h"
 #include "packfile.h"
diff --git a/commit-graph.h b/commit-graph.h
index 39484482cc1..881c9b46e57 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -2,9 +2,6 @@
 #define COMMIT_GRAPH_H
 
 #include "git-compat-util.h"
-#include "repository.h"
-#include "string-list.h"
-#include "cache.h"
 #include "object-store.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
@@ -22,6 +19,9 @@ void git_test_write_commit_graph_or_die(void);
 
 struct commit;
 struct bloom_filter_settings;
+struct repository;
+struct raw_object_store;
+struct string_list;
 
 char *get_commit_graph_filename(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
-- 
gitgitgadget


Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26D7C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D089420723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJeqO5FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgE2IvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgE2IvH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B51C08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so2486757wru.12
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKOEwdMcEgkOfkRknqVUn547aOdqsfbOFi4pIQH+8ng=;
        b=eJeqO5FPGkr/X8z31/o1udXxlqB657ZUzdropdRrlzmBPPIpTtXPNvFUlhtIJ0SuJv
         5Mi2L4IgQXIbLjlPgwmYxYWr1WVUpleYs+6RNr/P6odQMyTxxWGMLQO2CMNO73FdYmT5
         4NFGSag11yOQ9aBMJqQ1tGvLfTIsrVR8iapdd28bGdewoK2KzwdK50TUUtK97fxznVM4
         KFy41cHMSesHN+aq8HyDTCTbHXWKF0BH0NHgzHY3bTXRNojZf0bTmVSCdZfcegHAajAE
         ItGqjcWvHV42+PAZjNwIsDAjD20sSb5Wim+/ZUsb2qQJ9BYuUIbuvFDKAKJ1oW+ykBw/
         HXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKOEwdMcEgkOfkRknqVUn547aOdqsfbOFi4pIQH+8ng=;
        b=gQKj8UqPtBC9qsqmj0TvtCvUFWScpu6tNvqXkxMs8AGcw5cBvC0fENXwC37Yc7LzVx
         3ROI7x6/9y85HXRcuUgvXNh0WNZzes/UcbG1B0Gx5O1+AwMyaQ258fQy53IP7ibtX69a
         5+6bZHgwyjmngcL5JaG7G8j955yW4oKrvugHk8VDxAx75SejLJ0SxNaGFAgM2MsPrZEB
         NlYPTkIYBVSykD25lwUS0oS9RGtL3Ml0GH20HhwcLu3/+xkCHMqNAd+5emfDOK6MNM/A
         AO9I95H4GPnkvGLkzg13stz67rVbO6vtj59iieEiynaVXlVRQYWsiZODHgFn9VhYbP5p
         23Pw==
X-Gm-Message-State: AOAM532e/t2WC9s5Ryd/OiaN9UBbx21mvCkOkKGRho09p0myQ4XMR9sp
        LESZSks9FV+AkTI90+asjvFlTqmo
X-Google-Smtp-Source: ABdhPJyAHe5tGb8mHfbFP2sPt9U32RwYH9ENd4IfkPoopun/c2jfhhh2efi0nTa9cTri6lJktEo4YQ==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr8209659wrv.392.1590742265470;
        Fri, 29 May 2020 01:51:05 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/34] commit-graph: clean up #includes
Date:   Fri, 29 May 2020 10:50:10 +0200
Message-Id: <20200529085038.26008-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 commit-graph.c | 4 +---
 commit-graph.h | 7 ++++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 12df74c925..f5ba8a9578 100644
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
index 7f5c933fa2..847cd25cfc 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -2,14 +2,15 @@
 #define COMMIT_GRAPH_H
 
 #include "git-compat-util.h"
-#include "repository.h"
-#include "string-list.h"
-#include "cache.h"
+#include "hash.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 
 struct commit;
+struct repository;
+struct raw_object_store;
+struct string_list;
 
 char *get_commit_graph_filename(const char *obj_dir);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
-- 
2.27.0.rc1.431.g5c813f95dc


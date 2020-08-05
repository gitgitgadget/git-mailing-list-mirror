Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC642C433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF2720842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQG4ZqR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHEBVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgHEBVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:21:03 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D61C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:21:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h5so30023033pgq.4
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V6HJ8a80+gSNHl9U79xv02mGKNkVnr97q8RY6TaYSrA=;
        b=IQG4ZqR9Rt8tgf4UqK/YRDzMlbyzQEqGGsfy1KyZcU6lbusShRFy4GTQEWbAn8kWZA
         e6d6HkY2Jhyq7rtb6jb6UHUK6wdDap4TFKIBqU4sTHiuWvf81nf5vRSyG73ZgIqaVQtE
         MZ75x+AJFj1WsfeWIp+P1M5y+UbZnkfgx33XXTlo+3vKyktwbECL4aoLQ5UejOunb9LH
         a7Dr4wd3/aqZCtxj/C5THcu7Hir1i6Mm7GZagTcw1zGZLRsoSead2l4FV31IfhneHYbR
         PNgD+9s5/Mix75uFc+DtxSVgzQhECxojHHZLlf6UvVK6SlWyLYZ1rKrAyf5Cr1fTJvEu
         +5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V6HJ8a80+gSNHl9U79xv02mGKNkVnr97q8RY6TaYSrA=;
        b=bGzqu8VtRvSE7B4xyh7tt3e8LhTZ4CRRMtN361gWuD4AJE3iEEPWMZupSTwtPpJIUl
         G63SdXEDbEUSykRcgADyVMwjrWkLOMi7nQJwerNYemF53uaohH3QwPvuFfIbdaoevPgS
         ueJkQDPxN6EnqKL/+qgEfNlYdNEBoEYNt57I21thydnm7aROHeQsPQjUEO9/pAVCK5f3
         9min0RIwQa5xdtMXYKccwzunQGBBr2W2kJa906oP15QCl+akk+Jx6Afg1SxzW3LTcFNY
         ysupSDHW6Pe7IY0u0xOSg7/kWYJ3/bJVlWDLrf1RLYzhbAunzkNILCLodV1NE+iOCHB3
         1cTw==
X-Gm-Message-State: AOAM532/pIzfYCNA/wjFuzMiCfYBFKdkBxlbVA/yotjCUHmmbC4H8i6K
        elNvJYQOH4qhfS3637EMJLK/LiGiStb5sL9SZOCxY2yuITVpv5I0hyGmwsehpYPwa+bjZkmwbJT
        q4/5I1rq/1myTVYnzsGdQqbfMyUV9jsV1O/xheMYzGi8FYrsX8PVWifzkU8D4lq6E9/x5dIv8RX
        ji
X-Google-Smtp-Source: ABdhPJz5OC321/K8bBFtFeWKEK/gPOE50jNkbuPi0PHbQoVt/RoQwx9kyvPZXSBJBJCxNHrp6v6U0NmUeAQ8qePHEvb+
X-Received: by 2002:a17:902:7fcb:: with SMTP id t11mr908084plb.266.1596590462285;
 Tue, 04 Aug 2020 18:21:02 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:47 -0700
In-Reply-To: <cover.1596590295.git.jonathantanmy@google.com>
Message-Id: <9ebcc5808a21e1f87370b6c18ea28168e63d4e3a.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1596590295.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 4/7] fetch: --stdin
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3ccf69753f..a5498646bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -80,6 +80,7 @@ static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 static int fetch_write_commit_graph = -1;
+static int stdin_refspecs = 0;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -209,6 +210,8 @@ static struct option builtin_fetch_options[] = {
 		 N_("check for forced-updates on all updated branches")),
 	OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
 		 N_("write the commit-graph after fetching")),
+	OPT_BOOL(0, "stdin", &stdin_refspecs,
+		 N_("accept refspecs from stdin")),
 	OPT_END()
 };
 
@@ -1684,7 +1687,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	return;
 }
 
-static int fetch_one(struct remote *remote, int argc, const char **argv, int prune_tags_ok)
+static int fetch_one(struct remote *remote, int argc, const char **argv,
+		     int prune_tags_ok, int use_stdin_refspecs)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
 	int i;
@@ -1741,6 +1745,13 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 		}
 	}
 
+	if (use_stdin_refspecs) {
+		struct strbuf line = STRBUF_INIT;
+		while (strbuf_getline_lf(&line, stdin) != EOF)
+			refspec_append(&rs, line.buf);
+		strbuf_release(&line);
+	}
+
 	if (server_options.nr)
 		gtransport->server_options = &server_options;
 
@@ -1841,7 +1852,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (remote) {
 		if (filter_options.choice || has_promisor_remote())
 			fetch_one_setup_partial(remote);
-		result = fetch_one(remote, argc, argv, prune_tags_ok);
+		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs);
 	} else {
 		int max_children = max_jobs;
 
@@ -1849,6 +1860,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			die(_("--filter can only be used with the remote "
 			      "configured in extensions.partialclone"));
 
+		if (stdin_refspecs)
+			die(_("--stdin can only be used when fetching "
+			      "from one remote"));
+
 		if (max_children < 0)
 			max_children = fetch_parallel_config;
 
-- 
2.28.0.163.g6104cc2f0b6-goog


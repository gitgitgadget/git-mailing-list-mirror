Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A2C433E1
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43173206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lz2ZOpxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHKWwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKWwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 18:52:32 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B8C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:32 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id bg5so336358plb.18
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Kat1I1RCRdoIRw/u2zLFnXz4xICtec5tGi3//jdxym4=;
        b=Lz2ZOpxiiXkDGC1eONA4HBlCQStMSX/dKIuklvD8v3JnbmyN9Zo2/RS2TarmjN9CZK
         f7L8+aOgk3extpAjEEEZB5DBoNSIPwXG7IDZHiPKuEvtl9d+ehVultMdnoIrH7yz2bYr
         o5NHDhLVj0XL8saUEXFJBJ+vrgJMsZmjaWy7Lm90h8Fj9uOHn795v1mD+LFfmTlP4RFq
         FaKgmtGGw0Urv8Ol0CP8UbQryEslZ8fio+vNRvrc33l2h3HMh4/o7ljNRFlB9MyTNAx/
         wVPcnslh+CQ61vlTJcybtCooMFac8ZkxnO1UTNb0z4Ka8tzD99cZgO6FGNnj8A1GmcKm
         3a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Kat1I1RCRdoIRw/u2zLFnXz4xICtec5tGi3//jdxym4=;
        b=SgHYCP09w7zsL285OUGOfkAW9U/uUAzApB8BkrwTDhCvSZ7c85rlwzYr8sqeVGedRG
         QKBV0MJeGolXd0KdC2U40VY+oOwZH9E1wmcymYp6zjwJ6/+JfMlg85PhhWVd22KLAFSg
         s6SR9QGf8PUvT9UYIkoLElFS0V1nnEAEFBOY6sG9mKsVAJ7s6RBoSAGJRRX/6WF+I+2X
         3ERmSTTm1rRkeEwZ4Z3LZXBFH5Dk5n/67hsvOr4LA4XZNhCjHKbRcum8HaV4YjQa7bH2
         fmgFDAq6g55njuXuZMuSi4wh44h0BGqqgW6kz3fIYjUH/DaC9sE14s3btg76scmxl0cm
         XBAQ==
X-Gm-Message-State: AOAM530p4JaLR4Y0615MdIgEZgi6te0PSxUZpukcWbGW9IjTpiPwuzyE
        6Z7vj0PsfkuJ1yIGmnv61ZMn3T+xVs/N5Xfpf0giLjdXIyI+0C7Gos5KQLdD21+zl3MNkiJ3zhz
        7qnh4LdLG3hYwh53CDasPi3q4+rrYiaHmEku87Vb0xxGNxzPZXEK23Qn6B3vgXsOZawWHzfL3YS
        cw
X-Google-Smtp-Source: ABdhPJzyqZI2FBbrdm3plG1I6B6Tjyk8OJHICFSkMtb8yJe/1xCELsfb07vHEb+qwVMDR0Gg2pS50EzZ5VAkKiIcECDY
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr341034pjb.1.1597186351532;
 Tue, 11 Aug 2020 15:52:31 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:52:17 -0700
In-Reply-To: <cover.1597184948.git.jonathantanmy@google.com>
Message-Id: <00ad7dd875d8a6754c0ccf6f2789cec27aaa1d1d.1597184949.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597184948.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 2/7] fetch: allow refspecs specified through stdin
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent patch, partial clones will be taught to fetch missing
objects using a "git fetch" subprocess. Because the number of objects
fetched may be too numerous to fit on the command line, teach "fetch" to
accept refspecs passed through stdin.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-fetch.txt |  4 ++++
 builtin/fetch.c             | 19 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 45b6d8e633..9067c2079e 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -48,6 +48,10 @@ include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
 
+--stdin::
+	Read refspecs, one per line, from stdin in addition to those provided
+	as arguments. The "tag <name>" format is not supported.
+
 include::urls-remotes.txt[]
 
 
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
2.28.0.236.gb10cc79966-goog


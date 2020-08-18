Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29233C433E3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6982072A
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4V6FTLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHREBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHREBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 00:01:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF8C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:54 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 4so12044658pfd.23
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KMR/f/lp74dQGVAR9jgtjWRJABwbGdpjUZiaHz1Lz3s=;
        b=n4V6FTLDWlxhMvNy4eu2M02H47UALIXfKTy5tSxKFJI9DkUpwaRUqylNgHimwCvfla
         1F14eyUvIW/SUKVvPlFQHF94UFBBU9BLO6uG9H9rmaYGKfqW/8NKP21GwTPCtAlq4NU3
         BcJ7g5Hl62gPFhK5vh4CD32zbpt5Mjd6hM/h6xSRTNhxhPzoUHxceA7Ttp8k9ZfA2quU
         39LVMzMFU6BvFIsTTY6/zFpXCrzFHwGf/NwFNDom7Mxv1TFk62hvkgGF6sVdvQUZWZ1A
         0BJW0oWi65jUngO+BmTmTJacOVLVqURK4vH4YBf/2UnGBgC3sosS+b+vmU3FKic88r/J
         oLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KMR/f/lp74dQGVAR9jgtjWRJABwbGdpjUZiaHz1Lz3s=;
        b=Am4LDVs4uFuxXufrWjd2LCq02NeB18ud4rPuilGAK2uLc/XoU3BnUb1PspuDmTRzUW
         4z+0nkWXa3FTu8ELA3tUIzVL49GdzahxcuiSrq2hDsEPDBvADWlGCMeHLm9i9gR6OlBT
         3aCin9vgghj4YTBw2WyDxV4eMQ4LH5hQm7SfwiAZUeAMt11I3/ZP4fME/ZSSDEa8YVhe
         JRbh48uo+RJxCdpZq3n1Brm/POECx+TD9InQvv99jv2e0bMwWPFupc4l/a3phuTIi/yE
         RHfmsnY+v4hNFtsoyJrNM6iTKod5kv6HorYX177Y6YDK1K//aNsXcbRJpJvT7d3uQ7ha
         NARg==
X-Gm-Message-State: AOAM530HtkHJvW+/qHMyWh3KrTtsiWcXnWuX1XjRrTBQ6POfNhGBHC0s
        M9gQiOGa63SPk2TNrOAPEQfkAkxmrWIxMvOdCavGf8TIOoxehmhLc/cgeyfSj5yeAeTNP1VOry/
        KcL8+VeSTIQxcKUjncEbqBCGRbxUDKG9LrF9wHlN3bsEDdTByaGvdt2Kl0W8E6+m30T9i1t/6Au
        7Y
X-Google-Smtp-Source: ABdhPJzGlmvgGneVpiAty2O1NXjAlWlVcYkPRivSRAwNL1Pgum/D9NYZGyXBOLAkQIht6rk0EJw9C8oN1XmdoR45qbkR
X-Received: by 2002:a17:90a:7485:: with SMTP id p5mr9120979pjk.130.1597723313379;
 Mon, 17 Aug 2020 21:01:53 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:01:32 -0700
In-Reply-To: <cover.1597722941.git.jonathantanmy@google.com>
Message-Id: <9f277f1631a37785dcd72a552dd86738d639ea59.1597722942.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597722941.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 2/7] fetch: allow refspecs specified through stdin
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
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
2.28.0.220.ged08abb693-goog


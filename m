Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C581C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiBAPuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiBAPuA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 10:50:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825ADC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 07:50:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m26so6788917wms.0
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vJ92QZXSdrobOwnnBOpWJBUeIZCC5srFtX7SIQlEyV8=;
        b=NbC9dZXwE67LpxZuUKmpsayTefiXCy0CioUydERUEnL/fjNm7bUdbCDG3SRJChZPRU
         tkBtqXTrjIt3smkTFbV4qnXLcUNeWL6Mg4JKAB8epIkWEhJZFA8Q8v4cQY7nPFHVKCK3
         IywFQaa1JoJsw1elmBUALpteWysUhy35HPiCikr+nH25A+Dhkvn6ogEVDkSHGuwNbek4
         5KRwPUfhABRuxlGGL0sDdN/ZAMIS0GZh4x6MEnanEHGfL7tv0ULm7S+dJTEkc/wq4mlB
         p2tRp/i9XOnCEmTBNl3TGWUyGZBtxaWWWXrJAe5qC8YTf6DUdBP77FU2YnO7AkEuLX/5
         mvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vJ92QZXSdrobOwnnBOpWJBUeIZCC5srFtX7SIQlEyV8=;
        b=1w/wmWxtl9GlTW7dG+llNpFiHbmKiFkYzHAgcyxMlI2qz5f/qU5wPzH2qCfQoeDT0q
         9Z3ELTP7+PdkNGeLI1dWPlPw0zove7gJALF2J2upiNsLSN+AXhxe5UE/JooxvF3uBYqy
         CmFI9s89v3AXvrzvxKzt8wxrAQukLsHpdXOGV5NS1S9IUqXALb1NdvKAuqNoqfP9u3co
         6A0C92MP7+C40yRvCcQrAiDJx9zgncG7bEnZ1r+ev2RudG9wRVhWbKuaL9stFeM1M88Y
         lUYXNeoSuDoM+oKS6xUsNXUHdjixYoD/DUTiFm6eJa0sNpTnnmlPwaW+detdcHP8U2yk
         9pbQ==
X-Gm-Message-State: AOAM531a0Tc/VQLAPRBtDogtzGLvw1rzmfgY/5uzua+DGc21mORw5li2
        1/yKUgc1Dq/NH3VGt03r3QvSeH+ZE2c=
X-Google-Smtp-Source: ABdhPJysTFyYSkJSVDytuTF9VTNYbVdEznY6f+MwsPA62/pcprDbijJoSIs0g5+9+LKDx/D7PtUvdA==
X-Received: by 2002:a05:600c:3217:: with SMTP id r23mr2281165wmp.159.1643730598936;
        Tue, 01 Feb 2022 07:49:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm1307555wrt.102.2022.02.01.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:49:58 -0800 (PST)
Message-Id: <3e102724196eb2b7e2336aeb5265b76999e78e2e.1643730593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 15:49:51 +0000
Subject: [PATCH 4/6] fetch: add --refilter option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Teach fetch and transports the --refilter option to force a full fetch
when applying a new filter.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/fetch-options.txt |  9 +++++++++
 builtin/fetch.c                 | 18 +++++++++++++++++-
 transport-helper.c              |  3 +++
 transport.c                     |  4 ++++
 transport.h                     |  4 ++++
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e967ff1874c..004078bfea9 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -162,6 +162,15 @@ endif::git-pull[]
 	behavior for a remote may be specified with the remote.<name>.tagOpt
 	setting. See linkgit:git-config[1].
 
+ifndef::git-pull[]
+--refilter::
+	Reapply a partial clone filter from configuration or `--filter=`, such
+	as when the filter definition has changed. Instead of negotiating with
+	the server to avoid transferring commits and associated objects that are
+	already present locally, this option fetches all objects that match the
+	filter.
+endif::git-pull[]
+
 --refmap=<refspec>::
 	When fetching refs listed on the command line, use the
 	specified refspec (can be given more than once) to map the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e9..1dec90fb25f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -59,7 +59,7 @@ static int prune_tags = -1; /* unspecified */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
 static int write_fetch_head = 1;
-static int verbosity, deepen_relative, set_upstream;
+static int verbosity, deepen_relative, set_upstream, refilter;
 static int progress = -1;
 static int enable_auto_gc = 1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
@@ -189,6 +189,9 @@ static struct option builtin_fetch_options[] = {
 	OPT_SET_INT_F(0, "unshallow", &unshallow,
 		      N_("convert to a complete repository"),
 		      1, PARSE_OPT_NONEG),
+	OPT_SET_INT_F(0, "refilter", &refilter,
+		      N_("re-fetch with a modified filter"),
+		      1, PARSE_OPT_NONEG),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	OPT_CALLBACK_F(0, "recurse-submodules-default",
@@ -1292,6 +1295,17 @@ static int check_exist_and_connected(struct ref *ref_map)
 	if (deepen)
 		return -1;
 
+	/*
+	 * Similarly, if we need to refilter a partial clone we already have
+	 * these commits reachable.  Running rev-list here will return with
+	 * a good (0) exit status and we'll bypass the fetch that we
+	 * really need to perform.  Claiming failure now will ensure
+	 * we perform the network exchange to reapply the filter.
+	 */
+	if (refilter)
+		return -1;
+
+
 	/*
 	 * check_connected() allows objects to merely be promised, but
 	 * we need all direct targets to exist.
@@ -1487,6 +1501,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (refilter)
+		set_option(transport, TRANS_OPT_REFILTER, "yes");
 	if (filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&filter_options);
diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986c..3cab1ccc8d5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -715,6 +715,9 @@ static int fetch_refs(struct transport *transport,
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
+	if (data->transport_options.refilter)
+		set_helper_option(transport, "refilter", "true");
+
 	if (data->transport_options.filter_options.choice) {
 		const char *spec = expand_list_objects_filter_spec(
 			&data->transport_options.filter_options);
diff --git a/transport.c b/transport.c
index 2a3e3241545..a150964e20d 100644
--- a/transport.c
+++ b/transport.c
@@ -243,6 +243,9 @@ static int set_git_option(struct git_transport_options *opts,
 		list_objects_filter_die_if_populated(&opts->filter_options);
 		parse_list_objects_filter(&opts->filter_options, value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_REFILTER)) {
+		opts->refilter = !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
 		opts->reject_shallow = !!value;
 		return 0;
@@ -377,6 +380,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 	args.from_promisor = data->options.from_promisor;
 	args.filter_options = data->options.filter_options;
+	args.refilter = data->options.refilter;
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
diff --git a/transport.h b/transport.h
index 3f16e50c196..6e21a5b0393 100644
--- a/transport.h
+++ b/transport.h
@@ -16,6 +16,7 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	unsigned reject_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned refilter : 1;
 
 	/* see documentation of corresponding flag in fetch-pack.h */
 	unsigned from_promisor : 1;
@@ -216,6 +217,9 @@ void transport_check_allowed(const char *type);
 /* Filter objects for partial clone and fetch */
 #define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
 
+/* Refilter a previous partial clone */
+#define TRANS_OPT_REFILTER "refilter"
+
 /* Request atomic (all-or-nothing) updates when pushing */
 #define TRANS_OPT_ATOMIC "atomic"
 
-- 
gitgitgadget


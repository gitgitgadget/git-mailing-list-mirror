Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C31E1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759072AbcG1QDS (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:03:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35963 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759051AbcG1QDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:03:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so11814043wma.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:03:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fd2YlaQS3Gp+3cI6k0o6ntpxzGGR6m/avtkg6xXyayI=;
        b=FiT+BEor6+AqFNiMplkRn4PFG21vn4FSUJ/NO0n9IaRWZ+YlghYzK6Cs6ubZcYc0gR
         O64Jih8X84VR+a26fkqmqNC9+wOjdHWT44d0anABgIhLUlC7xSBgIz/Bx4q7SiS48X2O
         /jrnphofwZhZQ9R3J/QBAnDFEcliMBI3yPuvVvzaE+fALyLrN6YMzSCiGq0djA/H/SwM
         sFrgV+BTydQFyqrle/cOe3JLjyFSYFcfEQVHtd2rA1gQcRn/SWbpWnqgwUEDWZHZLu4T
         knNays/Lf6sxmUkqF6cHXtfLQmLkwfsReTLIcp7Rvs4bBjzW9DZOmFdoMpQWjNJvaMTW
         OVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fd2YlaQS3Gp+3cI6k0o6ntpxzGGR6m/avtkg6xXyayI=;
        b=LLw+gQhMxhvAFrLZXEHwZ/P9o7W4V8jUUCtutM7+a2PF2YPAAThz+K42nYS6J+mnE4
         67BUxaayDeLPkcM7qszGxLXkt2ygJCeP2OxledMRKK6fqaSX3CmgGXcmedHm+RZO5cua
         yXSCguapllR/wsKXx8kdOeD26paiBEhYPeZTx5jT/n3UgA+4vlGvU85oXwVLXg5mOI1K
         Be2iW/L6viPa5JHhkPElb3fmBIZj1nma9mcFd/lCaf+qgdn0mMBCUUsR32AgVxZrNzxY
         bagbxv/R7HICVD0jBAhrYnfeNi3IizL9wZhW987JD9AzgTEPn9uZ7MCHhtN2TXD6feRS
         u7kA==
X-Gm-Message-State: AEkoousk7/4oFBVgEF+4lodpVfKgX9YDyNsICwQyi7Cgx/f4BvhjsCEpplEvoGXJT+64OQ==
X-Received: by 10.194.235.69 with SMTP id uk5mr38380240wjc.53.1469721790268;
        Thu, 28 Jul 2016 09:03:10 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:03:09 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 5/7] fetch: add sparse-prefix option
Date:	Thu, 28 Jul 2016 18:02:24 +0200
Message-Id: <20160728160226.24018-6-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

also pass sparse-prefix option from fetch to rev-list while checking
connectivity

Signed-off-by: Robin Ruede <r.ruede@gmail.com>
---
 builtin/fetch.c | 19 ++++++++++++++-----
 connected.c     |  7 ++++++-
 transport.c     |  4 ++++
 transport.h     |  4 ++++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index acd0cf1..b48537f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -41,6 +41,7 @@ static int tags = TAGS_DEFAULT, unshallow, update_shallow;
 static int max_children = -1;
 static enum transport_family family;
 static const char *depth;
+static const char *sparse_prefix;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
@@ -117,6 +118,8 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	OPT_STRING(0, "sparse-prefix", &sparse_prefix, N_("path-prefix"),
+		   N_("only fetch blobs for the specified path-prefix")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -706,9 +709,11 @@ static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
 	return 0;
 }
 
-static int store_updated_refs(const char *raw_url, const char *remote_name,
+static int store_updated_refs(struct transport *transport,
 		struct ref *ref_map)
 {
+	const char *raw_url = transport->url;
+	const char *remote_name = transport->remote->name;
 	FILE *fp;
 	struct commit *commit;
 	int url_len, i, rc = 0;
@@ -729,7 +734,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	rm = ref_map;
-	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
+	if (check_everything_connected_with_transport(iterate_ref_map, 0, &rm,
+				transport)) {
 		rc = error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -885,9 +891,7 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	if (ret)
 		ret = transport_fetch_refs(transport, ref_map);
 	if (!ret)
-		ret |= store_updated_refs(transport->url,
-				transport->remote->name,
-				ref_map);
+		ret |= store_updated_refs(transport, ref_map);
 	transport_unlock_pack(transport);
 	return ret;
 }
@@ -993,6 +997,11 @@ static struct transport *prepare_transport(struct remote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
+	if (sparse_prefix) {
+		if(sparse_prefix[0] != '/')
+			die(N_("sparse prefix must start with /"));
+		set_option(transport, TRANS_OPT_SPARSE_PREFIX, sparse_prefix);
+	}
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
diff --git a/connected.c b/connected.c
index bf1b12e..1534c5c 100644
--- a/connected.c
+++ b/connected.c
@@ -26,7 +26,7 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 					   const char *shallow_file)
 {
 	struct child_process rev_list = CHILD_PROCESS_INIT;
-	const char *argv[9];
+	const char *argv[11];
 	char commit[41];
 	unsigned char sha1[20];
 	int err = 0, ac = 0;
@@ -56,6 +56,11 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 	argv[ac++] = "--stdin";
 	argv[ac++] = "--not";
 	argv[ac++] = "--all";
+	if(transport && transport->smart_options && 
+			transport->smart_options->sparse_prefix) {
+		argv[ac++] = "--sparse-prefix";
+		argv[ac++] = transport->smart_options->sparse_prefix;
+	}
 	if (quiet)
 		argv[ac++] = "--quiet";
 	argv[ac] = NULL;
diff --git a/transport.c b/transport.c
index b233e3e..ce7e2e1 100644
--- a/transport.c
+++ b/transport.c
@@ -141,6 +141,9 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_UPDATE_SHALLOW)) {
 		opts->update_shallow = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_SPARSE_PREFIX)) {
+		opts->sparse_prefix = value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			opts->depth = 0;
@@ -211,6 +214,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.quiet = (transport->verbose < 0);
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
+	args.sparse_prefix = data->options.sparse_prefix;
 	args.check_self_contained_and_connected =
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
diff --git a/transport.h b/transport.h
index c681408..abee186 100644
--- a/transport.h
+++ b/transport.h
@@ -15,6 +15,7 @@ struct git_transport_options {
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
+	const char *sparse_prefix;
 	struct push_cas_option *cas;
 };
 
@@ -179,6 +180,9 @@ int transport_restrict_protocols(void);
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"
 
+/* Only fetch blobs whose referenced path begins with this if not null */
+#define TRANS_OPT_SPARSE_PREFIX "sparse-prefix"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
 
-- 
2.9.1.283.g3ca5b4c.dirty


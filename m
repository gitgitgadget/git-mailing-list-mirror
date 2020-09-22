Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5874BC4346E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A77D239D4
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCpHn6RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIVDEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgIVDEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 23:04:04 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735DC0613CF
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 20:04:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s204so10170764pfs.18
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eyMRYlTllKidF8RTGExmefcXc9eTpX6VroACkw+yrOQ=;
        b=sCpHn6RYQbzv5ye4ihvXyb0bmrThx2nW6cdvXozk9s+U+WVJw5p11ZJJ1JBUohCUyE
         8xBMZ2PxEbO7ItqH9s3/+LQtkoiv9RvIU1sf3c3/USzyrURwtPaZqsNKRA2I/aFc/tog
         fWW9qDWb8or1Z08ifqpzBVn9FcMVi5/C5OXnhQG94fM6oqbOVyMsDenW4aDu8MxpBs4T
         2eRmy654RI2ruLDisgCmcNr4yDNsVXHO+xVs5eDJPXr/rB/eIuCcDTydGCiKejqR2qUp
         D4AyfWGXx4ZP2mR7mLfVNKLOKNxvYi4gP0O3P8tSCb9t8h7Uy6j9XXjQT7zACReYvueX
         w47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eyMRYlTllKidF8RTGExmefcXc9eTpX6VroACkw+yrOQ=;
        b=YIjHiLbbqIEYbswR1X0syddElWka2My0stPHA2Nrlsvo08TQtzk+yA80bDmlFUssjQ
         3QXut6KL/BAI7Yse7lMGD1Q2S4ipUxf6kJc0f3C5I10oK7ehnIBEvWY2/P/CpGnC+Q+b
         ZYDpx5jjjYVxDMrL5pdzR3tq0jiXCah9mYpAOzS/RJ6X2KAP+fbYGhK2jQEmetv+ZHey
         6HZYjXVv9cifcO8OZGv4nhfpktPETfN1SmIBtp/f+i/KvZBuecjDX9b16EyaQQAav/7X
         MTrnWPCcRYH11LpWi+jvgGJW4NEvqNDXUOhTh/jOrIooMo3LWJr8llqX8/XShJRM1TPl
         mAPA==
X-Gm-Message-State: AOAM531/Yew8gSPpU68b1cp25hHH3CApAzYzE74edeyGprkha3Aa39Uc
        tmSSxRpVkuM03gzOs5F+DYD0n3CKJtzE3vH9bObXMK18Wp3SZ3bxd3CYvKwKXT+VYDnpDP99GXN
        bYR7wTSROE8/bqBEnnsxT74aWLOXcAcH8AGaPNaejmMFH67jtwQEZcjlGOMdQuQLnJNxlGkaL78
        Lr
X-Google-Smtp-Source: ABdhPJxTRWi1psR4U6tpBA9QU8/L6lW9fbS0HjaTip4fjsOS5mRlypED+EmFZvaInUTLWRUndfUTaOFfweeRvaJZPfn4
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:fe07:: with SMTP id
 ck7mr2018215pjb.20.1600743844102; Mon, 21 Sep 2020 20:04:04 -0700 (PDT)
Date:   Mon, 21 Sep 2020 20:03:57 -0700
In-Reply-To: <cover.1600743698.git.jonathantanmy@google.com>
Message-Id: <070a717aabbac31ae44567dbe54a325029f9931f.1600743698.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1600743698.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 2/2] fetch: do not override partial clone filter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a fetch with the --filter argument is made, the configured default
filter is set even if one already exists. This change was made in
5e46139376 ("builtin/fetch: remove unique promisor remote limitation",
2019-06-25) - in particular, changing from:

 * If this is the FIRST partial-fetch request, we enable partial
 * on this repo and remember the given filter-spec as the default
 * for subsequent fetches to this remote.

to:

 * If this is a partial-fetch request, we enable partial on
 * this repo if not already enabled and remember the given
 * filter-spec as the default for subsequent fetches to this
 * remote.

(The given filter-spec is "remembered" even if there is already an
existing one.)

This is problematic whenever a lazy fetch is made, because lazy fetches
are made using "git fetch --filter=blob:none", but this will also happen
if the user invokes "git fetch --filter=<filter>" manually. Therefore,
restore the behavior prior to 5e46139376, which writes a filter-spec
only if the current fetch request is the first partial-fetch one (for
that remote).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c               |  2 +-
 list-objects-filter-options.c | 10 +++++++++-
 t/t5601-clone.sh              |  5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a6d3268661..752148eec5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1677,7 +1677,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If this is a partial-fetch request, we enable partial on
 	 * this repo if not already enabled and remember the given
 	 * filter-spec as the default for subsequent fetches to this
-	 * remote.
+	 * remote if there is currently no default filter-spec.
 	 */
 	if (filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index b66314560a..defd3dfd10 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -344,11 +344,19 @@ void partial_clone_register(
 	const char *remote,
 	struct list_objects_filter_options *filter_options)
 {
+	struct promisor_remote *promisor_remote;
 	char *cfg_name;
 	char *filter_name;
 
 	/* Check if it is already registered */
-	if (!promisor_remote_find(remote)) {
+	if ((promisor_remote = promisor_remote_find(remote))) {
+		if (promisor_remote->partial_clone_filter)
+			/*
+			 * Remote is already registered and a filter is already
+			 * set, so we don't need to do anything here.
+			 */
+			return;
+	} else {
 		if (upgrade_repository_format(1) < 0)
 			die(_("unable to upgrade repository format to support partial clone"));
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 15fb64c18d..7c5cf5a2ec 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -672,6 +672,11 @@ test_expect_success 'partial clone with -o' '
 	git clone -o blah --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
+test_expect_success 'ensure that filter is written to config' '
+	FILTER=$(git -C client config --get remote.blah.partialclonefilter) &&
+	test "$FILTER" == "blob:limit=0"
+'
+
 test_expect_success 'partial clone: warn if server does not support object filtering' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.28.0.681.g6f77f65b4e-goog


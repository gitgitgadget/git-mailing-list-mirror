Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B199C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EE864FEE
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 01:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCEBQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCEBQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 20:16:26 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7576EC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 17:16:26 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id v136so386212qkb.9
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 17:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iJs52+aTtI+JK3uUE6KJ0ujkma7qBkhwastYR3AK5Bo=;
        b=azIKG9w3/Wu6BNnGUxUDq5drnMBYBRyNrPXVCHwhDOnCB4YLNI9qq1MexEy2fOzzUR
         wTeICQOHbUozl1SCR1XMBK7dxgm2MrZTqUlqtbMog7TDrwxJX3WUqkeAreCaLweyiIwA
         01XIND6DqsLiH4FGaOSM6vQe965+A8XzlQJIkQ9PzCQkCtVvekLGc0hz7SaXrZ14kQ5q
         srAoybCvk0E91Hq7I6pFoTPwXojn4QUgUujRzg6+N1sQAPYKVdr/54rbY3lBCeIoEKpA
         6MGPE3cqnOFroicgJlTCaA71ogkfeKnQ4+IuCumZmnwvF4xiBkBIVrNus84+HNLbPk5j
         zBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJs52+aTtI+JK3uUE6KJ0ujkma7qBkhwastYR3AK5Bo=;
        b=gOzakv8y0b/nV7VAGQI0VBYeW4s7ujtD92NfuB4nYBMjFcwhxXrfYS/yh/mDiiapWk
         mGQwNVck3XfUhV3bKJtJE2Itj1sIj2swDzQr9OzWLjAW3RMuusG7J1A8PeZdjWgEJ8qH
         SjSuCrw5gQ/AxLn7anz8a447qUSn5vwye4LQFDWM8Vm3AYvLLyWUZ3HpbNSq3xikzQZe
         czpR4zvfe5QL8AJJegNniNpG+fBz0SMOxe2GfMBiWkAXmv+R7IDM1g/RcwGcE293/XEe
         r5j6deIcRCMNAe2kk9bOrToGdUkLXxrhhe7imbVlwp7A95uYm7ucu1uEEeBka7WdEQiq
         oFeg==
X-Gm-Message-State: AOAM531OhleBw1lp5rvnUe1kNkie8Uhc81okRrxuVRUHBDO5qc/EtJSl
        Nw+FLT+hZ7/R8inciKvoOYlv4B9V+RrODDJAyebfsXsPRYp/SymAGkhldNE97Ktgq27OGiHUC5H
        mwktqQi/7jGwb7gsU4vqTZnmHeTvb4fx2wBQiUPdQE7qQ9Wj6afxXaxJysXfXrqLMMbKQNAS7WU
        kH
X-Google-Smtp-Source: ABdhPJwdBOXQpnsnKeaQFsIn6lwZXhlJdzqQN8nmFRMu1Dierm6NwexhGlSYY86VWLDTk+Hohx5eWs+IgjvzfLcdLu80
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f890:: with SMTP id
 u16mr6961883qvn.21.1614906985501; Thu, 04 Mar 2021 17:16:25 -0800 (PST)
Date:   Thu,  4 Mar 2021 17:16:20 -0800
In-Reply-To: <YEF5BfE6eXmhhiAf@google.com>
Message-Id: <20210305011621.599649-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YEF5BfE6eXmhhiAf@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        nmulcahey@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching (as opposed to cloning) from a repository with packfile
URIs enabled, an error like this may occur:

 fatal: pack has bad object at offset 12: unknown object type 5
 fatal: finish_http_pack_request gave result -1
 fatal: fetch-pack: expected keep then TAB at start of http-fetch output

This bug was introduced in b664e9ffa1 ("fetch-pack: with packfile URIs,
use index-pack arg", 2021-02-22), when the index-pack args used when
processing the inline packfile of a fetch response and when processing
packfile URIs were unified.

This bug happens because fetch, by default, partially reads (and
consumes) the header of the inline packfile to determine if it should
store the downloaded objects as a packfile or loose objects, and thus
passes --pack_header=<...> to index-pack to inform it that some bytes
are missing. However, when it subsequently fetches the additional
packfiles linked by URIs, it reuses the same index-pack arguments, thus
wrongly passing --index-pack-arg=--pack_header=<...> when no bytes are
missing.

This does not happen when cloning because "git clone" always passes
do_keep, which instructs the fetch mechanism to always retain the
packfile, eliminating the need to read the header.

There are a few ways to fix this, including filtering out pack_header
arguments when downloading the additional packfiles, but I decided to
stick to always using index-pack throughout when packfile URIs are
present - thus, Git no longer needs to read the bytes, and no longer
needs --pack_header here.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Here's a fix for this issue.

This is on jt/transfer-fsck-across-packs.

One simplification that we could do is to eliminate the unpack-objects
codepath. As far as I understand, the main advantage of writing loose
objects is that we have automatic SHA-1 collision detection, but we have
such mitigations when writing packs too, so that might not be as large a
benefit as we think. This simplification would have enabled us to avoid
this bug, I think.
---
 fetch-pack.c           |  4 ++--
 t/t5702-protocol-v2.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f9def5ac74..e990607742 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -852,7 +852,7 @@ static int get_pack(struct fetch_pack_args *args,
 	else
 		demux.out = xd[0];
 
-	if (!args->keep_pack && unpack_limit) {
+	if (!args->keep_pack && unpack_limit && !index_pack_args) {
 
 		if (read_pack_header(demux.out, &header))
 			die(_("protocol error: bad pack header"));
@@ -885,7 +885,7 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			strvec_push(&cmd.args, "--fix-thin");
-		if (do_keep && (args->lock_pack || unpack_limit)) {
+		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
 			char hostname[HOST_NAME_MAX + 1];
 			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index b1bc73a9a9..9df1ec82ca 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -853,6 +853,27 @@ test_expect_success 'part of packfile response provided as URI' '
 	test_line_count = 6 filelist
 '
 
+test_expect_success 'packfile URIs with fetch instead of clone' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	git init http_child &&
+
+	GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch "$HTTPD_URL/smart/http_parent"
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	rm -rf "$P" http_child log &&
-- 
2.30.1.766.gb4fecdf3b7-goog


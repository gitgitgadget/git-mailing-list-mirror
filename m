Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21EC4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A5920791
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mw0OwTDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgKLBcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgKKXbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:31:41 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1DBC061A4D
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:58 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id w6so2534721qvr.15
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=9tzZ/0P2yNnNcgxjKVsU3Tbe+lcp5eVVL3uTZgYDgTU=;
        b=Mw0OwTDE5pTylcq3yGYjftmxkVuId/E/BPiljiwbu9+9VGPeEKKm7mjUognHWuyq0D
         dpNIwbFGF0cVTSYS0TiUe+C13fLCYWoionnXQ8KeKfRLSguXgrA9rWTxVR/lvjHeCIcE
         YFhvzmGwxhIUkqLzX8rSe287kvtVjxChNifa8ATzTsA5hHgznWn+lnVMnz8uIHDq1Ppe
         0udS7WNl17NyoBzhfg2LYVMk3yUBGiR68+u9N2OQ6YvxZBi3GqfLbU0oITHaHZZzolvu
         hzM5Vau6ZG5/zLWJFCSDo+3kHMFU5Ze2sQ3czQXqC4M2A/cqtLrJwH0GoxDxgxuzzol3
         e1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=9tzZ/0P2yNnNcgxjKVsU3Tbe+lcp5eVVL3uTZgYDgTU=;
        b=o7kDDrJyavo6UwQiT+WGcNVVQKJuWdfXaFEYtHf+hELkUQdludMbRWpIVhx4/lZl/m
         EudQfqIUd/M9dfWTHzFrqh3oFH4q+op1hJfcTfIkVXf9BJWwZWu2eOYmOHJBpr8Uw1Kj
         9NnV7OulQURhJXfAWed1kW6tAwp8bXuyvcBCNLyHhMxYcjXXCUnHYCjm1lwdQ9KIIodG
         jdvf4/slk9Ail3bVvvfQgJrlX15UVLDpokBjB0f4vlVDj0F9lwjEoFKDX8L5IOE2rPFH
         /kLmyLV8TtUPjxXbR4Pzn1BQuH41HbXhxqenE73i9He2faa0zn/sBBo5Fy3FB+Nlhwl3
         a4Gg==
X-Gm-Message-State: AOAM533Mv+/4EwQMnpsk4Ss+CQGCXYQhPgTj3clNiM3+sjY6avOZzIQm
        lU1yKS7r1Dhdcqt+SSW2GL2Nb/X2yhdx0F6NH5VlkxcCQAQb7k0v5TeT9Dc5s4ycL8TtcXHmodv
        IBu0DWlVbc9+QazRJjNT3cTiqem/N+pPw8VJENoQu0tXwl21eLIF6lqaMzlhoYLA=
X-Google-Smtp-Source: ABdhPJzn5FXtaH6l97RCZzgZs97oG2aty8h5GQEDOglJ3Edbyt6hEu7YyC7WSA1bYXL1ydPcBHfOzMyI/QrQFw==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:ad4:56f2:: with SMTP id
 cr18mr17637175qvb.62.1605137397157; Wed, 11 Nov 2020 15:29:57 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:34 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <ea2a318f2bd46115f5eb76426e6546a325a1b62e.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 11/11] receive-pack: log received client session ID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When receive-pack receives a session-id capability from the client, log
the received session ID via a trace2 data event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/receive-pack.c                |  7 +++++++
 t/t5705-session-id-in-capabilities.sh | 20 ++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6ed498b6c7..deb5f859a9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2039,6 +2039,7 @@ static struct command *read_head_info(struct packet_reader *reader,
 		if (linelen < reader->pktlen) {
 			const char *feature_list = reader->line + linelen + 1;
 			const char *hash = NULL;
+			const char *client_sid;
 			int len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
@@ -2061,6 +2062,12 @@ static struct command *read_head_info(struct packet_reader *reader,
 			}
 			if (xstrncmpz(the_hash_algo->name, hash, len))
 				die("error: unsupported object format '%s'", hash);
+			client_sid = parse_feature_value(feature_list, "session-id", &len, NULL);
+			if (client_sid) {
+				char *sid = xstrndup(client_sid, len);
+				trace2_data_string("transfer", NULL, "client-sid", client_sid);
+				free(sid);
+			}
 		}
 
 		if (!strcmp(reader->line, "push-cert")) {
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index afa2159657..f1d189d5bc 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -28,13 +28,17 @@ do
 	'
 
 	test_expect_success "session IDs not advertised by default (push v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
 		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local push origin &&
-		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+		git -c protocol.version=$PROTO -C local push \
+			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
+			origin HEAD:new-branch &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)" &&
+		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
 	'
 done
 
@@ -57,13 +61,17 @@ do
 	'
 
 	test_expect_success "session IDs advertised (push v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
 		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local push origin &&
-		grep \"key\":\"server-sid\" tr2-client-events
+		git -c protocol.version=$PROTO -C local push \
+			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
+			origin HEAD:new-branch &&
+		grep \"key\":\"server-sid\" tr2-client-events &&
+		grep \"key\":\"client-sid\" tr2-server-events
 	'
 done
 
-- 
2.29.2.222.g5d2a92d10f8-goog


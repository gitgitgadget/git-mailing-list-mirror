Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62BFC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F7D2087D
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWZRIEQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgJ2VdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgJ2Vc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666AC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b189so4150019ybh.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=sY1kQGMYTG9GfYW35zzHamF/+N+T18FfArRU2GQ7NA0=;
        b=mWZRIEQOKCUnfIjD9eeigziLxYDK0FMXbh+J1GQSJnfL22QBWGHMIp6TV50QpDzHOc
         1Yiu+afMNVRsgt/v0gFxzfIrh2lcb5DWrKZMUrn9kKI3faCSCrHPc/D1WGwqhDpHd4ek
         oY8DeUjGuoC9bgnkAvMLWL8u2ScmflrtiLRUHepFwRWmhFqyBXnv5YRjYaBUVxUlNINL
         DHPzG8snXFTVcelOYnE1YH9/7uPoK/vipgeKQiRf9XqONGXS5ZboAWyrmRXBQsmeCdsJ
         mAC3C+AMaI7XCQnS+CZ98bKdUabizuRppy/7VEq/L2ZDiS+bWvMHMoHnaCpvGiSW+Yk+
         g+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=sY1kQGMYTG9GfYW35zzHamF/+N+T18FfArRU2GQ7NA0=;
        b=WzxCrgymSGzzR65kkd12PDmjUOI0quYmy46tu+d1tO9A+pL9t3oLl7ttFbSPJmZEf/
         EuWHB8yrnlPwOb4Du7liycWrQSB0bHeGOgVh4sjYQBjdGUClqdOSt3kRUwCsNiV1enYb
         vbBn7gyOsR1SNRU26dlFjDuGzFtgQd15RY4EVjIVU2ZfGrxCCzHtsr48uHmyj8qqG0LI
         V6ssLy6TlyJrm47GIUqPfCx1pQqKyXkT1f38AdfTCGyvJYh4lUiefUgv9dOm+TM/hQpu
         7r0FNrnhGagkHghY+p0WnIIxzZ07yjKedz+zfyfMS70tVof/MpVISdfnDaWpPrK1Q/Yx
         O/tA==
X-Gm-Message-State: AOAM532Dk6vX2Uv5y9aWz6T4jXWGfZ4hWXDVbeiDscu+vSZZAQprcITO
        onbv+dq9afalkpdIIsgjkWpiRVkX+nhzr//YbLa2FaXI9l/56m6/vTBkmfD8AeRy9Y9I8oxJS9W
        RA12Q1U9/DSRq03yq259A/wyRIXA6JCFYqZkWKI51NTD1ZcrSVwxW4OjEPMZqDeo=
X-Google-Smtp-Source: ABdhPJxJUKvO22uIj2hnHY4RB7rcSSufHWkSPU1pu5O/Y3ZSgYFLzp/fCUzyxMnHS/7245yCr1dd5WvmQBAfFQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a5b:286:: with SMTP id
 x6mr8886550ybl.78.1604007177195; Thu, 29 Oct 2020 14:32:57 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:38 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <b160941c65e633f60fe08d71110e1d30b079c40e.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 08/10] upload-pack, serve: log received client trace2 SID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When upload-pack (protocol v0/v1) or a protocol v2 server receives a
trace2-sid capability from a client, log the received session ID via a
trace2 data event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 serve.c                               |  4 ++++
 t/t5705-trace2-sid-in-capabilities.sh | 19 +++++++++++++------
 upload-pack.c                         |  7 +++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index 6ad73d69ab..6a4f0c64a9 100644
--- a/serve.c
+++ b/serve.c
@@ -202,6 +202,7 @@ static int process_request(void)
 	struct packet_reader reader;
 	struct strvec keys = STRVEC_INIT;
 	struct protocol_capability *command = NULL;
+	const char *client_sid;
 
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -265,6 +266,9 @@ static int process_request(void)
 
 	check_algorithm(the_repository, &keys);
 
+	if (has_capability(&keys, "trace2-sid", &client_sid))
+		trace2_data_string("trace2", NULL, "client-sid", client_sid);
+
 	command->command(the_repository, &keys, &reader);
 
 	strvec_clear(&keys);
diff --git a/t/t5705-trace2-sid-in-capabilities.sh b/t/t5705-trace2-sid-in-capabilities.sh
index 0870e78f7c..3fad9462d3 100755
--- a/t/t5705-trace2-sid-in-capabilities.sh
+++ b/t/t5705-trace2-sid-in-capabilities.sh
@@ -17,11 +17,14 @@ test_expect_success 'setup repos for trace2 SID capability tests' '
 for PROTO in 0 1 2
 do
 	test_expect_success "trace2 session IDs not advertised by default (fetch v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local fetch origin &&
-		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+		git -c protocol.version=$PROTO -C local fetch \
+			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
+			origin &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)" &&
+		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
 	'
 
 	test_expect_success "trace2 session IDs not advertised by default (push v${PROTO})" '
@@ -43,11 +46,15 @@ test_expect_success 'enable SID advertisement' '
 for PROTO in 0 1 2
 do
 	test_expect_success "trace2 session IDs advertised (fetch v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
 		cp -r "$LOCAL_PRISTINE" local &&
+		git -C local config trace2.advertiseSID true &&
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local fetch origin &&
-		grep \"key\":\"server-sid\" tr2-client-events
+		git -c protocol.version=$PROTO -C local fetch \
+			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
+			origin &&
+		grep \"key\":\"server-sid\" tr2-client-events &&
+		grep \"key\":\"client-sid\" tr2-server-events
 	'
 
 	test_expect_success "trace2 session IDs advertised (push v${PROTO})" '
diff --git a/upload-pack.c b/upload-pack.c
index 862656010c..4238e06510 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1059,6 +1059,7 @@ static void receive_needs(struct upload_pack_data *data,
 		const char *features;
 		struct object_id oid_buf;
 		const char *arg;
+		int feature_len;
 
 		reset_timeout(data->timeout);
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
@@ -1110,6 +1111,12 @@ static void receive_needs(struct upload_pack_data *data,
 		if (data->allow_filter &&
 		    parse_feature_request(features, "filter"))
 			data->filter_capability_requested = 1;
+		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, 0)))
+		{
+			char *client_sid = xstrndup(arg, feature_len);
+			trace2_data_string("trace2", NULL, "client-sid", client_sid);
+			free(client_sid);
+		}
 
 		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
-- 
2.29.1.341.ge80a0c044ae-goog


Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C56C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A092F22280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQvqxD3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgKBWbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKBWba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:30 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87CC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:29 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id bc2so9379001plb.23
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=2hJQ5+0X4beS66Jh7pYrdI0xmglyNQJJK/K5drFP/EY=;
        b=fQvqxD3CLQNhyfrsk1YJ7bf2J8SPI0fAnht3MfsQTD/EAf60E7zzjErjKnIMDKRB4R
         2juzw/xWmrwJX+mltglGDIkSVdA1S4Y1kJsnAYFe/c34yB6MYq9vVzXEa2ZyXFs/lvbo
         524WdFcMkcdZceyOfqrnsLNwY1S4T6Vrydoh/S7XFzjcv6q7lNnCsmmyba386j2PMnz/
         oFH+AHrsPPuHChKJzd1Ca3tMB8lBv34LcX4W//hf3Ccv5BU94vy2KMe9jXxDbdaPfI0N
         x4z1jn/HVTo8TGo3DFCs5heTDNbT6CiAVNfv6FykPxqvITS3g8Ug7vwehqAgLQikxiAl
         jFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=2hJQ5+0X4beS66Jh7pYrdI0xmglyNQJJK/K5drFP/EY=;
        b=gMtUzA9gjfKIUmHnr99MG72oJc0JPP7tA8PsKnezCiT2sbYY/siY7HXFX+EstGCyJg
         vWGytYVeCruIgkLW943uTjfBAa5Oe8Rmopt0Ld73Hg3mtayeahsu3zpGNmF66rtzZalx
         CIAuoxbO0jxaQdIPg9WCPnFOWRk11xM++PWAve2ll4dzaxJt4x1mX3+k4UCZMprRLi4J
         nya+pQUx5sHs9p5gEKNvk9KqpQv4nCzRq9YjvnaAPlsKWZ9u9JLfLiSKuBewUiZlgWoq
         rv3cT9WjTYuHDFIxaUfK8Tz//FhaKlIyrHE9OTyvzIKzvMoXKhCyRjvLiXFyihaVo760
         Ekjg==
X-Gm-Message-State: AOAM53194Zb9sizLXv6PmNGLg0OFmsKjKmsZt/w1/TZiPIamOm1YEJlx
        8Un3w6zIQueGwnf9MWvy99XYGVoOy5vNVDUMW297DmWdS3SfWIsxrQMdVh4YqZAkwHm8JVDchaA
        s7YhrrDFlNZYPIgcypTKx7IUhdi+OZHHOGfpSQRBuYRpXAh/6R3I2IyhjiClaDcc=
X-Google-Smtp-Source: ABdhPJxgNzz7DpSvrtFi2T82Lftb9MKRT7RE4KWboX0HPPs64DsQAk0ULsjRZyh2NzKC8/W1rmYqe27+GduY5A==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a17:90b:4c43:: with SMTP id
 np3mr409976pjb.28.1604356288777; Mon, 02 Nov 2020 14:31:28 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:07 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <23f44bc904dfdd31f68a27c587b4b61df4bc0041.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 09/11] upload-pack, serve: log received client trace2 SID
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
index b40d7aad34..ffe5ba3f8a 100644
--- a/serve.c
+++ b/serve.c
@@ -201,6 +201,7 @@ static int process_request(void)
 	struct packet_reader reader;
 	struct strvec keys = STRVEC_INIT;
 	struct protocol_capability *command = NULL;
+	const char *client_sid;
 
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -264,6 +265,9 @@ static int process_request(void)
 
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
index 3bb01c5427..d938603c97 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1058,6 +1058,7 @@ static void receive_needs(struct upload_pack_data *data,
 		const char *features;
 		struct object_id oid_buf;
 		const char *arg;
+		int feature_len;
 
 		reset_timeout(data->timeout);
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
@@ -1109,6 +1110,12 @@ static void receive_needs(struct upload_pack_data *data,
 		if (data->allow_filter &&
 		    parse_feature_request(features, "filter"))
 			data->filter_capability_requested = 1;
+		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, NULL)))
+		{
+			char *client_sid = xstrndup(arg, feature_len);
+			trace2_data_string("trace2", NULL, "client-sid", client_sid);
+			free(client_sid);
+		}
 
 		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
-- 
2.29.1.341.ge80a0c044ae-goog


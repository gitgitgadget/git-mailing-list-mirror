Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7271F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965048AbeB1XYy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:54 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:42230 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964929AbeB1XYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:52 -0500
Received: by mail-qk0-f201.google.com with SMTP id x139so2621018qkb.9
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=eWdbitPIPMY6HRCZP3YfJ19M7fsJZDXWd2PUZ7lRIFQ=;
        b=eoKeXh0sykgiQYV82Fwais+oZ6I2OggwgJn+Wa8bfAH2EYLV7Ei61EO5DX+7moyFNm
         8PiXV5I3tm1VlASaZGilJPUwfcPMBiDAZzWbrkLE7MGWs64yuySpHL/qKo7MkaAWhbBH
         rgKfSRb4xOmw12Ba4WE0XF/etw0IQ8nIVFeUmxT48v59fv9tovVAn4BmFH+PqfwDGuJ4
         b8mbBKpAh/LKFZfJMwk/mhuxTKFVyHZJoiAl0Wk33ls4spc+8Bfd5iIShqyL/pGTkB9j
         xMlP010FxF1pvoPn/x/hGud/wzjiOCLggiAVBKF5/yIjo9OyaeQQu1TdbD9iF4R0HEJn
         Eeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=eWdbitPIPMY6HRCZP3YfJ19M7fsJZDXWd2PUZ7lRIFQ=;
        b=AqEFD65KNLN1lgoEX2F4wFD08cqQgjUN8tuD+7OgLIdJsWonR3OC0AJR+fPzkibaO/
         8y/FRIiCk70GxV+4LV9AF1PaG01Ys13WwL+sHl8IlmRPd6BfvgnoCwtMxlaRM/lCXxYQ
         yDQO0rPBKk3I5IVTnM0H+bJLWCsgNmynz7conQ55ag7ZfcHY1K7ou0EPpx49Udb1CaKv
         K9OiV3fspMlKCBeyzjMemPjAkuOpjQY0/vwChRq9+wEylsy3ScyvRtwy7jrlipZgSU51
         6c5y2MYW8MAD82J8yXbzev4DrBEi88Nr01VKhhqJzQ+W3YfDgxicXn08yJtNg2Qw4aPT
         kWBA==
X-Gm-Message-State: APf1xPC5x2nXiNJ9EFNhlySI9NndPvxcqfWGLnN0jx+s8z6NvYVac5Cm
        WUUv0xyChE/o0+cHXK/XvqqcEKRjZgEvlj3l1UZy9xIhqoqE/1kakXX+BBxixbfqNu7UFHv7r8d
        POhtK9dc52xThCaiUyihMZxTLVjz+1x6NyZt+qkyTBFyQHnn9bRV9wLuzkg==
X-Google-Smtp-Source: AG47ELvLPPvdR8RIGsKt4O6YZdzoQZl61iJmfgF3bFvnF+XJQUHSyGroae5th1sPKknbzZEePOZ2E2kQFYA=
MIME-Version: 1.0
X-Received: by 10.55.155.132 with SMTP id d126mr14022812qke.54.1519860291675;
 Wed, 28 Feb 2018 15:24:51 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:52 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-36-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 35/35] remote-curl: don't request v2 when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be able to ship protocol v2 with only supporting fetch, we
need clients to not issue a request to use protocol v2 when pushing
(since the client currently doesn't know how to push using protocol v2).
This allows a client to have protocol v2 configured in
`protocol.version` and take advantage of using v2 for fetch and falling
back to using v0 when pushing while v2 for push is being designed.

We could run into issues if we didn't fall back to protocol v2 when
pushing right now.  This is because currently a server will ignore a request to
use v2 when contacting the 'receive-pack' endpoint and fall back to
using v0, but when push v2 is rolled out to servers, the 'receive-pack'
endpoint will start responding using v2.  So we don't want to get into a
state where a client is requesting to push with v2 before they actually
know how to push using v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c          | 11 ++++++++++-
 t/t5702-protocol-v2.sh | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 3f882d766..379ab9b21 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -322,6 +322,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
 	struct http_get_options http_options;
+	enum protocol_version version = get_protocol_version_config();
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -338,8 +339,16 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
+	/*
+	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
+	 * to perform a push, then fallback to v0 since the client doesn't know
+	 * how to push yet using v2.
+	 */
+	if (version == protocol_v2 && !strcmp("git-receive-pack", service))
+		version = protocol_v0;
+
 	/* Add the extra Git-Protocol header */
-	if (get_protocol_http_header(get_protocol_version_config(), &protocol_header))
+	if (get_protocol_http_header(version, &protocol_header))
 		string_list_append(&extra_headers, protocol_header.buf);
 
 	memset(&http_options, 0, sizeof(http_options));
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 124063c2c..56f7c3c32 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -244,6 +244,30 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	grep "git< version 2" log
 '
 
+test_expect_success 'push with http:// and a config of v2 does not request v2' '
+	test_when_finished "rm -f log" &&
+	# Till v2 for push is designed, make sure that if a client has
+	# protocol.version configured to use v2, that the client instead falls
+	# back and uses v0.
+
+	test_commit -C http_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
+		push origin HEAD:client_branch &&
+
+	git -C http_child log -1 --format=%s >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Client didnt request to use protocol v2
+	! grep "Git-Protocol: version=2" log &&
+	# Server didnt respond using protocol v2
+	! grep "git< version 2" log
+'
+
+
 stop_httpd
 
 test_done
-- 
2.16.2.395.g2e18187dfd-goog


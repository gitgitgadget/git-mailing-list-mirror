Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F9B1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeBGBOR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:17 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:54135 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeBGBOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:14 -0500
Received: by mail-qk0-f201.google.com with SMTP id u194so2800469qka.20
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0mdrb/4mibI0H1JFgUadNgc1619i3Z8m3wRLcgcC3iw=;
        b=fcDrDN8OGkKdsaLaCVKuhxqiqHwNoCAfN4cE4+X6eq/Oj7N+OaSR30/Cc3ne7Tv+Ef
         YXltiz2a9i59z+aghomXpIC+GZTOXRwgy5EFsqNh8dxDSz5buAve9vXy9etVariOgGeU
         bjtIJSKKwyRwJGbRvNMgLXKdd/rUftlZFUmGvdu51Qh2zM70W3h+aQDzO4ljBYlkkbPu
         2NsSByR5vvkfeCARVV/iRNOqNds9ABaYPwI3CHXnwcHE1MNJNmiZxFcAPQFt+IjvzZ9r
         J6HV3CT9Xl/5SckaZFKe+iFi98qZanHEBWQPnHVOUr+cuEQELVtKTaMDCwBzm1qAIuAX
         4COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0mdrb/4mibI0H1JFgUadNgc1619i3Z8m3wRLcgcC3iw=;
        b=n2ydZ3n6gwWHtxv5n8L1gJ/JEDNWpzEBAOIMh6Z1ekXvIimOKk9et1H7yEjS3Z4TVI
         QnGRcVP7ecQJWsXPOSJn3frzMkRgJpDgbAv6Zz/8SN3ctkRH7sy5xf3fy0igp4ebFuHA
         Yiks0xIa9oSkc3CxJlp+/2nUAKcU4f1dtYtV4WH08LwBcfRfOa0/R6bqDkSNN5cgA0o+
         rqdDKsonEeNzXxAQroAcYp4U59/mKFl4Fyi4ZFsInqPh1mHEeQhw56JYgbUmTyCZAjA+
         BgOJqBNw10LPv1siQJefo415E7JBQbmBzzCwZn6AQ7+yyIIyJ7QxlLR9yhUc/AL/UPOf
         PmgQ==
X-Gm-Message-State: APf1xPAaRkGxJETiXMcfK8qg9vLB0+wdpbQnc0U7vY3h5bMNqqwb65Wg
        fPEIaqdXe20Rl+enFBF7Lz9OCyXonM8dr2PTxqstcIQsiILx+ONW48E52pICwgFhFATFBS41WSG
        KTsKps2aTISJk5MVc30R+RPgxSf6k6WGEJxC8zYqxR1+Q5Z3STMP6QffhUg==
X-Google-Smtp-Source: AH8x226g2L7EmJWcRr7WTSluiXp6GhpZLjFBs2NxT2yAkFoPa7KDeZchbgwRF9o6WGCCpmJ3hA5odwOC37k=
MIME-Version: 1.0
X-Received: by 10.233.230.66 with SMTP id x2mr3227866qkl.1.1517966053723; Tue,
 06 Feb 2018 17:14:13 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:02 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-26-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 25/35] connect: don't request v2 when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
 connect.c              |  8 ++++++++
 t/t5702-protocol-v2.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/connect.c b/connect.c
index dbf4def65..37a6a8935 100644
--- a/connect.c
+++ b/connect.c
@@ -1212,6 +1212,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 	enum protocol protocol;
 	enum protocol_version version = get_protocol_version_config();
 
+	/*
+	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
+	 * to perform a push, then fallback to v0 since the client doesn't know
+	 * how to push yet using v2.
+	 */
+	if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
+		version = protocol_v0;
+
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
 	 */
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 16304d1c8..60e43bcf5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -82,6 +82,28 @@ test_expect_success 'pull with git:// using protocol v2' '
 	grep "fetch< version 2" log
 '
 
+test_expect_success 'push with git:// and a config of v2 does not request v2' '
+	# Till v2 for push is designed, make sure that if a client has
+	# protocol.version configured to use v2, that the client instead falls
+	# back and uses v0.
+
+	test_commit -C daemon_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=2 \
+		push origin HEAD:client_branch 2>log &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v2
+	! grep "push> .*\\\0\\\0version=2\\\0$" log &&
+	# Server responded using protocol v2
+	! grep "push< version 2" log
+'
+
 stop_git_daemon
 
 # Test protocol v2 with 'file://' transport
-- 
2.16.0.rc1.238.g530d649a79-goog


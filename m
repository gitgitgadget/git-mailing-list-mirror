Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C351F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965030AbeB1XYb (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:31 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:33265 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965014AbeB1XYW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:22 -0500
Received: by mail-yb0-f202.google.com with SMTP id q130-v6so2389962ybb.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=JBdCjctMGoDxDvjvZrQ/HK9SapU45AmwY7YIoEtiBg8=;
        b=tpitPnCgWjdbaDSAC6X7XeoEGzG0jQpASRUhkP5DNCBehs4kqLwTvNJKXcgP7mbiS8
         l9LLogtH7VPFPQ147wh3hNWe29OKOGoYRVXRIYKJOkJvC1FJj5wX6LBgMspqE9oSUbdQ
         KXANCj4aZPSpDYBXqrRzHG+F8LhwAhTEePc8pV9afkilOBMiimAwq8z3QI24qv7H0Ena
         wv/Z+UngkoaVJzL8VxuwjP+++2W3lgieU52VSjlF7EpRx2lKZR9xcmlXS8abWToFtF31
         jekiF9hBHeUI+7zt5VxV1b4y8yyexTE/n//biZtJFqCtSQh44+cxlTQqxJKT4pMa/3y0
         X0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=JBdCjctMGoDxDvjvZrQ/HK9SapU45AmwY7YIoEtiBg8=;
        b=ugEMJ8R0euE6W2B0gBX2ru4vqDcdbHd0qC5++ydzhUSXEa99QMLYQnu6tXzYyQlud8
         bsUqWVzwYWU2CmSaKcWSYzq8IBR5uKBlNlSLdlGt7O6ISAznVB+JA2+bBUqPrXU/CkIP
         PMij46xlqhZ5bfCWefWVZYbLB+aTjxpAAcg35y9sGu/0Ae55msN0JrAmvzmFNDLMWbQL
         OHjoi8ZeygerKXepwyHCCVgnKZg+6I2lNBS8gFGfK+4v7r7OF1RC8wwFA5gM9xGJMY5K
         o54Z9+xsfTo9T74ZhmkDOZt+sM2Uao4yUZ1NlkAp+KkJ2JL6TzMr99qjlYSzMFkK7Dgu
         eN5w==
X-Gm-Message-State: APf1xPD2py3rMsegXkSFkCoci6asxXY7ROO/gbW2wF0a1jofajqsdGkh
        W43+ZXVwQQrCRWzptTQrgaK+01YqWoyUsNRs/ddxNnKl1Eh5ZoBTjKMnFqzSNUaUaW7ZNB7DSLA
        w+F4gk08ric48PESRiG/SVtAkreIPB+0L6OQmeakBzFfY58c6P7nkKLq5Jg==
X-Google-Smtp-Source: AG47ELvPOE3Ssbhx6iGpz/rjAUdyXIOT6bOpxEymmceSNrQYfLG0Qf2IZXnWJoQvZsiROz8q8dEe96Dz7po=
MIME-Version: 1.0
X-Received: by 2002:a25:1603:: with SMTP id 3-v6mr9997705ybw.7.1519860261543;
 Wed, 28 Feb 2018 15:24:21 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:41 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-25-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 24/35] connect: don't request v2 when pushing
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
 connect.c              |  8 ++++++++
 t/t5702-protocol-v2.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/connect.c b/connect.c
index a0bfcdf4f..32284d050 100644
--- a/connect.c
+++ b/connect.c
@@ -1218,6 +1218,14 @@ struct child_process *git_connect(int fd[2], const char *url,
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
index 4365ac273..e3a7c09d4 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -95,6 +95,30 @@ test_expect_success 'pull with git:// using protocol v2' '
 	grep "fetch< version 2" log
 '
 
+test_expect_success 'push with git:// and a config of v2 does not request v2' '
+	test_when_finished "rm -f log" &&
+
+	# Till v2 for push is designed, make sure that if a client has
+	# protocol.version configured to use v2, that the client instead falls
+	# back and uses v0.
+
+	test_commit -C daemon_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
+		push origin HEAD:client_branch &&
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
2.16.2.395.g2e18187dfd-goog


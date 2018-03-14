Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01F41F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeCNSeI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:34:08 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:60180 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNSdO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:14 -0400
Received: by mail-it0-f73.google.com with SMTP id m37-v6so3607631iti.9
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/k6vmGViCp/b0NnmDxA3wEX3V5LmlaO5gD7ANlI9GMg=;
        b=Kt2X5mz8Fdpu3FobysjhWoBGgqHrgGk+FYwP/bT38CgX06RF2rAQDtQ8cYNqzLLXyf
         5yF5PkWA0Wxso3EaXvrkQsSucReNykvE6A0FWkYYzm+f9QhGJMUTgSPEKjAU7r5kDHfN
         of16y0R2IqCagjvxvlhRmDGD6r9u+97lfi0ygVWRlIKxv6ugsKPyuqzSht1Ns3CVGRRW
         qRvuERKEkV4kVmLhL1GV+xVEsr7mfOwu1nDED4oXsF/jI3NaK8nxHw2SfMHT4VAziEyK
         yfMcj1bDnmzlJqUeTR+5h2GAb9z06MwEE/uOhNpmMjMBD5eEoC0hGE0Txw+7+Gpf0laq
         OikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/k6vmGViCp/b0NnmDxA3wEX3V5LmlaO5gD7ANlI9GMg=;
        b=WqbEC/5ttozNgxq8RTyr97NHwW+LBSsz80Rw/aLAV4fx/M0j9D5HHr2VzN0G5j6k2z
         /ZDBAEz1AxPzcrjrfw0tnArXXCk+K2UPIp/hVfqzrpRlJLQwxGVami6w0Ydx/0m7BwMX
         7CoKYEADn08rdrn8Oc3H+qVwGYMSIiQtBZlUBILSQZZLX6pbeTUAtQqjB+5X68X5pJse
         mZxfPYL1XvhXLDtoPyweODsNEMmWcsnTtihkBz9D99MT+J1gmoSf9CLhvJVZU6chYEmj
         FZ7mcpADdn2HJsT0N8EyT4GxTaEHAh0cjKm3iZiCC7vFNyIou06E4Kw9PCdOb5zgphBr
         3iNw==
X-Gm-Message-State: AElRT7Gu92NbTCWp7xWoC+X+EQROaIC1JuoncTPKxAOvpvxPw7rE7zgn
        6BFnvmiY86pAIxLHLjuJGeOsUOu32VErN/OoBuGWtv+uN+LWZgRvZpHHKMpaaJwZs7Ol8U6uClj
        cjCkE23c+xMWoGSYcLq1xOB+zkNEfU3zIoy1dxdMoehlJsB/Hohk/srLFjg==
X-Google-Smtp-Source: AG47ELsVZ4YZ9OszQ7GygV/eCLdZJs/SHP56JQatYlBwCssGLGXjSDt9GuLwVpT0DSUiaBchEk4J/VcBTic=
MIME-Version: 1.0
X-Received: by 2002:a24:1943:: with SMTP id b64-v6mr1314741itb.5.1521052393151;
 Wed, 14 Mar 2018 11:33:13 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:01 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-25-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 24/35] connect: don't request v2 when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
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
index a57a060dc4..54971166ac 100644
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
index 4365ac2736..e3a7c09d4a 100755
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
2.16.2.804.g6dcf76e118-goog


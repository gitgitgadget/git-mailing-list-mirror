Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773B82035F
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933888AbcHaI4c (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:55272 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933760AbcHaI42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:28 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MLvLE-1bkUxZ0ZIq-007kLC; Wed, 31 Aug 2016 10:56:25
 +0200
Date:   Wed, 31 Aug 2016 10:56:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 28/34] run_command_opt(): optionally hide stderr when the
 command succeeds
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <6383b7afcdeb6c999862aa32ba437997f2dd3d4e.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LScO9xcUPBxp1tMHr692Qb6aLM3ZJTkIKax5IlM4pVr8LLt4GMd
 tbz47Nr+VwCzxzTrdmwYRZIoaomlKL5vgFYyb8RO2Adyo7rO1vTahCk6FLhdpEWY6icKxbl
 MTOoZEg17GK8eAree+Npfyy7duMyx5OZhOmoYvFPreRE3bzYyYnNDjsYxkscTYJibEn1kSj
 g68/KNPy/BHh3tdNVgwLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SvPFH3JjwyU=:STDvjcmsbEYh9cee6SwG80
 Qy0TfbknPTsBtC5eQqQB4f0C4+c8Ic9RXBdx9k3yqCGDggD3EQwCgonJleoL/7Y2qYaIcuD/J
 TGiKqWUTbMcJwA77hJBn+Xxq+ObrFWWjo+tzHiTQbfu5W8z4EuR8ZN260QThSCuPGFB+F/bAX
 WX40KFHPXyUrjikxfHmwwfcqTnia+9CyMkJ/HZWtQc6CRR+CL9KuC4QFBiTnpnvqOthm2lYU/
 BqZQvgyPUEZR/g+2sG/PaxIbE3WHE1ZwYFqo7Ifh4FCDwgMO5J85rtNjeHu1tusNlSjnmqIQG
 rdp3R2KWFnCPn784bwYsHJHUn+XDEwI7AtdJeDzmkr3+pyEeGyJKkMrE/UhP4lGOB1m2uSiap
 1JBophLmg745WIL6dt1lZiQar4+SYdP1R9P0VEH7Nh/bwygMaiOoP0I10zB+nb06HhXJc7wgY
 fjWMOiKVYtTmN4a875iL3izvv4nN3cpa7qylEGVPTwHXaQKeOsstOt+ooVrjDO3KLA1KsfeFG
 eYyDcY8g8TrTfKO8O56GWAcfJZmZSlSgHvYFnE9vaJ3syp8bQq4kBpSIpYIq2ohhaJawGn9pl
 eqmS0n60l98eGcctpfANOHc7g8l2Mz0lcElvfKgpCVIMkuiGcIFrHhNBw2khL/7Rqs2I3lgSc
 NXCeSx2pX1tvG0LFUVZ39nfbYI5p79ZAHCsdhkzJ4qwA3/oGG6vGor4hmfHVix8oTU2TKrBmW
 uQM8DIjOTxu4bo2/7Vn3kDEIMoYGZeKkXmJMmHnTeAAhjopy7SYU7mtvbNR72f/GEYRsc0XlE
 3RVKpuM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be needed to hide the output of `git commit` when the
sequencer handles an interactive rebase's script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 23 +++++++++++++++++++++++
 run-command.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/run-command.c b/run-command.c
index 5a4dbb6..921e43c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -575,6 +575,29 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
+
+	if (opt & RUN_HIDE_STDERR_ON_SUCCESS) {
+		struct strbuf buf = STRBUF_INIT;
+		int res;
+
+		cmd.err = -1;
+		if (start_command(&cmd) < 0)
+			return -1;
+
+		if (strbuf_read(&buf, cmd.err, 0) < 0) {
+			close(cmd.err);
+			finish_command(&cmd); /* throw away exit code */
+			return -1;
+		}
+
+		close(cmd.err);
+		res = finish_command(&cmd);
+		if (res)
+			fputs(buf.buf, stderr);
+		strbuf_release(&buf);
+		return res;
+	}
+
 	return run_command(&cmd);
 }
 
diff --git a/run-command.h b/run-command.h
index 5066649..f87d01a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -70,6 +70,7 @@ extern int run_hook_ve(const char *const *env, const char *name, va_list args);
 #define RUN_SILENT_EXEC_FAILURE 8
 #define RUN_USING_SHELL 16
 #define RUN_CLEAN_ON_EXIT 32
+#define RUN_HIDE_STDERR_ON_SUCCESS 64
 int run_command_v_opt(const char **argv, int opt);
 
 /*
-- 
2.10.0.rc2.102.g5c102ec



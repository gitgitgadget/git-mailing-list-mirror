Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7865520189
	for <e@80x24.org>; Wed, 22 Jun 2016 15:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbcFVPCW (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:02:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:53482 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbcFVPCU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:20 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LkfdE-1bpttk0Zvg-00aWZo; Wed, 22 Jun 2016 17:02:08
 +0200
Date:	Wed, 22 Jun 2016 17:02:07 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 09/10] shortlog: respect the --output=<file> setting
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <ceb2fb1f2e63e3a74af870cfe7ea799bb2646e25.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KnbngVm44iHKDrctwi3ys2sn8+Iit2WfTy4kvVsrXcpEtCF7tpt
 LA4NIXowiRJxvSBAf/vEu4JsZpi/m+11Uj8cF+HK6kKbko8R6L1UvqHtU3IaJF597d8vE5l
 Rio2TCzlrD6CfdPf9MhvnoQxmWZSucTCcAd2eEz2/m0N9iDExfA3evLusmZVDtHUgDi3QJV
 f/8UcFYxJjldnCx32aGbQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Hlc07Dfm2co=:HVl51JYIiu6UGXZtyjcaRV
 GhLJGgTTcCSVRoOab1CgYWtMSrh1luVaAySipUAIHFAmxKGLfIL5tPFbno6IB7HdM1aDtMsYe
 RVbsIy/8YhN4MlR6lg1vdguVMambxv01FYjfrgwNZAEcNpn8p/unF7wFdZ9VlMsH3i7USV4cW
 ReIz6iOSSpONdULwLlq9tqh6lUJUkmwwUVb/VtDc/VwhBeTASqcn0SIlg9cGs25u/nwWJpsSb
 i8uot+HFTZknnlZoI+hgKfKurz7xY2GPI7V408EgFPomWyByU7ttDwudoaIuqChauKprKU4y2
 V5YqrI4Ck8MD3gseg+FDe4snxKPQytsJP6ERS/h3/a/1zSUhzTMWybb3hdtdh9SLwfKkSIxfm
 9AAwJi0M2dJW5PCl3Q/kj/fw6OjD200K1EkEsAwaq/Q3k5Qq1cpaNhCuQb4RzW6XHzw/8ZyFw
 N8wG8grscPMe4jy5HLT9Qa63Agb3HubPM5hqNLPl7bEBFiW9Lay/5Y7s9pQte6jDKvBkqCi4H
 M3/NrBR27G0paSTLZMyzKTD6IS/0ArfL8kwi/3MF0+dOdPWKj5e0mYxMzNdkH8HpQN2IMm8w5
 moITa/FyQtvRGDpJLg7UG/fUHuTPFts2h2efJNJHxPAIIUsned+QkszHShtAGhzt8dDsyq55R
 hX9gBkwikm535L/d7Y+LXPM6Z440W9f/ZtFOWQLXNOBcWfWfXWJYMW4Tjv/P1rjzc2y1D9noA
 xSIsVETu7525igjtL3lWwkaaAgjL+t3bK7NId++uaLRS9P27UfbSr6UINZAKRHKim1SUV47E2
 ZBYZ3nV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks to the diff option parsing, we already know about this option.
We just have to make use of it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/shortlog.c  | 4 +++-
 t/t4201-shortlog.sh | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 39d74fe..be80547 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -229,7 +229,6 @@ void shortlog_init(struct shortlog *log)
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
-	log->file = stdout;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -277,6 +276,7 @@ parse_done:
 
 	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
 	log.abbrev = rev.abbrev;
+	log.file = rev.diffopt.file;
 
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
@@ -290,6 +290,8 @@ parse_done:
 		get_from_rev(&rev, &log);
 
 	shortlog_output(&log);
+	if (log.file != stdout)
+		fclose(log.file);
 	return 0;
 }
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index a977365..bd699e1 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -184,4 +184,10 @@ test_expect_success 'shortlog with revision pseudo options' '
 	git shortlog --exclude=refs/heads/m* --all
 '
 
+test_expect_success 'shortlog with --output=<file>' '
+	git shortlog --output=shortlog master >output &&
+	test ! -s output &&
+	test_line_count = 7 shortlog
+'
+
 test_done
-- 
2.9.0.118.g0e1a633



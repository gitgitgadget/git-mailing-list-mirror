Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E999A1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbcHaIzF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:63292 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933400AbcHaIyz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:55 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mb7pT-1bPP173FH9-00Kiev; Wed, 31 Aug 2016 10:54:50
 +0200
Date:   Wed, 31 Aug 2016 10:54:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/34] sequencer (rebase -i): write an author-script file
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <36d2a101cc8eccbeba57da812e2f4b241b151238.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FuKNRjC8QRaElQO3WfHYi9RepBJsm1bcFogqefX+10UyTafBtEE
 5hlDb02ZPjWARBYmK3AZi4/bGRM5hESr2YYwQ8hlJCGDeToPuj0jy2ubYSoT432cxtZzW5Z
 jycs05yaafpZkatf044HrEtX07M2e68ovQ3YSADkY3yd+1V73SJxm4eppBRMmmWbMAs5WdC
 ZTl/zbdVUm7P1XWkD94wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8gyaOUB4BZ0=:JArORFSiX5YVIzaRXzxcUY
 V8u5ApTOIFwFRtzCE7/rE1Ch5QaApuStZRYh95JNeLQ3hNnUUnzOzjDYEMtzXR3O5W5XuVjpb
 JXgyXgrTS+5r3txDjUXXlWrTNJu3RxF/np4RvRA8G4NcqB4lAd2rxiEu8AFcgOiC4Qbj3Ut20
 uPSv5RX8NDfYgm4BVXhTHb6+Ghmvy01YS01t1qGzw7z+z35so4SNKyUNeQVy9GcVgcuGz7gqK
 TnYYne1h3acmFdItu5YBHAGLLukExuZYST81Eo1qSxiusEYo1+lceT8XDsHuKCDwkw2PLvvGD
 C2jXuJOADQwjVhFUuHBAtCZfgPeK5O7kPMO1Gmtysv2dU5Kg/m7GG2b/E1NPFXu9BKyy3nEkO
 LhG9D7KxNhIEmhePmqV20hzNTkEfhfo9Ha8stfdVkJ2sUbwBMztW5XTnwzOuTJvizVqXDjjpR
 zz9cb7gTPV3gZSxWUzEl8q+YtoRMQLuIpol3PJroNM6ewp+NTeNJR6HC3yYqDeyY1nRXq9Pbk
 jHyAN7bev3Q0HhyOKTkN45j4actGvzJaI+Wb2g8EgtkPbz2FKJeCji22duSYiGToCXD0knlC6
 jZBdtaos7s9Axn0Cy1XFDAqffp+Zprpuy9LkAy8FPmUSbN+ZydYHQYs61lWW4+HZGmaZPVFNP
 yuBr+jbRaPPaPSjGN2wV8tVOciX4jfCXLmO6lFA+p+CJqvzK3e5Lz+Bsq1yVwl0Q92ZeOxLU1
 YQ2u9QeIuRGvu+Lqk8v2WWfnMR3L+bICs/w02jPSgR5EhoCpBca6RZlPSX57cmVL0h3UsxZ9k
 vk2Nheh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the interactive rebase aborts, it writes out an author-script file
to record the author information for the current commit. As we are about
to teach the sequencer how to perform the actions behind an interactive
rebase, it needs to write those author-script files, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 919698b..ef818a2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -528,6 +528,51 @@ static int is_index_unchanged(void)
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
 }
 
+static int write_author_script(const char *message)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *eol;
+
+	for (;;)
+		if (!*message || starts_with(message, "\n")) {
+missing_author:
+			/* Missing 'author' line? */
+			unlink(rebase_path_author_script());
+			return 0;
+		}
+		else if (skip_prefix(message, "author ", &message))
+			break;
+		else if ((eol = strchr(message, '\n')))
+			message = eol + 1;
+		else
+			goto missing_author;
+
+	strbuf_addstr(&buf, "GIT_AUTHOR_NAME='");
+	while (*message && *message != '\n' && *message != '\r')
+		if (skip_prefix(message, " <", &message))
+			break;
+		else if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
+	while (*message && *message != '\n' && *message != '\r')
+		if (skip_prefix(message, "> ", &message))
+			break;
+		else if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
+	while (*message && *message != '\n' && *message != '\r')
+		if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addstr(&buf, "'\n");
+	return write_message(&buf, rebase_path_author_script());
+}
+
 static char **read_author_script(void)
 {
 	struct strbuf script = STRBUF_INIT;
@@ -979,7 +1024,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
+	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
+		res |= -1;
+	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res |= do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		if (res < 0)
-- 
2.10.0.rc2.102.g5c102ec



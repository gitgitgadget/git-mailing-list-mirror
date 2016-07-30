Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F341F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbcG3Rgg (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:36:36 -0400
Received: from mout.web.de ([212.227.17.11]:62742 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbcG3Rge (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:36:34 -0400
Received: from [192.168.178.36] ([79.237.49.94]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M6V1T-1b5zsm1obb-00yMLe; Sat, 30 Jul 2016 19:36:27
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_addstr() for adding constant strings to a strbuf
Message-ID: <579CE597.4060009@web.de>
Date:	Sat, 30 Jul 2016 19:36:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5D5NTK6gYjIb2duZbjPaLv7DVJ/3CLwZcPDxYMaEyGY4RN6uDkz
 7iP5b8l4DpxW4mLs/mmucv911jUQgb90If7BDxHqSzrGLy/twfhIsYv43lUGzUTQNqlrGfe
 hmCAF9NobsN/TeJSimJK1XTSQzQ76mU7H7nMD03r4InmQpRVsN3ScIQfwS4PUM4w0PQLZQw
 nUXSUN8f19KkPx6h8Qh4w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:I9XMyYpGOdc=:fTnWKjl3ZI6CMzLRJeDjKt
 I5MbBqbW4gESf6OHk+2kUWX4JlS9329AshaPEeusq4Wcf8t6pwUfq9jU167oqiTgZ34U2sznl
 VINa0AHIYL8pcXXUfb9tfwvjar/ACzpUtr6YFahp26m7LY4TrHCKk4Fgbd09RWNDJeexwECYH
 AAf5+DONohD+Sk54Ecdt3loJwPYY77thCB28Ub4Wk89tNDIBFCJGYubotpn4aOBJ42RzLP+JK
 cApmWhQyVf020RRcYqOBqE6R+g25pCli7Klx8Z8Vpef7M8Y0lXNFgEqo4oiZuq2GiZfYqS+Lx
 xi/nIf1tmrO8OBQu9BxqCWwZIpS6McIGZ3lZGJq6tqoaHZk1UNk2ogCgNbiVafXd2tdN4CCAz
 xzIaUlESObKEqx224ihyxp1ETkGuDMfkTgX8Eg0cKcJOA7RpshzxWQ9G5HxsDQjJc6rOhVLnz
 YzlrKtj4xIhvMFK0dx+kjWooo+uydtoAJoBkjmnuiwUk5w7p3QT6jSSNNN1HJ3DbEnNDJnYOi
 Udd7B+O5RaKHa0gDeL5f1rqJVnu935i5HBlY+QWqkSfV/LQusfbKxB8dVP7hmTrTFCt51dC1i
 imErH8geKOMIbCMrbKa6t8NV/D5HfMhh9xqRMdYcU92Y6fs3oxA5c0qONcXw9EGtlSI0Y+pZz
 8vlinAJTxYTtoJzX3WBBEphuxD217xy8YgIdIOBvVJDyIeUn+3CTcNl3/nqlSM38b04Bz91Sf
 mX791zrIgiF+5WsYSCUU6uAmCJoc8yKCX1/5RdCCzxYzmeIijMtUN+wKLR9HEZQ1cKOHbDNfC
 YT6pbJY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Replace uses of strbuf_addf() for adding strings with more lightweight
strbuf_addstr() calls.

In http-push.c it becomes easier to see what's going on without having
to verfiy that the definition of PROPFIND_ALL_REQUEST doesn't contain
any format specifiers.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/rev-parse.c         | 2 +-
 http-push.c                 | 2 +-
 send-pack.c                 | 2 +-
 t/helper/test-run-command.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c961b74..76cf05e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -469,7 +469,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 			(stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0) |
 			PARSE_OPT_SHELL_EVAL);
 
-	strbuf_addf(&parsed, " --");
+	strbuf_addstr(&parsed, " --");
 	sq_quote_argv(&parsed, argv, 0);
 	puts(parsed.buf);
 	return 0;
diff --git a/http-push.c b/http-push.c
index a092f02..d0b29ac 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1137,7 +1137,7 @@ static void remote_ls(const char *path, int flags,
 	ls.userData = userData;
 	ls.userFunc = userFunc;
 
-	strbuf_addf(&out_buffer.buf, PROPFIND_ALL_REQUEST);
+	strbuf_addstr(&out_buffer.buf, PROPFIND_ALL_REQUEST);
 
 	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
diff --git a/send-pack.c b/send-pack.c
index 299d303..1f85c56 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -265,7 +265,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	struct strbuf cert = STRBUF_INIT;
 	int update_seen = 0;
 
-	strbuf_addf(&cert, "certificate version 0.1\n");
+	strbuf_addstr(&cert, "certificate version 0.1\n");
 	strbuf_addf(&cert, "pusher %s ", signing_key);
 	datestamp(&cert);
 	strbuf_addch(&cert, '\n');
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 30a64a9..6bb53da 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -26,7 +26,7 @@ static int parallel_next(struct child_process *cp,
 		return 0;
 
 	argv_array_pushv(&cp->args, d->argv);
-	strbuf_addf(err, "preloaded output of a child\n");
+	strbuf_addstr(err, "preloaded output of a child\n");
 	number_callbacks++;
 	return 1;
 }
@@ -36,7 +36,7 @@ static int no_job(struct child_process *cp,
 		  void *cb,
 		  void **task_cb)
 {
-	strbuf_addf(err, "no further jobs available\n");
+	strbuf_addstr(err, "no further jobs available\n");
 	return 0;
 }
 
@@ -45,7 +45,7 @@ static int task_finished(int result,
 			 void *pp_cb,
 			 void *pp_task_cb)
 {
-	strbuf_addf(err, "asking for a quick stop\n");
+	strbuf_addstr(err, "asking for a quick stop\n");
 	return 1;
 }
 
-- 
2.9.2


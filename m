Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE17220285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdH3SAx (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:00:53 -0400
Received: from mout.web.de ([217.72.192.78]:54248 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752575AbdH3SAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:00:40 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7KN0-1dY2gS38Ny-00x5lK for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:00:38 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 27/34] shortlog: release strbuf after use in insert_one_record()
Date:   Wed, 30 Aug 2017 20:00:30 +0200
Message-Id: <20170830180037.20950-8-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830180037.20950-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
X-Provags-ID: V03:K0:P7TMhIRnyAYUaIu7jgfyktMONjFbedYkfn7F+z1nCMmx1Yu1fNn
 L84d+6LywtLsNQA+fMfTr7jLUp3FA6tNBvvHB0tyd1h39T+oMyRVZA6eUvwjfldQ6MHWV3v
 260jNQ9rsOItr6m1UPO/4ZvG3VdSkQ8D/YhQR4dFnXRdU+PjpOUHT6M1iZLKB/Dug50ths5
 wCLH9Ahd3LAnTR8qjW88w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iZUQKLhEONE=:2O+X56vcoPVKY1WypGdXXk
 QaFxaYTaCCZdgek9WZ31ApCei5dKZCDl/O+jco1PQe12DKGy6t7mt4Bms4Bf1/m+k/ZeJdwmb
 IMUJPeAQPUocdAw+HSddenL9AJKDFGR1dpsFj6u2SUGuAjm+Br+n/vOrPF361tPU38P9e8a1v
 dcsE2WMo5ewNgg3gs/RdOi91YGrQ6VLP0izfa1GmyI5zVJejTKzROzSoLIXrhwwpP0EBAQUCV
 x4JuuSC7Dehe3wYqiFtqcvurWVtCo3MH3hGxMPRFHF/EAMHvcCL9atfWY9S5zHr7n1dHx9omo
 BpHLPx2JGOX5ltRlF3f0ISg6X6cxnOm161MVSCBVGMIdQSiDg8xXzzDUPkcuTMypVDB/52+1V
 NqRS52mJVCvXuQ01pn31tPzCDNj3wV6YU8YyXO0cEWuc97V1NzEULuUqzuUN/5yk9J5CMAGGu
 foL9D28Pgc1uaR3KVtDhjAGPdzRNuC7DOQ91FceiAcm1u3FJ1CvqRmbCe13I+qkD9X1iHGsWE
 zGx1BXU+eYb9RxvnVa8M9rYn7VVopwBYBDNy5WHX2QcQZtKW9K9R68rWneA70DBzcEpcNh5AF
 dZXfyMey7yXxN7jLH6uTcUG5k6k2TEhyiHk/IXd8cREtlj3kTghSbtnByhnir89qRSQ5JVlJW
 k+VrCCsh/lQKBlKLz88070IddeQ+yQptn6AAzQVdPlvynlKmHQVN0ZBkqmUzAJRDE4APvFy1I
 IYFCiHxLeId6OZMbbgG4eP/G2f2rxjYpdHK9dx4n2jcGbVuPWeyoYvWC7vUK9b9Bi7OrubukR
 znVKv1vLCLm2udkS8bP1ajKSC9syQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/shortlog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 43c4799ea9..48af16c681 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -50,66 +50,67 @@ static int compare_by_list(const void *a1, const void *a2)
 static void insert_one_record(struct shortlog *log,
 			      const char *author,
 			      const char *oneline)
 {
 	struct string_list_item *item;
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
 	struct strbuf namemailbuf = STRBUF_INIT;
 	struct ident_split ident;
 
 	if (split_ident_line(&ident, author, strlen(author)))
 		return;
 
 	namebuf = ident.name_begin;
 	mailbuf = ident.mail_begin;
 	namelen = ident.name_end - ident.name_begin;
 	maillen = ident.mail_end - ident.mail_begin;
 
 	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 	strbuf_add(&namemailbuf, namebuf, namelen);
 
 	if (log->email)
 		strbuf_addf(&namemailbuf, " <%.*s>", (int)maillen, mailbuf);
 
 	item = string_list_insert(&log->list, namemailbuf.buf);
+	strbuf_release(&namemailbuf);
 
 	if (log->summary)
 		item->util = (void *)(UTIL_TO_INT(item) + 1);
 	else {
 		const char *dot3 = log->common_repo_prefix;
 		char *buffer, *p;
 		struct strbuf subject = STRBUF_INIT;
 		const char *eol;
 
 		/* Skip any leading whitespace, including any blank lines. */
 		while (*oneline && isspace(*oneline))
 			oneline++;
 		eol = strchr(oneline, '\n');
 		if (!eol)
 			eol = oneline + strlen(oneline);
 		if (starts_with(oneline, "[PATCH")) {
 			char *eob = strchr(oneline, ']');
 			if (eob && (!eol || eob < eol))
 				oneline = eob + 1;
 		}
 		while (*oneline && isspace(*oneline) && *oneline != '\n')
 			oneline++;
 		format_subject(&subject, oneline, " ");
 		buffer = strbuf_detach(&subject, NULL);
 
 		if (dot3) {
 			int dot3len = strlen(dot3);
 			if (dot3len > 5) {
 				while ((p = strstr(buffer, dot3)) != NULL) {
 					int taillen = strlen(p) - dot3len;
 					memcpy(p, "/.../", 5);
 					memmove(p + 5, p + dot3len, taillen + 1);
 				}
 			}
 		}
 
 		if (item->util == NULL)
 			item->util = xcalloc(1, sizeof(struct string_list));
 		string_list_append(item->util, buffer);
 	}
 }
-- 
2.14.1


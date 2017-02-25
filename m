Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC2D201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbdBYT2C (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:28:02 -0500
Received: from mout.web.de ([212.227.15.3]:55202 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbdBYT2B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 14:28:01 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McnaL-1cyxuJ0pUn-00Hu7o; Sat, 25
 Feb 2017 20:27:42 +0100
Subject: [PATCH 2/2] commit: don't check for space twice when looking for
 header
To:     Git List <git@vger.kernel.org>
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
Date:   Sat, 25 Feb 2017 20:27:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:doDsHiEfztzH2r+wcBDlqYivZOY0FyHdcbE4JOIzpT46lnw18Qy
 A7T3yy6Wy/viKCLAQT6G2mCwRN68M46H5Gc7i9sVujAx5es5Ww1eBWtY4LVpvB363Kvosgu
 EKEdj5kc4Q4pge/LbNHrLueqwJkmrf8xH/PrOhgiUVJf8Yqx+N6puYjMb629MYwFmOsBzTQ
 uAH+60xrR0a9WFy/ObIKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b3wEo3t9no8=:vPuQ74JZy+7Xj8YvK73eRY
 dGMj2yDIZ73RjFBPMHArK3tzdLMhw2vySyxQWyJqu1ZtsHxGNHOOE7IYkMIYQYOglM75lDKwS
 ScEr8mTVpmkX/v8susLbrBlNixFXOzzll1CefIpc27TLVTIyAu3h3Qav/iLNVmOMj6CTlvT4n
 3yykkhAEUkomIVaKKvkg07J+KI3aqBxV6atw4rZNXhKms468Rwalz1QOlwlVrks27sYCZZOz2
 BCdkPIx/tEpZjAiuFCiEbVhCqsGtcnlzylUiuJOtnjbItM0kKF92JeUCOyl3F5Uy+Jl8FPEm5
 BZet8Q8nxa7QaOWkn1qa43m9LPJf8WScr/WXMJGf3JQYCfYGYiQ+/qEu0Cq8UkNfy2G/GjmvR
 5OcFSDAy0b0UKWPJ3ySfXdFPTDv91bk6YkvATy31bsdjgLycrAhHMOMcD1bYSm5e1ovW5tAIq
 WFTwsZxM5rXOFP8LGlQiz1uf9P8U9yZ/qIkPyH97dV+gqjUFtvmCRFKQVJasDzzedlvVEgFFf
 qnxqDm8Wej0aFkovSUGCwQZQV7BhGMlWo80Ne73sezg6HM7SVnq7ut80N+4qoUabfYUURpr8h
 6EcwfdOBhrOUPYyi8ItBRJ/RoFVl5itO4Fs2T0mjkj0NMCCDqzB9sd22wH//suoigqpQEpiql
 QDWsVIvs3T7qy9WZwl0SQLP5j4iA/bVDZIb+s5WSNIOEH3COHop12HrcGUJJ4AcC300gZSFOb
 9tTRFXoTSTsYxXDPyqDBevGhKYQABoFDFI/9mrwWkx4wt9Gh/0Ao5Kl1gCkYG59zBlBoEqUzs
 zMawTTu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both standard_header_field() and excluded_header_field() check if
there's a space after the buffer that's handed to them.  We already
check in the caller if that space is present.  Don't bother calling
the functions if it's missing, as they are guaranteed to return 0 in
that case, and remove the now redundant checks from them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index 173c6d3818..fab8269731 100644
--- a/commit.c
+++ b/commit.c
@@ -1308,11 +1308,11 @@ void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
 
 static inline int standard_header_field(const char *field, size_t len)
 {
-	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
-		(len == 6 && !memcmp(field, "parent ", 7)) ||
-		(len == 6 && !memcmp(field, "author ", 7)) ||
-		(len == 9 && !memcmp(field, "committer ", 10)) ||
-		(len == 8 && !memcmp(field, "encoding ", 9)));
+	return ((len == 4 && !memcmp(field, "tree", 4)) ||
+		(len == 6 && !memcmp(field, "parent", 6)) ||
+		(len == 6 && !memcmp(field, "author", 6)) ||
+		(len == 9 && !memcmp(field, "committer", 9)) ||
+		(len == 8 && !memcmp(field, "encoding", 8)));
 }
 
 static int excluded_header_field(const char *field, size_t len, const char **exclude)
@@ -1322,8 +1322,7 @@ static int excluded_header_field(const char *field, size_t len, const char **exc
 
 	while (*exclude) {
 		size_t xlen = strlen(*exclude);
-		if (len == xlen &&
-		    !memcmp(field, *exclude, xlen) && field[xlen] == ' ')
+		if (len == xlen && !memcmp(field, *exclude, xlen))
 			return 1;
 		exclude++;
 	}
@@ -1357,9 +1356,8 @@ static struct commit_extra_header *read_commit_extra_header_lines(
 		eof = memchr(line, ' ', next - line);
 		if (!eof)
 			eof = next;
-
-		if (standard_header_field(line, eof - line) ||
-		    excluded_header_field(line, eof - line, exclude))
+		else if (standard_header_field(line, eof - line) ||
+			 excluded_header_field(line, eof - line, exclude))
 			continue;
 
 		it = xcalloc(1, sizeof(*it));
-- 
2.12.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E84E2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 20:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcGGUCc (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:02:32 -0400
Received: from mout.web.de ([212.227.15.4]:63645 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbcGGUCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:02:30 -0400
Received: from [192.168.178.36] ([79.237.54.245]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M57T4-1bUWFk2MRC-00zJbW; Thu, 07 Jul 2016 22:02:22
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] am: ignore return value of write_file()
Message-ID: <577EB546.1090007@web.de>
Date:	Thu, 7 Jul 2016 22:02:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pJrdAXycEO9mYYKJ003gFsX9/BdvHlRFjmZwgwtXjm7A0HxyOrM
 Tx8ts4iZsDwnBhpPm41uceOs9t2rrMKFU+fUhRXBpeL836nYQXgTlL7D1dKmNDOzpp1NfPt
 aTmRlnMG4z2YDGBZYfRpaQisBxhGZiO0bFdlHO7/cCwR0tDDcDPbDa1F3c/0mtpNmWco4T0
 V1JklPn8bFp0FnORam2BA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:RCkQK75pyR8=:gbSqRymFR78S+OR//5HXg0
 RAq9fWXmYW0He7hc5l+x7cmneS1fP1QWcHbWwBD0/+bWALhc3ALuOFxZ2wBKn3FNMpYBzdjn9
 PcBg16LS9u9M1kOAW+F8VF04ZgNuSQs970cRApjs4ivzigsPUKtcCPhp0oH5rLgs+E9rrpsr1
 xH4ggNpqowu25PbIFC3cMwiSBPh+8QTahbPDSWP88jcGDT8UffF/HzkN2Ry/LTdwIR/LDZ1XX
 W+wtpIhYmFLjQZM7FD6GZrOGgXkalKXm1senysuBTvo+qAtYyHVLKg7AG+x++J4iCqnZR2UhC
 nqEpZ3bWSwuEWHH9x+S7i51OonCONergakv74tWQ5Fjc1LsJNNBeXB5QjzXhL6kGO6L9tNSiq
 lALH4VegCMiL8gTGno3+6vnRvfqKvJNGnew9gDsxv5z1LslKjRBZDdlrF2XYNT509/kM7Sk22
 CIN4YWsSN/QFOD2g6YdRRbj0h+6Z2dt3ri7QeD9rMKtzCXIdHPh3V6YO2I2rEc8UP/+RIJam8
 n2GyGFPHp7q/dlWlhM8HJjTTcJ8FAfcW08j3ypgKXBdZNC1tN5W0j7QS017b/8RH+o4Kaiz4E
 kKsvIL9jNdeLKif38LwolaWmKscMgvN4gQgDDf8mwtyXNO6cBzVHxMVXR0Q0Y5+hHUe1o8v3e
 zRbf3pg9yDLrMmF0N8Mcq8cdQrofnSwN0BzZAKg3+1io/mDP1qU8KJXvuGmVxGHZcHA/VSy4J
 pRBtyafK7kFYnGfkCajybjh32+UVgJ+Zcbc0l77/g4JNguVdL04MwnxqKprcsZ/zrpFCb1GRj
 Zk3oVDG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

write_file() either returns 0 or dies, so there is no point in checking
its return value.  The callers of the wrappers write_state_text(),
write_state_count() and write_state_bool() consequently already ignore
their return values.  Stop pretenting we care and make them void.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d5da5fe..339e360 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -184,22 +184,22 @@ static inline const char *am_path(const struct am_state *state, const char *path
 /**
  * For convenience to call write_file()
  */
-static int write_state_text(const struct am_state *state,
-			    const char *name, const char *string)
+static void write_state_text(const struct am_state *state,
+			     const char *name, const char *string)
 {
-	return write_file(am_path(state, name), "%s", string);
+	write_file(am_path(state, name), "%s", string);
 }
 
-static int write_state_count(const struct am_state *state,
-			     const char *name, int value)
+static void write_state_count(const struct am_state *state,
+			      const char *name, int value)
 {
-	return write_file(am_path(state, name), "%d", value);
+	write_file(am_path(state, name), "%d", value);
 }
 
-static int write_state_bool(const struct am_state *state,
-			    const char *name, int value)
+static void write_state_bool(const struct am_state *state,
+			     const char *name, int value)
 {
-	return write_state_text(state, name, value ? "t" : "f");
+	write_state_text(state, name, value ? "t" : "f");
 }
 
 /**
-- 
2.9.0


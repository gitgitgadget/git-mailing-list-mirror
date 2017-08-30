Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659CA208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdH3RuJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:09 -0400
Received: from mout.web.de ([217.72.192.78]:60140 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdH3RuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:07 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7srs-1dZgsf3UpM-00vRQ1 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:05 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 01/34] am: release strbufs after use in detect_patch_format()
Date:   Wed, 30 Aug 2017 19:49:32 +0200
Message-Id: <20170830175005.20756-2-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:tJth6cJJrhE+4ZhKQT31DFh1xzmqe+IfVOdyZ8k1rt3DcW2U43U
 hgtZjEjotHVu4K4zCM3Rk+MbcCiwWoPJNANCIGjXFQMkf3HDyN38PSb7orvhLUdJQG8QoQ7
 BJc3FF5ZPV+myd9mWRuHpIx7ZoSaXQVZJEe5Kmzva3TzGqEx1PsTtK9GLTJ4Pm/BXVnaIHi
 Ehv+jm7QWoBeAKzKwmI7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8sqqVYHvRvM=:zGxJ7GMn/2gLcESLbqewAi
 v516kfJiQWKu7FXl+pFWNc0uj9Q+s2R7ulpVHlQOeToQ8Ennu6oqcHLwPASJp6G6hq1zH3NHx
 wkRn5JtnQIemJEACl7GYGZdqcmuHFwemW+cFjnLIKNJRrRSQt5JJm6dTUnNI8cAQrmm2Q1g7+
 iAR/8W8BG36kM4Aj7Af4MK2vP44SjuEo1VfP0gqChr3EIdS4VnQctyVXxBVvx7o9Q0yTNEZtN
 Q4w4gBPxoXraeo2ooZawiVxesOupcfYd7DSvjbDs8lwqhRjEYmJFxw1lNXtl1llbSGaUI5syJ
 YYuuH2QEEQwkA8XRcc8Z/1lpx/jzGUN2Wr50wfHRkKHQPgLw0+BzVbbN29I4jgZeOEfHZqwd8
 03IbyjLOpjjcCxTIAvVf8XnCPMADBZBbSx8s5mydcuSAO8BGhW920ZQYyP5DgT6EE5hweR1VC
 Y5mdvKdLqG1QD66KXmHkf+K33XlC/PAQXJIOFi+ZnGJL3TkaT0U8FvGEC7na7ia3djzIUZ2rp
 OTmWNoDz8L2JGu5ZXl9/Mo43y8Nv546aNhn8qSlovDZCLOR9HTVnXsGzn2vQzZUJj9ZJZLH+9
 PctzGxk9hvzep50OrOl2VEXLCp55SXREjH1Uyl6NoD02C2BkuepvLf0K/0Z6AEr9Pwa2QKfSk
 dyZn0B6U4G4mXhN0Efu5BLnoA/QqcSSL8h2/EWcQpHjeTFy7dHOp+Pjz0YVYd9V4LWowgLrHV
 h7jaNaK6kYn1DX46bpkdP2ypE1Tyi0kgEo1zX+xKwT9o6NzRGYjWojlM2aIklCfflxspWxltV
 F0i+paMC7P45CDdfdYFYu2Soo1CHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't reset the strbufs l2 and l3 before use as if they were static, but
release them at the end instead.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c369dd1dce..3c50b03faa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -633,73 +633,73 @@ static int is_mail(FILE *fp)
 static int detect_patch_format(const char **paths)
 {
 	enum patch_format ret = PATCH_FORMAT_UNKNOWN;
 	struct strbuf l1 = STRBUF_INIT;
 	struct strbuf l2 = STRBUF_INIT;
 	struct strbuf l3 = STRBUF_INIT;
 	FILE *fp;
 
 	/*
 	 * We default to mbox format if input is from stdin and for directories
 	 */
 	if (!*paths || !strcmp(*paths, "-") || is_directory(*paths))
 		return PATCH_FORMAT_MBOX;
 
 	/*
 	 * Otherwise, check the first few lines of the first patch, starting
 	 * from the first non-blank line, to try to detect its format.
 	 */
 
 	fp = xfopen(*paths, "r");
 
 	while (!strbuf_getline(&l1, fp)) {
 		if (l1.len)
 			break;
 	}
 
 	if (starts_with(l1.buf, "From ") || starts_with(l1.buf, "From: ")) {
 		ret = PATCH_FORMAT_MBOX;
 		goto done;
 	}
 
 	if (starts_with(l1.buf, "# This series applies on GIT commit")) {
 		ret = PATCH_FORMAT_STGIT_SERIES;
 		goto done;
 	}
 
 	if (!strcmp(l1.buf, "# HG changeset patch")) {
 		ret = PATCH_FORMAT_HG;
 		goto done;
 	}
 
-	strbuf_reset(&l2);
 	strbuf_getline(&l2, fp);
-	strbuf_reset(&l3);
 	strbuf_getline(&l3, fp);
 
 	/*
 	 * If the second line is empty and the third is a From, Author or Date
 	 * entry, this is likely an StGit patch.
 	 */
 	if (l1.len && !l2.len &&
 		(starts_with(l3.buf, "From:") ||
 		 starts_with(l3.buf, "Author:") ||
 		 starts_with(l3.buf, "Date:"))) {
 		ret = PATCH_FORMAT_STGIT;
 		goto done;
 	}
 
 	if (l1.len && is_mail(fp)) {
 		ret = PATCH_FORMAT_MBOX;
 		goto done;
 	}
 
 done:
 	fclose(fp);
 	strbuf_release(&l1);
+	strbuf_release(&l2);
+	strbuf_release(&l3);
 	return ret;
 }
 
 /**
  * Splits out individual email patches from `paths`, where each path is either
  * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
  */
-- 
2.14.1


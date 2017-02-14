Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13E52013A
	for <e@80x24.org>; Tue, 14 Feb 2017 09:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbdBNJzv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 04:55:51 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35058 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbdBNJy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 04:54:57 -0500
Received: by mail-it0-f65.google.com with SMTP id 203so4345083ith.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 01:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKc2+mbZ5QYwJGXxXYI03SrwQh9ggLRtRp65cqx2RFY=;
        b=lFRaYOkK8gQN8O8BQYAGXMY4vvbuFQF7O097thj3BbCJOR5vvpKMm/r60MgEhNH5Pb
         hOkqj13fVVz1kXG5af068ruWhm0PIxNQUIZcltGX8dPHuJM0bEErscPkkGHuL7vGIbiZ
         sBo/X3T0Ux/jN8jxjx4PvRMpeeJH2k6kS77H1xTkgHnrUm82FU6F9mG+puOF7waeJv9n
         H37AleDVAW2xJtGSHDKVtrb3bmKJ3SMMtaTcUguPFgAl+/3LitUGmiAv4Rf0KibxnLQ3
         dG/hUfLkSM1MLaBC3RMKI9vEQLDk3NQC+/0kgXCD1Iq0ZiPqd2ZLeNkhybhbbChOZ6VP
         yyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKc2+mbZ5QYwJGXxXYI03SrwQh9ggLRtRp65cqx2RFY=;
        b=I+iAN9cg9Pc4koa+dY3rDo4jG1t2vEI/6vv+iYoRYfYJ0shncwxM8ALlFujsYLDjmY
         NUluWqZg2CVMSTwMFMMzO2tDoEeIBougJvJkAghSHMVGxkbyyNyVw6E/3eHmA1MDVXJJ
         GXHg7cOGvI2X2c+ncpc5gMrRvW+0+g2wztUVKln1kyu7hiVItPXQP6f0ui6MTkSMV4Bx
         rauYQNP9IAkW60knqSitIGl0lI9UIWZKAIdZlpHNopUN81VXBEAvNInEqRlAgq8vZAUt
         0G38d7CsMAxGVCDzXU+g5/vYAIDCZEiIN4By8A06LGSSAWhvL5+BtLfvMSoi5EUtxOIG
         cflA==
X-Gm-Message-State: AMke39lqFv2oR7KCyjvP5mzkRM9ssl19irQXGfAQ5TYubOr46fv9uUkz+7w6HqAgiWn0cw==
X-Received: by 10.99.136.198 with SMTP id l189mr31381262pgd.45.1487066096245;
        Tue, 14 Feb 2017 01:54:56 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id y184sm115676pfg.86.2017.02.14.01.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 01:54:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 14 Feb 2017 16:54:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] clean: use warning_errno() when appropriate
Date:   Tue, 14 Feb 2017 16:54:49 +0700
Message-Id: <20170214095449.15585-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213092702.10462-1-pclouds@gmail.com>
References: <20170213092702.10462-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All these warning() calls are preceded by a system call. Report the
actual error to help the user understand why we fail to remove
something.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 dances with errno

 builtin/clean.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d6bc3aaae..3569736f6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -154,6 +154,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	struct strbuf quoted = STRBUF_INIT;
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
+	int saved_errno;
 	struct string_list dels = STRING_LIST_INIT_DUP;
 
 	*dir_gone = 1;
@@ -173,9 +174,11 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	if (!dir) {
 		/* an empty dir could be removed even if it is unreadble */
 		res = dry_run ? 0 : rmdir(path->buf);
+		saved_errno = errno;
 		if (res) {
 			quote_path_relative(path->buf, prefix, &quoted);
-			warning(_(msg_warn_remove_failed), quoted.buf);
+			errno = saved_errno;
+			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 		}
 		return res;
@@ -204,12 +207,14 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			continue;
 		} else {
 			res = dry_run ? 0 : unlink(path->buf);
+			saved_errno = errno;
 			if (!res) {
 				quote_path_relative(path->buf, prefix, &quoted);
 				string_list_append(&dels, quoted.buf);
 			} else {
 				quote_path_relative(path->buf, prefix, &quoted);
-				warning(_(msg_warn_remove_failed), quoted.buf);
+				errno = saved_errno;
+				warning_errno(_(msg_warn_remove_failed), quoted.buf);
 				*dir_gone = 0;
 				ret = 1;
 			}
@@ -227,11 +232,13 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 	if (*dir_gone) {
 		res = dry_run ? 0 : rmdir(path->buf);
+		saved_errno = errno;
 		if (!res)
 			*dir_gone = 1;
 		else {
 			quote_path_relative(path->buf, prefix, &quoted);
-			warning(_(msg_warn_remove_failed), quoted.buf);
+			errno = saved_errno;
+			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 			ret = 1;
 		}
@@ -853,7 +860,7 @@ static void interactive_main_loop(void)
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, res;
+	int i, res, saved_errno;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
@@ -980,9 +987,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			}
 		} else {
 			res = dry_run ? 0 : unlink(abs_path.buf);
+			saved_errno = errno;
 			if (res) {
 				qname = quote_path_relative(item->string, NULL, &buf);
-				warning(_(msg_warn_remove_failed), qname);
+				errno = saved_errno;
+				warning_errno(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
 				qname = quote_path_relative(item->string, NULL, &buf);
-- 
2.11.0.157.gd943d85


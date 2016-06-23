Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D781FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbcFWQ3m (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:42 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34289 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcFWQ3k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id l184so18868747lfl.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhttAlq6zjXw6gzLfQeL3foAp+Em2BKWEzpkWYI2sxY=;
        b=vAryu3jJlk5ZCc4GT6pwPPaKlkW+oOQC5e5OnlDAfD8DB1uvvt0qS0sYD7qHxzwUsD
         zpBmGGFcSp4SROexmBogOy9ANLFa1V3ZFIlZkzVl6hSpNsHkaSHY8mhUJuxHmGU4t3qd
         8gggDZdJ3CuD3VvjUQh85iHCdNdH0KibeYHvTI84lt6ryMK0pR0JyOpY2gD1O5xYkPBE
         ZiA2zt7XHgMsiEe0cYJKCtRWDRmQGuHs7Io4fIXaAr1IGl5VYJmAgDovQu2/+a7NIhRm
         ECf9DBCun8g2LX2TZXntxhJXjNtmBRgtYVTjDFqljpprD7Nj08gOPXqYJhWIljJn7clu
         si+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhttAlq6zjXw6gzLfQeL3foAp+Em2BKWEzpkWYI2sxY=;
        b=XqTZlCSmRMyS/biR24AWUjJv3TtJnJqXq25LF/HLKF1BOBrrzLo8mazIfiTg34oKem
         WOviDcZ1TdSDdCU6eUZkaT6O8YDy8lMN28gKd5wssyy6O0NPMvgUhR6s6gX+TYxmWjLE
         lg+2debBRwbCocTbAnclIEdT7u2xx/fw6rir3jw7uFzwJ4nlqCY7hq90tYX9gOWKSXX0
         NxEDhuXr1Xkqg2Xe1T3eztTn+4Hp1l2evoqiJ0V5kir8YwvcE5FJdouv7YLW1QksdUSN
         ZkpW/BK3StcPGZtW2Bt/issbdJhDsyIo7OlLJRanFiyJg08zcZLNRp00hctc5CfkhyXF
         Z8YQ==
X-Gm-Message-State: ALyK8tIy/HF7rAdXmn2Hb9LslCOQ9XZlM6JJYQxlz+Ct1sUopypr12ler4bGHNu5uW4TYw==
X-Received: by 10.25.160.135 with SMTP id j129mr4086490lfe.231.1466699378837;
        Thu, 23 Jun 2016 09:29:38 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:38 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/11] diffcore-pickaxe: "share" regex error handling code
Date:	Thu, 23 Jun 2016 18:29:05 +0200
Message-Id: <20160623162907.23295-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There's another regcomp code block coming in this function. By moving
the error handling code out of this block, we don't have to add the
same error handling code in the new block.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7715c13..69c6567 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -204,20 +204,13 @@ void diffcore_pickaxe(struct diff_options *o)
 	int opts = o->pickaxe_opts;
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
+	int err = 0;
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
-		int err;
 		int cflags = REG_EXTENDED | REG_NEWLINE;
 		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
 			cflags |= REG_ICASE;
 		err = regcomp(&regex, needle, cflags);
-		if (err) {
-			/* The POSIX.2 people are surely sick */
-			char errbuf[1024];
-			regerror(err, &regex, errbuf, 1024);
-			regfree(&regex);
-			die("invalid regex: %s", errbuf);
-		}
 		regexp = &regex;
 	} else {
 		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
@@ -225,6 +218,13 @@ void diffcore_pickaxe(struct diff_options *o)
 		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
 	}
+	if (err) {
+		/* The POSIX.2 people are surely sick */
+		char errbuf[1024];
+		regerror(err, &regex, errbuf, 1024);
+		regfree(&regex);
+		die("invalid regex: %s", errbuf);
+	}
 
 	/* Might want to warn when both S and G are on; I don't care... */
 	pickaxe(&diff_queued_diff, o, regexp, kws,
-- 
2.8.2.526.g02eed6d


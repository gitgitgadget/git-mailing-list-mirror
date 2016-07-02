Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F2F2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 13:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbcGBNNq (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 09:13:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34200 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbcGBNNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 09:13:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id l102so1267474lfi.1
        for <git@vger.kernel.org>; Sat, 02 Jul 2016 06:13:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9djgy5EHshsifNgdo4+BAXfSUUWezYiXoS4Tdpfq7E=;
        b=XXqNOTQoaKxUnPiAgPAvcn+0VJBQcBcnsdpQxrF6qswekpWxnsiVTi9AsQf3WHgdK9
         t+Ktwx0j57XVPVb7/18PTmYFycEFWEaIRyIP9jjGYJRtdHayWrJVTvYUv5D78hbzUUM7
         JJ+z1g+83sqqa2vQs9/NH6g4q5DcZfB7utfw+velyWfqLn+gDYyMZ1PQOArdQ5wgvni8
         rdzXKZUqQBPL7UPktpmod36Q4voMlUYDdojSoNqw9RGzFDnq7/awfkBkx3PgcxDacaZn
         9YKU9eFtHCtuLBhNq88SglctWDUoDWNVzuvpoZTHWYF3jK914uZyiXWS7POFUfy/+5Rq
         mnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9djgy5EHshsifNgdo4+BAXfSUUWezYiXoS4Tdpfq7E=;
        b=iO7fBX2jeeQHL0hVFs1kCgyYiVcuG0hqJ2T2ve/lhzr2GAXjapK4DH/wJbzDAt06Xu
         +ei8GGy3EjhvjJOXGOwuj21c0LJAorr3pahank1Vbhm7CllkzK1Q05TAxcSlCBNWZcHJ
         j+z+DQd4UVVcQKJ4X3gkjDkxely8z3tb+nKoAGtQe6PxJb2hU78RUOSLKv8mPUJYFF6R
         RRxf2Vu8SCBFxvJzhl9OWUcDwgyP+jDQahCyRhEaRmORupu6RM0sqh/W9FBOirwt5+JT
         8swrcwmECECc7oVMTSw/eOpB4SV3FrBJSn2rNMaSmjWW6vl9zqgf+1cYzoweuVcgU5ok
         txTQ==
X-Gm-Message-State: ALyK8tIrlV0OH4lH1wshoDzi3PEsfnFLdnYeiUhftJlX8j/z5/FIMEhCcWDplcMzr+YfHA==
X-Received: by 10.25.89.10 with SMTP id n10mr892728lfb.89.1467465224163;
        Sat, 02 Jul 2016 06:13:44 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id o184sm3162735lfb.19.2016.07.02.06.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Jul 2016 06:13:42 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] config.c: fix potential number truncation in git_parse_signed()
Date:	Sat,  2 Jul 2016 15:13:33 +0200
Message-Id: <20160702131333.8418-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.532.g6dfa503.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

clang -Wabsolute-value on IA-32 architecture complains that "absolute
value function 'labs' given an argument of type 'intmax_t' (aka 'long
long') but has parameter of type 'long' which may cause truncation of
value". Very unlikely for this code though. Nevertheless, add an
explicit check for truncation to shut clang up and error out.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index d7ce34b..880bd4a 100644
--- a/config.c
+++ b/config.c
@@ -503,6 +503,7 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 		intmax_t val;
 		uintmax_t uval;
 		uintmax_t factor = 1;
+		long int lival;
 
 		errno = 0;
 		val = strtoimax(value, &end, 0);
@@ -512,9 +513,14 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 			errno = EINVAL;
 			return 0;
 		}
-		uval = labs(val);
+		lival = (long int)val;
+		if (lival != val) {
+			errno = ERANGE;
+			return 0;
+		}
+		uval = labs(lival);
 		uval *= factor;
-		if (uval > max || labs(val) > uval) {
+		if (uval > max || labs(lival) > uval) {
 			errno = ERANGE;
 			return 0;
 		}
-- 
2.8.2.532.g6dfa503.dirty


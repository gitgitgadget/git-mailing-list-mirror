Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4A320707
	for <e@80x24.org>; Tue,  5 Jul 2016 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbcGERGe (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 13:06:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33013 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcGERG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 13:06:26 -0400
Received: by mail-lf0-f67.google.com with SMTP id l188so20287638lfe.0
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 10:06:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tTLSp6JP6Bc9vQhvq5FLwDSwrs1ninh0K4q0oqkuy0=;
        b=yozMoAl05yGin9j8Yg54dMIgXPLw2Or+CPrwKOG8MDRJ9d2vQhpi6gSCkjx4jrDo28
         Hch3lIaia2quCDcXAGFMgOO2LTgetHa+LM4EzepSOjN9GXkLXkTk2nAXBvu8LlOakp76
         EBMKCT5aRI4vi9JKGvJUvtmXm6+AI+lO7MkHIfJ1Z6RHoXeAfSa+38uzgVwucI5bHmv3
         TXLB/0vafA/5V1jyMfmjUiKmQBGMiS65icpXaCMLwxq0H8jMi8Fa0PR4WXssOW4hnts/
         fzrpLR85I3Ma4WM5gWLDupK5Qobftas6pbPsMEWsoMlUKNR03XwT/gCdNzUJWiX+SZbG
         cnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tTLSp6JP6Bc9vQhvq5FLwDSwrs1ninh0K4q0oqkuy0=;
        b=f4/ictPXuoB0SM1ZlwIJKFGNjQE9azX0YbVpPVk8RQ5c6zzUwPgMgZ2DtddXssPIQc
         4sHML6OlR/jBjGI2Fgqc4Z4GL5lQ1khPMzB5sLpjfzH6xJPqb3QHmPjdIFtEMs7Cbf3i
         J3/UTLw82WjLrMo+BLFSHQ+JJqVQA6co+8hu/aM86MmiJwy883NcLCVBy/O0qq9jLMd+
         pBrlQuVkjinQeel4wdRmGEXbS+hAn0cKnlnnTgpgSep2deRFwqQUnB+JmF2q469pQDLr
         HxVmGqOSzS+v6eXa8n1nVl/MBp4c5W05zon5A8jf9GRNYQBaH1o4OUR6fpiOt5qsXrnw
         I42A==
X-Gm-Message-State: ALyK8tKjTDN7ZGrfFkVwffnuKSmsUD2/yGZoo8tT/n7WxXfRPzfXN3vrhqGIhtBTn7kL5g==
X-Received: by 10.25.154.72 with SMTP id c69mr3706924lfe.72.1467738384695;
        Tue, 05 Jul 2016 10:06:24 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 142sm5693793ljj.4.2016.07.05.10.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 10:06:23 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] index-pack: report correct bad object offsets even if they are large
Date:	Tue,  5 Jul 2016 19:05:57 +0200
Message-Id: <20160705170558.10906-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <1466807902.28869.8.camel@gmail.com>
 <20160705170558.10906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use the right type for offsets in this case, off_t, which makes a
difference on 32-bit systems with large file support, and change
formatting code accordingly.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cafaab7..73f7cd2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -338,10 +338,10 @@ static void parse_pack_header(void)
 	use(sizeof(struct pack_header));
 }
 
-static NORETURN void bad_object(unsigned long offset, const char *format,
+static NORETURN void bad_object(off_t offset, const char *format,
 		       ...) __attribute__((format (printf, 2, 3)));
 
-static NORETURN void bad_object(unsigned long offset, const char *format, ...)
+static NORETURN void bad_object(off_t offset, const char *format, ...)
 {
 	va_list params;
 	char buf[1024];
@@ -349,7 +349,8 @@ static NORETURN void bad_object(unsigned long offset, const char *format, ...)
 	va_start(params, format);
 	vsnprintf(buf, sizeof(buf), format, params);
 	va_end(params);
-	die(_("pack has bad object at offset %lu: %s"), offset, buf);
+	die(_("pack has bad object at offset %"PRIiMAX": %s"),
+	    (intmax_t)offset, buf);
 }
 
 static inline struct thread_local *get_thread_data(void)
-- 
2.8.2.537.g0965dd9


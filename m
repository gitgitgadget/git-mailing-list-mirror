Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B0C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1C22176D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiwjGRCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfK1MZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:25:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44348 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:25:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id d199so8436721pfd.11
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqtF8ajq4HMwuHyAD1wbSIAYDlMLu+THm0CjjqMFL0A=;
        b=uiwjGRCW8I6ZtyyDWHqbM2pzMv7jL7eo7LVssSC7RO+Ud9OJ1m+AjQVp9SKL6WwNn3
         qK+r19hLbKuyUgmZ8+IC5ZqoCoRr5cQRIF1UIrXHBMJsh/ocI3ctiMwsmMjYsjIiCFGI
         wzfHpO4RNnyH9TxMisVNAtjYfqvHSMfveegiHuA21vR2X2LJ1MhOpEkb7Z+DhPtCTylf
         o9PMsITCAilNUDGyY5XIIbsW88W8MFkei3CfwdXtyVou8PviIDYbATumGx1Rzo4WUGF/
         MGDN3qQl45x64ax/1iZIazcmils2AtjzPW3DGA8PV1us9KtT439JjoLPYSDR2tgbETTr
         BnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqtF8ajq4HMwuHyAD1wbSIAYDlMLu+THm0CjjqMFL0A=;
        b=hyPk7R2JRK6wCiy0MEWvQd2z4okn/gq4q13i0h2BJqlTePqYJSStYIb1cDCW/axWec
         8iLKqz72KkwQeRfKjwNFBVUWNhZvnMojHoG4ORi9kLmEMq/ltiFPj6I2MprEc2nnkHFQ
         81WBO6cqkymDOYvsWYWq+xPPIUZo0NCm2ZSVACp2cYM/ulSp5Q8waepqAnY2mIq8qMAW
         QXvAdrrEPO4SLKdrPT90PzBNftnE8WdtPJ6t41aLqNKurNgEVyzM+u0N/AEFFEXfrnhz
         Dp4QN9JWq2uVp+3CAEZuoQ98cAOmlxGQCn1McgsHi9PCQni6dUFiFpe8gNDPPW/HR8W2
         YCzg==
X-Gm-Message-State: APjAAAWoUnAsgscIty9LAOANd2CZMvQO9ssNNjLeG54A/irORuAlz77d
        utMN35SMPKc4Xxa/ERLrJB7s+rfm
X-Google-Smtp-Source: APXvYqweer6h6bY3/yPVI6j6SYsgBTA4AMBauuFUzN2Tm5inM31qyiLzuukewAA96fvTzVNGvqfoYg==
X-Received: by 2002:a62:2a4c:: with SMTP id q73mr51697462pfq.94.1574943944725;
        Thu, 28 Nov 2019 04:25:44 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id r28sm18849448pgk.75.2019.11.28.04.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 04:25:44 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2 2/3] archive-zip.c: switch to reentrant localtime_r
Date:   Thu, 28 Nov 2019 19:25:04 +0700
Message-Id: <77798f17730b3c3ad739a9f4a73072e5bb6ac5d9.1574943677.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.615.g37f5bfbdea
In-Reply-To: <cover.1574943677.git.congdanhqx@gmail.com>
References: <cover.1574943677.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, git was intended to be single-thread executable.
`localtime(3)' can be used in such codebase for cleaner code.

Overtime, we're employing multithread in our code base.

Let's phase out `gmtime(3)' in favour of `localtime_r(3)'.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 archive-zip.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 4d66b5be6e..8bbd3e5884 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -603,18 +603,18 @@ static void write_zip_trailer(const struct object_id *oid)
 static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 {
 	time_t time;
-	struct tm *t;
+	struct tm tm;
 
 	if (date_overflows(*timestamp))
 		die(_("timestamp too large for this system: %"PRItime),
 		    *timestamp);
 	time = (time_t)*timestamp;
-	t = localtime(&time);
+	localtime_r(&time, &tm);
 	*timestamp = time;
 
-	*dos_date = t->tm_mday + (t->tm_mon + 1) * 32 +
-	            (t->tm_year + 1900 - 1980) * 512;
-	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
+	*dos_date = tm.tm_mday + (tm.tm_mon + 1) * 32 +
+	            (tm.tm_year + 1900 - 1980) * 512;
+	*dos_time = tm.tm_sec / 2 + tm.tm_min * 32 + tm.tm_hour * 2048;
 }
 
 static int archive_zip_config(const char *var, const char *value, void *data)
-- 
2.24.0.615.g37f5bfbdea


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6D7206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 18:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbcLLSRP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:17:15 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36251 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbcLLSRI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:17:08 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so13788007pfz.3
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fXXyHGd2neDiTlLS7urpgtqrQuX7zS+Vdd9WCvaLSQs=;
        b=PqAf6nCZtubfG3zwz9awRxVcjiHg7qCClQAdpeRMwO+60k6B1t/ZZBj7Q1C17mSx4T
         aQjh/hI39HmBKXQaA48y/W07vGTzoBapjAvdyVIr+ZUzfhnZdAvMi4WER4pBioTMajCI
         WAZF/gOFwQjHoxqoo0/loK1VlNfX8geP29JKPIblKy9Kq7FXBVEloU1nObytyDkKPPaO
         3P3qeA2bY+owZqSlyXqfk68qmOuVgGfo5RdiRpNwE0jgFYW/W1+kSXXf4f6XpJ5CqSLF
         CmhAZQ4vvdpm3oPcrFDtgSdg3nHMiIpXwUxjWdpjIjM9ENmZsOzGm1Va8i2DzyX4KXvj
         GV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fXXyHGd2neDiTlLS7urpgtqrQuX7zS+Vdd9WCvaLSQs=;
        b=TC13w1AWXS/EQ1ylQRxgSXNsSCLphjoxyXnrJxsYYrT2s8w/QDAJycOlEUchZcXvTQ
         GWZtrSU+p5EbPzfWgP8C9PQmo9wY25k5MaIDinkwKPWOQbk0VGuXj4v+4i5UbpTwFYf7
         7rbkXkxhAx7y1Yrj1P95IUBgKKLbr2UkgbliFFsZxTKWmkl6M+lG+wBlaqGUweeLlLVz
         Lir9IRSPNMfk/lQSCyRdXt+nacg9pfgO1kwu9hxqBRytNe40JgufiETaAwXYFj5P/Ytf
         709dWxqGPhwf9GsbcKKetO3cUb9Uv5hpupr2OWYGaij2T8LfprTdCWc4O/VxLqpolEnK
         YmPQ==
X-Gm-Message-State: AKaTC00nAbNaay7FDwCZgmrxj06cZoR9UPMbTHXdwb6WbiNreX8eqbFMUBqNaS7Cl8BLRmVR
X-Received: by 10.84.164.106 with SMTP id m39mr185742177plg.97.1481566627830;
        Mon, 12 Dec 2016 10:17:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y66sm77644889pgb.21.2016.12.12.10.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 10:17:06 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v3 3/4] real_path: create real_pathdup
Date:   Mon, 12 Dec 2016 10:16:54 -0800
Message-Id: <1481566615-75299-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481566615-75299-1-git-send-email-bmwill@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create real_pathdup which returns a caller owned string of the resolved
realpath based on the provide path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 13 +++++++++++++
 cache.h   |  1 +
 2 files changed, 14 insertions(+)

diff --git a/abspath.c b/abspath.c
index 8c6c76b..79ee310 100644
--- a/abspath.c
+++ b/abspath.c
@@ -205,6 +205,19 @@ const char *real_path_if_valid(const char *path)
 	return strbuf_realpath(&realpath, path, 0);
 }
 
+char *real_pathdup(const char *path)
+{
+	struct strbuf realpath = STRBUF_INIT;
+	char *retval = NULL;
+
+	if (strbuf_realpath(&realpath, path, 0))
+		retval = strbuf_detach(&realpath, NULL);
+
+	strbuf_release(&realpath);
+
+	return retval;
+}
+
 /*
  * Use this to get an absolute path from a relative one. If you want
  * to resolve links, you should use real_path.
diff --git a/cache.h b/cache.h
index 7a81294..e12a5d9 100644
--- a/cache.h
+++ b/cache.h
@@ -1068,6 +1068,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
+char *real_pathdup(const char *path);
 const char *absolute_path(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
-- 
2.8.0.rc3.226.g39d4020


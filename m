Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D083207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbdECKSb (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35364 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdECKS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so8166174pgd.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/vFinDIivOUdQNfbbeTcydqrfkRfGr4L6KObBQDR/s=;
        b=UXBlXBb1Hqrttic+65VbFmbKy6Uy3JY0OnybHq90ufpV87JsktIDiNBUhJ91k4Z0Ri
         4NeampiNKlniGhYnHgmOGOi+/xz5eQQFAc/7rzGcb2vv35h9n07tblFiRfH1IWO6bWl8
         uD3jPCzhZlbli6uJctmwoUH0KsX8fj2T+T0QplxHAXnORm722WNEVmGPnr4D+LMhMqYe
         AUMo2h1V0E39UdSQxPhVFWBF0uPpR8DNrOmnnPCQ9Qv2wY/M/Y+pYp0FBEnVcCz9oPeb
         X3gGLvBKcNFK/9yRDwyFykCjNOZqbvMzxlDtGwaGCd/a2B2Or2hRMJovSE1xKDsXSZuH
         3s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/vFinDIivOUdQNfbbeTcydqrfkRfGr4L6KObBQDR/s=;
        b=A3xbDIUYy5KTwO0JKAmUOfKNuZPJUyWgec2S/L+TBiGOQ3VlmYSQ0gYrr7q731/oSh
         Z8ETgtqxjZz5lklqV1ykxrK6ZhuhfXIDpEKo6YfBPM2Y/mbrMrpZhl3uF8FwfBDIgOrX
         Ss0LESULgsARe2Prevc2ZGW54jfnQaDQLmk2YQPF7QfX5L3SQ9uoBPWtapWBTSLGUE65
         UHk3j84OyVpdVX86zqlh8WXGGs5STHMDUGWIcpvB1ikapxaPwpnXgM5NCVCN411fwamW
         rwLRtqQ1vvWETML+l6mQkJsye8UE/o/TMMQ0V4e0/uC2KMtmBt3ZjNFVgyWtQ2R3+MtF
         TJWQ==
X-Gm-Message-State: AN3rC/4lQmYHvGKr2OcpfaLzkL6AUGbFddoh8/kBPOlT8+fN/2dL6v1y
        GkexYGZYAnS3lA==
X-Received: by 10.84.175.67 with SMTP id s61mr47937579plb.43.1493806708696;
        Wed, 03 May 2017 03:18:28 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 194sm7870025pgf.62.2017.05.03.03.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/21] wrapper.c: add fopen_or_warn()
Date:   Wed,  3 May 2017 17:16:50 +0700
Message-Id: <20170503101706.9223-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fopen() returns NULL, it could be because the given path does not
exist, but it could also be some other errors and the caller has to
check. Add a wrapper so we don't have to repeat the same error check
everywhere.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index c5b59c23e8..c1647b01e0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -800,6 +800,7 @@ extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
 extern char *xgetcwd(void);
 extern FILE *fopen_for_writing(const char *path);
+extern FILE *fopen_or_warn(const char *path, const char *mode);
 
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
diff --git a/wrapper.c b/wrapper.c
index 20c25e7e65..6e513c904a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -428,6 +428,17 @@ int warn_on_fopen_errors(const char *path)
 	return 0;
 }
 
+FILE *fopen_or_warn(const char *path, const char *mode)
+{
+	FILE *fp = fopen(path, mode);
+
+	if (fp)
+		return fp;
+
+	warn_on_fopen_errors(path);
+	return NULL;
+}
+
 int xmkstemp(char *template)
 {
 	int fd;
-- 
2.11.0.157.gd943d85


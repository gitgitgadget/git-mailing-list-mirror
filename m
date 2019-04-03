Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285F920248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDCLfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44906 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDCLfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so7899844pll.11
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNHEfU5Es+iTRROnoumQYR2DGfc6CnyeuJUutLTjvtc=;
        b=I0VTESrFTAtDVbdsD5ZeQzIoVPlQZFOLEBEIqx1WRAGdMsNdagZQdjzjp2G/ExsB/F
         v+1o/9PypTJmojK/txqJio87pnL9/c5FBbSIBwHPubpV0ZkPWWhoDz1krnToB3VBP0sR
         pq//qZBMQqsoziZK9vGu7PgLh+OcvBuO2ZdbaMN7N77CXkScJ0YOXmNw/pEJcfhEeWZg
         kcqxaViidHgwsX5knQqkYc1zXi2d1v9vFIXronbQ+44ExS43FTkHbhSHC/4FjzqDRwQ9
         Pnar6eRAeXbwK7fRU8g83QvqNnw+3e6L2bJvVs2CjPQXOM6UyPOOLYMkQwxLLwIr8s7M
         wPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNHEfU5Es+iTRROnoumQYR2DGfc6CnyeuJUutLTjvtc=;
        b=dBiK/EfUv1C51dvXbyECMFh4p0q+nPwmCEOJM3Xs7Hl6BrTX51x2OZDANsXfpI6jsY
         nB4D3dzcGvPmrvNpS7mPOt/zhd9sz2IiKFVtKqgt7ik+VTcVA9XvFD/PKiS3tFyh7HJw
         CqnypJ3Q2NlX3iyR94bq2+ICkUx3JLgMWXwYk8GtA7+Waum5FHWI28OkWkVNjkri/FD7
         jQ29hxC9bDXQJtLNflMw3vStZSheyFWHoYikRiV7iT41o7iGhSys26H69bA7vT7BblZU
         XMseXnLlYiyANuz7C9k7lPkEG+7rWDfyilU6O5KT8s7gxU1opQcuK7wM8lpuVYZ0WGNq
         8IdQ==
X-Gm-Message-State: APjAAAW7sTNkUVFsqqeqXMYCOI2QJUUmN3p6Mb/QD+U4Z/S6AZmqvQhc
        PDPtJxY2MGM0aA7sTRxLDH4=
X-Google-Smtp-Source: APXvYqxVsp/wTAxqzmDgFluNPx2tFy6xSf1Pul2C2x7XNQ3hbV4I9VtsI/dlFBvshOcaBTwn0vIPzA==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr75924379ple.48.1554291329965;
        Wed, 03 Apr 2019 04:35:29 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id r87sm15063774pfa.71.2019.04.03.04.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/32] refs.c: add refs_shorten_unambiguous_ref()
Date:   Wed,  3 Apr 2019 18:34:29 +0700
Message-Id: <20190403113457.20399-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 11 +++++++++--
 refs.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index b869f32d8b..3dde824aab 100644
--- a/refs.c
+++ b/refs.c
@@ -1169,7 +1169,8 @@ int update_ref(const char *msg, const char *refname,
 			       old_oid, flags, onerr);
 }
 
-char *shorten_unambiguous_ref(const char *refname, int strict)
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict)
 {
 	int i;
 	static char **scanf_fmts;
@@ -1247,7 +1248,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			strbuf_reset(&resolved_buf);
 			strbuf_addf(&resolved_buf, rule,
 				    short_name_len, short_name);
-			if (ref_exists(resolved_buf.buf))
+			if (refs_ref_exists(refs, resolved_buf.buf))
 				break;
 		}
 
@@ -1266,6 +1267,12 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	return xstrdup(refname);
 }
 
+char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    refname, strict);
+}
+
 static struct string_list *hide_refs;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
diff --git a/refs.h b/refs.h
index 308fa1f03b..5627570241 100644
--- a/refs.h
+++ b/refs.h
@@ -462,6 +462,8 @@ int check_refname_format(const char *refname, int flags);
 
 const char *prettify_refname(const char *refname);
 
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict);
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-- 
2.21.0.479.g47ac719cd3


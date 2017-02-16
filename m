Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D87220136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbdBPLtw (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:52 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34162 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754832AbdBPLtu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:50 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so1834809pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=foSDmp0OVDrVD431UCvHFlaRSbADtsx9saxgAL0HexA=;
        b=XcMLoViPnsVc+XIMpVKEMXWCr4ytRzWR5svbKZQls24/3PRAclPgFr9RZ4AU36w3eu
         xmsIVhdWblI/bjh5KtnZ5Sy/Jpyk9NAIcKhI3+05xlTxD46g7kN6GftqMDZxFvKdE65E
         CfK7vTYuykDoGjcQnRqNLkxZbw7xOrpVvCBArR8O7tdkovX6sKcDtrI7SnfmDK8RPZR7
         gC65sR2zsmaodaFC68PyXTlPmoh4KriX1q29ra1lrCJPA0T0vA314NvDnF86EetrmWgt
         CKVvVY3gxZGo/1RJT6AaEdF56ujX8dGE+zf/g+ZRpzyao/Q+8xuTSW818+8f/ymK0Aw8
         Sq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foSDmp0OVDrVD431UCvHFlaRSbADtsx9saxgAL0HexA=;
        b=YeXOcNgb3T/ZVfq4IaMdGVvfCYJSYRHTyXC5tgz/PV1xylM6F2wCZV4zkXdENnvcK1
         mbWhKYlqwSHuZgIYh2bNdV2V3yEVuoFjrmaDwqBIN/IitFEg5eSuOkCI0XCms1G23FLx
         kPnfz1EWzMVE2++FLaZQSwRtMcYhQmviWGCV5Rq20ervsB8Hkuj3TwV3vlxjeU96IgJB
         3qyP82hQ4bcXOMDYglD/UKsJ75RRVqIIcoHN7rGbeN1QBFHR2Y085qOxQ2lwP8CodTLm
         CkgdzBYxDS7dYkdYoNZ6jI2Us0e9Z0TPgk+2AnWHAJfPc7XYM8o5XyAjNiNgfkXr99Ps
         ir7w==
X-Gm-Message-State: AMke39lHGQk0IyYanaJeRZKcaYWzXXQOLbXlj8CYmoj2/h2susYQ8AWy+Au5xtgml6EiHg==
X-Received: by 10.98.38.130 with SMTP id m124mr2193071pfm.22.1487245789470;
        Thu, 16 Feb 2017 03:49:49 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t14sm13297046pfk.85.2017.02.16.03.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/16] refs.c: flatten get_ref_store() a bit
Date:   Thu, 16 Feb 2017 18:48:12 +0700
Message-Id: <20170216114818.6080-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps the future changes in this code. And because get_ref_store()
is destined to become get_submodule_ref_store(), the "get main store"
code path will be removed eventually. After this the patch to delete
that code will be cleaner.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index ea13a5b86..76a0e7b5a 100644
--- a/refs.c
+++ b/refs.c
@@ -1454,22 +1454,21 @@ static struct ref_store *get_main_ref_store(void)
 
 struct ref_store *get_ref_store(const char *submodule)
 {
+	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
-	} else {
-		refs = lookup_submodule_ref_store(submodule);
+	}
 
-		if (!refs) {
-			struct strbuf submodule_sb = STRBUF_INIT;
+	refs = lookup_submodule_ref_store(submodule);
+	if (refs)
+		return refs;
 
-			strbuf_addstr(&submodule_sb, submodule);
-			if (is_nonbare_repository_dir(&submodule_sb))
-				refs = ref_store_init(submodule);
-			strbuf_release(&submodule_sb);
-		}
-	}
+	strbuf_addstr(&submodule_sb, submodule);
+	if (is_nonbare_repository_dir(&submodule_sb))
+		refs = ref_store_init(submodule);
+	strbuf_release(&submodule_sb);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


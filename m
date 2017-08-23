Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3334520899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbdHWMhy (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:37:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38114 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMhx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:37:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id h75so1343344pfh.5
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eW4s1bOPVFTX4aYtoW9GEkazUY7UFvbQL7xnS3C5Hh4=;
        b=DIPCCvKoUh3ugH0SqW8sSQWdS5e56vu0iT4rv70a6X3Ni5S6ptYVoZePMb/bxEqxu3
         8QQeZRnLofqdWwSDBp1PFRYzEGicUYf6wKVw2Rg7qPRJKbtCoEZFvEtMaQI0GlZEtCK6
         cfI1r5NoS0p7qI+lfyy6drqvsGfKPlfmOI/wHV71WJO4vBUP6Jitot2Kt4MVLOgYY21G
         W8p5Jug1x0G+zVfQ5X++A4nIWFiw68lrNxHa4+jvfexbRpr6Qm1Hf6luExGjnWdJHjX6
         fdF8uhJqNAZDYZ2Z0RBxskA1JN41gz3X+J+JEqa3SqFOlq9nXd6CKaARqhIxetkCS63u
         7UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eW4s1bOPVFTX4aYtoW9GEkazUY7UFvbQL7xnS3C5Hh4=;
        b=tJWiyXEkpuWT37JuDNxPaSnT/dxIa9qqIS7iTXyToKUCP8JUJFXQRr6URxh4D2EgIc
         5GyfG8Du3FSDWTJRNgNpl2msYjveDNyxnM7F+67iE72tiEAdd+r5/vlze+5W3K5zH/Wz
         PISISB/4XGMvmg5GQ6/cOriF/CSSvTbMqVltSN+YkDMDhFHkP+wPlUzXS4Nq1J3pLl+Q
         gAtj87iQuKfQyzzBC2RROLKtoc5CtvzViY/ApUjuejhz311/KPgHcF8Q57NUcypyeoaE
         32wQu5XEUAm+QSjDvip+M5ffoPeh7FlB8WSU92mV7TE+TtuhM6Nu0/Xn5zYbM8/JY88Y
         XlMQ==
X-Gm-Message-State: AHYfb5g7qdMWWq1U5OEg/h0ZOp+W5KF4O+/5c99FkUCSNpzhWNpc4xCs
        DSZChyK4gb+NVGB8
X-Received: by 10.84.171.195 with SMTP id l61mr2991940plb.464.1503491872756;
        Wed, 23 Aug 2017 05:37:52 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id e184sm2984050pfe.172.2017.08.23.05.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:37:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 05/16] refs.c: refactor get_submodule_ref_store(), share common free block
Date:   Wed, 23 Aug 2017 19:36:53 +0700
Message-Id: <20170823123704.16518-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index dec899a57a..522c4ab74f 100644
--- a/refs.c
+++ b/refs.c
@@ -1636,7 +1636,6 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
-	int ret;
 
 	if (!submodule || !*submodule) {
 		/*
@@ -1648,19 +1647,14 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
 	if (refs)
-		return refs;
+		goto done;
 
 	strbuf_addstr(&submodule_sb, submodule);
-	ret = is_nonbare_repository_dir(&submodule_sb);
-	strbuf_release(&submodule_sb);
-	if (!ret)
-		return NULL;
+	if (!is_nonbare_repository_dir(&submodule_sb))
+		goto done;
 
-	ret = submodule_to_gitdir(&submodule_sb, submodule);
-	if (ret) {
-		strbuf_release(&submodule_sb);
-		return NULL;
-	}
+	if (submodule_to_gitdir(&submodule_sb, submodule))
+		goto done;
 
 	/* assume that add_submodule_odb() has been called */
 	refs = ref_store_init(submodule_sb.buf,
@@ -1668,6 +1662,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
 
+done:
 	strbuf_release(&submodule_sb);
 	return refs;
 }
-- 
2.11.0.157.gd943d85


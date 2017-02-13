Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3092C1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbdBMPVN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:21:13 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35411 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdBMPVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:21:09 -0500
Received: by mail-ot0-f195.google.com with SMTP id 65so11880547otq.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds/TNmMImbaLRdPC5Ge7lwO+nRYl6gaul+QUy4nlWtA=;
        b=D9cw1kD9WKGRNecVRR+nQ+mG5Nc2ZiyUV5VVJN1AqrXzks1oylkNjtq6uMDM7UJqHd
         qz9WFmPXLi+R/dMqMvFrwHCzMTl0z6DwBytib92X4/duhp5IgS/TBitCk2FX2O1xLKZ1
         mSqDJ5kqrQPrY/qWCK5Ru4lNRcuna4gExUnR+avwjnVEpoXfwvJk9p09bqb/UpeDIjfU
         Y94Z9t+w7BsopkhWG/u5E9i2s6MYqyz7Osu5JKeMhLvYMEEGHD7P56y+dX/BdrUTeY71
         gYlMeNFwZjpuhMUJWpU4TO53D0eLqPnehUDC05tjgHKr07aXx1cKh8PLirHNapcXQgcj
         g64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds/TNmMImbaLRdPC5Ge7lwO+nRYl6gaul+QUy4nlWtA=;
        b=UmzKceu+zBEsKTTscgyI6IiBkUTOvvIyEmtXe3a33wp5pkCpp+YwJaFZGPXS2K8vDu
         W2HNhut/k4fs/uiRtFyt9GXva1TgPIr+MarxWg86oaQPhXDP9YOIi1OLfoZUUv2EJVqt
         lMkEYoRqEa2agZKCNQp+PYVTHubGm3RU+GY1Z69doxkRPS1YxIYWd1woKr4JPDl935z2
         Qvp9ZcwNUfpPrykH1jAYwUbPZ4YmRfoZY9TSLaxSF/WUJm6gj/ULRqhi92AexJ7VvIJ9
         wqi1W/oA38nvjJBwWlyOBf3SKdS67Dod29dwcCnvXvckWffNd7oQVEFL6f2/98e9EmYE
         eAlg==
X-Gm-Message-State: AMke39kisbVTf1Sy7VKgNw2V0dXW+bo3hFBosE+3mBAUmHz0cPMZscvLVIPf0NhI+/uJ2g==
X-Received: by 10.98.78.66 with SMTP id c63mr26767080pfb.138.1486999263622;
        Mon, 13 Feb 2017 07:21:03 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 2sm15387469pfv.100.2017.02.13.07.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:21:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:20:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/11] refs.c: factor submodule code out of get_ref_store()
Date:   Mon, 13 Feb 2017 22:20:08 +0700
Message-Id: <20170213152011.12050-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code is going to be expanded a bit soon. Keep it out for
better readability later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 2cacd934e..8ef7a52ba 100644
--- a/refs.c
+++ b/refs.c
@@ -1445,6 +1445,18 @@ static struct ref_store *lookup_ref_store(const char *submodule)
 	return entry ? entry->refs : NULL;
 }
 
+static struct ref_store *init_submodule_ref_store(const char *submodule)
+{
+	struct strbuf submodule_sb = STRBUF_INIT;
+	struct ref_store *refs = NULL;
+
+	strbuf_addstr(&submodule_sb, submodule);
+	if (is_nonbare_repository_dir(&submodule_sb))
+		refs = ref_store_init(submodule);
+	strbuf_release(&submodule_sb);
+	return refs;
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
@@ -1457,14 +1469,8 @@ struct ref_store *get_ref_store(const char *submodule)
 	} else {
 		refs = lookup_ref_store(submodule);
 
-		if (!refs) {
-			struct strbuf submodule_sb = STRBUF_INIT;
-
-			strbuf_addstr(&submodule_sb, submodule);
-			if (is_nonbare_repository_dir(&submodule_sb))
-				refs = ref_store_init(submodule);
-			strbuf_release(&submodule_sb);
-		}
+		if (!refs)
+			refs = init_submodule_ref_store(submodule);
 	}
 
 	return refs;
-- 
2.11.0.157.gd943d85


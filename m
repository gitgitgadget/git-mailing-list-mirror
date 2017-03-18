Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBDD20323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdCRKMw (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:12:52 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34355 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdCRKMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:12:30 -0400
Received: by mail-pg0-f66.google.com with SMTP id b5so13175011pgg.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DyGzlNLH7q94U+xat0Bk6cIJHxLZruA6/GZdgZaw4+o=;
        b=CnjsosRhBaqz5r6Z9ZiDLK0KbOOTNwvpmypB9Ic1n8SJC2AviAMzZb8PO08EybhMpf
         vT8/mNJvg1V1WhzlQ1ozX12FmP7J3T/PtYat0oBVs1XXbH/RfideTmNamwmHT582+hEy
         w5RRn+jEs66aKjJyQ8f7WOiiFwdG5hTMAonfV85W1dAEvxoL6sH6/1RXsucwt5mBuO7f
         AmJrz16IGe73MrphZDB9UUbfaf9E3k91RLn9arpGHPyhhiQ/My/ChmIR6Z2MJubbblWB
         IRjuVq9sLAmBPmucia2iTs41V4e/xTYHpwW9XPB7NyxBumSO3ApMUoVvMuPkSN96B/aP
         IVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DyGzlNLH7q94U+xat0Bk6cIJHxLZruA6/GZdgZaw4+o=;
        b=MZRCfZvQNWdeJoz5Xv4HlPmESEPPbqEacbuktBc9M/nwfeZxbhUcC755/HcbHk3Dgv
         qI43tH3ojxtjAX7hsf2PO/Bu3TiX7Ca74GA6+A0gFV7e34/h84JKHPPXP91klNjHkRA4
         T3Y+R9dEtXsqMI4JZnPzx6u6U829KqCP5sYYsg/qv1Ij1b8VomhO9JN9diOSXiruYwhQ
         qW/bK5UlqCeOKWLDvElGN+FVwc3Vo4fn0Pomit5Nx09q3KTVXx5qF4v4rUq1LZWr0EVV
         Wxq+omtbLR3hTRK+Vzt5UbPLrScvg1b/qorVARzDKEN14Qkhfx+ukwSqIDhtN+A6OBcc
         M1uA==
X-Gm-Message-State: AFeK/H3u2+gMSBAgOIaf6OZUkcoYCPxPFpR9tIXFDcLoRyoan6QjVcAR4eBf5yvPIwKw0A==
X-Received: by 10.98.192.151 with SMTP id g23mr21775416pfk.254.1489831949622;
        Sat, 18 Mar 2017 03:12:29 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id e68sm21800860pfa.85.2017.03.18.03.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/12] refs: move submodule slash stripping code to get_submodule_ref_store
Date:   Sat, 18 Mar 2017 17:11:46 +0700
Message-Id: <20170318101153.6901-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a better place that will benefit all submodule callers instead
of just resolve_gitlink_ref()
---
 refs.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 8912798c1d..a38149d84a 100644
--- a/refs.c
+++ b/refs.c
@@ -1422,25 +1422,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 int resolve_gitlink_ref(const char *submodule, const char *refname,
 			unsigned char *sha1)
 {
-	size_t len = strlen(submodule);
 	struct ref_store *refs;
 	int flags;
 
-	while (len && submodule[len - 1] == '/')
-		len--;
-
-	if (!len)
-		return -1;
-
-	if (submodule[len]) {
-		/* We need to strip off one or more trailing slashes */
-		char *stripped = xmemdupz(submodule, len);
-
-		refs = get_submodule_ref_store(stripped);
-		free(stripped);
-	} else {
-		refs = get_submodule_ref_store(submodule);
-	}
+	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
@@ -1559,7 +1544,17 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
+	char *to_free = NULL;
 	int ret;
+	size_t len;
+
+	if (submodule) {
+		len = strlen(submodule);
+		while (len && submodule[len - 1] == '/')
+			len--;
+		if (!len)
+			submodule = NULL;
+	}
 
 	if (!submodule || !*submodule) {
 		/*
@@ -1569,6 +1564,10 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		return get_main_ref_store();
 	}
 
+	if (submodule[len])
+		/* We need to strip off one or more trailing slashes */
+		submodule = to_free = xmemdupz(submodule, len);
+
 	refs = lookup_submodule_ref_store(submodule);
 	if (refs)
 		goto done;
@@ -1589,6 +1588,8 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 done:
 	strbuf_release(&submodule_sb);
+	free(to_free);
+
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


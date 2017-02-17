Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0FB620136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934370AbdBQOTy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:19:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32996 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOTs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:19:48 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so5070326pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYZRuRF1o64L3LFBwRp1Wbtg3ayk6gVe/oW8sT1u2Vk=;
        b=Iz8MwrDaUunD+aUflRsxTnvqiduGm+hSuNZINNO0TBgax/V28kf2ZVRUpQ0DPj9AHW
         jd5AWFzGHVvdeg/WulazjUSHf8TQCu/Pi85i7hHnLkA6+2U+1rTDB/x1qrSN1H2KNxYT
         /74s6TVGUDEOfJLnAGPilqLDXJk4CE6bl+TXkxwurYQ8J3+djNJ1JGTcm98jI1kE/04v
         z8EFo4XzcQBBkT/V18yGd9dBc0PCEXftZdiEGGHQHfnp5uZ65+CSS2j12WHGcAS5nmJj
         luLj8j866QhipjUwzei3JIKsD6qnBTnBW3mCzw0m+7qnmDslrTZWG9pJurB/zBTzz0KX
         SuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYZRuRF1o64L3LFBwRp1Wbtg3ayk6gVe/oW8sT1u2Vk=;
        b=b/G+0iF1Dn1z2K7x0TqRd5nBWPn+bpE3VggNc88oNhKfIIw4f56PFbBB7H5WMm/g9z
         eL+2lGHak/B/332RrtGnDFoKp2r44TKKEvcUuu9tn9R2irBzVjbExOEEOj/d+TMfjRId
         na2hS99Q+7ed4PrQgAQaf7PmoeUakVkOESRjDwe80ixGi50rIEJ3pcZ+km4+BoM+csQT
         EojX/a498yiRwz6VJTJEQgRS+zjnTn2RoSf59/DtwOEbAeC7Tv8dqRtEr6T+JnQoTb/D
         tmcf3n8AQvTTg+BThtg0MOZZQP7kIAR46LNn0Wco4t/LEug3fOKpDQJHtAEqF5O8rYjJ
         JWog==
X-Gm-Message-State: AMke39nEMNglOMMqPXEl85AbnHUEypjAqvYE8Ke0SM3SsSpdX/2ql8W2q7S3BrlYWn2KRw==
X-Received: by 10.98.90.196 with SMTP id o187mr9682959pfb.30.1487341187471;
        Fri, 17 Feb 2017 06:19:47 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id o12sm20123611pfg.15.2017.02.17.06.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:19:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/15] refs: move submodule slash stripping code to get_submodule_ref_store
Date:   Fri, 17 Feb 2017 21:18:57 +0700
Message-Id: <20170217141908.18012-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a better place that will benefit all submodule callers instead
of just resolve_gitlink_ref()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 23e0a8eda..9c86c44b8 100644
--- a/refs.c
+++ b/refs.c
@@ -1321,25 +1321,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
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
@@ -1458,7 +1443,17 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
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
@@ -1468,15 +1463,19 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		return get_main_ref_store();
 	}
 
+	if (submodule[len])
+		/* We need to strip off one or more trailing slashes */
+		submodule = to_free = xmemdupz(submodule, len);
+
 	refs = lookup_submodule_ref_store(submodule);
 	if (refs)
-		return refs;
+		goto done;
 
 	strbuf_addstr(&submodule_sb, submodule);
 	ret = is_nonbare_repository_dir(&submodule_sb);
 	strbuf_release(&submodule_sb);
 	if (!ret)
-		return refs;
+		goto done;
 
 	ret = submodule_to_gitdir(&submodule_sb, submodule);
 	if (!ret)
@@ -1485,6 +1484,9 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 	if (refs)
 		register_submodule_ref_store(refs, submodule);
+
+done:
+	free(to_free);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


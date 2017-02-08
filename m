Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9331FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 11:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932864AbdBHLcD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 06:32:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33777 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbdBHLcA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 06:32:00 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so14980816pgd.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 03:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf03dtNcYO8+VsGpfyW6p9fjb2jaGAalZ/Nna77tRPM=;
        b=DMm7h8PtJMTnQ912JLVEpMuaX7bQf8hp9tGFlHPvyKUfcZkNzKRWW2wcvV8H9+COQy
         Zx5Y2IjlAQO8XJ1N4gn+Pwg+DwRIGO0YwcewElDyKnjB5fS2GmnrO9KolZEsqWKe/tDw
         R4d7OWRk6W88q5P/z144pHXNXPV8YbjG9rigIJvhJE3ohGBNeIMrvjBGtkGyoAL52Jub
         hVqVs+omgPHyULdSD2ydJfzuXJE0CXYWd+Ly/uZWqW8WpJeyiAd2tmlU2Orc2Jd9h4cQ
         5kP5OlISGsADQThaByf9PqMFjPAqqz46kZXD2oawZ1KhlhXx/VQLcik01cTgn9790E4D
         obXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf03dtNcYO8+VsGpfyW6p9fjb2jaGAalZ/Nna77tRPM=;
        b=fF0rQEBc286NviU4AMRk5b5tge7S57+PFRYTLnyYRwxQ0GYW06+3ucoyJ/0fr4o3QR
         lo4O6b0k03s/f2n43LhYAAuASzow5/2Ty1td82aNJTrqZnSgPb8409q94pQyiPN4EpvY
         EMlcd82UBUBRkY8Wp91eo4GTnXoxqz7RGP6Xlm1W0GV6tjZMGwvZK/StI2Sm240M42Fe
         XTz9/4nYnebdP+no28iC6fn9XYOsPWUV7pl9NPUZik5j1ukQMw2mdgSDXjGJTE5qAL2/
         iYWzj1jreTr29sr1hvgZul924lGPKt1keTWfyTGu0ZG1MTCQNXYXx9d3DTweuE13aoNL
         35ug==
X-Gm-Message-State: AIkVDXJfK5MtUaGsn19rSPt2wV+v1pWVjivgqwcCJe57mv30/CWOCejam1X2sejJuOJvqw==
X-Received: by 10.84.162.204 with SMTP id o12mr33384480plg.132.1486553515313;
        Wed, 08 Feb 2017 03:31:55 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id k76sm19549678pfg.42.2017.02.08.03.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 03:31:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 08 Feb 2017 18:31:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] refs.c: add resolve_ref_submodule()
Date:   Wed,  8 Feb 2017 18:31:43 +0700
Message-Id: <20170208113144.8201-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170208113144.8201-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is basically the extended version of resolve_gitlink_ref() where we
have access to more info from the underlying resolve_ref_recursively() call.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 20 ++++++++++++++------
 refs.h |  3 +++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index cd36b64ed9..02e35d83f3 100644
--- a/refs.c
+++ b/refs.c
@@ -1325,18 +1325,18 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 				       resolve_flags, sha1, flags);
 }
 
-int resolve_gitlink_ref(const char *submodule, const char *refname,
-			unsigned char *sha1)
+const char *resolve_ref_submodule(const char *submodule, const char *refname,
+				  int resolve_flags, unsigned char *sha1,
+				  int *flags)
 {
 	size_t len = strlen(submodule);
 	struct ref_store *refs;
-	int flags;
 
 	while (len && submodule[len - 1] == '/')
 		len--;
 
 	if (!len)
-		return -1;
+		return NULL;
 
 	if (submodule[len]) {
 		/* We need to strip off one or more trailing slashes */
@@ -1349,9 +1349,17 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	}
 
 	if (!refs)
-		return -1;
+		return NULL;
+
+	return resolve_ref_recursively(refs, refname, resolve_flags, sha1, flags);
+}
+
+int resolve_gitlink_ref(const char *submodule, const char *refname,
+			unsigned char *sha1)
+{
+	int flags;
 
-	if (!resolve_ref_recursively(refs, refname, 0, sha1, &flags) ||
+	if (!resolve_ref_submodule(submodule, refname, 0, sha1, &flags) ||
 	    is_null_sha1(sha1))
 		return -1;
 	return 0;
diff --git a/refs.h b/refs.h
index 9fbff90e79..74542468d8 100644
--- a/refs.h
+++ b/refs.h
@@ -88,6 +88,9 @@ int peel_ref(const char *refname, unsigned char *sha1);
  */
 int resolve_gitlink_ref(const char *submodule, const char *refname,
 			unsigned char *sha1);
+const char *resolve_ref_submodule(const char *submodule, const char *refname,
+				  int resolve_flags, unsigned char *sha1,
+				  int *flags);
 
 /*
  * Return true iff abbrev_name is a possible abbreviation for
-- 
2.11.0.157.gd943d85


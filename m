Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6901D20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbdHWMh7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:37:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35626 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:37:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id k3so1351306pfc.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9zA9Xs71UhlXVNasm9MV8PybP5pQT9MYBPjDJ9Z1t0=;
        b=dhZM2U1GbRbjeV7xq4ogOWiSNik/Bc7NDJTrq7+l2Ijh1Nytp3lZTtE6aFzG6Kx3OP
         XvO8NrDBTvMd+ao7TXelcpV4d++TMn42zRilmadQaVKSmi0szboS9h/s1ItclQwats7S
         7W5VEtKOOnj8Z1y+hhxxEdpRyaduaqXgzNjoVAh8KGM7FJJw3lb0KwlrfYBIYPvHzTtv
         lEKUuxiohym9f03IljU0WNy7+AhlWeHwkxTg+UVxdLUqmZ12EKWp8YqPryjmbXTIclGb
         I9ZHEy4nwqVtm+k+UwGjIA0huICZeGUTVlLGvIUjZSxCKPW+F/l8cQF8uILi8LthlVLC
         ZOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9zA9Xs71UhlXVNasm9MV8PybP5pQT9MYBPjDJ9Z1t0=;
        b=ca8HR7m67XCUPNXqleGHmax6Za2gQJT2mhyG59akqCLI+UY02Gxk34obNelqbQm1vG
         yLIQ7vEaXPTbydQbj7egzbYWb6w+6379gO8vbeevv5sucm6VSX4OsbWb975HSUicfcTd
         YwrikAuSq57trPAqVi0HLw9UFrsldzs6WSzgMsT8ACAw7oM4PHxfH8NpdKQ7i61fzjlz
         uA9MB+oHEzi4gzqRzmud6FzdXX+SC2YrXGwXvAW73Vqrf4dxC79pc7ck2uGAOmXk6mlP
         uUQBebA1A+kcjuyJLGiHYhAMNMGpkP7rKMGyGu9OzKNQMXar4rhWCuDI5opskT0EiF2N
         Cskg==
X-Gm-Message-State: AHYfb5iSU2A8rl4xiBpFk4eU/0dzFaQyVBK7CMGYBSVLNSFBrkzFJ+Mx
        r67dVwvUxMF20Mvs
X-Received: by 10.84.232.141 with SMTP id i13mr2775400plk.87.1503491878132;
        Wed, 23 Aug 2017 05:37:58 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id f16sm3636013pfd.55.2017.08.23.05.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:37:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 06/16] refs: move submodule slash stripping code to get_submodule_ref_store
Date:   Wed, 23 Aug 2017 19:36:54 +0700
Message-Id: <20170823123704.16518-7-pclouds@gmail.com>
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

This is a better place that will benefit all submodule callers instead
of just resolve_gitlink_ref()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 522c4ab74f..ea8e6b9f42 100644
--- a/refs.c
+++ b/refs.c
@@ -1503,25 +1503,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 int resolve_gitlink_ref(const char *submodule, const char *refname,
 			unsigned char *sha1)
 {
-	size_t len = strlen(submodule);
 	struct ref_store *refs;
 	int flags;
 
-	while (len && is_dir_sep(submodule[len - 1]))
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
@@ -1636,6 +1621,16 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
+	char *to_free = NULL;
+	size_t len;
+
+	if (submodule) {
+		len = strlen(submodule);
+		while (len && is_dir_sep(submodule[len - 1]))
+			len--;
+		if (!len)
+			return NULL;
+	}
 
 	if (!submodule || !*submodule) {
 		/*
@@ -1645,6 +1640,10 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		return get_main_ref_store();
 	}
 
+	if (submodule[len])
+		/* We need to strip off one or more trailing slashes */
+		submodule = to_free = xmemdupz(submodule, len);
+
 	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
 	if (refs)
 		goto done;
@@ -1664,6 +1663,8 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 done:
 	strbuf_release(&submodule_sb);
+	free(to_free);
+
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


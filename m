Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD7520136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934465AbdBQOUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:52 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33215 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934178AbdBQOUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so5071835pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzQhTEEuuyWQ2ZfjroAS7Ig/e9PuZ1xOiSMKn9VzHlU=;
        b=PcvUmkcI7yaNWgaAP5O6C2UGqsr0x0v4pFjK5bcev1V1+Hf3R9s5WmlZQ5/eh/c4kc
         /Q5lJVnVsbWVlZwjQRNM6nQ4YWuyW26hNdYBrimucKZ6x04iMtLqaBqtkco7mo1orhKr
         Ur2t2+gzg5BMZFFH5BMIpwvV97LdhLyYFLdH2Z0vQvAbPGI1wHQin1Qc89rWFxqBzGIz
         z7bpg8Mr4cithWLIm8NDOaRe0D0m8kKGjPw0yWze+h8vpESt9lTyBb1/1exIDM1oF1hZ
         Z36op5HCX2M2ZbH/rA2UZdZ3179Oq/IKGy1i/2/nLPaEYVQdcij1xxGqAnI3XlXZiUg8
         O5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzQhTEEuuyWQ2ZfjroAS7Ig/e9PuZ1xOiSMKn9VzHlU=;
        b=Y48aJweUF9AbkmlT8ezTWItbU01QihbTgqeCsJ1brVxxV0f0t6v5DQ+w/7piaOD8lL
         DPfWkHMeIDNpwyvQ+sCppGon5iFrjEPin+fx+QztxQfrwNNyl8Lz27l8FfMdFHjDKCRL
         XRp6Dz8T3Oq5owF4sRZWEhfMzwcKLZtJQTBCqD7DqkKfSot5Eig/mQ8TjsRWVstGNjx3
         7/pV6coIFM3Mmxsi6dxQJfTu5+E6ZmD6E6qHpAmCRapMYPVhen3P96KdrCO9x+So+5xl
         HOaBKcn+pRQQpsvoj+q0qIoToKmwk6jCVvYep+QQRastCDKoWyhKULBip6MTmflYw1xe
         R8sQ==
X-Gm-Message-State: AMke39nqwIZjTbBwOLFhrhvDHns1muEMMHB43GUkSZXI/Yf/OIf2izgZQUeDSK7N4K8xow==
X-Received: by 10.99.117.8 with SMTP id q8mr10554567pgc.9.1487341239656;
        Fri, 17 Feb 2017 06:20:39 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t133sm20253219pgc.24.2017.02.17.06.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/15] files-backend: make reflog iterator go through per-worktree reflog
Date:   Fri, 17 Feb 2017 21:19:06 +0700
Message-Id: <20170217141908.18012-14-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 011a7e256..d429f8713 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3314,6 +3314,7 @@ struct files_reflog_iterator {
 	struct ref_iterator base;
 
 	struct dir_iterator *dir_iterator;
+	struct dir_iterator *dir_iterator2;
 	struct object_id oid;
 };
 
@@ -3334,6 +3335,10 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
+		if (iter->dir_iterator2 &&
+		    starts_with(diter->relative_path, "refs/bisect/"))
+			continue;
+
 		if (read_ref_full(diter->relative_path, 0,
 				  iter->oid.hash, &flags)) {
 			error("bad ref for %s", diter->path.buf);
@@ -3346,7 +3351,11 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		return ITER_OK;
 	}
 
-	iter->dir_iterator = NULL;
+	iter->dir_iterator = iter->dir_iterator2;
+	if (iter->dir_iterator2) {
+		iter->dir_iterator2 = NULL;
+		return files_reflog_iterator_advance(ref_iterator);
+	}
 	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
 		ok = ITER_ERROR;
 	return ok;
@@ -3367,6 +3376,12 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
 	if (iter->dir_iterator)
 		ok = dir_iterator_abort(iter->dir_iterator);
 
+	if (iter->dir_iterator2) {
+		int ok2 = dir_iterator_abort(iter->dir_iterator2);
+		if (ok2 == ITER_ERROR)
+			ok = ok2;
+	}
+
 	base_ref_iterator_free(ref_iterator);
 	return ok;
 }
@@ -3389,6 +3404,13 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	files_path(refs, &sb, "logs");
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	strbuf_release(&sb);
+
+	if (strcmp(refs->gitdir.buf, refs->gitcommondir.buf)) {
+		strbuf_addf(&sb, "%s/logs", refs->gitdir.buf);
+		iter->dir_iterator2 = dir_iterator_begin(sb.buf);
+		strbuf_release(&sb);
+	}
+
 	return ref_iterator;
 }
 
-- 
2.11.0.157.gd943d85


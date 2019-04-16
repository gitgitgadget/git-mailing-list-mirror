Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA2920248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfDPJhY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45385 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfDPJhY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so10042367pgk.12
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3Haq9BL+2QSQ6IXg1M6Biu3LzvW3KM0b+B/hUTQS44=;
        b=h9K5JMVtBo5USB6E9bbUqKW3sPqV1ZPB6FavaHF27OVo2yqddxiaHOhndQ7OM6uWEq
         YHfRODRKm4rkE41J7OuukGDtkt+IV2gGm4JnvM0hPbriDDqyUY1bnnFoprM6qZJcZB6r
         1qM03tvvEyqOydZHesE0ozaMTVX7E2ibxt6dUBFDcjpd168PJxIHs0jumqqoCQeQ1HDn
         6rR/B5cWpcJE1l34VP6cQKxceq7P5bTZ+lqfogxYAB7VYkz3pe5sw2jCYPiqinPT4GEM
         K7HOiYStuqOA8U6iOjKgWDiFwrHep5q+FnJOQomO05Wi4GU6bZm7az4Id38F1Qza1ie+
         4qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3Haq9BL+2QSQ6IXg1M6Biu3LzvW3KM0b+B/hUTQS44=;
        b=otSp4/0TKgn701briqKv3pfjemKY4BfKj8Xu72MJxGJyY62Bb9G9URnsHd5h17aE/3
         k5MNY5FDJPoe1pY+jYRRtdJiVFOT9bnqe6ilnwx9gjRBiMntV/NVCF7SNWbMLWDvN5kH
         bXmTfr7JgTcSAiqqkMtA7xKA7eKbAagftb3eDl8AOJ/kawJLLXfOkMEI2QRxXrLZLO2P
         foUCsOiDpSi50i14ogkq/4We8uU//cN97OxuOeG2y06RJZ9xh717DBJBcpS9JY9wonq2
         /aoNHza2aQB1RIRJ5NCN/Fjh1zHj8A2b2uR1T/1Y208rqSZu5B/1S9+ANbe0uAvEaYLR
         IR6Q==
X-Gm-Message-State: APjAAAUYxZyIMcR7l5eGTLOcBtD2z2QMXu4x2LziByqkcByfDizYpXi5
        /4B/HAgdcF9yK2kUVltMr6W9Jsrv
X-Google-Smtp-Source: APXvYqwnYHfbUFm1CXDH29LE//Pt5QxFqrPoPs90HQpL20jr3Yf57iQCi+XNbp3xMEiIYHXmhq6XYw==
X-Received: by 2002:a62:1647:: with SMTP id 68mr19399896pfw.113.1555407443708;
        Tue, 16 Apr 2019 02:37:23 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id l74sm91377966pfi.174.2019.04.16.02.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 28/34] sha1-name.c: remove the_repo from resolve_relative_path()
Date:   Tue, 16 Apr 2019 16:33:35 +0700
Message-Id: <20190416093341.17079-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"remove" is not entirely correct. But at least the function is aware
that if the given repo is not the_repository, then $CWD and
is_inside_work_tree() means nothing.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6caf3f4e3a..6b53ea2eeb 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1719,12 +1719,12 @@ static void diagnose_invalid_index_path(struct repository *r,
 }
 
 
-static char *resolve_relative_path(const char *rel)
+static char *resolve_relative_path(struct repository *r, const char *rel)
 {
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (!is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree())
 		die("relative path syntax can't be used outside working tree.");
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
@@ -1785,7 +1785,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		new_path = resolve_relative_path(cp);
+		new_path = resolve_relative_path(repo, cp);
 		if (!new_path) {
 			namelen = namelen - (cp - name);
 		} else {
@@ -1839,7 +1839,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-			new_filename = resolve_relative_path(filename);
+			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-- 
2.21.0.682.g30d2204636


Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB095C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1BB20706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc+Ld1Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDXPMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgDXPMm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:12:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4DAC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so3245825pfn.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsKvaFxShVvtV19V1GAHBkKbRAndfAUKlC3PVY8PwaM=;
        b=Kc+Ld1CqCdb7+tPsya1d9dKSkMJZGNPBU05vfvkPjTCqivWFfDZyE1J3Ea8ZQuIAZy
         XO2GG3YsV2Ushe1Ik2dtnDna2vGhvItGzOo2q2qdOG8ckYvUvBR6JlPVhYumqv7j+JI3
         sH+DpWc7YlfbfEVm6Ax9rVn0poh5KRJU3S0kK/RTSwlSMMfSv/xpidnVVHnXBL1yKoJT
         HYg+LLlGAPQHphqAUVXm+OckfU54qAFnx9qC9iavYjFt14xRd+WXcNH8HCEFJSo3Xj1d
         81VOGd8uQWpOHrvrO9dnAWVlQAD8xwN71M1ywwJ9q/2pPypGMKUlTJjnDk9BbZXUnx75
         4MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsKvaFxShVvtV19V1GAHBkKbRAndfAUKlC3PVY8PwaM=;
        b=TJlMjoovGUdb8ZinimHk59yDetOoEkm+2tlQ+Aix/TrITYFCKVFDXWzq2AZPTMtJpe
         WSCGNwSiwZ+eqPrzl9abS1rlya5pn2TOxJZI/pyTHlRpVa06ZlKcZDub2EsG97Mx4kE7
         LvczeFaGH3SVTLH14ealI7+S3M6Ssnm3yJsmGZjzHXY6xrj+iH3Z0ulbgQS6jNSAEcCP
         K7dx6P3E1XNw7mAb1joMWCemqdWM2hBmlkdODYJdssX+5hAQdakMbf8aTM9dZ76D7PPf
         JpLQ6LIFO5+naV0DFS1+DfhyLrihxKRjVfvD7pIDVmEstLmxCP5YQLO1V/MHk3O6N32t
         nCmw==
X-Gm-Message-State: AGi0PuaLCjdbbj1DCKaJPq8+tsX6ptLh3/bDHRHqSUIaZh3IHhGKy911
        QsWoj2iGqmVqDiGEXMXh+IP8PiM7
X-Google-Smtp-Source: APiQypKqZ+dyQtUqRnSFhZGnCgaSpdp2n9SpKA40dmO6WUasLS2zLTVrbKVmH+a4OCex8USmjUBXEQ==
X-Received: by 2002:aa7:97a6:: with SMTP id d6mr10012799pfq.92.1587741161429;
        Fri, 24 Apr 2020 08:12:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id f99sm5078429pjg.22.2020.04.24.08.12.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:12:40 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/4] test-parse-pathspec-file.c: s/0/NULL/ for pointer type
Date:   Fri, 24 Apr 2020 22:12:30 +0700
Message-Id: <c9a1812abfc1d2ec804105b703f44639c0f8e3e7.1587740959.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587740959.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587740959.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/helper/test-parse-pathspec-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
index 02f4ccfd2a..b3e08cef4b 100644
--- a/t/helper/test-parse-pathspec-file.c
+++ b/t/helper/test-parse-pathspec-file.c
@@ -6,7 +6,7 @@
 int cmd__parse_pathspec_file(int argc, const char **argv)
 {
 	struct pathspec pathspec;
-	const char *pathspec_from_file = 0;
+	const char *pathspec_from_file = NULL;
 	int pathspec_file_nul = 0, i;
 
 	static const char *const usage[] = {
@@ -20,9 +20,9 @@ int cmd__parse_pathspec_file(int argc, const char **argv)
 		OPT_END()
 	};
 
-	parse_options(argc, argv, 0, options, usage, 0);
+	parse_options(argc, argv, NULL, options, usage, 0);
 
-	parse_pathspec_file(&pathspec, 0, 0, 0, pathspec_from_file,
+	parse_pathspec_file(&pathspec, 0, 0, NULL, pathspec_from_file,
 			    pathspec_file_nul);
 
 	for (i = 0; i < pathspec.nr; i++)
-- 
2.26.2.384.g435bf60bd5


Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88ACC54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8734B206CD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceJRjT7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgD0OWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD0OWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 10:22:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309EAC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a31so5615985pje.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eA+O4sddYdP5GMNRX+j0xbuvsli0tMVBLdUsgqzMRGI=;
        b=ceJRjT7WubZe8b4OKf6tdou40kDqGQ7soYyQNj2ZioTJZGQXpaseShzdjvy56oADNJ
         hwzhgZRVodZHUxsMNya7gvfFq91lto9aUIgPq+BSiyR/iUF2OKSbeTBsO/g2j4AIgA4Q
         2gX9qsPjmlF2jeAFnnNsjMMz+f0bxzlewNiQw7OuBT+fG+Vg/wPge/NpPE1/XegiIev4
         u4FVb2anmzAeyOPJ1b4/9aEoawORTu4znWotJBHjySlfmMqpcDL9oZzfGHveG99PpoBd
         5ovtW41qAWCsz5dx8fsYLKKC80/g4xlcvkM7HCc6Hw/jKK2vhdksmxG8OvlptAX+JV8/
         kUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eA+O4sddYdP5GMNRX+j0xbuvsli0tMVBLdUsgqzMRGI=;
        b=LRCv/R73tpveEdjXcGkBRirEd3oQ9UE8prNyCNr1CFKzdeMd4A7Tj2HL0/B2z6AR3x
         BVFuLKf0il8natpoYlpAUeeQB18sMEyTHmPVh1rwp9NGJQIQflweINanLVTJ0p9ztSb1
         xtyqXOEe5drhmHxzuY8WFNu+/1laJX6DnDrztSGPP87V18kcsvx9Ksz3xZJvQ52dMBFu
         04EZVC+C8D2bnnVwXwtEvpyww8Y6hFhB8dnibMu5Y+CkJ+8vjtFn+Xqo0hV0oN/jJPCH
         c1BiuAX6Y26Mw33sSGrihN2Xf45w/lzeFg87/wDPQ6L86thojL5mFakEAyV2ltfYl7vk
         1bew==
X-Gm-Message-State: AGi0PuYmA4kQq7WZDH5D8/fNEdRaxPfXEKhBtQb4JqUF7WRsHHzNwNRc
        Oz8tZz8YoNKYaCJTVCUb8tmcYUWA
X-Google-Smtp-Source: APiQypJNqAYb0L58qY+0cyJlH9sdbjdL9HVJlsVCsa2292muOt+zjBCgslcggkW9oyz779/UfkbEzg==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr11156288pls.214.1587997371524;
        Mon, 27 Apr 2020 07:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id c1sm12589602pfc.94.2020.04.27.07.22.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:22:50 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] test-parse-pathspec-file.c: s/0/NULL/ for pointer type
Date:   Mon, 27 Apr 2020 21:22:34 +0700
Message-Id: <c9a1812abfc1d2ec804105b703f44639c0f8e3e7.1587996766.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
In-Reply-To: <cover.1587996765.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587996765.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Notes:
    	struct foo val = { 0 };
    
    should be taken as idiom for zero-ing structured data.

    I think this should be written to CodingGuideline.
    I'll prepare a patch for this addition

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
2.26.2.526.g744177e7f7


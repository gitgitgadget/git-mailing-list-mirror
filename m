Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91053C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C226141E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFORXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFORXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:23:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783AC06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:21:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so2252505pjz.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+vWYT2qt/Qucoi8PSDv68ZdtCRQHUgA2pe6hKJhx0s=;
        b=KZ2H52kijhaHgta5+MzMQZwDa1IdjHynhnIHdHJs0IbJHnfYSLZzBD6lM6p0zwMcVw
         CkE5L91dDZJNt7gjW3uQ1tmADCqDIXCJqXvxQ3hUwuaaoW2NsrBkvH+lArRis9znmhoH
         w+yQYF6av5NBDwgrYgWmysxA5Og+JlAaa9EPU3A0ALGrwB3qUdfjgine/LJGDVcM+Z4r
         tdIzTCqJLYnEUNlF3l4GiSJ+WVaEPjgaRehH7zY7LGCrkny90EDipfovw1P9Esz/zJhQ
         BbSsnWd/fs6gPdiIgAL3NNTTCOWHyyepRhqvKBCQJ0/qzYKJBNKG68R3CepFPGAT1Bpj
         oYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+vWYT2qt/Qucoi8PSDv68ZdtCRQHUgA2pe6hKJhx0s=;
        b=UxKfKOUAXWlVTtitm7ifiJTuS74tvFHr4VCUBQyYs2kEd25303+5DwLdVH/3cEGvfX
         HIzFr89VxiV3+Z/ZB2dXaD2Mv16cqD5HpM/XP9sfY34gb5p/ENjknqmuoOqd/9GtaGR5
         zuAS8eg/K0fBd8w7ho9QvUycrbADjLlt+MirPHpb5HGmA8pupvllG9PGru1gfc6IHcSZ
         8vlAT5vMkaSEygFbufgx4Y2Fj4bavQHvI2DkKGMegUIisZQ51hVUycPNclAp4pJpWH+U
         SfGBc2oUqGDqHafqoTeeS7yq/xL4jx9J21hqsPSrVYUMo7easVZ6ghX/byu/5Qd3Nfh/
         OW2A==
X-Gm-Message-State: AOAM531ibPpZn2w9UJpup7IU+mDgC7o6BlZ+7h3z0nGz/1jXOxXDHbdK
        7tqWhPe9TWWuzTYxYBUnyKjgYbB8WnE=
X-Google-Smtp-Source: ABdhPJwxmJmARq/zVC/RyG6Kf5mLDWMKUL4h5SEXcWzpjo0dhBlLM6nD82IRsy/lSMqQBalUxXpmUA==
X-Received: by 2002:a17:902:ce8e:b029:10c:eb2d:8d2e with SMTP id f14-20020a170902ce8eb029010ceb2d8d2emr4882399plg.15.1623777665238;
        Tue, 15 Jun 2021 10:21:05 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id z22sm16864162pfa.157.2021.06.15.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:21:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/5] t6400: use test_line_count_cmd to count # of lines in stdout
Date:   Wed, 16 Jun 2021 00:20:37 +0700
Message-Id: <20210615172038.28917-5-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6400-merge-df.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 38700d29b5..8cf3603a24 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -82,13 +82,13 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_line_count_cmd --out = 5 git ls-files -s &&
+	test_line_count_cmd --out = 4 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 0 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 1 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
@@ -103,13 +103,13 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test_must_fail git merge delete &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_line_count_cmd --out = 5 git ls-files -s &&
+	test_line_count_cmd --out = 4 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 0 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd --out = 1 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
-- 
2.32.0.278.gd42b80f139


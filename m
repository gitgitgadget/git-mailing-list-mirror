Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0782FC76196
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjCXUyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCXUyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB455AD
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x3so12587380edb.10
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7k/lcP0By6gbC7MFqksaAdhGbjPogHyvJ00FCXooYA=;
        b=OsplpOeAItl3suOMKFhpkE4stuGTPzKJ0ps/yNrAMZG/heZqNb0z9xX3f7CTdglnJE
         oD8glFLKrweOL7NrWy8DvFh8y/TdLh/JzLYjnwVtqIHe51o/3tA3UQbU+tyE6wP6tYeB
         grgJ1eFdUPIph1NH1fWwk+yPshOaLUICoL/qXFtcSmb6MaF/8MCzTapB/7R8YSZ2os47
         If/Q2W/njSn/BBHmHnB8UdlJYH85hNrQ58nxLe8gbp9JbcaDrrMVg7L+Hr+m2RdbbWro
         u3pQcBckFMLm8DMs+I4BlQrRZ4rOZRRCs/SsBER/DP6TaYSqDpvunS+IQz8aD5JbY4uz
         FVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7k/lcP0By6gbC7MFqksaAdhGbjPogHyvJ00FCXooYA=;
        b=Belo+ojGyeK699mAl6+Z3qMY+Jav+Rc9JhC8nrxnqqfqwZc9xUzUFWUDWQWWGTMdu6
         w8Sji7c0CBZskeKfJkWo1wOfMxgGsM3ZN5BPnZdpx+PifAWPUKBI4hukVu2zuaPVn7Uq
         U65PoCvgdgSVpO0++i4lzb0ddHe+Bc1oEVddKvfpUfhfgNu0xmNeI33BPO907CDnNNVu
         qCGzpLmZLuLXvQk6dteQ9+h5p6RxeF1pMHMTRd6O/PTMGcAM+e8xbK/vY4JTPNUmLRL3
         nCqT2NM5B94UPpgSjEy2ZKdcKMjLYhwxpiuHFnkR4hgJn8kat4ifAYJbKT050/xkZjH6
         DXFQ==
X-Gm-Message-State: AAQBX9eB8zULmplCJm3Lb29KZBkm5Suziv9oyiS/eW/Cylvyfz/y1KAP
        Yw4c6TNIsJRH11r8ChTNbsTWyCFEifV2cgdY
X-Google-Smtp-Source: AKy350acSne/0SbZSx2FD9Qihtu3wg+P0vq9anvMjt+ykGvpac1SiyapovEKX77W1/kBrGzccoZTIw==
X-Received: by 2002:aa7:c141:0:b0:4fa:ada1:796d with SMTP id r1-20020aa7c141000000b004faada1796dmr4278818edp.10.1679691277894;
        Fri, 24 Mar 2023 13:54:37 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:37 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/7] t1005: assert output of ls-files
Date:   Fri, 24 Mar 2023 21:54:28 +0100
Message-Id: <20230324205434.93754-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230324205434.93754-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'reset should work' in t1005-read-tree-reset.sh compares two files
"expect" and "actual" to assert the expected output of "git ls-files".
Several other tests in the same file also create files "expect" and
"actual", but don't use them in assertions.

Assert output of "git ls-files" in t1005-read-tree-reset.sh to improve
test coverage.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1005-read-tree-reset.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 12e30d77d0..26be4a2b5a 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -41,7 +41,8 @@ test_expect_success 'reset should remove remnants from a failed merge' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'two-way reset should remove remnants too' '
@@ -56,7 +57,8 @@ test_expect_success 'two-way reset should remove remnants too' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain reset should remove remnants too' '
@@ -71,7 +73,8 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 	git ls-files -s &&
 	git reset --hard &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain checkout -f should remove remnants too' '
@@ -86,7 +89,8 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
@@ -101,7 +105,8 @@ test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.40.0


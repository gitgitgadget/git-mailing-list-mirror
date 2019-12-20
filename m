Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FFAC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211DD2082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O31spNxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfLTSOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:46 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37981 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfLTSOn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so4476066pje.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cq3i6CU2w1OvkLOnIHEPmtZ2dO3HE+MsuoDzwGrRs/Q=;
        b=O31spNxxn7VQnEvwhSPthNMjvnj/eNVhK/PyoayF8qySczuOptBChGpQbA6+2uXt1w
         peo0gD3j4Jp9gbvVF2SDbUTeRM63vt7bSA3i7pE3afAQ366jXO+sOoB8GhZ/REL7xgOc
         3YPGAsxQ+pdL4DNkphWwJFK0M9lfdz0Pm7vSgb1ss21CA1iWwf5BhXcras3SBo1l1UwY
         zjJYF6CYC8dh1WB3t4Zs3uf41QrGX67PIXUTWsg7npPdhx+RayIPQeIbYZ/1CjP+bLfv
         MtuwhFp5UfmTWO3zcwfpLmgq1l9YQi+rLMvFPbmeuMV5PzskaDs8JLPCO4H+XNcQBru3
         ytiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cq3i6CU2w1OvkLOnIHEPmtZ2dO3HE+MsuoDzwGrRs/Q=;
        b=QHbMqmzJbixzL3TTM5BOu4RK9B3qKoQoXeN2WJ6Ke5oH4Zswajdzc0pTrW9k8mqgho
         mMkKPTJ/dVGo+HT00W/viX0C2jMmq8v3aTTxqV4ugasVC0WHqth2XX39Xqk5TgLft3ji
         KtY/z62nob6r8WdN+QWs29IOhyZPQuHBOvxeNBAHHinepP+VytMPdfPXXMCtvYJKzRd1
         Z6aK58UoQ0H9v3fcfodXjmSHoK4Q6Jj4fp2jmjAiYxwGXwJ4Y5f7V/plgAFXeC+nhm96
         gDIOhrp3atNpQifeYYww7gpR8iSxgyK638PvmInpqMD1Ls7iurotXHNDWKVitN+5qSxy
         gm6g==
X-Gm-Message-State: APjAAAVxXo0H/jpSNI2rG8+RMGDaEwMOqvp7BjYmR2bj/XDxd3IaGxh/
        xfc3Y1Z3SpFCZeJE0dBNdlN1OD23
X-Google-Smtp-Source: APXvYqwOHymacV08h6x7NwRWTiW3GxdU3sc9hkBg33hdI9deafbigBRqxlw6YxutJNhBQrg06KKc9w==
X-Received: by 2002:a17:902:7787:: with SMTP id o7mr17089054pll.328.1576865682025;
        Fri, 20 Dec 2019 10:14:42 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:41 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/15] t1307: reorder `nongit test_must_fail`
Date:   Fri, 20 Dec 2019 10:15:56 -0800
Message-Id: <cf43579d654387ca19d3d8b10c4e775a8f663621.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on only allowing `test_must_fail` to work on a
restricted subset of commands, including `git`. Reorder the commands so
that `nongit` comes before `test_must_fail`. This way, `test_must_fail`
operates on a git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1307-config-blob.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 37dc689d8c..002e6d3388 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -74,7 +74,7 @@ test_expect_success 'can parse blob ending with CR' '
 '
 
 test_expect_success 'config --blob outside of a repository is an error' '
-	test_must_fail nongit git config --blob=foo --list
+	nongit test_must_fail git config --blob=foo --list
 '
 
 test_done
-- 
2.24.1.703.g2f499f1283


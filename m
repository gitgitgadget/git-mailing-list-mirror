Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC510C2D0CD
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C332146E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aooH1Iuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLQMBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45663 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfLQMBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so5541435pgk.12
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jeGkdMu1Pqnc7Dfg8RYHL7z3t3UcPwW67UTVH0Rr0Ik=;
        b=aooH1Iuud+n5OaNHJdvjT9DlYaJDUoyYl2oaVlxssOubrVnxK3UDiwm5G3JmcjZhR6
         unpbDXWa0FNIDAfohrkdNLgFpEKfykpgnPrhfzKN2Mc4QAv+UV0rDuRe7CsVYJO+58dP
         xbe6Nrsq2VuzzUGdVH6bn/jlv7MNEDfcmBPObVOzvXidrHDM6TdM6b4MIyVFWJjoY/7G
         +GlRO0Ezl/+q3z1k7qGbI9GdDP3N3HpTBOaYVg3GAmeqz9R/54LOC7T6Dfrg7RFtg3M9
         d0lsWs9tw00SVHI74z/69jcdLA2Q11dBu6vCTeeP1zlXFkgJdco6hBJDeIKaq8gIpWpx
         rtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jeGkdMu1Pqnc7Dfg8RYHL7z3t3UcPwW67UTVH0Rr0Ik=;
        b=IMFen4tZvKr+AemxD7Bs0r5alKezBWHRxE9/ujxs9fGocM1OvFRA0aulPsNgdIVFA1
         K8nkgtlpIP+ZddXAnjPp1LltzEvnsA26A62TA5Z42i3xPWz5fsfzAJAxo3JXirmK7Cnj
         QtuZwd6CaW1Jpd3LNl/81xG1772Ps+kIvXmzYXce5O/YBg7AZtL4KKU5ZMGOSLcQnV1d
         MCjQ8sakO3PKeNzefuruE2W10X0v+XuaLLEv/xc2thshJIdP2hpGCnuMfRSLYf6mRpBw
         dcE1zoIBq3+5fgPj3S3hUXW9bJTEll6KnMBZi7ccEzdr8+9DTa0XoSDwrTJm5lXzkLTm
         79Jg==
X-Gm-Message-State: APjAAAVZCJ2CSXU87/qnqV647FAhpd7i2dVFacRdI66SVsQwCBJ7ml/s
        fzCfSjmCxVlVQXvmqdjnJhSm/5S8
X-Google-Smtp-Source: APXvYqweNB2TWhyBOiCX9ALiR+NAITd5kcog1tjmFbnCP5CsNV/9wZe0gWy5mpKST6LCKB4yMZThuA==
X-Received: by 2002:a63:3409:: with SMTP id b9mr24618512pga.320.1576584106713;
        Tue, 17 Dec 2019 04:01:46 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:46 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 05/15] t0003: use test_must_be_empty()
Date:   Tue, 17 Dec 2019 04:01:30 -0800
Message-Id: <055caa5c08d9a53e5e1415d540024d54d0916252.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several places, we used `test_line_count = 0` to check for an empty
file. Although this is correct, it's overkill. Use test_must_be_empty()
instead because it's more suited for this purpose.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index c47d4cfbcd..53a730e2ee 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -12,7 +12,7 @@ attr_check () {
 	git $git_opts check-attr test -- "$path" >actual 2>err &&
 	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 }
 
 attr_check_quote () {
@@ -245,7 +245,7 @@ EOF
 	git check-attr foo -- "a/b/f" >>actual 2>>err &&
 	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success '"**" with no slashes test' '
@@ -266,7 +266,7 @@ EOF
 	git check-attr foo -- "a/b/f" >>actual 2>>err &&
 	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
 	test_cmp expect actual &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success 'using --git-dir and --work-tree' '
-- 
2.24.0.627.geba02921db


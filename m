Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE21C2D0E8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C772070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qch2kaPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZI2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:33 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35860 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgCZI2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:32 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so2495040qvw.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sBVr0xFCoRHeS2xGCDPImGVaY6u3pSWB1zUmqkoPxT8=;
        b=Qch2kaPrmZaiI89sONrx8VG/o83WtNMel+c33HQiOJbpQZM+LeUu5ae0sz02A+Ijll
         UVrMfQxsDE4f5qZVA7K5FcS4ixQdYXMnsIlBmqMw2V96pdXI3kaiV14aPSYBYxTmwcIO
         KfAEuQXkleWMKpDM/bv1a5plqgtjLzBUG1op/ivuMSXvYcg4LvH7ZKK0MCZaAHKUZZpE
         HExPr030pw8W2ygH9ns2lCKrfpq/uOUe1ZnQ4FsPbs3dB65x1p4jRzFgGtSXbETL+8ab
         gFq0c1h2gperC+z6UvK6iBSf+Lervke1u/ew95F1PWxMBkGha5GUh8zgr244G/IlAKij
         PsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBVr0xFCoRHeS2xGCDPImGVaY6u3pSWB1zUmqkoPxT8=;
        b=im1fb38V6LORECeFuiwbwimQZ+jauqPsLmOYbX8r90M3CnfZaTnGByaA1NelfwgyvC
         94jGTB/MpaJtGu/PNmYCkbOl8wUau09tbYndjhMv5Cg2YbDJwFnuCWtPQ0rxDIDiQIG7
         dx7huh7JOV0kPaZ3Mgud2JkcfFjjMDpWxna6F//7SYnGVMW2EBCwwKEYUM+q3xwUYBrw
         BB6hDWcTQGM93mPgiL1wMIq8qAJVNDJqt/qBEuskLswd6xex9ZaYZerzU8vKJxG2X+Mt
         UOl2x3ENPSgJhH2XkjOhr0/nQiLSj+9aAzfxEIiqjFRNJkvp/4DR7mK7nD34GOcmoB+y
         ZO8Q==
X-Gm-Message-State: ANhLgQ2ejTE38siKaqLPahiMzeI97xLVVN74GOvzq57WMyBq+JcDr8hr
        vxzcNv6PbR3CxfneoGV6VjnuXRmL
X-Google-Smtp-Source: ADFU+vudDsRXacsb5UHU+7DRX9162/HEh+raLzqfJIwMFhdSc6F59zXRwR6f1STY00TGqmE1XI+1HQ==
X-Received: by 2002:ad4:5648:: with SMTP id bl8mr6829840qvb.189.1585211311114;
        Thu, 26 Mar 2020 01:28:31 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:30 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 5/8] t5607: reorder `nongit test_must_fail`
Date:   Thu, 26 Mar 2020 04:27:52 -0400
Message-Id: <4955b701e1f961e592e1c0c6567e28cbc12b3c14.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
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
 t/t5607-clone-bundle.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 9108ff6fbd..6d5a977fcb 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 
 test_expect_success '"verify" needs a worktree' '
 	git bundle create tip.bundle -1 master &&
-	test_must_fail nongit git bundle verify ../tip.bundle 2>err &&
+	nongit test_must_fail git bundle verify ../tip.bundle 2>err &&
 	test_i18ngrep "need a repository" err
 '
 
-- 
2.26.0.159.g23e2136ad0


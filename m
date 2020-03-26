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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A518BC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD5620772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5UPR+i/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgCZI2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40223 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCZI2d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id l25so5548783qki.7
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n58nEpda53AYxbJqjD32mYUrlmc9oQSXYYZj23APSiE=;
        b=b5UPR+i/I0ONRJe1Sbh7VWvjaXrbk6RiqS/Qn+4BDmnMxxg/AlmtbcNHJguhCs0vW0
         RutGE+pGBH3QButw/aABfyYT8/rqy4kBKpeasbK9ZaFnoB6KCMy4/Ee9/03oa102eoxB
         FJRNmIYk7OrD8j+qbdnc0P8Mcj6+qUIBYZoXhSnLU+tW60iQ5+tl+1N3WepOeu/Zl6fG
         oAkdJwD+3Ju9U2SqZ4h6VFcO/h+VpHPwE/tCjoNIfrdiEXNO9jaxIbLKCuNjoVLeWtWi
         DzmRoSbLVKzTlnEwr3+9lpS9geOooMlgkJXEStoqOThhZCxDFWLSTNFG0IxEuabahQlj
         dDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n58nEpda53AYxbJqjD32mYUrlmc9oQSXYYZj23APSiE=;
        b=Vp25BOitOMxdWbfR/i92DdtXTK0yWP9b1dVGZ0P5iVuN1mYC4KtJr1cbfPMekKOkts
         18kXDSFsJmTkiqJyk5LRhsR30Rd1peT9m2OhmJTCLMhGddaLajCJ8FG4olG8nfJrGDi+
         nFNDEiLdXQMiM7ciwvWQNY0RokQ+sV7SVoeWZcSFW1NKAhu8g5d50yWwH8wNic0to04+
         yxx3gISCcScUAv/qS+rfHu84aY1EdmPxxBPG96mTqKh45TqZuIya6WLWOuCoE3Nb0Cun
         omQ3XEZeaVokGhuvnsb3VeNy7NPhVvkJLW7bEWSRxe6PmVCURpaq6nnCELWm2AdjEQc9
         fx7Q==
X-Gm-Message-State: ANhLgQ0ZYZJaS/+W+FDyL4iz2m9+gwZBhN6a+Yekk0K0/d7Uj3SfzCGh
        mjJz2q6fhIGV5Z8U2vg76ayRvLTY
X-Google-Smtp-Source: ADFU+vvYgWIq3KLolbfgH5EkMk7bSrmMrfzjIa/W3tbcMOlDgT5ozdg1wHsB0VIqOrWqV6kyOVwZ6g==
X-Received: by 2002:a05:620a:a55:: with SMTP id j21mr6256131qka.125.1585211312297;
        Thu, 26 Mar 2020 01:28:32 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 6/8] t5612: don't use `test_must_fail test_cmp`
Date:   Thu, 26 Mar 2020 04:27:53 -0400
Message-Id: <a3d9d3673b24ab77e38e5c546f16fe9085d69496.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since test_cmp() just
wraps an external command, replace `test_must_fail test_cmp` with
`! test_cmp`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5612-clone-refspec.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index e36ac01661..28373e715a 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -87,7 +87,7 @@ test_expect_success 'by default no tags will be kept updated' '
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-	test_must_fail test_cmp expect actual &&
+	! test_cmp expect actual &&
 	test_line_count = 2 actual
 '
 
-- 
2.26.0.159.g23e2136ad0


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3AC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53DC2070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJxwVPPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgCZI2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:33 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:36044 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgCZI2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:32 -0400
Received: by mail-qk1-f171.google.com with SMTP id d11so5562879qko.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTWRnwXLFVks91UVpL0hL4J0nNSz2tGoRrQxSVfMyCA=;
        b=JJxwVPPNgcq3t0gzoz3nlCfVmTszgVx7O1Wdmp7XNPEG7aS2328nyjSEyeV9kKI3aj
         5ZgYRlMVHFXp6R9uDz3Jm3e913MH3s+TV40DeREXaslDj+IVn5BHykk+qvuLibLcnYO2
         mI3aPvijlhmTJGX/5hgVmpKJu1TzaZhEdH1FP1C4WJrcozZAeuBGzoQ4ZtdFHZKubk/l
         P2a4pPSrzLBENW/oTQpft+SPZuUVzkA9Jqw5io+JGmPAFTUGHa+LMRXkpF4e+gJair9O
         8ZPxUOlwmBAzYsFEYm7Tqt+TAgbFhyj7YhTMhyXIZ95MNa1qiLP2P4VTuc98YVT7Mnhp
         vyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTWRnwXLFVks91UVpL0hL4J0nNSz2tGoRrQxSVfMyCA=;
        b=SJVKRoq7Zb2nj5M0RvLVzr7L9OFYP3jWHEvG1W+9pyX/KcXagoYOqSNVRiwSvfTKN3
         NBQqkknOXuomChskRRqFBgx4Mj1BiQuE8C3XNWt15rmB2IEKvpIehAZX0PIO5oxHWBTx
         T/hMLW5tCy5T9NiOHAWj8UsH4rkv52i38ppK+rRte72hhvarv/TvXXyQQKML3nOFpWdV
         EthRnd11Fp1eeG+GDK4qnXl2Z8ajFZ0qPuentRPtfSZI2zyfmS9djAboEOtC2382UsN5
         bGJxceWajx57MCPfIHpppJl2C8HOeEucWhC0+RBv1ObotFzh1k9aEVcsw+6VfUO5euoG
         Jpuw==
X-Gm-Message-State: ANhLgQ1xIZqybL6zVsasiV7RegVOmD/VVJ/MqR/OVhi7K+GBrn9WlwSH
        TWz+xVJMwARyObsAQBUPIOXEeLN6
X-Google-Smtp-Source: ADFU+vsgEZIRvhLy7wgeabZ6LaNB2nbPi3/BamF4K6/d6zygWdNcb7fus8StrukimSzFekQoVf6yog==
X-Received: by 2002:a37:b002:: with SMTP id z2mr6707587qke.289.1585211310161;
        Thu, 26 Mar 2020 01:28:30 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] t5550: simplify no matching line check
Date:   Thu, 26 Mar 2020 04:27:51 -0400
Message-Id: <53e64e7077063a177cfafd97aa01340ee5b4cf1f.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the 'did not use upload-pack service' test, we have a complicated
song-and-dance to ensure that there are no "/git-upload-pack" lines in
"$HTTPD_ROOT_PATH/access.log". Simplify this by just checking that grep
returns a non-zero exit code.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5550-http-fetch-dumb.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b811d89cfd..bcde886b87 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -248,9 +248,7 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
 '
 
 test_expect_success 'did not use upload-pack service' '
-	test_might_fail grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act &&
-	: >exp &&
-	test_cmp exp act
+	! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
 '
 
 test_expect_success 'git client shows text/plain errors' '
-- 
2.26.0.159.g23e2136ad0


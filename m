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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3486C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB3C2064B
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8XD3mnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfLTSOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46863 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTSOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so5306197pgb.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SR1Way5k+Wj+6Ue6ejt0y/lCWjpKuXZoBOUBpag+XqM=;
        b=D8XD3mnLkbEfvCZF++0QTpAFnx2HkRxY+xY+Zq2u3YNTf9YDu0rUEkdPGBKUV3uGEp
         9ZAldj6sQrsSILZWacoG8mHeRm8jn3QAC0Kf9ZXRMHUOuTSzrZzXqzK5BeIwDQ3htOR/
         YjE1zTwfl2Uzeelz3P6HmO9vjYi7aCAgCltcyKcOXQPM7e9ORYI5YbcalBjOa5KFufa6
         AmdqqG3JefnemfvDWqvDICE3U6ktc1kWxvoo9skQhJ1/ToPX5eNDOdv/ye2nCnThtiZK
         /jD503kaavMtsShMsoolqrUvzVIFy/UwKHTpomsxteRw3Jmt+vwOYUjsZFFb7V04j8Oe
         WIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SR1Way5k+Wj+6Ue6ejt0y/lCWjpKuXZoBOUBpag+XqM=;
        b=eCRpa0/yF6LZnUozkzsfQDFebBmiFOG/kv60nC6qJOGMl/dMKbjRYyzQCsqI7aPTKG
         iwHWsk7xMP5S0+PMWjCTPYywkPeQVnx33XqBtOZLygql4UWSGRm4CbzEUaXoe6L8WMTA
         KNGwPe0+xi+soyUI5ummYT7I0t1zNCrbXc1jijuJuMOhpvogxrptButXArY5pfIW2TxR
         2qoVt4oKhV6pkJvOTUe1noi5gWBWkc1AcQWDyD6RZDWVqyKs+MnRoymiWJ25t4FAXepY
         RUfiJIG3EsOEhpuFJ5LBuTC4XrvoMXo/FrFNDfF+auhanCnalEWzNXw/+vsWYTIKH0+Q
         X8HQ==
X-Gm-Message-State: APjAAAU+aSy1Z77BL3hcZVsxWBqbxIj49q7+ikKvLSJEB5H7ITRfhl3f
        aBm2tE7/8pMWlzP+s3QBY0D33tK4
X-Google-Smtp-Source: APXvYqxIUcdJoW610TMygMBCzOsiOmbW+kvxZOyMyoYVCPjBJSu/ELVoX0MyhJSsNY43uaYDbINT2g==
X-Received: by 2002:a63:3750:: with SMTP id g16mr16467579pgn.413.1576865674585;
        Fri, 20 Dec 2019 10:14:34 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:34 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/15] t/lib-git-p4: use test_path_is_missing()
Date:   Fri, 20 Dec 2019 10:15:48 -0800
Message-Id: <cf3dd04b8af8c23b242584f29d1dcfbc0b59d331.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, cleanup_git() would use `test_must_fail test -d` to ensure
that the directory is removed. However, test_must_fail should only be
used for git commands. Use test_path_is_missing() instead to check that
the directory has been removed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 547b9f88e1..5aff2abe8b 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -175,7 +175,7 @@ stop_and_cleanup_p4d () {
 
 cleanup_git () {
 	retry_until_success rm -r "$git"
-	test_must_fail test -d "$git" &&
+	test_path_is_missing "$git" &&
 	retry_until_success mkdir "$git"
 }
 
-- 
2.24.1.703.g2f499f1283


Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F425C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DCD206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDXSuBK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKUWUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42826 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so6322828wrf.9
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Io767/v87hev8kDmfnmz3wDTZyj8vs5Whnbhh5IghDc=;
        b=bDXSuBK25NTf7GrprTGTHCCKlfrp4FPP8mT1VvvtmVJYN2WbKvDzJGIPWss02ZWudl
         5zo3Y2WXZYCf8BpXIljxGIwtTWRSBEfu+bsTDKVBn703zRUOSvhgUIg/9iCKjeVBrVxO
         B5u81Eahy2WUgCu1f/J9GrkpcigsXqzEyr6QCfylWr3kwMCei7AOqScD59lr/Z/JogN+
         QI91inDsH5ZOqUaMepay5sYZxRUvatHMQ1MS0QAIh1JzCvHjBCUkrn1Y7zP0QHnMJROE
         PdYUhofmJ70h4QQ8gyMQKPnzqrQr9Il0YK5fSHAxNF67cd5v2Kw43sQA0S16hMtJPCCO
         qFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Io767/v87hev8kDmfnmz3wDTZyj8vs5Whnbhh5IghDc=;
        b=Uy9vvL8S3Owy7fTHE24wEGQBz/BvQoaLHLeajJcRe1uyRXV/xmERx7ncJl5cL2iSyF
         DFK1roeQ2opm6Ii/MEVq5m5Cp9QQOMk3/bp93QNQO5eUgTPmVFgvmadYb4qReeASJJSv
         9r6LNkar8dGcJZfujdWPQ9R2P4v8xonn996p8Ji99Hm6v8/F9UIA0Q690ThYWc89dQxh
         GsCFNWaw7FZKV6rqKjy9XhVHGruhNCuzS3LMe4wJpa+MC70MDv0MUlhb0i7ndkVr1bss
         EzxfQLCdVjoYIG6CUX7nL+cjzS8nB63aJuMKH2wsf6bU1I6BVqw0mTKw1ygx3rl37joi
         vMwQ==
X-Gm-Message-State: APjAAAVgUOR04ztzRutZs5RQcwZsZROWlu7/YDhP0Yso9PInOY/4cbxI
        Su5G5Aua+mPMkqGvIkJ3CqatpECU
X-Google-Smtp-Source: APXvYqw0Iuyr4qjqNnWDIeEmHhEwWbdFuHKp9OjoxwSEAjqGcDlInFS9CIEjiaYLLdeCbQZTvWf/fQ==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr13160407wro.215.1574374829440;
        Thu, 21 Nov 2019 14:20:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm5100685wrm.7.2019.11.21.14.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:29 -0800 (PST)
Message-Id: <ed40ce8e4cf877983ccfd909134f5ffe3a2b0c04.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:18 +0000
Subject: [PATCH 03/11] t1301-shared-repo.sh: disable FSMONITOR
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1301-shared-repo.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 2dc853d1be..665ade0cf2 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -128,6 +128,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 '
 
 test_expect_success POSIXPERM 'forced modes' '
+	GIT_TEST_FSMONITOR="" &&
 	mkdir -p templates/hooks &&
 	echo update-server-info >templates/hooks/post-update &&
 	chmod +x templates/hooks/post-update &&
-- 
gitgitgadget


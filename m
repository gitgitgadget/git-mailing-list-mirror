Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2BA1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940285AbdDSXNk (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:13:40 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36208 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939263AbdDSXNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:13:38 -0400
Received: by mail-io0-f173.google.com with SMTP id o22so45061460iod.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kjOclDfuk0G+siCba0ux4uWsU3vl9N75vD6NpdFfHAU=;
        b=t3iqnfjM/l5XWtY80Y3Zf7f+iX5TBZPHIUmVXJqQBBVoB06Fpgtcu2TbQrFRrzzIk3
         f1++k9l5KtsOiQ9NYGg58qoMggtlStX/lc2+KL0/0utA/xv6PYg0Q6xqcItg1k6xQvNt
         dhaWeOHMT3etkJBuvZwUhojZLVA7gNeHCcx/2l9PjTmUD12kx9nuWnBEyJFdsor4wk9H
         Kc1hGJCabZ0PjUhWxTi6VxjNCkrBvqS4c3aomeA/Tapz0KLXaO/JKPftVRupNi7AhC4d
         ksQjnqoNUpmEzp4Niq+Qvg9ifMGD8hVHdoXVp17uldIAFRwMCAiNyCLrv0CVkGMbD9rX
         7EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kjOclDfuk0G+siCba0ux4uWsU3vl9N75vD6NpdFfHAU=;
        b=nGrB9F2hD0Cr805Y0+8R8ajcFo+FD+8cvEhV/RgjViL8/X6XNHrnn+ItBsJPJlgi7E
         dGwj3Od3F+tw2qCVLVCd2HC9ZsBmtMAsFvC0dL0sqiThPMYalwhGW2WG95Ok6K/8wX0W
         uifswWqZxhXopplL70RvKb0xbzli+Bmjx7XFw8vHOYxBrR9TH3ilk34vSqfPe+Lk3dUR
         ecyKHq0V0foLiHGDWOZT0E4tQ86qSwQ/leuYVUjl3KceLEPDsFnIKQcjZg/Fxb8AOKof
         fM/7bLBfeJPV/HG++qvik3EGAZHzMQFKLU/6ZBW7PsGVkSw0MKgi7AGK5+hzXVxnAneP
         71+w==
X-Gm-Message-State: AN3rC/6gg00nyV6DFDVnFx36kIILIlYTr0p8zRAxNHvpyPIwtr6QPsvt
        YC1ipHjg9s3OkcUSVfPlMQ==
X-Received: by 10.99.159.1 with SMTP id g1mr5244662pge.116.1492643616308;
        Wed, 19 Apr 2017 16:13:36 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:35 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 01/11] t5550: use write_script to generate post-update hook
Date:   Wed, 19 Apr 2017 16:13:17 -0700
Message-Id: <20170419231327.49895-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170419231327.49895-1-bmwill@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The post-update hooks created in t5550-http-fetch-dumb.sh is missing the
"!#/bin/sh" line which can cause issues with portability.  Instead
create the hook using the 'write_script' function which includes the
proper "#!" line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t5550-http-fetch-dumb.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 87308cdce..8552184e7 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -20,8 +20,9 @@ test_expect_success 'create http-accessible bare repository with loose objects'
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	 git config core.bare true &&
 	 mkdir -p hooks &&
-	 echo "exec git update-server-info" >hooks/post-update &&
-	 chmod +x hooks/post-update &&
+	 write_script "hooks/post-update" <<-\EOF &&
+	 exec git update-server-info
+	EOF
 	 hooks/post-update
 	) &&
 	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-- 
2.12.2.816.g2cccc81164-goog


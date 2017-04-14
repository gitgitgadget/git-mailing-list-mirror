Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661B8209FA
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbdDNQ7R (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:17 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33891 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbdDNQ7M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:12 -0400
Received: by mail-pf0-f180.google.com with SMTP id c198so42770346pfc.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/0vEKs9XgyWiryHwYSY9IR5okycMUAKLeDk+N+WCYw=;
        b=IiphKhAnlNkBcbVdwinCMpdHuLbQU0/0oH5JEythSnkY9bRwidfVdu+MAw/8W+bKqE
         mKSmbGqdEqcD3YdaN10NRF42OTFpYwzSfsONlnbH9JVGRtYIAw/mGwK5KD648vOf7UwB
         ZsSH2rKCXIxLVT8nPh6CSqc3bRWIH92HLUMctFlGaxtV7IAOu5JCBlNlwbEKi72Mg+pj
         hYt4R/jcnjvTvX6kgXwQ8f2FVmExiffciBTujMBKfyiluasWkhJHzyl0pydTOKmQUNVW
         Vx6R+kI+RtYgpyOeG10HNMYhn949DyTNI4rByM+SLewplh2EIHS6Ez8S7zsOGdUBrNd4
         jOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/0vEKs9XgyWiryHwYSY9IR5okycMUAKLeDk+N+WCYw=;
        b=umH5ndlxpH0kHymdvqYyrVUvCntZQJYX4T4JgCmh7y6fMmWeglY3g/UGETeVvEq0nA
         9P4zYHZK/lkO3cZ/5xERoXHCwX+NRxB902U4Q6Khc8SjAJfCRh2GtELSKtSuEce87yRe
         doWoVAw6swEp8QrkImst8UUPSdz5smN4tB/1cdrTVuQbgrG9Au+p27N4+BEXoNMGpLe0
         MgaAZPzK1sniGlrBHWSuwoaIhviE45hW2Z8JtD6A1wQQV+WXTsHWGsfXkNXorKT6pZO7
         vjnAHh1DtE5EY96N2+E34NG0p4BZ2GB1Ajlj1E8m1iM/35clgpOP2roomhTjlJgphb6o
         YADQ==
X-Gm-Message-State: AN3rC/7BFEvN+vhN2fLSw553/xg2ke3Po0CH+ElO8cxQwmPHyG7SQaBp
        EuRXav28j3PVPWjq6JJbAg==
X-Received: by 10.99.170.70 with SMTP id x6mr8143572pgo.111.1492189151287;
        Fri, 14 Apr 2017 09:59:11 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 01/10] t5550: use write_script to generate post-update hook
Date:   Fri, 14 Apr 2017 09:58:53 -0700
Message-Id: <20170414165902.174167-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
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
2.12.2.762.g0e3151a226-goog


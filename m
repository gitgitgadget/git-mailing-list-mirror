Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7362A1FE90
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbdDQWIc (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:32 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34122 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbdDQWIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:30 -0400
Received: by mail-pg0-f48.google.com with SMTP id z127so14161193pgb.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/0vEKs9XgyWiryHwYSY9IR5okycMUAKLeDk+N+WCYw=;
        b=EExMVLpmfk2u6pIXGBhyBypIBijEuN8AwIDhjFNXErwrdBgg03Pqr3veI3PUPiClbp
         cWD0R7H7o3YotFFKdhKpfugjQEgJD3Fz9trO22t3hSB7coBzSztX8sE+xLmvdecBqCoe
         2xEx0H+EG+UugKsNZ0bDqGA9frO6oZ42m1Fkj+h/oRmEwV3uEzDRuWa1lp7LA55oAMkX
         5pqc8OcfNLuZT8OsbXoRU/uCnpalL6K2/34zj6hBVz9jTsJ3N0vowTm9msiRuuJ0s6uw
         Dh9zpGLDSwu9/KlWs4qn5plnzyH0gjLBu0wfLEAUfItzct7jf8g8vvoIVBqiN7dx05/D
         bdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/0vEKs9XgyWiryHwYSY9IR5okycMUAKLeDk+N+WCYw=;
        b=PqDdvdB1UjOorRunWodMYXUdCILoW6dxOGQZBISmgh535htdrvQp1q+mjD8WQHwSVD
         DXcCoy+Gi5Z6TUKxUVW7Ndihrnf6n4qGk82qAbrkw27QFI8HIjEB80LjM3eaWku1Hv7K
         AAEMRWKeyQ51SmHotGtJCFlEkzH8gVwxRpxVkgpM/82tzBIA73e5mXtqE3fCJ1dd5zyv
         8jBA0g3+jpo9iKZpRui3TJ28di0+guNHO+a4qZVY7ryC5DtyVqf0Y92mKW7DaonRGWdL
         nNip9mPQedMGQt2nR1ULLMVmKjE3Qj8YVA56czoWiaWQSHap10YQZNb6ulhkZ33qzbR5
         AjLA==
X-Gm-Message-State: AN3rC/7yUgjWAEbcjuNtO4ZZ8M+i65DztiNKP55eMAvOL+r7Bsxr2U2Q
        AKEWP3pnG50PYBuX
X-Received: by 10.84.238.195 with SMTP id l3mr18844428pln.101.1492466910076;
        Mon, 17 Apr 2017 15:08:30 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 01/10] t5550: use write_script to generate post-update hook
Date:   Mon, 17 Apr 2017 15:08:09 -0700
Message-Id: <20170417220818.44917-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
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


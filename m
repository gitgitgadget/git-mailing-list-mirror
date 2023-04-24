Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ABAC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDXQvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjDXQux (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:53 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E606580
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:52 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-18ebb77aecfso3190463fac.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355051; x=1684947051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv2nRUzNufruoqX5pYdeG5WQynfGoX1AsevpHpBoq5k=;
        b=k3m4C1k/emVkVXshO2OZh7OYHqZBzAed5x0/q5dbYsyfQtUjZul7WZ5IXI9eGPZ2c8
         el0gbzgBn/QAFTcXrtf+SZeT+K51vVMITWpJB5YaPjpWG0f71bHjoyb95bSXWbfNqw41
         kS25S8a+FHC/DopOaMG0U23UKoZT22I4wxJKGIT/dwHekfMX58k3EwEPtS3jfRtruUDa
         6roT7sd5vVQc70m/MJW0WPKiHjC7J+flmYK9umx46sPOlQhPio6kzMMvpxxr5yY8TdBn
         nwxUXGG9b+8GMsXn6A7VRb/jgAxZEVqfgCOZMAwLX2b0LcNhE1WEa+9v14oL9OLM6Fn1
         avvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355051; x=1684947051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sv2nRUzNufruoqX5pYdeG5WQynfGoX1AsevpHpBoq5k=;
        b=gQ7BNiiVWCHGjMiFP9zXNSBwOyBQ7jnZXsyRHpYavc6LvObbKHhQMsLPJcXWbGrIHP
         blQPhOaOCNDBgUDOeIJBiRoYCSaPx850G9ERwduKtwOHBornE29o7kz8HM7nKgobGRiZ
         30jtgTm9veecxBiKJ3GPEm6XfV4/nVwBQDhk7+tc4eJiNioJeo2Pst2aq4/vTGoNbI7i
         ZY1T/lWuEp4PJ8+OeTj7HsBs3g36QL6HUEcY0jNcN6uKy664IDodIp3QopCGf/Qyjih6
         KR/eR6lLcSsxqgxwovU+gYiG3iVQ3yYDY1nZCaeTA6I2HQhlPLt0m/+ZaAAAT3sPXsTE
         tPdw==
X-Gm-Message-State: AAQBX9em4a04U1sJkgLEjEG02LkV9Al6goVMSOYPehHCJAeOyGzYDLhK
        vJ1isvtAhh/Ib+M/guRVTPnBD14XcJM=
X-Google-Smtp-Source: AKy350Zvfc3FzCHhqvuIWVB9lvTfrsoV8TR/pmwv9dsNiHWCGpFJ+c6nLC+PG6yiuSBrbMHJHpePLg==
X-Received: by 2002:aca:f1c2:0:b0:389:5120:9506 with SMTP id p185-20020acaf1c2000000b0038951209506mr11058953oih.8.1682355051604;
        Mon, 24 Apr 2023 09:50:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z9-20020a4aae09000000b005421d52de9csm4944156oom.45.2023.04.24.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/15] version-gen: simplify dirty check
Date:   Mon, 24 Apr 2023 10:50:33 -0600
Message-Id: <20230424165041.25180-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index e99c7b45c0..8edaf8f335 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -4,10 +4,7 @@ GVF=GIT-VERSION-FILE
 DEF_VER=v2.40.GIT
 
 describe () {
-	VN=$(git describe --match "v[0-9]*" 2>/dev/null) || return 1
-	git update-index -q --refresh
-	test -z "$(git diff-index --name-only HEAD --)" ||
-	VN="$VN-dirty"
+	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null) || return 1
 }
 
 # First see if there is a version file (included in release tarballs),
-- 
2.40.0+fc1


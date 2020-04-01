Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B758C2D0F3
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A3A214DB
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 15:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdYJ8lGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbgDAPze (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:55:34 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46845 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732799AbgDAPzd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 11:55:33 -0400
Received: by mail-pg1-f182.google.com with SMTP id k191so226888pgc.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P4unpLNU70LpbgWYQj9DrWaPgVV5ZYHD+TqOgm/LWcc=;
        b=SdYJ8lGd4h05WzN5za15dFd7wIDS1WYI9atKwrcDjO5NRFoRPLf96Ejecp+byxx0d9
         7Xj/RzCCCfrnCy3So2yNYQ0Te6j4lSwbA+aHB1I/tzZclWXlzCCDXv9WOezdvMtx+3BG
         7HLTsObAvK/j0xVA0duIDGFdS5adQ5c1Q0Yf9KDxQtanKRPWdfX8fZOw+W5zw3qVFjmf
         yIK2EVYrNArpibeIDkjHHXVnpol2EdZfZbRDKCerdoTKjG9Wp4U6c8b8V5Gb0A3VrxNZ
         FQqkcJ7TZRymWak2GJQVnJ0ooqJaxiArQdw5KIHfywIi6KzHPFL8c7iX9C/Rbw8W8lQz
         C0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4unpLNU70LpbgWYQj9DrWaPgVV5ZYHD+TqOgm/LWcc=;
        b=lzISTwyTRrKeryNcwD1bgifHhvipPJPerlZIkFx1UOu7LYSu98rcJxA6LTYtscdTyt
         Gg5HV20Rch4OGG/ClEZV0/a74iLQF83y3IGCJw50dQFkgQyD7VH6SfB9QV4ykZKK5902
         ZM0wNu0Y2OWbkguTGUXWC3UBnC847tMlE7JMdow+KZCDBAAofVxhl0zXleCQElZV0Gh0
         oaYtLfZQPDIYQWyggs4Lc0dq3uDSkfQVhXHzRPtEJ4aZPW+9NlrIMUFe9QNkWtNqnAM3
         MiJ0eyKBfjbmcLA9Y1z8wSVbQoBeRCbgG5ZIOfw8PIsnvac86Ybu7pgyzvt5frz1aClj
         Q8sw==
X-Gm-Message-State: AGi0PuZygFVUVSkR5WIFYkMt3fd0EFah4vYCW3QYEUebde1Z02oDyJcj
        8omXCyJVrGZo2RUKQEzsQmVUsg+M
X-Google-Smtp-Source: APiQypLXz3F6282gq9usa5oUiF/ElT+orm9LbYXU2eV/uqChN8gCker9XjxA6zFGfaeODCGTHh6HZQ==
X-Received: by 2002:a63:340f:: with SMTP id b15mr4785010pga.38.1585756532442;
        Wed, 01 Apr 2020 08:55:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id x4sm1990826pjf.23.2020.04.01.08.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:55:31 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/6] ci/lib: if CI type is unknown, show the environment variables
Date:   Wed,  1 Apr 2020 22:55:03 +0700
Message-Id: <27cb77c257e717aba3386505d70d4cc93cdf13fa.1585756350.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585756350.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1585756350.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This should help with adding new CI-specific if-else arms.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index c3a8cd2104..766da75063 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -138,6 +138,7 @@ then
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
+	env >&2
 	exit 1
 fi
 
-- 
2.26.0.334.g6536db25bb


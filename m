Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1779AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014B4610CC
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbhIMRlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243866AbhIMRlK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25699C0613CF
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so15978235wrb.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBuMCp9wye4nJ0EwkJl/E213+4vvdkP7RervuT74vis=;
        b=fZGbyTq5tBRwTz9iAYBy44nSBH2WNMxYi8iNl9JeHlWl8Wb/sTvD7LgBNog9Xp/pPj
         gnDRZZ1mQEkt8RrAGymM7sxmUOw5W19V9xCaug1K5/WY9AVHM6TcX8nymtz/tBD4XjFL
         1m/Z3gq7tt9NqjTrZzR06XPZfBaA5rbBWX85w3PMBIvV5WEg5AW0ip4Vp0lqRM0XWFLn
         mFC4RVpAqsjx1X9ztx8tWi+n5KhOvZ0P8y8+SjdRiW9yp7fHQuVw8V2EA3tjM2o20fyA
         dhp4Pyrsg2UIyjqFcEcL7EiQ0OjWZoSM6NT+hLivE9UtJDgmMxbvbr8j/wG8ROz5MXjx
         R/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBuMCp9wye4nJ0EwkJl/E213+4vvdkP7RervuT74vis=;
        b=7caWRzuupdI36ymgGgz0yMnykyTMdkNAePvjuSCm+01TCxOukjQ7EGtz705wp58LOD
         Hd36qx1zhNjT9O/rr9wIeBa+SYaZMw2vHE0KoEIiRg3xe4XrHbGEoA2weAzhxIzAvGfl
         o3RZF9v75zob5JeqkCcutXHQQ77IVON6xHPqjCQigORM1AX+X4tiNf3WJrhPRE4Kv5oO
         4qDPbXl/nTNd3Z6g4mPcBXlgVjKjgFMSzcsakIiHgj5tuFwyvxYRqHp8XDqzXpwmGRSg
         woQvAluKNmzFz5MDcKmy9xhXP2Mdf9TK/TBfqGgwYgPYxiuHHI3I3BnZHR6Lw44c7Pe5
         oZLQ==
X-Gm-Message-State: AOAM532OE+1R/3BZDVqHOx+lqkFbUTt1Fs9J47ts574uq6IRZ7bAQgy3
        ANOw0uco5zDtyi/3P+GjNor0lXuskgM=
X-Google-Smtp-Source: ABdhPJxtWv5zBv/c285bvG/Z026/3eojHfOP4YEQx3j63Pq+TQfO7k03o8ZYn8EJlIdllhdYoKYLMg==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr14042424wrr.46.1631554753810;
        Mon, 13 Sep 2021 10:39:13 -0700 (PDT)
Received: from localhost.localdomain ([81.0.34.57])
        by smtp.gmail.com with ESMTPSA id u25sm4428959wmm.5.2021.09.13.10.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:39:13 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 1/6] t6030-bisect-porcelain: add tests to control bisect run exit cases
Date:   Mon, 13 Sep 2021 19:38:59 +0200
Message-Id: <20210913173905.44438-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913173905.44438-1-mirucam@gmail.com>
References: <20210913173905.44438-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a gap on bisect run test coverage related with error exits.
Add two tests to control these error cases.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a1baf4e451..5986fbecd1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -962,4 +962,15 @@ test_expect_success 'bisect handles annotated tags' '
 	grep "$bad is the first bad commit" output
 '
 
+test_expect_success 'bisect run fails with exit code equals or greater than 128' '
+	write_script test_script.sh <<-\EOF &&
+	exit 128
+	EOF
+	test_must_fail git bisect run ./test_script.sh &&
+	write_script test_script.sh <<-\EOF &&
+	exit 255
+	EOF
+	test_must_fail git bisect run ./test_script.sh
+'
+
 test_done
-- 
2.29.2


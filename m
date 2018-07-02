Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECE11F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeGBAZK (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42406 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeGBAY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:56 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so13225970ioh.9
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3lcUVGCvLN05qPjaT4bhLg7xw6XZZkN96iujIMVL/F4=;
        b=pw5qwI5cr0QDe56sxP0+RxLeCpMdZOdLi6kwWBWpPSbVdKf1pP4UKUrXoK/oLFKKG6
         ++w5u9bG7J9jrryfoR7f1hPXqQmyaCj1SENp4TXHvFiNCMFeh25kH8srxdkSxJ4JxB/q
         8e2w5H7AtC3ekwQ2NwKXV+zTsPUkC//lYZomxd0sZSNXtmfrazcNTt97MD4SA9N4nd6P
         ZCQSOuoCnrNysyd+mOV6p79k3opXt++tePOTModm3sbRkjt8kw8ed3EVFYs5tKHvHs8+
         FnjG7BjDz/PlmSkFU5ZE6IbTElHSLtgzK8dIBGWbWAFijLcSPdZRbLwTv0ZtrSRHkqrW
         AvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3lcUVGCvLN05qPjaT4bhLg7xw6XZZkN96iujIMVL/F4=;
        b=P+OZbZPorrkGJK46HN273TGUyJPhyLoQCKc6j9no0QjZpbuOx4KkYtopwp+g2kHbre
         mCb8UaBLAr0LvoRxbe2iJFfhL1j4ohhyY1lnaqey2OHboKsY5t0hWIDWfEOlrgnwUAlc
         gL6SUpMKSd3YOerU8Ob2MVmXQ2eFddZOzGHLKRj2W6ySZrGceRwgBaHW92+sjwoh+jRX
         AKsO4sOjG8gKXzjMzoYvayqk+F2sBwhHrEPq+hd1vStkI7RIfymBlceF3gYl7b5nWagB
         Q9rx/gwmFBsOrMT12+AiMHVauhJGqZMfANKgfiyY/Ym6jpgkpXSR3e94kdSG1Ckh2B6G
         nK4g==
X-Gm-Message-State: APt69E02lF/dQjSbRcEpHY7oHd63ewpUwkw28mgwn1hVSqsBLvRPdpVc
        TLUAACOYzE3ikPRzzWXipRbhAA==
X-Google-Smtp-Source: AAOMgpcQkW/Nxsy9vha0kx+oX1XO0kOt3U0HmSQKWQ8jySRevWQovy+4ST544Y72lyzCvzU7JdU8Xw==
X-Received: by 2002:a6b:bd43:: with SMTP id n64-v6mr20239149iof.254.1530491095707;
        Sun, 01 Jul 2018 17:24:55 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:55 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/25] t5406: use write_script() instead of birthing shell script manually
Date:   Sun,  1 Jul 2018 20:23:47 -0400
Message-Id: <20180702002405.3042-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of write_script() to abstract-away details of shell
script creation, thus allowing the reader to focus on script content.
Readability benefits, particularly in this case, since the script body
was buried in a noisy one-liner subshell responsible for emitting
boilerplate and body.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t5406-remote-rejects.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index 59e80a5ea2..ff06f99649 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -6,8 +6,9 @@ test_description='remote push rejects are reported by client'
 
 test_expect_success 'setup' '
 	mkdir .git/hooks &&
-	(echo "#!/bin/sh" ; echo "exit 1") >.git/hooks/update &&
-	chmod +x .git/hooks/update &&
+	write_script .git/hooks/update <<-\EOF &&
+	exit 1
+	EOF
 	echo 1 >file &&
 	git add file &&
 	git commit -m 1 &&
-- 
2.18.0.203.gfac676dfb9


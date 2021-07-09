Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC69C07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 02:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FD461459
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 02:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGICaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 22:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhGICaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 22:30:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FABC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 19:27:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso5259524pjb.0
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8Z6aMp/GWZHnZnYqGTl8+W45qRZcSO+qB71zPj2lt4=;
        b=B+7OnKVlQZkwRcsHIvkbzhGXwMO9lxS6RSQb6AiXKV420atlVmDWpSOVTqzl/9t3O3
         ISFbq/DQ3wiiveeDSzk07AK3AYxCvBl3b73nhRnw3dXyzPj2KVEG4KXW48z1gVf4fbx8
         mlPXvYxyZYBU34SvBS9Yf5iAoE1niQQ1h7+N5BELTBgx46fVZI+lXYnFy06lHQqmYOth
         ZPggp0DFaWAnLYmIkrhmo4/3obVU1L8RCUiYe3GlD3bQyr1wdiKFh1y6ByTUl/eHPKuq
         2R3zNv/TSaVFkJznr35vBdw7iUSxMUlQnx6V9m+qvZmKuxcVs4m/2FOcE7GgScXJEmNS
         3vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8Z6aMp/GWZHnZnYqGTl8+W45qRZcSO+qB71zPj2lt4=;
        b=kBhN7Pa3xVW1G+aTxzaXhkfQvl518ZfFPNsgCQ97U5iswOfc8ZXL4+CQHiar8aArXT
         nkbt/Bja2tYOiVxf2VOZSboDODDn4DyRqHIcaRphnDNPjgaXJws6jJdu1hmKPrB47KYc
         PpzErTwUYwN6hXl+GC1y6rrym7/uTjnBLyQQasR7tk7PZpfiIvCBbhFcM4Q4VzJppBua
         P7CptNnG687m0RwqHB0/+NlQXiGMkdToJLHKwRcL+e6kLAAzf0VCnUnn0BIjDgCx2BZD
         t/GktJNdIEYGv/p7miB1XuCB7Qhsb4wRXqI2zzs0H/1tiCDRZ18bAdg6zHs9B3WKXxf/
         gbQA==
X-Gm-Message-State: AOAM5302eC9Y2KuWzozGbhcvE39i0OLKG/uobbJSztKS10xSTlBzZyWo
        jyhoUlGauJzsAmzylfJcZ5xfFon7jZQ=
X-Google-Smtp-Source: ABdhPJwfw3qdYREoQ83NOimp+h2aqReP+jzzO67FdMD/F+MZyn6MyvoiM9A2PZiSLzs4+KAegsAnsg==
X-Received: by 2002:a17:90a:7d06:: with SMTP id g6mr35144371pjl.91.1625797652282;
        Thu, 08 Jul 2021 19:27:32 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.15.234])
        by smtp.gmail.com with ESMTPSA id c20sm4311163pfd.64.2021.07.08.19.27.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 19:27:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] Replace "stateless separator" with "response end"
Date:   Thu,  8 Jul 2021 19:27:22 -0700
Message-Id: <9c834801c85d873738577a45c87d4404a23666d6.1625797617.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.186.g3cb6fa43cd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 0181b600a6 (pkt-line: define PACKET_READ_RESPONSE_END, 2020-05-19),
the Response End packet was defined for Git's network protocol. When the
patch was sent, it included an oversight where the error messages
referenced "stateless separator", the work-in-progress name, over
"response end", the final name chosen.

Correct these error messages by having them correctly reference
a "response end" packet.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.c    | 2 +-
 remote-curl.c | 2 +-
 serve.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 98304ce374..9f63eae2e6 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -103,7 +103,7 @@ void packet_response_end(int fd)
 {
 	packet_trace("0002", 4, 1);
 	if (write_in_full(fd, "0002", 4) < 0)
-		die_errno(_("unable to write stateless separator packet"));
+		die_errno(_("unable to write response end packet"));
 }
 
 int packet_flush_gently(int fd)
diff --git a/remote-curl.c b/remote-curl.c
index 9d432c299a..6c320d5704 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -653,7 +653,7 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 			memcpy(buf - 4, "0000", 4);
 			break;
 		case PACKET_READ_RESPONSE_END:
-			die(_("remote server sent stateless separator"));
+			die(_("remote server sent unexpected response end packet"));
 		}
 	}
 
diff --git a/serve.c b/serve.c
index aa8209f147..f11c0e07c4 100644
--- a/serve.c
+++ b/serve.c
@@ -258,7 +258,7 @@ static int process_request(void)
 			state = PROCESS_REQUEST_DONE;
 			break;
 		case PACKET_READ_RESPONSE_END:
-			BUG("unexpected stateless separator packet");
+			BUG("unexpected response end packet");
 		}
 	}
 
-- 
2.32.0.rc1.186.g3cb6fa43cd


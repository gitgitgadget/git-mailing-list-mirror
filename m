Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD22C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EBC61057
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhEaTx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhEaTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:10 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9911AC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v22so13270562oic.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8h2/LLawg3qJwTAKsFMDPknmeDU7m4nmA9ynwHx4AsQ=;
        b=ubFCoaKEBoDDfd8KKaUmlAq7vm/b9ViOR6jThDhpM4WolctG9MtFUT9sykxBH591W8
         hPvpYWXJUgn+QzL+yChyFEfaA+KNmN3LVwASdO4nUzt7FdCXo5zPjYXeKNbosNodSM1z
         4XtcXlZZX9cjaK2xrgu0Cu+Kk4AZo1bIRJUAxLE8aLpHQ4dT7Zo1LYMLpx4V8YM9howF
         vuLfomdf+hQ4+bbn8dAtEcfLYLGMcPD88jPaQXAMWSVo8zhz1MYY94qJRCxrdskVU843
         BavVg7ugQzUJQOui1XatmXjca48bb+sUVyeMuNFQSFQr7eyQvoUyzTX8KfwYSSYEw8YZ
         a7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h2/LLawg3qJwTAKsFMDPknmeDU7m4nmA9ynwHx4AsQ=;
        b=TxmQnrBTpAbO/eMglsvKmVrcqK8t6YP61ibYj3f2+moAVmAtWW3JYqElLTFa7rMqN3
         FKcKbuNEXjYUrx1L1xW3YTmmJe7EiCflJdEQqAwaMW02M75iTTSBGuGNvQB/cUweG+xm
         TfEez+Dq9bBlfPPyP2bwVjzrGvkFH3ICH7knu7Y6i4VUTYLYWIi4vFhLQs64Q7PwOK6x
         YPghtngKyk2QFY6qDd7B2FjFCzGQl/bmpAYWCt9JBH+BgDkKhZw4u3p5gPmb886ypu3X
         WqnP0F+kZhlvrl92b16cCvZkG8miiK5BnZ9YpdL9fLlI7GhdkttB5v12dx+5DqBLUuv5
         UStg==
X-Gm-Message-State: AOAM530vPxmdKrebQasXnL6XeNzj6JRAMXC57fZ0KCcS6cYYczbWesld
        JI62TtTucA0lgDJBnXg5FYsyee5E54KJ6g==
X-Google-Smtp-Source: ABdhPJxFHfzeN8+LQi+OJd7uQUcZm35eNZYxmWV9UqZGMjScFY2I9M0KZz2tnNzxzRe7SKth641Gkw==
X-Received: by 2002:a54:4192:: with SMTP id 18mr474430oiy.84.1622490689800;
        Mon, 31 May 2021 12:51:29 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w6sm3245019otj.5.2021.05.31.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/13] push: return immediately in trivial switch case
Date:   Mon, 31 May 2021 14:51:13 -0500
Message-Id: <20210531195124.218325-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to break when nothing else will be executed.

Will help next patches.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index e3e792c69c..0aa1d0f07d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -257,25 +257,25 @@ static void setup_default_push_refspecs(struct remote *remote)
 	default:
 	case PUSH_DEFAULT_MATCHING:
 		refspec_append(&rs, ":");
-		break;
+		return;
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		setup_push_simple(remote, branch, same_remote);
-		break;
+		return;
 
 	case PUSH_DEFAULT_UPSTREAM:
 		setup_push_upstream(remote, branch, same_remote);
-		break;
+		return;
 
 	case PUSH_DEFAULT_CURRENT:
 		setup_push_current(remote, branch);
-		break;
+		return;
 
 	case PUSH_DEFAULT_NOTHING:
 		die(_("You didn't specify any refspecs to push, and "
 		    "push.default is \"nothing\"."));
-		break;
+		return;
 	}
 }
 
-- 
2.32.0.rc0


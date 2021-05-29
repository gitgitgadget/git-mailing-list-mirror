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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E83C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F12613F0
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhE2Hqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2Hqj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:39 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93DC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so5809309oto.0
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnUJxEwMYlPWy9dkL0ouaEN5kahFfn6cu0uhvOszYAA=;
        b=bzsJyFUWu/mrjJx5B1B/Y6mAuVMUbvV93XLIn2pBP9LQwq8ln1q2qoY+25hr9LcsNe
         vTsX4JxwnNWnIeCH9kw24rrpwVjweeXTxaC3T1fi+5xaN71QjYm37PQemKyptj3E3hkh
         yns42S+4NwL2sD6sSj9bdDxLmYAW4ib5eqbexswNC+wkfv1HoiG4hQAtl3ZJ+88Q+saY
         9D+Tjnn0m2xMOPcIE6bVSa/4ToR8QDxenIfTz5U2RH4Ktrl76P8NEwbU0XLtnFjymd5V
         uWGRIw7Ug3vQV5BNeBIuDxUYDmLLzy4ugDQf9G58FDUkqruCCb2HSEU7QI8LLe/uTTwx
         COUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnUJxEwMYlPWy9dkL0ouaEN5kahFfn6cu0uhvOszYAA=;
        b=AOZUbzIu6KO8RcI4DS8I+/5qHfRIdxFjTKtPRYBrp1/wo59OEngE4mj6tsWUgouz+M
         GLpwVJXgnYq1ULOqwW62RMN8IztyvmlL4NagkjwYyJ1ZfzgRMG04raDaw4rQ3uLp2Q4x
         JHYR+lUG8+BcT8NHCifskuzN7g1ynMgI4ccRB2apFfH4E8WVhT6qtNmZiPD+wxzIu+w9
         zcxZnm3isGFhD47xthpXVfK0gxaNR0SkFLTGQcefajk1ntxY1UB17q/+kJxDHbJIroWS
         QHQpwrOmNDYM8HfaZaLnq9tVFfsZwyx3P6ul40ov6dw5hQcicv0ljD80ZbbOp5lJQY4H
         6jow==
X-Gm-Message-State: AOAM531NYXanbVrl1m78ZdiKdV+1MBbY9SWV3P4VqbucQ7870qkGZ1xk
        MBm0IZ6ln3rsP2TM+6CgwOzZ20QbnYcFGw==
X-Google-Smtp-Source: ABdhPJwWrMIwtdELr/0LvxqHW1Wt5haXj5rSkAxiWGIejuc9jbnkLcuht0knzouM6IghXJNNN7Lz1Q==
X-Received: by 2002:a9d:e88:: with SMTP id 8mr9538835otj.239.1622274303018;
        Sat, 29 May 2021 00:45:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o20sm1625810otl.2.2021.05.29.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/15] push: return immediately in trivial switch case
Date:   Sat, 29 May 2021 02:44:45 -0500
Message-Id: <20210529074458.1916817-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
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
index 39a271bb27..f4e919450d 100644
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
 		setup_push_simple(remote, branch, triangular);
-		break;
+		return;
 
 	case PUSH_DEFAULT_UPSTREAM:
 		setup_push_upstream(remote, branch, triangular);
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


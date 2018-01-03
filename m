Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693561F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeACAqm (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:46:42 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42100 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeACAqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:46:37 -0500
Received: by mail-io0-f195.google.com with SMTP id x67so508072ioi.9
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DboV2eprDhykQSwoRT6nFJaStEm0DYgmSoTTOXv+Ru4=;
        b=sJ69PnvhAhjV82IRJsjG6CZmgcLOjEfbggkNeG5Fj/hloN+8vKnIG83E+pfSurZhPs
         lczEHp90j+JeL14fFgloFn9uy8gU4C+0oaE+msbLB+K5FNePNFpJhJmMgTaXqXLYWYoB
         YCBH+w1dAdE9dBdKQosrhiShIRqMxG8DME/2oXJtlCuxVuLvSBcSIEMjHIsXoOFGoMI2
         KEWrZHJMD8OnZUXZH8w1RYFPdr1s+MwTm/fMA6aiJQfuWGShXTL+efA9lBr1lFMSEF04
         wkyfJHUUYt0XOy5HlU/9oKQt7o2+8J5tlC8B0VlyLIMroBA0GTyFntY0JYJREQG0U/iU
         Y3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DboV2eprDhykQSwoRT6nFJaStEm0DYgmSoTTOXv+Ru4=;
        b=EBhUtk0w4yp5DSTAkxkzWOkIGAyrmr3VLhSkqlxv5I2FpDjAMfma7wb1KEFb4g9TEd
         q2ZpNZrCE50lDXJgoNHOGtdEaFuziX38/jyf5VIMN+hLq4FDlfHWWQ/JPI0zs2s3NoeW
         7rbTMRy79fZ+Kb2ComwUav7nxItzh8I0VrzA53BcFJXx4zxnncT71+XIQwGOlUIDaDmS
         chGlgSUotPZuOQnJuuz+17j2Ar9LDTFx5bUZz/dAbF8rVbURr/CWlmhZNI+P8JQGWI+A
         5MZELeYfZS8EN4T2+HFhB+Xx6koZVipa1H46C/C+CvZHJnTW9lq93PIHwKhgjbjckDeA
         b6Bg==
X-Gm-Message-State: AKGB3mLGH/ZpM5MYzFpzOFwys4Lr2e2jTZqUHgxz9lqbVQWuBbKhHwYn
        r9SZuRsm4C+WeZWHId31JArn0AJ/bdk=
X-Google-Smtp-Source: ACJfBotsoVMgrU7SpUbQ/2GXqDey+I42qMgroG7cz7doDevQIIoO1uekRjcq0Oy1jjMHUDRD2d2c2g==
X-Received: by 10.107.202.133 with SMTP id a127mr60626436iog.156.1514940396050;
        Tue, 02 Jan 2018 16:46:36 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v19sm37079ite.4.2018.01.02.16.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 16:46:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] diff: properly error out when combining multiple pickaxe options
Date:   Tue,  2 Jan 2018 16:46:24 -0800
Message-Id: <20180103004624.222528-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103004624.222528-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f506b8e8b5 (git log/diff: add -G<regexp> that greps in the patch text,
2010-08-23) we were hesitant to check if the user requests both -S and
-G at the same time. Now that the pickaxe family also offers --find-object,
which looks slightly more different than the former two, let's add a check
that those are not used at the same time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c             | 10 ++++++++++
 diffcore-pickaxe.c |  1 -
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index a872bdcac1..29973e78d6 100644
--- a/diff.c
+++ b/diff.c
@@ -4122,6 +4122,16 @@ void diff_setup_done(struct diff_options *options)
 		count++;
 	if (count > 1)
 		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
+	count = 0;
+
+	if (options->pickaxe_opts & DIFF_PICKAXE_KIND_S)
+		count++;
+	if (options->pickaxe_opts & DIFF_PICKAXE_KIND_G)
+		count++;
+	if (options->pickaxe_opts & DIFF_PICKAXE_KIND_OBJFIND)
+		count++;
+	if (count > 1)
+		die(_("-G, -S, --find-object are mutually exclusive"));
 
 	/*
 	 * Most of the time we can say "there are changes"
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 72bb5a9514..239ce5122b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -251,7 +251,6 @@ void diffcore_pickaxe(struct diff_options *o)
 		}
 	}
 
-	/* Might want to warn when both S and G are on; I don't care... */
 	pickaxe(&diff_queued_diff, o, regexp, kws,
 		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
 
-- 
2.15.1.620.gb9897f4670-goog


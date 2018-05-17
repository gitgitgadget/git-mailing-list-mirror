Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80AB21F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeEQSaI (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:30:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44202 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeEQSaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:30:06 -0400
Received: by mail-pg0-f68.google.com with SMTP id c22-v6so1513937pgn.11
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49Hhf4G6sraixNM8A3elvhUYuFde0pnz9p4MD88J8co=;
        b=A2Y8j1jNA7Y4WdMiSmSvWLBRoFJ1IPuD/wrKs6ECG9E6f/HphVCJ/c105trgHtP8AA
         186CvYGKFiWBDCEc3pUQQ2+p+GHyf8YIVzUp1ow1WijPOTdwjvwe1Sjr47CSv/TjmaUe
         CehhgiWGtWYpcrWIn1dYAJX7MnwXTLQ2dtsAB4owDAUQr3kyShFolD4wQp9Rqzlpiozh
         MAj3qJ7QLHrWnhtfWa6G3s7wWSOhJtspSwvl+n9USZY6kFpEL+UtKCF6EEkYKku0MsfW
         8/UgHdihsIsqO2UPZJP3We7ghlZqMwnKHxWCUkxOacuGB0OE2Or0NRyquRVvb4jA4tK4
         uUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49Hhf4G6sraixNM8A3elvhUYuFde0pnz9p4MD88J8co=;
        b=lKJgHM2+rS9EFRfBSxjmRjtcmePRwzlntBky1xmGh2eaIIJ6SdqUPZMd7ZquL+kScp
         i/d/B2/zeX98ojCCJw2rXAG/ybNpyGwWTwBiK9KGoB7P0fyeLLdF6KCezQytq5mlxRub
         VjDIm59Bp+4vwDFxiyo8AJewF0A81yATExMMwnwTx3Ed1SfADnvTyylc2XJvaICD0Yrc
         o2c4qYZffl2jgRw4e1qXJkHhVFKeznxJvdDEn+N/hDmcx6O6cVQhVc1Vs7LChaagCgUa
         qTKFpv3J0CVJ+mDAObjUX4vCPHbaEONTQJNnG7phG1xYddgTxxfC1Wk4snoJjDa5/1nP
         bn7w==
X-Gm-Message-State: ALKqPweLcrBZDw8Wo8JFu9VF5M48w4/JcokhqpgkeNi4a7gkT+p7OUKx
        V9d3oyu3vWsfyIC5Pc76tkusSA==
X-Google-Smtp-Source: AB8JxZoS7jxkAezjVa0DK0ApPvZb2nbW9+g90k2JfXm6l/H7zPzyEHbGsHCjZrGqt/+iF7kBews2iw==
X-Received: by 2002:aa7:810f:: with SMTP id b15-v6mr6066635pfi.79.1526581805942;
        Thu, 17 May 2018 11:30:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j10-v6sm11254385pfj.7.2018.05.17.11.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 11:30:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 2/2] replace-object.c: remove the_repository from prepare_replace_object
Date:   Thu, 17 May 2018 11:29:59 -0700
Message-Id: <20180517182959.22961-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517182959.22961-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517182959.22961-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was missed in 5982da9d2ce (replace-object: allow
prepare_replace_object to handle arbitrary repositories, 2018-04-11)

Technically the code works correctly as the replace_map is the same
size in different repositories, however it is hard to read. So convert
the code to the familiar pattern of dereferencing the pointer that we
assign in the sizeof itself.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 replace_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replace_object.c b/replace_object.c
index 246b98cd4f1..801b5c16789 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -37,7 +37,7 @@ static void prepare_replace_object(struct repository *r)
 		return;
 
 	r->objects->replace_map =
-		xmalloc(sizeof(*the_repository->objects->replace_map));
+		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
 	for_each_replace_ref(r, register_replace_ref, NULL);
-- 
2.17.0.582.gccdcbd54c44.dirty


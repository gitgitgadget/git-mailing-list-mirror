Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FC41F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDFXWe (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45303 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeDFXWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:05 -0400
Received: by mail-pl0-f65.google.com with SMTP id v18-v6so1522336ply.12
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eqeohi2hkPkbayySmb/Vc4l3Dg4olMnXqouexqHvBEw=;
        b=QK7G9KZVPAJJZ4aCd4591G9jtzQ4Nc1sPN1Fna/6B3SDA2Ae8EQq0gbHMSKhHaWnnf
         rQqqBbqNZt2sQnMhn4V7ew4tngmVz4v84CclyF0ug+fDUxJGpyXPQ6Jlj1Y+m57Znt/+
         havo7gpmiq7/aaEIgHxLC8OqIr2OSTDatMp/F2xxpHR7YoIgHzfaM3zEI8RETOiVAlF1
         aZVQF9kBG6BueBYd2QnnwKnYqMr6YOkyuao+4K0Dz7B/SUm8JVDyFdX6L+R8zVhJ8r/l
         BCoujfHICWt5cDTBZYLc72CIg/QI4xB3c4GPrPraEVn2lWMjmQIbXFvGUrXupNaviQKD
         NPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eqeohi2hkPkbayySmb/Vc4l3Dg4olMnXqouexqHvBEw=;
        b=IKfHA2mIUUshn3WMYRe3/RMpMfGsGSUNh5Rsr51c8vGU6kUtIR3RL1NffIyhQXXUqU
         lp9e/8gDXP9ohFIU+ZuDW+pd2G2HRSFXwH9U8QOAt7VeRrmJrJIoQZrCwRi5rta0rIsV
         ak/ClQa9J9DXyz2XmG73gNvTdH43WydhdCCJIcxQ2pbcks7pFnjyClEnOTr85BgDK6xg
         +WAV8A9tcPmjdDde41oOCQraS/6AvaKXRgedfFyp3ioj33ow78Onkoxyih9oHlfMdeIm
         cbpXvvyD6kpBBnEwIyIE8Y+/h8MUqL1S1WRyn1s9sBGwWwY0TemzpjmiNVnzJW+G2QqU
         dlVg==
X-Gm-Message-State: AElRT7F7enaiheJWBXHxTaCMVlO0OkBjCX0HiL/wn587T2rwTWgMGLne
        YPK13O4C/zi+ivtnorsAUewDmQ==
X-Google-Smtp-Source: AIpwx4/R3MkZJ3vjHcpN6qLKgLiQzdZnDNCTRZ5Nv+a+vPNTSqvTkEHTCRKm5KlG+rI9L0FcPHlEew==
X-Received: by 2002:a17:902:8c8e:: with SMTP id t14-v6mr29188864plo.206.1523056924501;
        Fri, 06 Apr 2018 16:22:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j3sm21245906pfj.60.2018.04.06.16.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/19] replace-object: add repository argument to prepare_replace_object
Date:   Fri,  6 Apr 2018 16:21:27 -0700
Message-Id: <20180406232136.253950-11-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the prepare_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index e9aa964978..3a3d971732 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -75,7 +75,9 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-static void prepare_replace_object(void)
+#define prepare_replace_object(r) \
+	prepare_replace_object_##r()
+static void prepare_replace_object_the_repository(void)
 {
 	if (the_repository->objects->replacements.prepared)
 		return;
@@ -99,7 +101,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
 
-	prepare_replace_object();
+	prepare_replace_object(the_repository);
 
 	/* Try to recursively replace the object */
 	do {
-- 
2.17.0.484.g0c8726318c-goog


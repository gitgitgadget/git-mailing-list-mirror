Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823431F404
	for <e@80x24.org>; Sun,  7 Jan 2018 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbeAGXB5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 18:01:57 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46347 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754713AbeAGXB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 18:01:56 -0500
Received: by mail-wr0-f194.google.com with SMTP id g21so3235375wrb.13
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 15:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SumOEBVIWmjBOWOULLOmUS3z1hRlDZzeHPYMPm6qphM=;
        b=f3VwHtVcYwGEtfxUaaI9J9l5L4vMBRpBUqA5OUbr/shmL8tvoOj1zwkuDeIPphRG+x
         x7nDJuUFwNVpbEvoL/4eQmG7K6iUa+GALebPgxYVTPpWeYk8/tu3x5uWs73aoCY5xPNX
         3mUMXWU+ikb94lwVjJhd3hV7wZi3v/JsI8xMLOANPpdL6BlomHgwf41Rmi5UoMo/lcXr
         RFCYpCP0ZC89SbcGZkQrdNDh2auSBNKLgArxe0Q93MwbWKYcxxofDFL5UsgAYzzmFvnT
         BSJnrAt3U43ENgI9om2ArEAkBrolRgyBhs2uTvi9LrDg0xeiW5KFOPeUeBWjy2FeXUQi
         opHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SumOEBVIWmjBOWOULLOmUS3z1hRlDZzeHPYMPm6qphM=;
        b=XdWe842ElqIwmdv5R+r/+aQnAybic6gAMAcyki18EYqS3HwXrAFD1nRSD7bzlBa5Px
         /7xfREQpuOlodle320auRTElOOBsyju76KTIB3vAr88ohmaXg/eoJ31IStcv+e70UGdK
         T0GXBBr6Vy7ZtpiX4y0jTPRL3Gn4ZQTYVKpqSHUO2eVLxufNpEr+JEQY2d4zczWkp/sm
         H576ZuRnoQPdkEu6L5VgkXPhc5dlPEkPF6VteFw9KOFlocN/6W8FIHOD9/o1KLVbA7NM
         S+awvv6U/87LmvT1x48cQe7PygHUpVcL8e1ftpcieeMyDjsMXVC1bLlOCdF0LVm8LXUR
         sLbg==
X-Gm-Message-State: AKGB3mJdxrtabY8mRwPat0vDZkxM3CRvblG3MGBewZIgJJnXM6f3OJgY
        rXrUD1us6DkYs5GA+i8dKwCEXdh1
X-Google-Smtp-Source: ACJfBoteeWG6ADSkWm3/iP22R1AVChofYvOOccQWo/vw6Mei/JTWOneqCgK3pCnytj8twJZBiXUJQw==
X-Received: by 10.223.177.143 with SMTP id q15mr7581143wra.228.1515366115517;
        Sun, 07 Jan 2018 15:01:55 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a69sm9249546wma.25.2018.01.07.15.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 15:01:54 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] oidset: don't return value from oidset_init
Date:   Sun,  7 Jan 2018 23:04:04 +0000
Message-Id: <20180107230404.23289-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c3a9ad3117 ("oidset: add iterator methods to oidset", 2017-11-21)
introduced a 'oidset_init()' function in oidset.h, which has void as
return type, but returns an expression.

This makes the solaris compiler fail with:

    "oidset.h", line 30: void function cannot return value

As the return type is void, and even the return type of the expression
we're trying to return (oidmap_init) is void just remove the return
statement to fix the compiler error.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 oidset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/oidset.h b/oidset.h
index 783abceccd..40ec5f87fe 100644
--- a/oidset.h
+++ b/oidset.h
@@ -27,7 +27,7 @@ struct oidset {
 
 static inline void oidset_init(struct oidset *set, size_t initial_size)
 {
-	return oidmap_init(&set->map, initial_size);
+	oidmap_init(&set->map, initial_size);
 }
 
 /**
-- 
2.16.0.rc1.238.g530d649a79


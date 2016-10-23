Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E580720987
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756366AbcJWJ13 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34995 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756338AbcJWJ10 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so5223089wma.2
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lHMPM/ptcqigcCfPToma37ijVFmJJKkdnGSGMhS03Q8=;
        b=UfWlovIzcmebPsKWMEn85SnjmGYakYPtYDIDdfgOSnBqkQtimBMES6uUcigSovY0Le
         Sbq8OBhiBs/PYk6CjB7hYOCN8PVg84JOrxGfKbqIjxH8U4FVIqDH8GLMbbVrYq7loc2u
         aQwNllqdVDal4KPBequAkcsLjgKrXBpXv+IN5CMphmM590SmHIzkbS7PrREwbpSfxQsh
         WyVQlKLQ+AJosuFj1LcV3L8mANrZs8t/l+3rxKWZ0hnodhqtD4RbLBDzhRw1488Civaw
         kmDgXlBTWNOctjo72T1zoiOLqC4WUZf1amPey5ZFZUeXFLjj/dd6u8LRzJO/AKXRC2iU
         Fyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lHMPM/ptcqigcCfPToma37ijVFmJJKkdnGSGMhS03Q8=;
        b=M1SXlbKABbHKgYwqjyL94jPYajOMnrcL3kyOQ+TGt8BFbgq5WQa9+BgF22w89H4c9k
         2m2lPypAGtSxVPyJ8Tq+2UB28k68Tes/YjZVaqD7wOKu1Nk5ZCY+EkvN7w2t1Mnr4fqa
         miI1hun7xoSSaRi3hRdWMW6Dcvz5KdpzfQsTe+IKGrogRamwBoSgK0GGyeG2F9QhQtrj
         RmhzXD49qztvKUC1Ax23xSNuISyVo84c/8Bbcncjce2CAT5ygveutW1WUQT9Ucv7NzDu
         3Fcns2JuT/WNnEsVuOofufd80/RgT0bCoCNRBwn7iT39qyGbodMwn3GnoDKBn61Mn3K+
         fcHA==
X-Gm-Message-State: AA6/9Rltu30/6v2TSewNVZR2vN+4+uD0m3HbDrKeYo55N70VSwFcXloAwlTRAJ784UtkdQ==
X-Received: by 10.28.69.214 with SMTP id l83mr17997001wmi.119.1477214844841;
        Sun, 23 Oct 2016 02:27:24 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 13/19] sha1_file: make check_and_freshen_file() non static
Date:   Sun, 23 Oct 2016 11:26:42 +0200
Message-Id: <20161023092648.12086-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a commit soon, so let's make
it available globally.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 3 +++
 sha1_file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index faceceb..a625b47 100644
--- a/cache.h
+++ b/cache.h
@@ -1167,6 +1167,9 @@ extern int has_pack_index(const unsigned char *sha1);
 
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
+/* Helper to check and "touch" a file */
+extern int check_and_freshen_file(const char *fn, int freshen);
+
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 266152d..29f927e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -576,7 +576,7 @@ static int freshen_file(const char *fn)
  * either does not exist on disk, or has a stale mtime and may be subject to
  * pruning).
  */
-static int check_and_freshen_file(const char *fn, int freshen)
+int check_and_freshen_file(const char *fn, int freshen)
 {
 	if (access(fn, F_OK))
 		return 0;
-- 
2.10.1.462.g7e1e03a


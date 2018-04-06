Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0681F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDFXWI (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39229 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDFXWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id c78so1789839pfj.6
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d81sFanDTeENgFiX1TTlNG8HoxF2BlTPY5bUJFPVu7k=;
        b=GT5F+izp8w68kbukMy4qYejFPVFlTGpw9q/33qNTlYLuHKDIJ0K5/pU06rVoGe9Uuq
         zVWqz7fDQAyQ2CB32f7meaxWVIp2YWHkny8IRaA0tOSZLfTAoImqb29A2+f4CWdc/EyZ
         OsKXVkaD4JxpIMWQvX1TmgAwtt+1oDkg3akoc4riggM+8m4924vj05dBp9momD2AAofJ
         ruHWsfq3q1Un+Sm1YMtirOQSkqxgBqSmxAbWM+JKtV2aDTj8RHP8widRjufxMGfucL6M
         QKXv1UPIUOr3gK45QJ7UKSmEiesfDXE0xHpXlkb6OOZmgdjUN4kFsm4GibBiedcVY/0z
         ay0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d81sFanDTeENgFiX1TTlNG8HoxF2BlTPY5bUJFPVu7k=;
        b=bNC2XN/jbxZKmrRF/SZWjXcdMhqJAwLIafgYnvjo5CYCbJyah3efUFfhjgbUMIzDE/
         tY0yqLGirGVrT4qUqe+3YYFcpqK36PqimCV8x66hHSMik3gNwtfxC01pYJS0oFDjKFz8
         G4XhkptkK1fwgZQpZffjwGpYXtEuTXz5SLhzfMm1uK+QfsxdI6fhGueu+DkoFD1iBLAz
         ExpLpqRJkz0a6vGY1C5kJzOV/ezYyEoHT7jwpr4PeenQu9e6hqzN7vKdwJbeonyAx436
         hSkYcwH9xt0cL6DSFjNadD7tzJkxsK9A4aeGArZ4XuI62cQ6102DqM4E58cq6ECR8DIY
         1/Yw==
X-Gm-Message-State: AElRT7Gvq7QQz5aB+d0qSBXJonB+J9z8VS+4p9U5fA7vtonm4ygUWZRD
        k4jY7tGfkC75xCnkGpevLb8f4YhsQB4=
X-Google-Smtp-Source: AIpwx483efWU8+sP9AyU67iSLZtqNlu4ct9BUjz77l119sQLnmq9Ne8Ltd7xHt8n05HfYanAvBDGdQ==
X-Received: by 10.99.180.6 with SMTP id s6mr18551922pgf.81.1523056925844;
        Fri, 06 Apr 2018 16:22:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b3sm20162548pfi.54.2018.04.06.16.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/19] replace-object: add repository argument to do_lookup_replace_object
Date:   Fri,  6 Apr 2018 16:21:28 -0700
Message-Id: <20180406232136.253950-12-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the do_lookup_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 2 +-
 replace-object.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 3a3d971732..944bcaf242 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -96,7 +96,7 @@ static void prepare_replace_object_the_repository(void)
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
+const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1)
 {
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
diff --git a/replace-object.h b/replace-object.h
index f2555cddb9..dbb128f4c3 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -14,7 +14,8 @@ struct replace_object {
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+#define do_lookup_replace_object(r, s) do_lookup_replace_object_##r(s)
+extern const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
@@ -28,7 +29,7 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 	    (the_repository->objects->replacements.prepared &&
 	     the_repository->objects->replacements.nr == 0))
 		return sha1;
-	return do_lookup_replace_object(sha1);
+	return do_lookup_replace_object(the_repository, sha1);
 }
 
 #endif /* REPLACE_OBJECT_H */
-- 
2.17.0.484.g0c8726318c-goog


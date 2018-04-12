Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867331F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeDLAWF (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:22:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40221 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeDLAVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id x4-v6so2603020pln.7
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3AbR9ATZkgWVY99h+AP/7diE5uK641ThYmaVhGH6Ny8=;
        b=E39c1oojJ8WiBgaWnUSmlW324MyiT5V+/Fvo0lkeXkfBet58yAq6+iO6suLhs9H0ty
         EBv6B8vLGyyYzPs45IDQjEVltazSzlnA9WGGxaQVROp2OQeToFfO8ozIOel+748fP4BR
         CiwgvIZxF25faE6MHMh+QVgUWHZWNpryuymFDz/06VfhljPMKZY/BF5fKvjhs3Mc91VQ
         B4yqtpVaDEd3h5oQ9sm6hK5GQ+f+k1IS/Wt6qY496tiwB0jBbFkSuOtpJbFgNKt7CWTD
         vC6F45Yn8w/uc6JYElxQ8Shtx+sRy80+uLSs1iy69WRLP52lF9uB5R6aA6+qR/IY2y/M
         RidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3AbR9ATZkgWVY99h+AP/7diE5uK641ThYmaVhGH6Ny8=;
        b=p7TmMgFUcgI2nnW+UtG8ew3vOhoDTH11Lk8j8/Wde5ack+cq+XmfulGTFz2TdMYcnZ
         DVvpRx4Abp35oshDnuwLO4idhBUvaD6SoA2u3pXm9PUHiLn8UZOh1Lsq/5SIEjDXdgQy
         XFTckWhn33lxyMfGJ2TMtjROUiAymhVXhd1r5IMCw6P/t77bQGDNJMKOms4yQTpavg4c
         dgaThLFPPmpkVaGPpdo1hR3lzbh2oOQ5pNz6zCN4cEkB6LVdUj/ZHUB8MNrmb9BU/pA+
         I0Q5CpevfgTFigG2nNiIeAUPkbmPY+N6YaE3jD4OvN5pGeXcNn07MrbFxM04O1MQHCFD
         aeFw==
X-Gm-Message-State: ALQs6tDT1E6jSV95WLLbxp0XDteqRUv1/FvF+zaDl0/ur+ciAxRC8Uip
        n7wU2Bt/2YDaKc101qDgSBO4/A==
X-Google-Smtp-Source: AIpwx4+GBpcZ9y0QB9DpOM5+wdt+k8MaEC3L4y6oijP2rOGVc6hxF23rDpLaEfbChXB++PSn3AcSIQ==
X-Received: by 2002:a17:902:68c2:: with SMTP id x2-v6mr7328783plm.129.1523492497388;
        Wed, 11 Apr 2018 17:21:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id g64sm6641971pfd.75.2018.04.11.17.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/15] replace-object: add repository argument to do_lookup_replace_object
Date:   Wed, 11 Apr 2018 17:21:12 -0700
Message-Id: <20180412002118.102976-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
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
 replace-object.h | 5 +++--
 replace_object.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/replace-object.h b/replace-object.h
index dbc51265ec..ddeb0470bd 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -14,7 +14,8 @@ struct replace_object {
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-extern const struct object_id *do_lookup_replace_object(const struct object_id *oid);
+#define do_lookup_replace_object(r, s) do_lookup_replace_object_##r(s)
+extern const struct object_id *do_lookup_replace_object_the_repository(const struct object_id *oid);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
@@ -28,7 +29,7 @@ static inline const struct object_id *lookup_replace_object(const struct object_
 	    (the_repository->objects->replace_map &&
 	     the_repository->objects->replace_map->map.tablesize == 0))
 		return oid;
-	return do_lookup_replace_object(oid);
+	return do_lookup_replace_object(the_repository, oid);
 }
 
 #endif /* REPLACE_OBJECT_H */
diff --git a/replace_object.c b/replace_object.c
index 567d9da708..adfed78901 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -55,7 +55,7 @@ static void prepare_replace_object_the_repository(void)
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const struct object_id *do_lookup_replace_object(const struct object_id *oid)
+const struct object_id *do_lookup_replace_object_the_repository(const struct object_id *oid)
 {
 	int depth = MAXREPLACEDEPTH;
 	const struct object_id *cur = oid;
-- 
2.17.0.484.g0c8726318c-goog


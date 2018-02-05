Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610AF1FAE2
	for <e@80x24.org>; Tue,  6 Feb 2018 00:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeBFADY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:03:24 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44974 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeBFADV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:03:21 -0500
Received: by mail-pl0-f65.google.com with SMTP id f8so89385plk.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRYuo+IOlMeaQYUmtEvaavYW0B7/ZlEu1MHFo6cjvV0=;
        b=QWGiq4h5oScc77E18qPqTdRLvKm9AxH9LWgVyJUgk55JvMFu9d8FoSTufQ7Gfx6HWj
         8wcJh2J7az3DjX1dvBO5bLz7/JuXHYyDmyukg+cy7dXvy4Xhr1zsVAtNK2tjAxsXfhOY
         Oh4lMuj+kmi/7WKfOWEyLRjhFSjR18jpC+pf8zv2AKy8QnsyQuoAG7zrBouPtMVSov2o
         ldNaqq18zO2P9oyYPo57hNJi2x7/cVmEfbLWtCeL1nLqZ/YD4EFfmsV0E8lw9mgg7qr8
         lMWdE7z2RiVYGrd9cXXKdg1GJGbdvtGt/WVSUmwAEiuiD6qEXVN3S3oeyRY1HHzhSahJ
         FCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRYuo+IOlMeaQYUmtEvaavYW0B7/ZlEu1MHFo6cjvV0=;
        b=UyKCMWoimLc6m1V8vfUqsNJ3Zh4ORiQQXMEjApIR5fx2corUHiZFDLwcSyoMIkHa5u
         828YMUKfIRrs4zDjkM2jASV2yQ0QFCwHWpFB7yYtn2JOdM/pVoWooI2kxrV5NBBO6tfg
         v+aw+obuxTEJMumwHRXJByDZho7DReTiPXvTa+Khnsl+fvNhcPtTot8XYYKNsR8h4ce8
         oAImTpPEIKp1Nao97lfu9HzkHNvkmXg7R7AhD3XNK1KftgG6HpvEUjq5yDcZeUo+bGyT
         He3jBKLgd5FZkIFNPfFnncFfKwXFPjQ5/57jX1kAuEvoK/JMaN/HW5+zYFUoOt95fq4h
         w0og==
X-Gm-Message-State: APf1xPBq+B+mkghWfOw+p9uQEQdDPDPz/Z5FcvP8PfYxwUjSwwkBz8gV
        kp8Llc9nE+hzod91LWnehqrUHF8+P70=
X-Google-Smtp-Source: AH8x225wtyV5WMolh/Z30tZ1r+uW/Cj3+PuRIrt+AU2iYt9wCTBhW6nyquDBt0H2B4gAVarZbMyA9g==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr501366plb.35.1517875400672;
        Mon, 05 Feb 2018 16:03:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 137sm14080017pge.74.2018.02.05.16.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:03:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 046/194] object-store: move replace_objects back to object-store
Date:   Mon,  5 Feb 2018 15:55:07 -0800
Message-Id: <20180205235735.216710-26-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

This way, object-store.h does not need to #include replace-object.h,
avoiding a header dependency loop in an upcoming change to the inline
definition of the lookup_replace_object function.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h   | 13 ++++++++++---
 replace-object.h | 11 -----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/object-store.h b/object-store.h
index 31628c49dc..cf06a54782 100644
--- a/object-store.h
+++ b/object-store.h
@@ -3,7 +3,6 @@
 
 #include "strbuf.h"
 #include "mru.h"
-#include "replace-object.h"
 #include "alternates.h"
 
 /* in packfile.h */
@@ -32,7 +31,15 @@ struct object_store {
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).
 	 */
-	struct replace_objects replacements;
+	struct replace_objects {
+		/*
+		 * An array of replacements.  The array is kept sorted by the original
+		 * sha1.
+		 */
+		struct replace_object **items;
+
+		int alloc, nr;
+	} replacements;
 
 	/*
 	 * A fast, rough count of the number of objects in the repository.
@@ -49,7 +56,7 @@ struct object_store {
 	unsigned packed_git_initialized : 1;
 };
 #define OBJECT_STORE_INIT \
-	{ NULL, MRU_INIT, ALTERNATES_INIT, REPLACE_OBJECTS_INIT, 0, 0, 0 }
+	{ NULL, MRU_INIT, ALTERNATES_INIT, { NULL, 0, 0 }, 0, 0, 0 }
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/replace-object.h b/replace-object.h
index 483335ffcc..e05713b951 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -1,17 +1,6 @@
 #ifndef REPLACE_OBJECT_H
 #define REPLACE_OBJECT_H
 
-struct replace_objects {
-	/*
-	 * An array of replacements.  The array is kept sorted by the original
-	 * sha1.
-	 */
-	struct replace_object **items;
-
-	int alloc, nr;
-};
-#define REPLACE_OBJECTS_INIT { NULL, 0, 0 }
-
 struct replace_object {
 	unsigned char original[20];
 	unsigned char replacement[20];
-- 
2.15.1.433.g936d1b9894.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D54D1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBUBzA (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:00 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38029 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeBUBy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:58 -0500
Received: by mail-pl0-f67.google.com with SMTP id d4so89209pll.5
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNLWdhVGj77d/2QPeyc6+7TeQH9uVVtrNDlfnYqjx+w=;
        b=HoFwa7G9GqGVj2c+P1pzzQy/CmAnTIQ9k24J4VA8oH/82bMDzjypokZlEbeDb9ejoI
         QQB4LDSccI7Kpu0w7w2jEzLW0fVSZBDSb0Lyqf3XwjbSG3f0c8l+/foGSgdlnfcMDTEC
         9orB9x19sRk2MfKlnIt59g5PxB98muw/+2DjjChMyhJpvUAgXp3+RLrIIkuJjcfiD+U9
         uegY5ai6uVAX+pxKb/0GuAxFGm2d7RYxWLRkLsBXy7zAp4sszfsJMerjBCdIaihH5x6C
         /MDKwOCNS7P2QD/qSVZkSIt9JZzfdj9HcTrOcuDntLvpkQ4diyGNqKu/iL/3mcfImsfu
         eSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNLWdhVGj77d/2QPeyc6+7TeQH9uVVtrNDlfnYqjx+w=;
        b=agVgRMAgdY7mQH/ylJ2rGi2CXnvKDL+yBCwClnr4hPNid6dIrOxXFBXF9TaU0MhI/L
         Z193cX9DgSGrLU1kp90NLprcGzg0ChEb+zaAxmGZcoIN8tk98rD+ucdpiiQ1UOvtQBon
         Uk4E43AF768g9jIKd4mcL4s0sFLL0BFRKnjNXn0c3S+Z1ZSEZ5gBYHa4DJA/OilGgMQl
         x8XkhcAHggYPQwASRSV7n+DYNc2f+F+IA3N+TqDipiY+NwmwOkw+Mp1rOYGB6SuU+gsy
         7w4j0vXNbpVajnTNc2P0gDxfNS/HyYx6Zjak3Hp8lZKFF/0tXjh97E7lqNgMKatatV3w
         Q1Qg==
X-Gm-Message-State: APf1xPApSBa8kzZZWw3jZSCyO/H/Fq2PEqeQqVb/7gvNoqR2UlwbpnMI
        ybX50B448Rf8BvxYB41zBsmC585uF5I=
X-Google-Smtp-Source: AH8x225oP9GuezcTss/7qI2hGCmQzG5CzV7gRTjqJO5mhOulpw/4gdXDdWC6JZqjQ3nP/coLPA8xVA==
X-Received: by 2002:a17:902:c24:: with SMTP id 33-v6mr1541869pls.24.1519178096940;
        Tue, 20 Feb 2018 17:54:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v126sm10802pgb.91.2018.02.20.17.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/27] sha1_file: add repository argument to read_info_alternates
Date:   Tue, 20 Feb 2018 17:54:14 -0800
Message-Id: <20180221015430.96054-12-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index aaa6276211..6edcc3d3a7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -389,7 +389,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static void read_info_alternates(const char * relative_base, int depth);
+#define read_info_alternates(r, rb, d) read_info_alternates_##r(rb, d)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth);
 #define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
 static int link_alt_odb_entry_the_repository(const char *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
@@ -430,7 +432,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(pathbuf.buf, depth + 1);
+	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -496,7 +498,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -680,7 +683,7 @@ void prepare_alt_odb(void)
 			&the_repository->objects.alt_odb_list;
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(the_repository, get_object_directory(), 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.291.g4437f3f132-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07AF1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeCWRWH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:07 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42901 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeCWRWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id a22-v6so19371034lfg.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLTQYhmjccRGy+OXOrqOIPVV6gvtPkj+oSONl9AtN/c=;
        b=tYdxU8NsBVJ6rSmbLWA8znptBk1cTl6n5hJCYw7zMsLTFKhudiZkAySydItrrIHNPZ
         +7O9/5INNUCM+NjmMy0m/c1B3bI+tLuEzC1Gaklb902G/PKx4xDm5pz3ojqy4ycu48gT
         COYGHzPRrKc4J1IknImou+Orxa16SKmUVXRTEOOilHWGN9ZZ6Q0xA8XZ9enpD6nfA6sj
         TlKsVazjbx2+m/URkx5tC5bSX38GtTfzdDJgT4+vXGn51qjBY/8J4xvSlrbm+fhoBYRM
         tvC3oDrOsmdBTgelJ/AS2Mge6UtSWwoC+q6KBuOlswS3rx84cEpv2Jz5THZgaqS3alMl
         JQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLTQYhmjccRGy+OXOrqOIPVV6gvtPkj+oSONl9AtN/c=;
        b=GzyS8dtkYmRDuKY9PauRkkEA04+2NHzewhzicm3KOByNHjoneP4oXpvgntZpRHbzBX
         TabMz04+pjIKAn6Rzb80p9BJyo0lPuAPjtZ+2HD9ZEqZg4PIDZnUCs3ZB3rdR99IcEDk
         CW/hC2pNR2kzf5/FdSATIC7WpWjaZN42NUkAGDaKaQqPrSzbbYPuxwOAAJAwjTO2Nvdv
         fKQNu3GKUXGsrNEMX0sC1awcMdHzmQ3+k5EBpfHsl45a/+q+3B7MHkAc8E5kVBuP6pfS
         H60GTJ8fq1PnAX++T0nSaARCHI3UopJCGNjJXOwS3v782ztwwkbjEQkY7Bd+6JdoWhnL
         Px+A==
X-Gm-Message-State: AElRT7GTDVN3jxnOcmTvSgA5iE3fZAvetDw5tdZo3fU/5C1hKbw4wtGV
        MAeIdfLW4zeCdkbnicniY9c=
X-Google-Smtp-Source: AG47ELufwK7MiAYYzGYQ8QPZER7n9DU31Nb5WkHa1/BFjbF/CaSSZDDFuP/ML2WHeoKKZ40reLVU8Q==
X-Received: by 10.46.2.90 with SMTP id 87mr6902171ljc.46.1521825719692;
        Fri, 23 Mar 2018 10:21:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 15/27] sha1_file: allow prepare_alt_odb to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:09 +0100
Message-Id: <20180323172121.17725-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h |  3 +--
 sha1_file.c    | 13 +++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/object-store.h b/object-store.h
index 3fc461a463..f54bc0b951 100644
--- a/object-store.h
+++ b/object-store.h
@@ -24,8 +24,7 @@ struct alternate_object_database {
 	 */
 	char path[FLEX_ARRAY];
 };
-#define prepare_alt_odb(r) prepare_alt_odb_##r()
-void prepare_alt_odb_the_repository(void);
+void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index d38f5cdb0e..04118f331c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -673,18 +673,15 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb_the_repository(void)
+void prepare_alt_odb(struct repository *r)
 {
-	if (the_repository->objects->alt_odb_tail)
+	if (r->objects->alt_odb_tail)
 		return;
 
-	the_repository->objects->alt_odb_tail =
-			&the_repository->objects->alt_odb_list;
-	link_alt_odb_entries(the_repository,
-			     the_repository->objects->alternate_db,
-			     PATH_SEP, NULL, 0);
+	r->objects->alt_odb_tail = &r->objects->alt_odb_list;
+	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(the_repository, get_object_directory(), 0);
+	read_info_alternates(r, r->objects->objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.17.0.rc0.348.gd5a49e0b6f


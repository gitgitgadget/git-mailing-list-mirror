Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9736C1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeGFAyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:15 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43020 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753969AbeGFAyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:54:13 -0400
Received: by mail-qt0-f193.google.com with SMTP id f18-v6so8713174qtp.10
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ftlLqLY7J+qjnpYaclYckTjuiyeaXAR+BAr6GJ7B+8=;
        b=Ur2/iCTIg4GsnrRKsKLU8uo5fPa00mCpeuHusMRnyVdsibvOPl5zMeBN7veROrrKu1
         eG83WicnES2/Rrj02ueEbIPiRDFhaZffVo1DMMI043m2JUQxuy42XEoTL1wQ7MqDDin3
         GXc3Siow5Zi5DzYKqeLN/8vq4p+S1Td6+oil47SixJEtwrn+G0Yn5VD4GP4//ZmyF4si
         KQYgQPvCrcz3rMNw/GXheXdGbEYeg3Msl3RVXJM7lmSglRKH35+6BZfy0f7pR5q0hDok
         9ZqvILFdoVTI4dSdzz1oON7xIbXGu8J0lXpNV5XHQyJzKMhoSi8E+HN+580RpcA+Szpu
         8/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ftlLqLY7J+qjnpYaclYckTjuiyeaXAR+BAr6GJ7B+8=;
        b=n4SF+oJP1Bd7RjuKaQSp+MyTAGAREtNPiOe4mvWyXLyx37VE0gDvdAsOmBUpiNfFAk
         c8f+c95CP3I4oP6wCVnDqNzigYzJtvLn4RWDf5M7Gv2l7CbmDmivZKGo0lpsXfJOTAwD
         gLjeLKIr3nrqhZeVzKF93Aepfr3Aineek+E/FRpNVhqvujWeQxnnHf9yUXJ/X3vHDxuw
         tYNWIyfkV2J4AVX1Bpx1jqMEpOVwaivmANUap86LFhuqUutpGpASw0NJKFPl33bnN/AR
         eGkTwKEIIMI3FNWHXRs1gJZQ+RRVDnblBsbiUUyDCAhg2+wlXFmnXncd/lYMlLyLMa/O
         s0IQ==
X-Gm-Message-State: APt69E3xSwRSussxGbqbkXlC3OB2Tq+4oB3jM1vT8weOLEGp+s318Fvf
        Wqt/Fjrhekq1HCGnJllUdS4AsHG+
X-Google-Smtp-Source: AAOMgpeqof2/nm8BZKGGzFul1OSn+jwcAVgaum5FjuflK8SFAENAeavwTbaY/qIZANm2WCS5zuWFXw==
X-Received: by 2002:a0c:8959:: with SMTP id 25-v6mr7237146qvq.169.1530838452323;
        Thu, 05 Jul 2018 17:54:12 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:54:11 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 24/24] midx: clear midx on repack
Date:   Thu,  5 Jul 2018 20:53:21 -0400
Message-Id: <20180706005321.124643-25-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a 'git repack' command replaces existing packfiles, then we must
clear the existing multi-pack-index before moving the packfiles it
references.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c |  8 ++++++++
 midx.c           | 12 ++++++++++++
 midx.h           |  1 +
 3 files changed, 21 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..66a7d8e8ea 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "midx.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -174,6 +175,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int quiet = 0;
 	int local = 0;
+	int midx_cleared = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -340,6 +342,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 
+			if (!midx_cleared) {
+				/* if we move a packfile, it will invalidated the midx */
+				clear_midx_file(get_object_directory());
+				midx_cleared = 1;
+			}
+
 			fname_old = mkpathdup("%s/old-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (file_exists(fname_old))
diff --git a/midx.c b/midx.c
index 7c00b02436..8afd08f3fe 100644
--- a/midx.c
+++ b/midx.c
@@ -903,3 +903,15 @@ int write_midx_file(const char *object_dir)
 	free(midx_name);
 	return 0;
 }
+
+void clear_midx_file(const char *object_dir)
+{
+	char *midx = get_midx_filename(object_dir);
+
+	if (remove_path(midx)) {
+		UNLEAK(midx);
+		die(_("failed to clear multi-pack-index at %s"), midx);
+	}
+
+	free(midx);
+}
diff --git a/midx.h b/midx.h
index 5faffb7bc6..5a42cbed1d 100644
--- a/midx.h
+++ b/midx.h
@@ -15,5 +15,6 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
+void clear_midx_file(const char *object_dir);
 
 #endif
-- 
2.18.0.118.gd4f65b8d14


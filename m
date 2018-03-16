Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4AD21F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeCPT2T (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:28:19 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38732 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbeCPT2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:28:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id y2-v6so14825125lfc.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=If+xMZaell1+lPxaUxdlWrTiil9EPcmDJeblrxhImn0=;
        b=nOrTtpTZCFENzMkAb5IfuZHeFtRr32Qtp1/cNhXL40r4FWV3QITwN+IXfWX5e2tkaC
         P3zDpp4IEXRdwJRR4sArbjacVrmXWkqnR8Bu+MqoRu+p8Nucok6Ih8JuiRaXwq/roDXA
         eb5o5LEP9xCcHWG6lS2VDA55Cr9VQ/NNQSKlzAOnXKkRlX8BRr1atgUIsV3siqSxnIl+
         oFKJklquejZ8G0+G1ylQg14tntWmXnTaOX/MpmhG+22PKBywPBdf666RsQCuE7gfB9B8
         GPFqOkEpfKaOvCZe2brfclGeXF52YmkayteOH1qK1+En8KVNaYEB+BwBMerrh9k85lMc
         qKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=If+xMZaell1+lPxaUxdlWrTiil9EPcmDJeblrxhImn0=;
        b=hmYxm06a7yns8XFiv6VbG/z0EO01oIliGxSlLxY9DzqnRp7cEX6mCNzc1af2pEgZvo
         r8dOaivBBApKZXg19T7cin+3m+YxpDbk8cKf0DpPkmEiuGjLcW5MTgqSlIYmOecU9pem
         Mof6kyNvO7hmHXM6rh5PmtPKv07ngWQK8nvoQw+18Mklhm+UWln3b9tEYR5WcVFWbM9x
         F6/jJmANFqg+edxxt6OTqnIbf+puOGDxai/UD370zFsuPXtxRL/2PcWDSUSmjv08m2kk
         mJQ7/0RL5mq6MXkEAEyJ1YmUhiT2MePhaEkgXK4VH7oqgD8PMa7KCjbZo0PAqZxBgP+s
         Rpkw==
X-Gm-Message-State: AElRT7ENkiV5kDYiPUYKwgkMOGApRY5s/7/RO4DSIeKHPu6LpGXpN4Gu
        UNvWwttTsxUc/YDfsl1F/fyQ9w==
X-Google-Smtp-Source: AG47ELvXSPeQeYb1DDLmoP9fcIdP70uNxXX7jG1mRuXrN0e0iPya6qvShJ81DP3K+QAzZntcEtlAew==
X-Received: by 2002:a19:15d9:: with SMTP id 86-v6mr2310001lfv.96.1521228493326;
        Fri, 16 Mar 2018 12:28:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm1766085lja.41.2018.03.16.12.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 12:28:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 6/7] pack-objects: show some progress when counting kept objects
Date:   Fri, 16 Mar 2018 20:27:44 +0100
Message-Id: <20180316192745.19557-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316192745.19557-1-pclouds@gmail.com>
References: <20180306104158.6541-1-pclouds@gmail.com>
 <20180316192745.19557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only show progress when there are new objects to be packed. But
when --keep-pack is specified on the base pack, we will exclude most
of objects. This makes 'pack-objects' stay silent for a long time
while the counting phase is going.

Let's show some progress whenever we visit an object instead. The
number of packed objects will be shown after if it's not the same as
the number of visited objects.

Since the meaning of this number has changed, use another word instead
of "Counting" to hint about the change.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6abde6ec6d..f74e9117f7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,7 +44,7 @@ static const char *pack_usage[] = {
 static struct packing_data to_pack;
 
 static struct pack_idx_entry **written_list;
-static uint32_t nr_result, nr_written;
+static uint32_t nr_result, nr_written, nr_seen;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -1094,6 +1094,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, exclude, &index_pos))
 		return 0;
 
@@ -1109,8 +1111,6 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1121,6 +1121,8 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 {
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, 0, &index_pos))
 		return 0;
 
@@ -1128,8 +1130,6 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, index_pos, pack, offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -3210,7 +3210,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress)
-		progress_state = start_progress(_("Counting objects"), 0);
+		progress_state = start_progress(_("Enumerating objects"), 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-- 
2.16.2.903.gd04caf5039


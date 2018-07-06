Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A171F6AC
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeGFAyf (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:35 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39728 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753891AbeGFAxs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:48 -0400
Received: by mail-qt0-f194.google.com with SMTP id q12-v6so8711718qtp.6
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iyaUQbq05yAb/n1g6lFlyfDEOd/BcXHH7CaUYBtBKtM=;
        b=tTHip+K3hXfnlhrZzHID4y4QhzHMQsQWhZsB+/ZthAsOYEMMfQeC/CefHlsf/O4wbV
         FIv5EcQQjrWGhdiMmbvM8xkn9kbG3m1VppWou+dzRhhtu1rYiR3HlMETt6MvK+zSkPC1
         zbkHwmS/4xmvF5vogj/mroxc0MPRYPMvqGM0ovdVsJz1IsT1ZzotGnxx9lltoQf4/fYg
         bpirKFTP0xbucdWRKGhkk42f6LicJewhdhTyDPuyCO1Ns40iJMojsMKmnAGCQ1Zyxkgk
         R0Y02ntnzVqTi/mxkDTB+UbTOYoSeimerkqpA/R4JF3GywitbexEpzl01mPq54WEyq8j
         R3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iyaUQbq05yAb/n1g6lFlyfDEOd/BcXHH7CaUYBtBKtM=;
        b=qNKxAhW2EKPiGmvTop7dFanXbUlKUgbBQrfN8//lSN2IDqLQfjoZPqGMbehYe1rAlK
         EafkLABl77/zucZjMalxfAJLJN8urydhd/S8FgHfhBYRBl0/7typPQfwiWLjDqZdlkdk
         WdYODy/9RU4YJPwtMmtMYqDH2nyy6wdtvzzex5pX3aNp1ZtR43+DLPMHhPzJi8MDvh6s
         j9/wm7VrV28w9Cm5A53is8lQVyOE3sU4dco9aMQ0w8mw+XRldbh3LyhBgTAJhNZwHCpC
         e/hBqWK4alw9WpqDVtYaUrN7kH0kVqfKrsToaOLvJHewHLJSxCUMvCU4wT2XEVElIIl0
         EzZQ==
X-Gm-Message-State: APt69E1uKOxmPrmCeWfBsyXtafHGtKgD1ATvatVSLSM/kRxzDpEzmUB/
        UbLAGVXdZxVFOC0+iJuL/G959sS/
X-Google-Smtp-Source: AAOMgpcaJ2aeGqd653jA96nfR+Ro9KCUc7c3sIOCYHmrkEn9FVcV4xuNDagb0Ydm7YNiDYxbDIFgXA==
X-Received: by 2002:aed:3a24:: with SMTP id n33-v6mr7603064qte.348.1530838427725;
        Thu, 05 Jul 2018 17:53:47 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:47 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 11/24] midx: read pack names into array
Date:   Thu,  5 Jul 2018 20:53:08 -0400
Message-Id: <20180706005321.124643-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 17 +++++++++++++++++
 object-store.h              |  1 +
 t/helper/test-read-midx.c   |  5 +++++
 t/t5319-multi-pack-index.sh |  7 ++++++-
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index f78c161422..ffe29af65d 100644
--- a/midx.c
+++ b/midx.c
@@ -37,6 +37,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	uint32_t hash_version;
 	char *midx_name = get_midx_filename(object_dir);
 	uint32_t i;
+	const char *cur_pack_name;
 
 	fd = git_open(midx_name);
 
@@ -117,6 +118,22 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	if (!m->chunk_pack_names)
 		die(_("multi-pack-index missing required pack-name chunk"));
 
+	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
+
+	cur_pack_name = (const char *)m->chunk_pack_names;
+	for (i = 0; i < m->num_packs; i++) {
+		m->pack_names[i] = cur_pack_name;
+
+		cur_pack_name += strlen(cur_pack_name) + 1;
+
+		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0) {
+			error(_("multi-pack-index pack names out of order: '%s' before '%s'"),
+			      m->pack_names[i - 1],
+			      m->pack_names[i]);
+			goto cleanup_fail;
+		}
+	}
+
 	return m;
 
 cleanup_fail:
diff --git a/object-store.h b/object-store.h
index c87d051849..88169b33e9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -99,6 +99,7 @@ struct multi_pack_index {
 
 	const unsigned char *chunk_pack_names;
 
+	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index a9232d8219..0b53a9e8b5 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -9,6 +9,7 @@
 
 static int read_midx_file(const char *object_dir)
 {
+	uint32_t i;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir);
 
 	if (!m)
@@ -27,6 +28,10 @@ static int read_midx_file(const char *object_dir)
 
 	printf("\n");
 
+	printf("packs:\n");
+	for (i = 0; i < m->num_packs; i++)
+		printf("%s\n", m->pack_names[i]);
+
 	printf("object_dir: %s\n", m->object_dir);
 
 	return 0;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index f458758945..4610352b69 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -8,8 +8,13 @@ midx_read_expect () {
 	cat >expect <<-EOF
 	header: 4d494458 1 1 $NUM_PACKS
 	chunks: pack_names
-	object_dir: .
+	packs:
 	EOF
+	if [ $NUM_PACKS -ge 1 ]
+	then
+		ls pack/ | grep idx | sort >> expect
+	fi
+	printf "object_dir: .\n" >>expect &&
 	test-tool read-midx . >actual &&
 	test_cmp expect actual
 }
-- 
2.18.0.118.gd4f65b8d14


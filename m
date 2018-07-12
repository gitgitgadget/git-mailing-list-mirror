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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4A81F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGLTvZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42256 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbeGLTvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:25 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so16654637qto.9
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4jF9qcML1nqLVKYKWW+RUVIMUlV1QKiiXWR0gfOR1U=;
        b=qI1TBcuxec+2DKUUz0mmk8S32lnDZKqN5b6uNp+BLbaaxbODmL3qNNQvGafwRxfs7d
         49FCYhzcmnQCSxlhvwuXgBm/eyuF6Z6nU/tqJOaujmU6CVaj6BAhaxHRB5vGpus4e8zH
         29wgY3jj7mIrqD6h/o4gr00MGuoVjfamwWEEmu7yjwW6rGAIKAo31WFkH+R/0ggyWMip
         IK47mMTXvbR3XzCfYmplZ5mNdchHLj9lpUovQQeZ0If4EixEfTD4Zv3qS1HJ2JYcKJ8r
         WM7PkP7ZEDqKIZ3qR6ffMYY/z0e+mMDE19P3X9fnkriUxlmSYGO2rhMk6XUs6monl4+W
         YKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4jF9qcML1nqLVKYKWW+RUVIMUlV1QKiiXWR0gfOR1U=;
        b=b4e4dFZWr5jKNlnOIBKXdtHpCqjgcVqKg8HGqYyGe4tZvZ+FTG+b2Jyy0nKk8jnkx9
         9rfnlLa1Xc+mO9pAuRqJiFTLcREqDZIhKezG18JMrZ8fwiAKFuHrfqQOasNcHoIq8kit
         elOg1AX7OC+qoobnq6/E/BvIaSAk1nivELUoy0d/fAPZCXeVHXFCDpC7ASckAkpD5Btn
         LvEeORwNflHWwSTBn7INfqrerLeKb6e+Z3mMG4Tb4g7j91j9TeLbstWHSk0oeRBRhmQl
         lsXlwkcZ+KMoqJUDSqJmvjxslz+wqgMBIf/HURctuoi/dnUzpopYWq3vkfO5qer3dsq9
         wPnQ==
X-Gm-Message-State: AOUpUlHhXCmi1uAwjXtpCk8NmLZon5HUosTQv14pkFZcOTI1++9N8nXD
        Y8HWTFOW/RkIElSt83Bma7N44aEMef8=
X-Google-Smtp-Source: AAOMgpesnrPeHS1A8atbleCYYp8SIm0yh+BlzG9vY4IRZPTX3LKJCGjSo11HGd5ZotHEO5tgnXhngg==
X-Received: by 2002:aed:37c2:: with SMTP id j60-v6mr3224402qtb.417.1531424424861;
        Thu, 12 Jul 2018 12:40:24 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:24 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 11/23] midx: read pack names into array
Date:   Thu, 12 Jul 2018 15:39:28 -0400
Message-Id: <20180712193940.21065-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 17 +++++++++++++++++
 midx.h                      |  1 +
 t/helper/test-read-midx.c   |  5 +++++
 t/t5319-multi-pack-index.sh | 17 ++++++++++++-----
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index ca7a32bf95..fcdf6553ce 100644
--- a/midx.c
+++ b/midx.c
@@ -37,6 +37,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	uint32_t hash_version;
 	char *midx_name = get_midx_filename(object_dir);
 	uint32_t i;
+	const char *cur_pack_name;
 
 	fd = git_open(midx_name);
 
@@ -115,6 +116,22 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
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
diff --git a/midx.h b/midx.h
index 38af01fa3b..17b56172e3 100644
--- a/midx.h
+++ b/midx.h
@@ -16,6 +16,7 @@ struct multi_pack_index {
 
 	const unsigned char *chunk_pack_names;
 
+	const char **pack_names;
 	char object_dir[FLEX_ARRAY];
 };
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 3f2d2cfa78..76a60d7882 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -6,6 +6,7 @@
 
 static int read_midx_file(const char *object_dir)
 {
+	uint32_t i;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir);
 
 	if (!m)
@@ -24,6 +25,10 @@ static int read_midx_file(const char *object_dir)
 
 	printf("\n");
 
+	printf("packs:\n");
+	for (i = 0; i < m->num_packs; i++)
+		printf("%s\n", m->pack_names[i]);
+
 	printf("object-dir: %s\n", m->object_dir);
 
 	return 0;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 7512d55c92..e8da082c64 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -5,11 +5,18 @@ test_description='multi-pack-indexes'
 
 midx_read_expect () {
 	NUM_PACKS=$1
-	cat >expect <<-EOF
-	header: 4d494458 1 1 $NUM_PACKS
-	chunks: pack-names
-	object-dir: .
-	EOF
+	{
+		cat <<-EOF &&
+		header: 4d494458 1 1 $NUM_PACKS
+		chunks: pack-names
+		packs:
+		EOF
+		if test $NUM_PACKS -ge 1
+		then
+			ls pack/ | grep idx | sort
+		fi &&
+		printf "object-dir: .\n"
+	} >expect &&
 	test-tool read-midx . >actual &&
 	test_cmp expect actual
 }
-- 
2.18.0.118.gd4f65b8d14


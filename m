Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B8C1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeFGOEN (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:13 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46485 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932877AbeFGOEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id h5-v6so9907979qtm.13
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OKkqGTdHhQVrJ4CtUrSb4QbxzQBTBHtYXrLqjNKCPlc=;
        b=LX+geMBQx8REmSGgPvXpzbW6oTsCp1PhWf3yQFQyDqIAOykUqhlovFx04wi0AniJK4
         8T4t9v7uiqrDnS7aiUCYggVsHjLBDeXcHAtC+tgWIiYVBH9f7ueHudqBo/nv954JRHbO
         bdZ4IqQpnkTtPNhkzFn2UO6PDbxfbVH8PiUGJ3eA0dtubjZZJXIttCvVtM7zyNRhuJgN
         EMVOlDYd0jwSbxm/vFNEZhb3QEsdszdziZeVPruixBpZQ/NoSlQEKYneDL6T9nRbTANa
         1K+l45oJDy9p4cX14tZteNE6uPYXF+DxU94YMpCcsodWFfh33RThuSiyykfJH0Tgv72/
         OXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OKkqGTdHhQVrJ4CtUrSb4QbxzQBTBHtYXrLqjNKCPlc=;
        b=a2krg+lyyH26vvO1R1zTbrt4X6YqSYjyfbnM9guW2fdryLFpnPlFmumr+Zi/2LSRPx
         /XeSfGHTTUEJ36z3q0dpNtiuwTBVhWN8D3rFDTjsMiTwGh3AepPIaEwdLTuHcFwTcoRd
         hi6gdQwVcz0OMDh2AzRJ715tMmkN4iIzIWRLgJ+mt4P3umqFo4I6dvwHtwnK9A5Ir/Rq
         GagwSWxpUzzs24wv6v4qdRfEhjhp7uKv55ToNAQSd7vvrAcN5ronI98oKA9YG7Y6XzjJ
         CSJMzE7ICktu2QcM38eWodG/anNJAChe6Tn7nOO15HtVs7d9mRiExjZFTmJoyYayR3gq
         H+IA==
X-Gm-Message-State: APt69E3qzBrzudTYTbfyMVo4uHQ/5H6hhBAiLHvT7W495xh/LKyImhBO
        oFBI0M0W85RXdo3RjWgsir2MCmkO
X-Google-Smtp-Source: ADUXVKKHsPu6slMT51nzUHOBbmUfrEmny/9JgQD+qZDQPKz+sNfbjl4hLYbax9cMFcOwJfAKdePAzw==
X-Received: by 2002:ac8:3358:: with SMTP id u24-v6mr1803650qta.31.1528380249271;
        Thu, 07 Jun 2018 07:04:09 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:08 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 22/23] midx: use midx to find ref-deltas
Date:   Thu,  7 Jun 2018 10:03:37 -0400
Message-Id: <20180607140338.32440-23-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c     |  2 +-
 midx.h     |  1 +
 packfile.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 3242646fe0..e46f392fa4 100644
--- a/midx.c
+++ b/midx.c
@@ -214,7 +214,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	return oid;
 }
 
-static off_t nth_midxed_offset(struct midxed_git *m, uint32_t pos)
+off_t nth_midxed_offset(struct midxed_git *m, uint32_t pos)
 {
 	const unsigned char *offset_data;
 	uint32_t offset32;
diff --git a/midx.h b/midx.h
index c1db58d8c4..6996b5ff6b 100644
--- a/midx.h
+++ b/midx.h
@@ -9,6 +9,7 @@
 
 struct midxed_git *load_midxed_git(const char *object_dir);
 int bsearch_midx(const struct object_id *oid, struct midxed_git *m, uint32_t *result);
+off_t nth_midxed_offset(struct midxed_git *m, uint32_t n);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct midxed_git *m,
 					uint32_t n);
diff --git a/packfile.c b/packfile.c
index 479cb69b9f..9b814c89c7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1794,6 +1794,21 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	uint32_t result;
 
 	if (!index) {
+		/*
+		 * If we have a MIDX, then we want to
+		 * check the MIDX for the offset instead.
+		 */
+		struct midxed_git *m;
+
+		for (m = get_midxed_git(the_repository); m; m = m->next) {
+			if (midx_contains_pack(m, p->pack_name)) {
+				if (bsearch_midx(&oid, m, &result))
+					return nth_midxed_offset(m, result);
+
+				break;
+			}
+		}
+
 		if (open_pack_index(p))
 			return 0;
 	}
-- 
2.18.0.rc1


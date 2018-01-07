Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF941F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbeAGSPk (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:40 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44266 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754463AbeAGSPa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:30 -0500
Received: by mail-qk0-f195.google.com with SMTP id v188so11712853qkh.11
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VQYawfa4YPKMwVe7QYqyYmkdcbIrdfbp199k8Y94Eg0=;
        b=mdjV4WqU9F5ubnW4glXv9qHHWwDlZImT4EuzFY+hvZUxnO2nWcgKnoRIM5sDrdc5eu
         6uI/ezj9XcpTn6MYZsIiGN4yyGtK1R5h+x49IlVIva5rKyfJeGyEySn9c+Z/cJZ77cRz
         tX9FRPMJrP9lZPZgpgxeAdPWcRa7dMcE2ROKC+BrZ/GR1xcivCFaj8XW8h/T7OLZvkmV
         FVVbpREX/TUbT4OHa+k14GCT1M7Jq4GSdJUd6bPiu9oa23Y+zW3pflzH+HwIujX4aQsp
         1gAmH+fTRpqbAidtdMvpagb08WBthMeebI2IeeLD2+S4YHkO2ZQRSmWPIBmf4QhJnO7Y
         unIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VQYawfa4YPKMwVe7QYqyYmkdcbIrdfbp199k8Y94Eg0=;
        b=Boe9tdxub+kLg/COluthzYl3uzu/QudVPL4Cjq9trVcacCHJwiJOzLJuB7249OFH2r
         2R0ZN6M3q64HNlHQOdIhRrtmYuYVZspiK439KoA96HaUbOgG1+WmxYWBg4ihp03mfNw/
         ec2rgHL9Ekn0hdwb32/JxNStKGtX+9TCm/WW2o2MhL0YWYPqflfdA9ACFcyoyV1CAuVq
         q/68j6Kabyltu2pzpPlejBsdgLNxcaMxrY0rBRLwTOFVtk7JBmrTxT+IuftrT7KAwtQ6
         OsPWuJ2ZvpWRs/dejMfHgFgbQqcQmlrNeTQVj27CkPh1Cm/sUz1kkJvE4eLTcRO0odAy
         Nihg==
X-Gm-Message-State: AKwxytdDT2AGOpfI1Mx+zJWwSryr41no8jLqf0dhGvKGQWFuOeg+5+L+
        WxDbMeNCwz3cOBg3iGGOYNbwVb0XJNI=
X-Google-Smtp-Source: ACJfBosvlKYY1dl78cKXizc5K32vg9E+fAphRdrA/7wQ6XvnVRJvTBdxm9iwCj3eu+LQEq/Jumr0CQ==
X-Received: by 10.55.116.71 with SMTP id p68mr12354337qkc.164.1515348929663;
        Sun, 07 Jan 2018 10:15:29 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:28 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 16/18] midx: nth_midxed_object_oid() and bsearch_midx()
Date:   Sun,  7 Jan 2018 13:14:57 -0500
Message-Id: <20180107181459.222909-17-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using a binary search, we can navigate to the position n within a
MIDX file where an object appears in the ordered list of objects.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 30 ++++++++++++++++++++++++++++++
 midx.h |  9 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/midx.c b/midx.c
index a66763b9e3..8c643caa92 100644
--- a/midx.c
+++ b/midx.c
@@ -299,6 +299,36 @@ const struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	return oid;
 }
 
+int bsearch_midx(struct midxed_git *m, const unsigned char *sha1, uint32_t *pos)
+{
+	uint32_t last, first = 0;
+
+	if (sha1[0])
+		first = ntohl(*(uint32_t*)(m->chunk_oid_fanout + 4 * (sha1[0] - 1)));
+	last = ntohl(*(uint32_t*)(m->chunk_oid_fanout + 4 * sha1[0]));
+
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		const unsigned char *current;
+		int cmp;
+
+		current = m->chunk_oid_lookup + m->hdr->hash_len * mid;
+		cmp = hashcmp(sha1, current);
+		if (!cmp) {
+			*pos = mid;
+			return 1;
+		}
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	*pos = first;
+	return 0;
+}
+
 int contains_pack(struct midxed_git *m, const char *pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
diff --git a/midx.h b/midx.h
index d8ede8121c..5598799189 100644
--- a/midx.h
+++ b/midx.h
@@ -101,6 +101,15 @@ extern const struct object_id *nth_midxed_object_oid(struct object_id *oid,
 						     struct midxed_git *m,
 						     uint32_t n);
 
+/*
+ * Perform a binary search on the object list in a MIDX file for the given sha1.
+ *
+ * If the object exists, then return 1 and set *pos to the position of the sha1.
+ * Otherwise, return 0 and set *pos to the position of the lex-first object greater
+ * than the given sha1.
+ */
+extern int bsearch_midx(struct midxed_git *m, const unsigned char *sha1, uint32_t *pos);
+
 extern int contains_pack(struct midxed_git *m, const char *pack_name);
 
 /*
-- 
2.15.0


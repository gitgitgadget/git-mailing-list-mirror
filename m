Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7FD1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753983AbeGFAyO (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42768 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753968AbeGFAyL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:54:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so205089qto.9
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PapCkNg8zUXqosRjO+QQ13YR2f0D19KojVYcVUe7CcU=;
        b=PEXPBiNPgRsBEIp6nJ7CTwYGg0dKvVzsmeGo/bFAqvNTe/d+FJuDNqJ//Jhy/uOTwe
         7/LMME40HKDS5Y98SmKsJeN6gBE1ySrhukCOjcJJl2GKGltltyTTHkJn1A1YpOneXROv
         G4saq5vh1NrpsgqsbdDRdzJCShwIje+9f5vxZ5/MifQ5XHBetatd2Vs0zV/LeJO0DT7Q
         rVOEEZo1XRMKEzhgtg2AHeXNHAe0cfW8QVSzEWOpLMxZfLIPNt8vlN3Kz9H6XnTfKgxQ
         hBerJdYYEpjkTxi0vMJqy66bjw0rRf8ee/HVjyBe13sF4Jd3zZ3hTWa7KUiK6Qdumqbn
         gN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PapCkNg8zUXqosRjO+QQ13YR2f0D19KojVYcVUe7CcU=;
        b=SBAt45JHK86eX+ecbRp20IsTPL/7iG6L9AJeiiqH1sHcl7B0CnupjjM53MyjExn59U
         MZRCR4yaTrIujwiWqj9ABA99WCsHAuKQ8rCRdQe2G6R8eayoOExRPC0Lk+qCupjWAnR3
         vf9rQoUMx2Jt53exGxUBKZs6kB9VPohPyUebWbvWT/l15Ip/Bi8ojk85p+7Ld6hIR4no
         oMlVKC2VoFPNfZH3g0/TgK9mM4PfITZrvRGlOALQitrMjiiLhkE1GbqQKaDeUx4lF5nL
         lytiJnzaA68kI+oimyyae1vjBs+ZFQgspZwKxDM6CZEDx02rYWo4TkHwUA1JNoAa6tLP
         FehA==
X-Gm-Message-State: APt69E1dK5ZQb28MRIC8Teo8uYVA2aYR+cPOE0hvkEf2GyPswB+Ck3GH
        ja//SM9E1EPotIGXOusxvD2RuZPE
X-Google-Smtp-Source: AAOMgpd+ak0jDITvUkCItfkND1H+av2CaNVJBi2nH30+Wo6gFIPd1GcCQjKfB8U8zMnV+qOhrOtpSg==
X-Received: by 2002:a0c:8283:: with SMTP id i3-v6mr7141972qva.21.1530838450494;
        Thu, 05 Jul 2018 17:54:10 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:54:10 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 23/24] packfile: skip loading index if in multi-pack-index
Date:   Thu,  5 Jul 2018 20:53:20 -0400
Message-Id: <20180706005321.124643-24-dstolee@microsoft.com>
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
 packfile.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 2c819a0ad8..e6ecf12ab5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -469,8 +469,19 @@ static int open_packed_git_1(struct packed_git *p)
 	ssize_t read_result;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
-	if (!p->index_data && open_pack_index(p))
-		return error("packfile %s index unavailable", p->pack_name);
+	if (!p->index_data) {
+		struct multi_pack_index *m;
+		const char *pack_name = strrchr(p->pack_name, '/');
+
+		for (m = the_repository->objects->multi_pack_index;
+		     m; m = m->next) {
+			if (midx_contains_pack(m, pack_name))
+				break;
+		}
+
+		if (!m && open_pack_index(p))
+			return error("packfile %s index unavailable", p->pack_name);
+	}
 
 	if (!pack_max_fds) {
 		unsigned int max_fds = get_max_fd_limit();
@@ -521,6 +532,10 @@ static int open_packed_git_1(struct packed_git *p)
 			" supported (try upgrading GIT to a newer version)",
 			p->pack_name, ntohl(hdr.hdr_version));
 
+	/* Skip index checking if in multi-pack-index */
+	if (!p->index_data)
+		return 0;
+
 	/* Verify the pack matches its index. */
 	if (p->num_objects != ntohl(hdr.hdr_entries))
 		return error("packfile %s claims to have %"PRIu32" objects"
-- 
2.18.0.118.gd4f65b8d14


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5643C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeGLTvr (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:47 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36923 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:45 -0400
Received: by mail-qk0-f195.google.com with SMTP id t79-v6so16052486qke.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PapCkNg8zUXqosRjO+QQ13YR2f0D19KojVYcVUe7CcU=;
        b=bHVVixg5DG2K+lcJdhP0FiqZ78fL3xhYAqBQtkdhKKtCv67aliZcom568tM7NIM1IS
         ZkQ/9zl78medBvTUVGJha8DIucmVnQRE/QQU49Uha/iOh53n/H517poBLWLVGV/6QhmF
         lCzVUMAK0P0cnedwYQCEv2E06nJc3ogmHvTTIfqj8HNXrX16UH0e+9bYBsuheshA0wfv
         8p6lES1B24A/f7XampY8f6rdj3i6rjMJp0rSx9TLepZNLRzzuNYths709zVuVeWEXwZR
         /NRav5lsI71wmW9UqjXgP5t6ICQjWuPYtyn6Z/NqvHMUZyLsOlkZSkezxRyzsu9lWi38
         9oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PapCkNg8zUXqosRjO+QQ13YR2f0D19KojVYcVUe7CcU=;
        b=LBeJ28GsrtaYm5bsEftK2FVxQh5E1YbS3QOdyKVt4KPepAlFoCVqFDl+4CwRhLUABX
         HRWFj0N1qpGadSN8xBcund0kXxIxvLwupko4ePwfoUm8J0z0+jAOJ01eWKqooltYdVGr
         +YZnfSQ69ayfxyZAGgBGmU5hRA+BdLjBPQqyZuUodqP3q6Ie2426K/N9gN5h+8Uvn+2C
         5/obGK8I+6Ii212y4kDG5GWZYf4oC7d1g6xR8JfSXxNGE5Fdmg8me4atNj/9uHqHUCS+
         aazweMdWAmtC1IgShQItsN+Xca5GyI0616QzL2q6lY/wj9a5BivFh+mfq36q/XnrykRq
         hFYQ==
X-Gm-Message-State: AOUpUlGJrNEyO233EltgtO42FHNSh7omos5QjTwUNvh8bJfDJ06wqEwv
        Njlnlf9udc5WdTkRUWQqLGItSLjzy6Q=
X-Google-Smtp-Source: AAOMgpfsnic/2WoM8tu3q/MkAkQjAkfNxNPbx1spUhXWhHiMD8ntuFtq78vpqTPdOYbtSqjeA0uWQA==
X-Received: by 2002:a37:a24f:: with SMTP id l76-v6mr2876484qke.406.1531424444689;
        Thu, 12 Jul 2018 12:40:44 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:44 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 22/23] packfile: skip loading index if in multi-pack-index
Date:   Thu, 12 Jul 2018 15:39:39 -0400
Message-Id: <20180712193940.21065-23-dstolee@microsoft.com>
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


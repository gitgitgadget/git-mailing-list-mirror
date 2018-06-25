Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6011F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeFYOfn (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:43 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34120 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934518AbeFYOfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:40 -0400
Received: by mail-qk0-f195.google.com with SMTP id b66-v6so2110860qkj.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2Hfcaag/JOmL2hcO6MY+i97baZm1DmAu9LeiWELvls=;
        b=Wk5fQEcYEmr7v/roop6vftw976H2ETTvwTYcHreCZqfzYMDHs51daaZumpqLjkA1TZ
         kMFLGW2NscUhKZC92SH0cvJoSIR9pO34vpZMYWL6vIssWcPo7c5Gv4E72PTgnF/tX0e4
         YcENr+ShAQQrQMafOMTXbNidIwQarLzgiq5/LVVkJQjoy3ZfNjU/oaa3jx771UvilVR2
         4BFUV85+qaw5t+9NSFe7U1Ozid6XipwfsCW2PyU44m6K0ttbfjTl9Q7ZnmaijGwXaZhY
         WqDpbVbm3YrAzo0qQ03pEv8TspLEv8GtMap4OgJMdiLVH4/oPUcyKGcU0m1VZR3KUV7F
         B+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2Hfcaag/JOmL2hcO6MY+i97baZm1DmAu9LeiWELvls=;
        b=lhSvTw00x7AmFa5abqVnDtAOhbaMIEeOuMA10tZMkgoW78fzTxF/FRZQ9NqpuK2bMr
         ejGTzmvcwCaXhpcnBGKDwZVXT+WARd8Ic+FtQXkbtdHUUr15684MGQXwJtLyRTu8KJqi
         ZfbxmVPhM/ub3BbKrlcKst9aw7Z0i6rxF2Rjza0WTgChCsBrmF3O7HMmDHPZ2aANQShj
         aFnzjgeOFDiwMCjpRk6orEFTxcoPepZ4lIow3W7xjzvF3apka/lqHzHA3VIHQyDvkPRd
         mvgkzlxc+AmD+Ghr1B1xAY3KYUKKPnilnSwUcKkcpKZGoeAQdTIHUScRdx9ehptpFdZW
         73Qw==
X-Gm-Message-State: APt69E2KjNue0l+CRawFce/Rsw3C9yHjnrAatNNsA8JrkWThwkPHn4dI
        XX0YbWp4Ab2fVjN+6tjSizOqTsG5
X-Google-Smtp-Source: ADUXVKJfXh+kBUMo+nV2u9YjJ6RWxnfvxKf7ZnY9huCLVBVHFl6322oc+ct1voWG+9xoMzLxuu86wg==
X-Received: by 2002:ae9:c105:: with SMTP id z5-v6mr10506488qki.320.1529937339426;
        Mon, 25 Jun 2018 07:35:39 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:38 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 23/24] packfile: skip loading index if in multi-pack-index
Date:   Mon, 25 Jun 2018 10:34:33 -0400
Message-Id: <20180625143434.89044-24-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index f2b8d6f8a7..acd02430a8 100644
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
2.18.0.24.g1b579a2ee9


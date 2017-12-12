Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79891F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbdLLTyI (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:54:08 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44850 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdLLTyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:54:05 -0500
Received: by mail-pf0-f195.google.com with SMTP id m26so17160pfj.11
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 11:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HeZAWTswrsstD7/HAS3qx5kPdtgaOBVM+uTklQkGKpM=;
        b=HtCVL48iY0FS57soFn1UHF9YzsgHw8yMrmtugzqj+9hTfDWkryE6FOpUdikL91m6kx
         2rg9HXb7KmZhAo7Gqz7IqSjX9oIDou7Na/vpE5ffeVKxR9F8USeaTt+zeLVyvsDc0ZXG
         3Q4TKyabTXzwoUv7R7m6fK7xgwCnOxwuBC+dOZdGD0a7IUNNiq9OWY5tW9OEwEQcGmiX
         iQfi0k+thp1XQ9C0ZQALc975YmvhXpTftVOutXSkJYBaUbFyq6IEuicYslL33tuanME0
         x8cfrLiJWBtHT0QQEo3nb/8fS0wRPPV9qiallXVaanYwCOPBmKOvbmoUeUT80SU4B55P
         jSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HeZAWTswrsstD7/HAS3qx5kPdtgaOBVM+uTklQkGKpM=;
        b=aaSAXs0EOgAZdbnACJVSM5Wd65ws/knML1fWY6VmTZFwQ6/SVQrNOHZ9N1ccbNomA8
         oGYrcUf9MorM0lj3V6pPxVgKPxbxAadRCCOxOvHiDNwvrqQbzzr4afwDSdRhHIb2acb+
         pMN/Fq6HisyCsX/tT8CMXcWfA414+oVYj+/hSxYrMrp6ZWDd5Zk+3X9eZP+mpXtrF7mZ
         dyuyMQ5EcJQjaXqVaah0KstMHDg05bKaLsPK5eLQqzpm9K7Dd2LSw9iQ7wfghvou5hj5
         KPIyCu+oZwzDdiGAm3EbBkZy+5bD2WMjvztQFTp03tSKkdNCS/TOZ62KiVoBUXKLWBGP
         mgbQ==
X-Gm-Message-State: AKGB3mLJyvj5qeFCisYZ5DQb1Izq2knzHVB/SQ8wuOTLOExP6rO6yk3t
        koVFr14xsbgTu73pWCqFZtK4xeiSFcI=
X-Google-Smtp-Source: ACJfBovzhyZRw7hBJeshOpwHls9YW3zVZ2bI1n0IeF7f+KH2+8dvG+XNl9GpCyaIdbQoxxK2UzdCNg==
X-Received: by 10.98.24.207 with SMTP id 198mr3391054pfy.3.1513108444507;
        Tue, 12 Dec 2017 11:54:04 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h69sm32822565pfe.107.2017.12.12.11.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 11:54:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/3] submodule: used correct index in is_staging_gitmodules_ok
Date:   Tue, 12 Dec 2017 11:53:51 -0800
Message-Id: <20171212195352.146675-3-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <20171212195352.146675-1-bmwill@google.com>
References: <20171212195352.146675-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 883e248b8 (fsmonitor: teach git to optionally utilize a file
system monitor to speed up detecting new or changed files., 2017-09-22)
introduced a call to 'ce_match_stat()' in 'is_staging_gitmodules_ok()'
which implicitly relys on the the global 'the_index' instead of the
passed in 'struct index_state'.  Fix this by changing the call to
'ie_match_stat()' and using the passed in index_state struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 5 +++--
 submodule.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7097be806..a9670eaae 100644
--- a/submodule.c
+++ b/submodule.c
@@ -55,14 +55,15 @@ int is_gitmodules_unmerged(const struct index_state *istate)
  * future version when we learn to stage the changes we do ourselves without
  * staging any previous modifications.
  */
-int is_staging_gitmodules_ok(const struct index_state *istate)
+int is_staging_gitmodules_ok(struct index_state *istate)
 {
 	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
 
 	if ((pos >= 0) && (pos < istate->cache_nr)) {
 		struct stat st;
 		if (lstat(GITMODULES_FILE, &st) == 0 &&
-		    ce_match_stat(istate->cache[pos], &st, CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANGED)
+		    ie_match_stat(istate, istate->cache[pos], &st,
+				  CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANGED)
 			return 0;
 	}
 
diff --git a/submodule.h b/submodule.h
index cd984ecba..e2a5de3d8 100644
--- a/submodule.h
+++ b/submodule.h
@@ -34,7 +34,7 @@ struct submodule_update_strategy {
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
 extern int is_gitmodules_unmerged(const struct index_state *istate);
-extern int is_staging_gitmodules_ok(const struct index_state *istate);
+extern int is_staging_gitmodules_ok(struct index_state *istate);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
 extern void stage_updated_gitmodules(struct index_state *istate);
-- 
2.15.1.504.g5279b80103-goog


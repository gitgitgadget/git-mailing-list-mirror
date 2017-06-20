Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A19120D20
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbdFTTUk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:40 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33286 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdFTTUg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:36 -0400
Received: by mail-pf0-f169.google.com with SMTP id 83so73769688pfr.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2n+IoxMW2y8uNe8Sd7HPtPfIYlB4jjHBm97EHfIipY=;
        b=qzJLA6oJG8DaB7UroXs4JF4kmzkNyLSPpnqpCXmTYQ5sO6YfowZh+TWDQL9PtijfMM
         fn0uGXCUUJWyDfCGgG7xuMjRxALadS5kHFHRm/sEPOrp56Q9k1u/k3+PVUD3eHXO5UMw
         alAeUnfhaBkCuvU/zsTCEhA+PP/piOyXXJea3mNYV2b4oP9tGPuHJmpY4G4CcDEqmmAx
         Lka5M02BkC9vedfZ9CCl2Q0zye/e4VsHK8SXaE5uqgD7vTjnOSp01U7hUshX35AxURhT
         kmHGaxGxfd6JDSdF1YTjeaQ+explGkCGZIDarXtQF9B2bUtKsBSBh4JMPrVFHoQI6+TW
         kYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2n+IoxMW2y8uNe8Sd7HPtPfIYlB4jjHBm97EHfIipY=;
        b=MyuuIdpqO2sfARG4oE5l0VfrWGdV462znw7GGUBxzXey5txQXtg4qsBMTgri/1eEnN
         niQHHh794KyN+oUqW1ixlfgSB1MVSMNexqcttEZcewZmucO9ZFcvMSEXM3tvUPWJOgKn
         LrkwSdtjRB3jc29p5hDnqxe0MekMsy/yZdOs2lihTAQ8LWoTwIL2kVzFltj+1Lu316bi
         QSlU3JAyaxNf/UNXggVGRrzqKOnztU83I47dXupOQBjK+CBa6ifQmc7h/RgneSkj55xB
         wFsaxJKwzttQ/W9zjVTG09JqkDJpvhQn5hd1hMQGEIR7ewYcDxRmjjr76MmolTe8kHSs
         y4AQ==
X-Gm-Message-State: AKS2vOx635Kupl6tElR2Ia+0YMujiXm1tQc9WXkep3Y+M0EhE2G7vwgJ
        r/hG63ZJpfQ52xoAANhiPg==
X-Received: by 10.98.207.68 with SMTP id b65mr32250548pfg.6.1497986420587;
        Tue, 20 Jun 2017 12:20:20 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:19 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 06/20] environment: store worktree in the_repository
Date:   Tue, 20 Jun 2017 12:19:37 -0700
Message-Id: <20170620191951.84791-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'work_tree' to be stored in 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 environment.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index aa79ef83e..3fd4b1084 100644
--- a/environment.c
+++ b/environment.c
@@ -96,7 +96,6 @@ int ignore_untracked_cache_config;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
-static char *work_tree;
 
 static const char *namespace;
 
@@ -223,19 +222,19 @@ void set_git_work_tree(const char *new_work_tree)
 {
 	if (git_work_tree_initialized) {
 		new_work_tree = real_path(new_work_tree);
-		if (strcmp(new_work_tree, work_tree))
+		if (strcmp(new_work_tree, the_repository->worktree))
 			die("internal error: work tree has already been set\n"
 			    "Current worktree: %s\nNew worktree: %s",
-			    work_tree, new_work_tree);
+			    the_repository->worktree, new_work_tree);
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = real_pathdup(new_work_tree, 1);
+	repo_set_worktree(the_repository, new_work_tree);
 }
 
 const char *get_git_work_tree(void)
 {
-	return work_tree;
+	return the_repository->worktree;
 }
 
 char *get_object_directory(void)
-- 
2.13.1.611.g7e3b11ae1-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923741F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdLLTyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:54:05 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40269 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbdLLTyD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:54:03 -0500
Received: by mail-pg0-f65.google.com with SMTP id k15so21339pgr.7
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XAee1rEQo7zE6Y6dVyjcdNzW0FZ4yxOJJVD12X3khEU=;
        b=DgRAb/MeAUTf48JKAhBGKjELle3T2m76JV9gXDOrcEK/0InUBmsquQQrK4y9MTn4oK
         51AlQPpj804Oe619EfONjWYLBIveJF4RMPCwss1uFd9Zg1867m9B+EaejYY/OBDlHdmM
         NPisN0B83a97jItP6EwP5vMwccdLDtheHuPORNPtSkjmP3eqHJQaCjRFFTJx4V7RTSP2
         NloXGDPbMtsKwCALgsy1uDTIuxlmWbZRqejhnGnnrBDuQ/C0EO8TYA2GB7Oa1k+byaZe
         Mea1wImt5y/a66+likpWBxNLFrPe/QHMiBnrFSpvGbCgxIjPD/yqP2CYz5aGsm89MNiW
         7kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XAee1rEQo7zE6Y6dVyjcdNzW0FZ4yxOJJVD12X3khEU=;
        b=fRdoIVGvjU5JEvU2328WzIU7FkAulROQRSo4HgS09z3fu9xpIyzCE9vClCK4dzUMZA
         45i0AyhXEj3RToxWG9I2xn8fWt6hnFiQIaJ9G2ZvhkNp32DWddd4bhSJ3wbhHN6iarQT
         OzaKEaprazK8HZ9P7K+Ky8LLlNIkN9XxIpn3WLbTRvHfoI1Wh7ZHrZzn0yOFy8zSAP42
         FJ/WRd4xenh9Dql+cMrQdp/diN4n3XplBAZu+ojNPufOQDsdKT1Y0fl70rD4uJvuCElo
         rspiGgYVbNfhYhYCv1CUZbZBxFbBithtl7tbfg3SU5CbE/XvgKvL9pHqEiAwSlSRoOxO
         5Ckw==
X-Gm-Message-State: AKGB3mJegqTaGwpym5nStesWMOExUcDKJN9Bs3olh3DY5KnWH3nQmBwn
        oPVPYEcT2Dori31dslZUXtgjREYqrYE=
X-Google-Smtp-Source: ACJfBov/hJQ+/JO8OK1vUGYqwkCgV9O8s7lcX5vAFMx2lag7aWalieE9sq7vM44tIjqtwkrzdqgMSQ==
X-Received: by 10.98.75.210 with SMTP id d79mr3349845pfj.230.1513108442793;
        Tue, 12 Dec 2017 11:54:02 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h69sm32822565pfe.107.2017.12.12.11.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 11:54:01 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/3] submodule: convert stage_updated_gitmodules to take a struct index_state
Date:   Tue, 12 Dec 2017 11:53:50 -0800
Message-Id: <20171212195352.146675-2-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <20171212195352.146675-1-bmwill@google.com>
References: <20171212195352.146675-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/mv.c | 2 +-
 builtin/rm.c | 2 +-
 submodule.c  | 4 ++--
 submodule.h  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index ffdd5f01a..cf3684d90 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -291,7 +291,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	}
 
 	if (gitmodules_modified)
-		stage_updated_gitmodules();
+		stage_updated_gitmodules(&the_index);
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
diff --git a/builtin/rm.c b/builtin/rm.c
index d91451fea..4a2fcca27 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -382,7 +382,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&buf);
 		if (gitmodules_modified)
-			stage_updated_gitmodules();
+			stage_updated_gitmodules(&the_index);
 	}
 
 	if (active_cache_changed) {
diff --git a/submodule.c b/submodule.c
index 95e6aff2b..7097be806 100644
--- a/submodule.c
+++ b/submodule.c
@@ -143,9 +143,9 @@ int remove_path_from_gitmodules(const char *path)
 	return 0;
 }
 
-void stage_updated_gitmodules(void)
+void stage_updated_gitmodules(struct index_state *istate)
 {
-	if (add_file_to_cache(GITMODULES_FILE, 0))
+	if (add_file_to_index(istate, GITMODULES_FILE, 0))
 		die(_("staging updated .gitmodules failed"));
 }
 
diff --git a/submodule.h b/submodule.h
index f0da0277a..cd984ecba 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,7 +37,7 @@ extern int is_gitmodules_unmerged(const struct index_state *istate);
 extern int is_staging_gitmodules_ok(const struct index_state *istate);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
-extern void stage_updated_gitmodules(void);
+extern void stage_updated_gitmodules(struct index_state *istate);
 extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
 extern int git_default_submodule_config(const char *var, const char *value, void *cb);
-- 
2.15.1.504.g5279b80103-goog


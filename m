Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B777120248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDPJhk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:37:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35784 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDPJhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:37:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so10063779plp.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vK/4um+iuE+J1+VBEHvy0bgxNvWT3iwFnGY4zfyG7WE=;
        b=Kfs3Wt6p6UH52DXvUFRjm7KJXf56LkSDjGn1+UNulCfPUShUHWS9Po+1hAtVoGL5OH
         1H/s+sKOBauJXEC2V4Vxw2MmcC47+PdEFo4Q7bfbOzVpTZ0dwOO9CxEFTw9LJ4Fo3NQa
         A4wgfSFOEncOdK0cOeBEY6wfFaCaokQ00zHFSb6o9mkU+qd3eVXCAT4/JGSceo73QyXE
         9KjcO/ECY0wufpU8qoYOAiugNyFXdsnFM8r9R3FYKJogSR+aiPO2sgrgOdiV5RuCgafb
         cAE9x2wJyfBsPxzJRHiWQTpZRWoeFIwAKbvuuGknaxBO633eDV0WvmmyRvVZmH3cXUVj
         EjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vK/4um+iuE+J1+VBEHvy0bgxNvWT3iwFnGY4zfyG7WE=;
        b=Dzye93X5X1dlgVgRr+DOCS1e3vLLQIMg2+CHWlSSgLJ24XFyAHLq6YUsS3UnDy1TC9
         5knWasizYBsx1nEj3HbqXR8lUq1fES4S2eoUiuFbYMihq42OUcEwIEobFk/8U5EyC3Yl
         Y0/sIbu7hgBfAZD/Ya8xirLicmsg9k5/YknR8rEDfxxSZ5PXo1DI7fAE6Ik3nSt2KpEu
         Dhu+K9XBLQ02d9F8ILMKUg48waWaG3ahqhR9eC0vD4ON7zAm576b2UI85E+mhvQsjVgr
         SLQhV6e4kEbO2W9ZsUcdrnFXW6Ld6ss1sidQyt8FebB/ZefiU7kKSNNVYqqI1ZOJeNu5
         W53w==
X-Gm-Message-State: APjAAAVu45fKoqiZmL6jYLAN+6OJ8OIJdUA40CF611LGwsU8Avnk2qOe
        xekuVoh7nUJr8LZRbcjoKbf9sH0s
X-Google-Smtp-Source: APXvYqygiiMBrrlUf6D8XJADXDpcoDvF6ufbToEAxWAF/KBD0h86zo/2DwwVl0LLbraTY06dDwxx2A==
X-Received: by 2002:a17:902:396a:: with SMTP id e39mr80776355plg.220.1555407459768;
        Tue, 16 Apr 2019 02:37:39 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id n65sm147689222pfb.160.2019.04.16.02.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:37:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:37:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 31/34] submodule-config.c: use repo_get_oid for reading .gitmodules
Date:   Tue, 16 Apr 2019 16:33:38 +0700
Message-Id: <20190416093341.17079-32-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 76e9bdc437 (submodule: support reading .gitmodules when it's not
in the working tree - 2018-10-25), every time you do

    git grep --recurse-submodules

you are likely to see one warning line per submodule (unless all those
submodules also have submodules). On a superproject with plenty of
submodules (I've seen one with 67) this is really annoying.

The warning was there because we could not resolve extended SHA-1
syntax on a submodule. We can now. Make use of the new API and get rid
of the warning.

It would be even better if config_with_options() supports multiple
repositories too. But one step at a time.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule-config.c                 | 20 +++++++-------------
 t/t7814-grep-recurse-submodules.sh |  6 +-----
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 66653e86b9..4264ee216f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -625,23 +625,16 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		const struct config_options opts = { 0 };
 		struct object_id oid;
 		char *file;
+		char *oidstr = NULL;
 
 		file = repo_worktree_path(repo, GITMODULES_FILE);
 		if (file_exists(file)) {
 			config_source.file = file;
-		} else if (repo->submodule_prefix) {
-			/*
-			 * When get_oid and config_with_options, used below,
-			 * become able to work on a specific repository, this
-			 * warning branch can be removed.
-			 */
-			warning("nested submodules without %s in the working tree are not supported yet",
-				GITMODULES_FILE);
-			goto out;
-		} else if (get_oid(GITMODULES_INDEX, &oid) >= 0) {
-			config_source.blob = GITMODULES_INDEX;
-		} else if (get_oid(GITMODULES_HEAD, &oid) >= 0) {
-			config_source.blob = GITMODULES_HEAD;
+		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
+			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
+			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
+			if (repo != the_repository)
+				add_to_alternates_memory(repo->objects->odb->path);
 		} else {
 			goto out;
 		}
@@ -649,6 +642,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		config_with_options(fn, data, &config_source, &opts);
 
 out:
+		free(oidstr);
 		free(file);
 	}
 }
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index fa475d52fa..134a694516 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -380,11 +380,7 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 	fi
 '
 
-# Recursing down into nested submodules which do not have .gitmodules in their
-# working tree does not work yet. This is because config_from_gitmodules()
-# uses get_oid() and the latter is still not able to get objects from an
-# arbitrary repository (the nested submodule, in this case).
-test_expect_failure 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
+test_expect_success 'grep --recurse-submodules with submodules without .gitmodules in the working tree' '
 	test_when_finished "git -C submodule checkout .gitmodules" &&
 	rm submodule/.gitmodules &&
 	git grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-- 
2.21.0.682.g30d2204636


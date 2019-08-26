Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD061F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfHZX5z (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:57:55 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:38643 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfHZX5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:57:53 -0400
Received: by mail-qk1-f171.google.com with SMTP id u190so15621513qkh.5
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igQQj2HlFSbcroaDbC/0D2NfsTTVyuZyjWvuTkwDdGA=;
        b=HEiDso+yTcU8Etg1Gyz9/7ngnNT99m+XErtiaElq60b9oKG5X8pRN26feXIQGmERSd
         MQ6mcHdYL0Y+WPKrEPnPMoq/a+baOYNMuWZMUFeqLVdmD0bCHNp5tVLimUoq7YxvXRf+
         7uyOInU+M35IXaiB0BlGybHVEQbcqXWrgR2aXh4LS+H3qRiaq0jZBH1kCa6PqOy+tu8d
         ROEV/IDAkkCAuWTVPom8tg+wf9mOKAOmHZpdF8RxDcV7GwTDuN2cs/u6nCO07BP9xyRZ
         oJhR1lhosqMBILaYK8pY8hLYuJ6+7VCOaiCxYSjJfudOgX5ms8Ag+/1ZKiQGhMn5Z9AA
         PqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igQQj2HlFSbcroaDbC/0D2NfsTTVyuZyjWvuTkwDdGA=;
        b=dlKWNvt+0sLMLZSTrapVAeO1BRYSuPbYAZa96MioZpDCudjC1wvS8md+EjILYFI79d
         W5GRXVvJgutS76bk73MZG0/iMma25SKOTr1rPNKW2fefR7LrCXh0Uq7vUNCrQb7fmitY
         JE6aaxGXOPPbjs8ciCvQfsm/0ZqN4EAgepr7ufW1FECGkZsh/eE0LUMyXjMbuNo+I9W4
         Zj8hBBbR6fWYjXKpJDBA+Cvq/AQCCJtRs3+YxwB5R8bKthuPHM8w3xW3ofPbDgN+EIl9
         6FAh9NvLarQYY/MmbWNI7TessdIb9e7hjsWhtRK924f3PRvaOZ8A/W4GARsOS00V537n
         IHvA==
X-Gm-Message-State: APjAAAVucVjDq2SwhdIbbzmyjwhk1Sf0m/hUYSMPWaLwTg6GRZmof0KQ
        ZZ/gZabEhVHrdgeLWxGVMY7vAINA+PU=
X-Google-Smtp-Source: APXvYqytNyXe7d2jMHrIY8V4+6lUC/LgujK3yjZhU9FZRfYyw/nhtTZ3oVa9iqGZ1Qa5y5+/9uGsCg==
X-Received: by 2002:a05:620a:6c3:: with SMTP id 3mr19272487qky.379.1566863872715;
        Mon, 26 Aug 2019 16:57:52 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id i62sm7192883qke.52.2019.08.26.16.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 16:57:52 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliams.eng@gmail.com>,
        Antonio Ospite <ao2@ao2.it>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] submodule: pass repo instead of adding to alternates list
Date:   Mon, 26 Aug 2019 20:57:28 -0300
Message-Id: <4619e04ecca575e7eb5f73f555be0bb55d11385e.1566863604.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566863604.git.matheus.bernardino@usp.br>
References: <cover.1566863604.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, config_with_options() wouldn't handle arbitrary repositories
besides the_repository. Because of that, when retrieving .gitmodules
from the cache, config_from_gitmodules() first needed to add the object
directories of the given repo to the in-memory alternates list. But we
have repo_config_with_options() now, which takes a repository as
argument. So let's use it and remove the call to
add_to_alternates_memory(). This should bring better performance to
commands using the function (there'll be fewer odb entries to process)
besides saving memory (repos may be free'd right after use whereas
the_repository's alternates list doesn't).

While we are here, let's also adjust the comment on top of
config_from_gitmodules() to be explicit that it also handles the case
where .gitmodules is not present at the working tree.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 submodule-config.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 1d28b17071..8271aa3834 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -616,7 +616,8 @@ static void submodule_cache_check_init(struct repository *repo)
  * the repository.
  *
  * Runs the provided config function on the '.gitmodules' file found in the
- * working directory.
+ * working directory. If the file is not present, tries to retrieve it from
+ * the staging area or HEAD.
  */
 static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
 {
@@ -633,13 +634,11 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
-			if (repo != the_repository)
-				add_to_alternates_memory(repo->objects->odb->path);
 		} else {
 			goto out;
 		}
 
-		config_with_options(fn, data, &config_source, &opts);
+		repo_config_with_options(repo, fn, data, &config_source, &opts);
 
 out:
 		free(oidstr);
-- 
2.22.0


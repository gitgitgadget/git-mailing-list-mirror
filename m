Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF9120248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDCLhS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36949 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDCLhS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so3832922pgc.4
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/RUO8ACXrqeLwgRI/QX11nIxHpfBgPfHg/OeHAlD+4=;
        b=jH6gFFONPQm8cQ49fRS5s5BHb01OpQVNIdvbfC4EVTY1BoikLlerDFU0Gw/o2+1Qgr
         weFZG1pbRsed+ZQHyUYYnmXAmlWj+0PZ6QT0uC5RPtSgHalDM2+QXMmuytJOMrZ6Sujm
         NBWjxQFbPvhYZSFso2SM1bPX7PDVkjVdf3nF3IRf3EDnOzIYBw4c4GsaLRnZ1eRHgtFq
         fjYV+VksPRCOMNLLRiiQgjF/AhGn0A6KaikhIxx4bV/k9dK01caWL08A1kNag4d3W18X
         X4ws+QA0j/rPYIcWGOpfGSKxdqOSJaNEy1G1N4MdeIuVno9xlEhT5RDbhaq4fEgT7l2j
         fjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/RUO8ACXrqeLwgRI/QX11nIxHpfBgPfHg/OeHAlD+4=;
        b=ak6tux4Vqe1VZljcpNSCzfU3NoPX7CFuxb+OK1HZf7NEezwKCPqUa0qLqzxrWMH4Du
         rQj+EnOyDZudvtPpdekzl10w8m2SWMPSi8yZ0MAVDnkQlc2d9473wcLml2YdrO7sRNCq
         zvzL1UWBla6e+9gs5ShYm1ZC691ocKK38VWte3ocvVjTyFqa2l/aBiDRIdr71k4ew2T7
         WdX0ph6BB53zxCYCXSEMmrqQ0jdh2c5hsd1mIPLpk2Imge3bhBmZ2iwGrB+g13YYm6RU
         8CHwJup1oqaBk41S704OltgW3XSnLiWKghxT57ZNhQxZJM0Lcu6e14H5xaEDnu7m7A6s
         EM/g==
X-Gm-Message-State: APjAAAWt0ZKEl7GYNxYb/P4ZE39oApP/IxOWR7lQS5wZPhjk2E5vNiX+
        v5RxRzV77wO/FpIFDQBoc0I=
X-Google-Smtp-Source: APXvYqwBAM7E6O/aVMqDWd1ATg3ySAQdhbXQ4Xz+OAgpoDZyWZnsVYOZh6bYZa1q+24pje335tvIxg==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr19051026pgc.40.1554291437636;
        Wed, 03 Apr 2019 04:37:17 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id 25sm19654657pfo.96.2019.04.03.04.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 24/32] sha1-name.c: remove the_repo from handle_one_ref()
Date:   Wed,  3 Apr 2019 18:34:49 +0700
Message-Id: <20190403113457.20399-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 5741a9f821..d9050776dd 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1189,15 +1189,21 @@ static enum get_oid_result get_oid_1(struct repository *r,
 /* Remember to update object flag allocation in object.h */
 #define ONELINE_SEEN (1u<<20)
 
+struct handle_one_ref_cb {
+	struct repository *repo;
+	struct commit_list **list;
+};
+
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
-	struct commit_list **list = cb_data;
-	struct object *object = parse_object(the_repository, oid);
+	struct handle_one_ref_cb *cb = cb_data;
+	struct commit_list **list = cb->list;
+	struct object *object = parse_object(cb->repo, oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
-		object = deref_tag(the_repository, object, path,
+		object = deref_tag(cb->repo, object, path,
 				   strlen(path));
 		if (!object)
 			return 0;
@@ -1760,10 +1766,13 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		char *new_path = NULL;
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
+			struct handle_one_ref_cb cb;
 			struct commit_list *list = NULL;
 
-			for_each_ref(handle_one_ref, &list);
-			head_ref(handle_one_ref, &list);
+			cb.repo = repo;
+			cb.list = &list;
+			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
+			refs_head_ref(repo->refs, handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
 		}
-- 
2.21.0.479.g47ac719cd3


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B828520A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLIKpc (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40094 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeLIKp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so7086969lji.7
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZJEi2hwdUOR5ipWtBBfyK0fXWLERNAsc5GfZF7lhNc=;
        b=dooh9qV6t7JxVzIi5kltCOutT1UPxvC7e21dqCCMBBO5GiJFKeqWpe9IJY98hLKsc9
         IfYbMz22hCw7ybbgP7B6/olMmaP06ELv266IcrJwo34BqjEsR8Z8MGdDFemtkER/+dbn
         9M0LhyW3GdtZp76vvPgwsXow1AtTVYGvRdz7mvqQEBjTovrK4xH9gyAZASQ1R34BtAkH
         FPdpJYwb4E0RXKl0n/WFg9tIjS+yH8u/Uo+9cHEvUEIsHGtQkHHoAyZnSylwubsWkX8+
         0Hm20/HodjD2YThGoCKa+vbvSrg78F3mcq0OPto6y6ejwjnOrCfnHvIFn5Di1qQj8xbr
         RNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZJEi2hwdUOR5ipWtBBfyK0fXWLERNAsc5GfZF7lhNc=;
        b=eWQAvRIi9F8+rT7rDJ//8yQhMgb5d5N9dcWDTi8nVMrrB0bVRlwCkynVb7ifM0Tj2r
         FuR65WISDuXCF6QvU1meQtQWr/H6po5CozVHJZ3kNrly8+Kg2oFi9fz0qZV//pZKks7M
         Nmfpokj14FJYBQMtZ3T5akWlv8KMDHDaDbUEakE7NP7MlLhBVybiyZKAPtMbVD2Ji0Sw
         7WPe6A5s0xF7i9R/FeKFwt3mR8SsyKWq2AHF2RP0zCBL1dwgdGUKJ42CmHy/2sV7OyI5
         r7MVnpzROfRW3SDio+BA6O4ePmFFX+rsqcsDlKfyQWw6SVxV2AVU4WM8m64v2i+LW+qv
         Kvhg==
X-Gm-Message-State: AA+aEWZJFUuNmPMpspzz+W4DiyaSOSfk8letk3i3tEA9F6E6lWWha06G
        ff00DoSNM6i2IXiX3iGHl2G6FveZ
X-Google-Smtp-Source: AFSGD/XjEamDFLO8QHKrQqvjS/4eOB7z099cd4Mx2Xdouv4jIGjF7c385OgbPQlepbNOGAQzpkzNgA==
X-Received: by 2002:a2e:2106:: with SMTP id h6-v6mr4680320ljh.37.1544352325839;
        Sun, 09 Dec 2018 02:45:25 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:25 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/24] rebase: keep backup of overwritten files on --skip or --abort
Date:   Sun,  9 Dec 2018 11:44:18 +0100
Message-Id: <20181209104419.12639-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b5c99ec10c..5c7b223843 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -573,8 +573,12 @@ static int reset_head(struct object_id *oid, const char *action,
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
-	if (!detach_head)
+	if (!detach_head) {
 		unpack_tree_opts.reset = 1;
+		repo_config_get_bool(the_repository, "core.backupLog",
+				     &unpack_tree_opts.keep_backup);
+	}
+
 
 	if (read_index_unmerged(the_repository->index) < 0) {
 		ret = error(_("could not read index"));
-- 
2.20.0.rc2.486.g9832c05c3d


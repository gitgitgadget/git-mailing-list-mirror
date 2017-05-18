Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D522201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbdERXW0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:26 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35675 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbdERXWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:22 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so30736124pfb.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CBCHlTMlD50yCAkaMP0BSOk3mzVUf1D1MT4M0Lw7gos=;
        b=IcMbnRpSFjEY/YNFvOY5OIVaxXeHN492e7YBiGjYQm7Um9b5dXkahXx21D+TihrAcY
         LOVlPBxcfGtkDn3GdL+04TTSgmHYOHdzGYH+E3qKAxm6WeyWPk2P9r1B8LnAN2Ocp9Fs
         FU7Lo5YsdUyoovxiJak4DH3KCwbAwnXf4wV6F1KAdOHsQn8LXrROC8L586PswdS0hsSV
         yRfvFD8g96vF6AgC8IcG4EfkbuVh0eqwmFbsj8z8bUH4TyNtIdc1USQXnae5sb+2mIWa
         wrGBRNWOarOBQvJNL9Vi6RTh+EzNL0i+H77jQyX3VIWF7bZ4NIyUvdze/j6YBZdZrA7R
         9MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CBCHlTMlD50yCAkaMP0BSOk3mzVUf1D1MT4M0Lw7gos=;
        b=dMy8R+6jy8IharQwpLiBsHChc/XZvmtMhiAy5tDlXT3/U3Nanv5DHGlbix2kEVpPh2
         mi5k0/6c3JgP23LgRn54/etaRJxXePC+lLixvnnqABd6ng+s4HApEBbm/VpwQsa9ZezE
         fNSiKvlyprJITiacEw+xgojEd8LAPnX1LjJoR+j+W9yot7wPdDW/TvMbz4RCPeZFI4+T
         GZQfOfCSc0X584enKQtpDWNu0tWZ7WlSGMiepTu8imhJxDj57VeTYYep/IQ5lkSYSdv6
         ZBWTwFsKI/rcUthCcyfbKVBi4hYirbVzg56kp0R+ZeS1LGxb5ON3kMeHlPwYvH+wXXP2
         U0wA==
X-Gm-Message-State: AODbwcCmjm9dKJB+JPyDZRThVtx5cxpPvLgvLlATjrhtmzuCLFsyG6Oj
        e67rGV2EudE7pCeg
X-Received: by 10.84.232.204 with SMTP id x12mr7737524plm.77.1495149741749;
        Thu, 18 May 2017 16:22:21 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 10/23] ls-files: convert show_other_files to take an index
Date:   Thu, 18 May 2017 16:21:21 -0700
Message-Id: <20170518232134.163059-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cdee2359..3d4e497cc 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -108,13 +108,14 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	write_name(ent->name);
 }
 
-static void show_other_files(struct dir_struct *dir)
+static void show_other_files(const struct index_state *istate,
+			     const struct dir_struct *dir)
 {
 	int i;
 
 	for (i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
-		if (!cache_name_is_other(ent->name, ent->len))
+		if (!index_name_is_other(istate, ent->name, ent->len))
 			continue;
 		show_dir_entry(tag_other, ent);
 	}
@@ -336,7 +337,7 @@ static void show_files(struct dir_struct *dir)
 			dir->flags |= DIR_COLLECT_KILLED_ONLY;
 		fill_directory(dir, &the_index, &pathspec);
 		if (show_others)
-			show_other_files(dir);
+			show_other_files(&the_index, dir);
 		if (show_killed)
 			show_killed_files(&the_index, dir);
 	}
-- 
2.13.0.303.g4ebf302169-goog


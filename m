Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D886C388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334712224D
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 15:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VciuP7RW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJaPOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgJaPOj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 11:14:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB1C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 08:14:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so12660791eji.4
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5+DeYK0VqLhVNFxfaUmwpWngdVAMMaoSluXV8PQWonM=;
        b=VciuP7RWIlcudN2jJIVEbNRovfCF+A+mWtnn05nSTHg+seF4kt9qwBiXD5qHF5PBFb
         8T7m1GzuUSLlOSpM6H2a7HnZm1w84vBxLskb6+bmhcVBKy9DmNhceIEINX++RxoRAuwO
         Z2KO5TeHIyWD/+ipKdviZ2lzirdkphMlhtbiAZpu7pdWXHdoIyDjobY8UiHS+SCREMYC
         DUNIfymyXGQdC3RqH0/NJpSamx7s+Xfh8mIKfdRJ24FZnU1dDtu8h6ilHRkwi6xseKNF
         jeUUoUqBok52tHb+vZfLlVlJP1DDJ3OiwQ23H4/OkVxttEgj2LIjwhuUrMT+QMM2K9Hm
         BWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5+DeYK0VqLhVNFxfaUmwpWngdVAMMaoSluXV8PQWonM=;
        b=f9IrnQ84MK4TjV4ETSJ1Wr5437GVZeXtsFDGnw5uv2YcPKh7FTIPIqO6R7Mk3JMCDH
         BRG0JwXJ+lLyIYA4iGMs9mfSxGbjv8+mcJimDL+W2iM78O4EHMcHi4VaXGOZeB2vTI6z
         AqjZHJrFQvXFpIc0HiDMGx6VTwKy85xM/poUUEFV76e6JuuFUpeLk+bIaUIQJrKqZ8DU
         BzH5Tyglq0YII+LpelfLLJl5NGfEAWsizG9+DZMwiOZ15Otow9zl7s6aCnM9jH8ya4y/
         uzKeG5J/lj96aBgbKtdhsKMJXZQSCjJ1uJmb41gGZg/UNSy2Um68FZciEPMBJeIzYAJi
         aEkw==
X-Gm-Message-State: AOAM5301wktUYDQW/IDzjRVBZnAbEVg9yc68N/ieS2S6r0FEUuf1NtE1
        LFezOgaLtgzFhzqL62NakWPvmQdqSpY=
X-Google-Smtp-Source: ABdhPJyw0epbpY0mmR26XkI4GV3Oz02agY+uWPeUExs6Gu8UjYzGEX8SkFBoEiaOA5mRHm6NudKoEw==
X-Received: by 2002:a17:906:9457:: with SMTP id z23mr7292308ejx.296.1604157276380;
        Sat, 31 Oct 2020 08:14:36 -0700 (PDT)
Received: from localhost.localdomain ([185.200.214.168])
        by smtp.gmail.com with ESMTPSA id g18sm5096186eje.12.2020.10.31.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:14:35 -0700 (PDT)
From:   izabela.bakollari@gmail.com
To:     git@vger.kernel.org
Cc:     Izabela Bakollari <izabela.bakollari@gmail.com>
Subject: [PATCH] t9363: Cleanup old version of code
Date:   Sat, 31 Oct 2020 16:14:34 +0100
Message-Id: <20201031151434.36400-1-izabela.bakollari@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Izabela Bakollari <izabela.bakollari@gmail.com>

Change style for `cd` in subshell.

Signed-off-by: Izabela Bakollari <izabela.bakollari@gmail.com>
---
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index 6187ec67fa..f09a7ed034 100755
--- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -53,8 +53,12 @@ test_expect_failure 'git clone works on previously created wiki with media files
 	git clone -c remote.origin.mediaimport=true \
 		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
-	(cd mw_dir_clone && git checkout HEAD^) &&
-	(cd mw_dir && git checkout HEAD^) &&
+	(
+		cd mw_dir_clone && git checkout HEAD^
+	) &&
+	(
+		cd mw_dir && git checkout HEAD^
+	) &&
 	test_path_is_file mw_dir_clone/Foo.txt &&
 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
 '
-- 
2.18.4


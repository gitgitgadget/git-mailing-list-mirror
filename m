Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6137C200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755258AbcLZKWk (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:40 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:32799 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbcLZKWg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:36 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so48028673wjc.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wgvx7FRG5Np0NNKZ603s/exfX3DgrTd2+4ZcDVIkcFI=;
        b=YM4tetYRy/ZtsymuYwFad8cwZpfSC+nBzV6aiW1SCBj6YI7beJrvgQ9DC7LeDBq0pK
         OvzqvpjQ+lIyALunOHvRM/ClFiYzgzJgfRazjgPYy6gBNtzJcLQTzH51v+DlaRN9NyS9
         +Nbfutry8cfjxs22QlOAvQhGsImI88jCaNDqVLdQdGtwT6xpT2yhstCJ72bODJC5q5jJ
         oAWqcIahhvN6udondsCtdc3Yxeyv2aiguDvZXFuj5Z6+Qf/QpmEfaRB2IJN37Pyqb3rL
         dlZ6JOs6vSnAPxLsuvsAVkwAm+Uv1805oEzhSkrcmaF6LoKFldc1fUTT+nN1Px6uJhJs
         JNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wgvx7FRG5Np0NNKZ603s/exfX3DgrTd2+4ZcDVIkcFI=;
        b=dfWwMjtbhrdHAz7dbmPZo8mtnRgxjbPgd1S9U7EYre6yhHsajJRQQOCl8UHJcPwrpY
         4l1XWOWWA4wehhu6da70+gxuZQp7RpGHykFWXNx6xNfM9gvquv3sZXrnzElVwQYDuv78
         8x1w8UF92g5UJ7j8gn/fc2jNL5nkdIZnuAyq8jYTVLnXuCm80HqdvsKXE0CtO5/pMf+n
         OUez0QIFssy+xROVegQ58RElcP6naZUQaSDCsMMJZ53thkZF3Cs+aoix6WyKPwBKiUji
         bYJTT20DYmB5eNIEBNn0ovGORv4HKCcpPChV7fSMebOx2owhQxyiXilTMh+rCeq8nYhs
         bZHQ==
X-Gm-Message-State: AIkVDXKsIiVHltqB4ocEJeSzD7mViDKeSuTjAvzZMH9ry0jqepn9X8c8T/kgpQFzWvH9pQ==
X-Received: by 10.194.41.163 with SMTP id g3mr22513705wjl.162.1482747754936;
        Mon, 26 Dec 2016 02:22:34 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:34 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 02/21] config: add git_config_get_split_index()
Date:   Mon, 26 Dec 2016 11:22:03 +0100
Message-Id: <20161226102222.17150-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function will be used in a following commit to know
if we want to use the split index feature or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index a50a61a197..c126fe475e 100644
--- a/cache.h
+++ b/cache.h
@@ -1821,6 +1821,7 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
+extern int git_config_get_split_index(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 2eaf8ad77a..421e8c9da6 100644
--- a/config.c
+++ b/config.c
@@ -1709,6 +1709,16 @@ int git_config_get_untracked_cache(void)
 	return -1; /* default value */
 }
 
+int git_config_get_split_index(void)
+{
+	int val;
+
+	if (!git_config_get_maybe_bool("core.splitindex", &val))
+		return val;
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.11.0.209.gda91e66374.dirty


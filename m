Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF51C432BE
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ACC60F3A
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhGaCmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhGaCmk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:42:40 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DCC0613D5
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w10so7837893qtj.3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpoQv5mOA6yN9dq+be8uJ4RXYBMz5qDd7+3Oby+OUaw=;
        b=DJnMjaP+ATodEQZy5FoS9Xizt0SEO3guqlCDDiTaUsWou/fWjqcSe0NLtD0zyvxKq6
         0WwICpMj7V/gYW9RIBLzh7k3iFfk1JUFNuUT0BRt2VedX0g2nhgOSSb6RwSC3o+ogf+G
         2IPWOr7XXgA5wXORIc+uYuhrDfeE4r5m9Qi/GTwAC5mMWU9Ej448NNTWhazoTsgWxwL9
         8TpSKEDRoBMwROu5mhOGGj4EEVw+b7vkbvUL76uh5AoYCLOTiqq4s4mlKztLKX5A2Cde
         elcM8/JLV4DXdIemATG+zQxgFWovIxDHXTpN0qvTPe8igH14J/IYLM94C5AtBk5Z6Q7c
         vbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpoQv5mOA6yN9dq+be8uJ4RXYBMz5qDd7+3Oby+OUaw=;
        b=iXS6Zp3wOCBkzLXfq4v1s83VuUw2vnPSiMVqrJsR356RXnw0HUyspfiAHCK4hYvOhp
         vuzZC+G27F2Y1YDO2rogq0ceg/ZFc049Xc81PDCh3wf7/iqnF+8DvqcALP0wGHOiFRM9
         rPRuiydBjrp4dtG8O+KqqVnyQuxWjbBY4GDsKWdO6AWqtcQ51rkGqZH/e2jk/MBdHI3E
         3bRdBI588q6xlUB92W0Xrpwi/talX8s6fM5w1Cqltp5pXWrgy+Wr9uaBkoCiQAqdYyD8
         oq1+Hm77QWlRKHZwoUVdkK1mh5MHWNASnz6PExS6DNrZRNchnydhHPLDfXxLzCHiwDrR
         IdGA==
X-Gm-Message-State: AOAM530LIMebgl1JjJm+oRPWljBryODGUS7ee5bYrb5Y6t2ThK/XmlT3
        nA3o2Ribulec8OuoxjCcPwJHC3c3il6Aew==
X-Google-Smtp-Source: ABdhPJztNKMm0bPpndIkxonqVsZD9hHu8krqa204FGWFFPOIWJWppdF/mPrJiofCgVxeMffDvaquCQ==
X-Received: by 2002:ac8:7d44:: with SMTP id h4mr5005068qtb.101.1627699353331;
        Fri, 30 Jul 2021 19:42:33 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id t25sm1880771qkt.11.2021.07.30.19.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:42:33 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 4/6] config: remove `core_compression_level`
Date:   Fri, 30 Jul 2021 22:42:19 -0400
Message-Id: <20210731024221.2113906-5-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731024221.2113906-1-mathstuf@gmail.com>
References: <20210731024221.2113906-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable is just stored to after parsing `core.compression` and
then ignored, so it can just be completely removed.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 cache.h       | 1 -
 config.c      | 1 -
 environment.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/cache.h b/cache.h
index dc6c4172cb..4fd134863c 100644
--- a/cache.h
+++ b/cache.h
@@ -947,7 +947,6 @@ extern int warn_on_object_refname_ambiguity;
 extern const char *git_attributes_file;
 extern const char *git_hooks_path;
 extern int zlib_compression_level;
-extern int core_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
diff --git a/config.c b/config.c
index c45001adbe..b241a56cfb 100644
--- a/config.c
+++ b/config.c
@@ -1401,7 +1401,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die(_("bad zlib compression level %d"), level);
-		core_compression_level = level;
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
 			zlib_compression_level = level;
diff --git a/environment.c b/environment.c
index 0cc086d847..3b995434fc 100644
--- a/environment.c
+++ b/environment.c
@@ -39,7 +39,6 @@ const char *git_log_output_encoding;
 const char *git_attributes_file;
 const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
-int core_compression_level;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
-- 
2.31.1


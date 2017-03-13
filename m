Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35531FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754478AbdCMRW5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:22:57 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35455 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753501AbdCMRWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:22:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id r5so7064069qtb.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9WqXLcD4jWJh8tKnWy/CDUD0dak4fAlGfewwRz6KVeA=;
        b=qjWLHxFsYzOCljqrQ705N39UsKoiDdpCO+tnkFwax6kdw9/xBb7tRAVYomY02dh0P4
         9lyOyxGCkj4cZYCjsvqqqgIaxDYMAkUUDbj3g1nA2a81ZYy+g+c3FGzCysfBsg+f3zKg
         k+KvdWr3LJY35+QTjn1uuvYVtL9/wDI1tQu9v3/suzeTh42jMMFvI507spS1q9IApICr
         uTPF+Lhs0Pavwm1NG7qKFW2VF4PWNGdrOlh+ift66c+113Yf49vuuMyWYN4xLu675bPE
         Ir/L/pj4PXov1q1VExkibg8uJGqlIyOZ9Nxhpug6yvkh8BHCH5wDKrebtMj8Nm+jfY2V
         54Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9WqXLcD4jWJh8tKnWy/CDUD0dak4fAlGfewwRz6KVeA=;
        b=X7+XrfqKB+KRxM+lHdajT6VQq1ZVCMK1E9BqLn7JrIrptSyLKpxfRARKxKrVDKAf8H
         56/KIMrD8e58Ub0MjAS6a685OgJs++BzmAArDkzGe64RIdudFFMGqdIa9vbCwuId5EG0
         IsbRQ2c6egu6k7lPcm4Fh+uPnIvw1lYiXSoRoonHRiYEle8lgSgOF2PZOw5IUjqoOQEL
         Xo7a8Xm2TPAMHi3/pKYwzgjtwEGi305etKh6IH9BPW/ttktnYaPJAzqdiClagxsHxG58
         XDUPktEbq9HBr2bvnCnau4zhtJ2eetbl4IiA1svdEotsrS/yxHsKgK+NqGKJ4f9BWKSY
         jZeQ==
X-Gm-Message-State: AMke39lkZhJVHpshaBIrqXaS3vljpY9DtM4ujYanW8m8EAcQ+acGs7HovazhHaxuePE49w==
X-Received: by 10.237.34.250 with SMTP id q55mr34601671qtc.144.1489425771468;
        Mon, 13 Mar 2017 10:22:51 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-821.cit.cornell.edu. [128.84.127.53])
        by smtp.googlemail.com with ESMTPSA id n19sm12579114qtn.35.2017.03.13.10.22.50
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 10:22:51 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH 1/3] path.c: Add xdg_cache_home to get paths under XDG_CACHE_HOME
Date:   Mon, 13 Mar 2017 13:22:30 -0400
Message-Id: <20170313172232.96678-2-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170313172232.96678-1-lehmacdj@gmail.com>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is necessary to make it posible to use XDG_CACHE_HOME for caches in
the XDG standard. I modeled this after the very similar xdg_config_home
function for obtaining paths to functions under XDG_CONFIG_HOME

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 cache.h |  7 +++++++
 path.c  | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index 8c0e64420..378a636e1 100644
--- a/cache.h
+++ b/cache.h
@@ -1169,6 +1169,13 @@ extern int is_ntfs_dotgit(const char *name);
  */
 extern char *xdg_config_home(const char *filename);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CACHE_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
+ * "$HOME/.config/git/$filename". Return NULL upon error.
+ */
+extern char *xdg_cache_home(const char *filename);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 #define LOOKUP_UNKNOWN_OBJECT 2
diff --git a/path.c b/path.c
index efcedafba..22248436b 100644
--- a/path.c
+++ b/path.c
@@ -1272,6 +1272,21 @@ char *xdg_config_home(const char *filename)
 	return NULL;
 }
 
+char *xdg_cache_home(const char *filename)
+{
+	const char *home, *cache_home;
+
+	assert(filename);
+	cache_home = getenv("XDG_CACHE_HOME");
+	if (cache_home && *cache_home)
+		return mkpathdup("%s/git/%s", cache_home, filename);
+
+	home = getenv("HOME");
+	if (home)
+		return mkpathdup("%s/.cache/git/%s", home, filename);
+	return NULL;
+}
+
 GIT_PATH_FUNC(git_path_cherry_pick_head, "CHERRY_PICK_HEAD")
 GIT_PATH_FUNC(git_path_revert_head, "REVERT_HEAD")
 GIT_PATH_FUNC(git_path_squash_msg, "SQUASH_MSG")
-- 
2.11.0


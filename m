Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7211A202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 05:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdCPFUM (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 01:20:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36821 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdCPFUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 01:20:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id n37so4468628qtb.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rr7wT6QXdCK/npHpItaa+etFnBJwia06AqUfIfvSCSg=;
        b=SUPrrXoAWPQq2Mbypi0ee5uRY7bq1qMisCtydLfTJa0nD5ya7/iiDwHhvjcm8C7XTG
         42WQGLRywGR1L0+AReFJm1SwvFdnR0lOdq4GgW7/X3dKxWCqgLfstP8ZPbfgca4tE8L0
         0BWPaS6ygJw7WA/JdJ3XI7Erd3/GaIRyaTtMP3M+DQdZZG+RUD5gJjR9N/mGh+iQYFGG
         s1vrafUT3khsa/va2PEUByBn6qsLrw82xJ+XmidrJktJs7hRTkg1gVfdzLvXzAVlhUof
         5EbukfcbvpRMRTStVK9mwhkjorPcyJtQhAGUOPS3tVtfqsJxe7qLsBx9nkZwPT5RNxAf
         sz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rr7wT6QXdCK/npHpItaa+etFnBJwia06AqUfIfvSCSg=;
        b=GjMSQOfsG9qFl4aB5KZx8H4zckNHLaV8y18dd89vffI28uYOL3iHuAmf4PY15v2qhr
         +ah//Jc8QQkZ0gwxOMLbrw/oKsJsXMPytdT1IWNE7MpODaawqQWV/7pH/Rdh/7WGhBaS
         lb59wNMn9i27DkuNanY2robX8UlOzb22o+3WqPvghmdgTigcdAjzdPpCW1PwQJAAwSE6
         /gwzg3pZcBFJgEFXGnsoBSn5EkoftvdFu7Yy4bzws/KX9lI+z2IrWzlc1ciz0C7tfh6t
         NMt3VwL2aMQjduJvl02LP0EZsvLh/Q7CkGsATusbEFV33qfQ//Fbpao8Tn4jdbxHqq5E
         p2lA==
X-Gm-Message-State: AFeK/H1Ye2nNbFKcd+R8vTHtROwWzqQSHbdKVDtkemFUEAGUou2VmQfG9aiCiWCTLaivjQ==
X-Received: by 10.237.62.176 with SMTP id n45mr6923222qtf.39.1489641516113;
        Wed, 15 Mar 2017 22:18:36 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-52.cit.cornell.edu. [128.84.124.52])
        by smtp.googlemail.com with ESMTPSA id y52sm2913833qty.60.2017.03.15.22.18.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 22:18:35 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [GSoC][PATCH v4 1/4] path.c: add xdg_cache_home
Date:   Thu, 16 Mar 2017 01:18:24 -0400
Message-Id: <20170316051827.97198-2-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170316051827.97198-1-lehmacdj@gmail.com>
References: <20170314003246.71586-4-lehmacdj@gmail.com>
 <20170316051827.97198-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have xdg_config_home to format paths relative to
XDG_CONFIG_HOME. Let's provide a similar function xdg_cache_home to do
the same for paths relative to XDG_CACHE_HOME.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 cache.h |  7 +++++++
 path.c  | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index c95826971..66761bc56 100644
--- a/cache.h
+++ b/cache.h
@@ -1169,6 +1169,13 @@ extern int is_ntfs_dotgit(const char *name);
  */
 extern char *xdg_config_home(const char *filename);
 
+/**
+ * Return a newly allocated string with the evaluation of
+ * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, otherwise
+ * "$HOME/.cache/git/$filename". Return NULL upon error.
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


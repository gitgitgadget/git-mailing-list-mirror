Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1E520373
	for <e@80x24.org>; Tue, 14 Mar 2017 00:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbdCNAdN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 20:33:13 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36323 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbdCNAdL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 20:33:11 -0400
Received: by mail-qk0-f195.google.com with SMTP id n141so39351018qke.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EuA9K7eMXvi90qRh78AsJAAkwTUDRMsmR/rHrPFF29c=;
        b=nZlU65nfYeLkRyl/VqBspgQck87hCSR4ga/bTbe+yFv8RPeZ5vufkEThmijpCU8VpK
         Rpd4h11+6Gg4YZhcWhjGqF9J/0p3VFQHiRmr0aH3qiGdBCZpAMybkc1slTLDLKXNKq09
         T05SqfFXzAcUnrYbYHHzdBjr1p4g9bRjf9YDdnef9gB6/WkAdy/djNNn358OZypAfEyN
         Fl/1WdXYmfCW2iPQkuV+3fJXtL76T4vF/RRf3JjieBJdsR0fEsA8jXXVPkwnxnvR2lTJ
         pFdIpCIBAxsLlGAxMWoojUfI+eJe6Em1f4RQ7TNxA3YSNqGlp1s/BYJo43iNl9u/SsbE
         eBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EuA9K7eMXvi90qRh78AsJAAkwTUDRMsmR/rHrPFF29c=;
        b=kWuex7Ck9t6SaRta/31H6rz+zVzpW+xqmhBad1Vb/Oc5CQWmagO3jsPQR04GfC+gS9
         KjcJ3Qv9zznkMvnPHoHk3Jjx3kBNDWeno/lQh/szCEZa57mrCCD0akiFGzy/fFnwPsUl
         n7QlMASFZmHx3agrhYDTs5r3gBivJigdK2HVJuz8k9eR34hjgKJG9lMcnPEPM2q+GOfo
         SIL5tcWYojhIBEUBvRLOb8ZblcnXAD3IX1kYbTt1k+jnrmDs7HWUU2tn/XmpnVAncN/X
         A9tRMdp+FvaI9khb8U2NtHtsZYCe82qASVUD1miQVyoLoMvZtF4hJ4Pb+9jC78NXIi7z
         mUWA==
X-Gm-Message-State: AFeK/H32pb8kUJR2dT7DTWzeKiynbDId9taK4t4Oc+3EnAlenJ1rYG7G5lP0705qzExfjA==
X-Received: by 10.55.155.88 with SMTP id d85mr32522102qke.233.1489451589584;
        Mon, 13 Mar 2017 17:33:09 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.googlemail.com with ESMTPSA id z196sm13327954qkb.11.2017.03.13.17.33.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 17:33:09 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [GSoC][PATCH/RFC v3 1/3] path.c: add xdg_cache_home
Date:   Mon, 13 Mar 2017 20:32:44 -0400
Message-Id: <20170314003246.71586-2-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170314003246.71586-1-lehmacdj@gmail.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
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
index 8c0e64420..5db29a945 100644
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


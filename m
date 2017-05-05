Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A575207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdEFStq (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:46 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35406 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdEFStg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:36 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so4880663qtb.2
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OqCpwXsP3wOOZ+SLCqaTFDX7jnqlVGgR1UHpMHilWG0=;
        b=VhGZUppwQ2onvTgz7wO2wX0g033BiLjI+MxXR4dkx3QHAoGnrIsYFLECH0xMfJ/VQv
         rQiAO9qdLr7DA4cONzhPQNtjAcivVTnte3mxpbU7DfT+503Sd6k6XMlNRHc6i3RwtVwX
         YdP6A4mA26Kdpm3sX61cdmVOGRLRKjROg9r7ms27OyKr0pPnVsq0d4nv+DEMK7vWCfbn
         nm1OydXqTPbPWnzw9IGq+YKVGlfcRhYRxrkbu+BpKXiPH2vy+Ll1hW1rmFvXJRnOHpHE
         L1QFysGYEXRJenB8KVjezhgxD6dUaxfNE6HbyXFeqnIlNirG43bjk7NbAUeOaKT2Mh/G
         LeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OqCpwXsP3wOOZ+SLCqaTFDX7jnqlVGgR1UHpMHilWG0=;
        b=GPjlDGrzzb+ObTs0KX7Mseu/Jdtu3u5X1PWqfpY9gcr6MY6jU07rT2SsAOzJx7ix1x
         ZB6wuJ046axdtv1fqoTQ5bbgiCxsodKMSxsJmi31ZYZTgREQx6u7LgUIlv44idvKHr3L
         WIem4lC9jsEWVg+GeFjoB8MNjd+x6y5Lftv3s5oZiO8z3baFSoXqfx6emAm43bArM2y7
         dYu17qt87MlCYSpPWhvPn6jh21U1FlBg8Atl31XzNSpcuaFjFs052Kci53acvnpas1PZ
         V0X1JTlDpyWHDiiYpGXYkM0+kQ5k8mHpxT73fgPk1T43ISLRBViqPyM4nT9ibIpGidAn
         RaWg==
X-Gm-Message-State: AN3rC/4yjh8NBgO6shL07DGDxVBxeoTE+AYVpY4GsSN19tlG4eUZGLC/
        UcMpP4JZRf/siE2IPS0=
X-Received: by 10.237.55.5 with SMTP id i5mr47106128qtb.76.1494096575115;
        Sat, 06 May 2017 11:49:35 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:34 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 7/9] builtin/clean: teach clean -d to skip dirs containing ignored files
Date:   Fri,  5 May 2017 05:46:09 -0500
Message-Id: <20170505104611.17845-8-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an implicit assumption that a directory containing only
untracked and ignored files should itself be considered untracked. This
makes sense in use cases where we're asking if a directory should be
added to the git database, but not when we're asking if a directory can
be safely removed from the working tree; as a result, clean -d would
assume that an "untracked" directory containing ignored files could be
deleted.

To get around this, we teach clean -d to collect ignored files and skip
over so-called "untracked" directories if they contain any ignored
files.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 builtin/clean.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a..368e19427 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -859,7 +859,7 @@ static void interactive_main_loop(void)
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, res;
+	int i, j, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
@@ -911,6 +911,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				  " refusing to clean"));
 	}
 
+	if (remove_directories)
+		dir.flags |= DIR_SHOW_IGNORED_TOO;
+
 	if (force > 1)
 		rm_flags = 0;
 
@@ -932,7 +935,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	fill_directory(&dir, &pathspec);
 
-	for (i = 0; i < dir.nr; i++) {
+	for (j = i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		int matches = 0;
 		struct stat st;
@@ -954,10 +957,27 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		    matches != MATCHED_EXACTLY)
 			continue;
 
+		// skip any dir.entries which contains a dir.ignored
+		for (; j < dir.ignored_nr; j++) {
+			if (cmp_name(&dir.entries[i],
+						&dir.ignored[j]) < 0)
+				break;
+		}
+		if ((j < dir.ignored_nr) &&
+				check_contains(dir.entries[i], dir.ignored[j])) {
+			continue;
+		}
+
 		rel = relative_path(ent->name, prefix, &buf);
 		string_list_append(&del_list, rel);
 	}
 
+	for (i = 0; i < dir.nr; i++)
+		free(dir.entries[i]);
+
+	for (i = 0; i < dir.ignored_nr; i++)
+		free(dir.ignored[i]);
+
 	if (interactive && del_list.nr > 0)
 		interactive_main_loop();
 
-- 
2.12.2


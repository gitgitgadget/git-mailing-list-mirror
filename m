Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6049C1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965673AbdACSxk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:53:40 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32911 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760438AbdACSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:53:06 -0500
Received: by mail-pg0-f52.google.com with SMTP id g1so178378014pgn.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qqXJ2L/Iczbv3J2quV3C7gLA8pcvWmsIVRvKL4pmOiI=;
        b=NXPydKzgZ5JPfnnANcPh+auY1PSShX9Ik1D2GoQKCW0lViymCA1NT9iVxL0rmDHZeH
         ip8v03XKHC4pDRfXAq9fPRud//FdcMCauNoYzpojAFG0xna4zIiXMUnp/CCaohlxQHlQ
         q/JsZpsCMhqlZckEWIRKrPgCUqE58xmVQMxRt36BmWx2sArSqlYOWcsEnHAcuPNM+s4C
         Mzigy5LiYlfkImRMU6ch8FNBW6XQ4ABxexDyXWz8Exazte3iMl8f7aTYmtSIX6/3R5qO
         p4EVCMdxJ8/gx58ohYE8zp/ZesPGfur9s8ntRSDMcXbCWX2Ve/dCh+z0T/Q6xxS11CR1
         exsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qqXJ2L/Iczbv3J2quV3C7gLA8pcvWmsIVRvKL4pmOiI=;
        b=BPykbjrhzpq66md1VJODJjQddgf6eFJlP1R5DyEneQ9RC50wiAMAEMUtEGeQSNqXoW
         w0t5wXt3Q5O+NRI67fGLOAXgxGgBiMko1Crq93fvBiTTYNhEHcuynHeEcAm/l1KL6ib0
         LyEIcxHIV/LxWD3Jzj9ywROUD5a8ttwWxPte0yKhNXQ6pR4C9ZdznRHyBd1XZoduVvKy
         0vZNr+gRAQg26OX/+aBAcwwMtvohoJuP6vVdmws0aTDuiX0GH/2HDtGq+s+obXJQBTLo
         qHS0upp7o5devlWEvjXoqKwRd96truGMCBHuUnOmagpH/re0upo9q4PAV1sYUiw3duUx
         HETw==
X-Gm-Message-State: AIkVDXLoN30zg0h6w6l9BvIjJfdupvB3vHiaOph/VPMqIzX4zwZMLh3moqkbZb8eiCjdlRFH
X-Received: by 10.84.164.106 with SMTP id m39mr136681609plg.97.1483468977548;
        Tue, 03 Jan 2017 10:42:57 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:42:56 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 00/16] pathspec cleanup
Date:   Tue,  3 Jan 2017 10:42:25 -0800
Message-Id: <20170103184241.128409-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 addresses a few comments from Duy.
* [2/16] push the guard pathspec macro into simplify_away() and
  exclude_matches_pathsepc().
* [6/16] when freeing a pathspec struct, set pathsepc->nr = 0.
* [8/16] tweak the die message when using unsupported magic to be more human
  readable.

Brandon Williams (16):
  mv: remove use of deprecated 'get_pathspec()'
  dir: remove struct path_simplify
  dir: convert fill_directory to use the pathspec struct interface
  ls-tree: convert show_recursive to use the pathspec struct interface
  pathspec: remove the deprecated get_pathspec function
  pathspec: copy and free owned memory
  pathspec: remove unused variable from unsupported_magic
  pathspec: always show mnemonic and name in unsupported_magic
  pathspec: simpler logic to prefix original pathspec elements
  pathspec: factor global magic into its own function
  pathspec: create parse_short_magic function
  pathspec: create parse_long_magic function
  pathspec: create parse_element_magic helper
  pathspec: create strip submodule slash helpers
  pathspec: small readability changes
  pathspec: rename prefix_pathspec to init_pathspec_item

 Documentation/technical/api-setup.txt |   2 -
 builtin/ls-tree.c                     |  16 +-
 builtin/mv.c                          |  50 ++--
 cache.h                               |   1 -
 dir.c                                 | 193 ++++++--------
 pathspec.c                            | 480 +++++++++++++++++++---------------
 pathspec.h                            |   5 +-
 7 files changed, 390 insertions(+), 357 deletions(-)

--- interdiff between v3 and v4

diff --git a/dir.c b/dir.c
index 15f7c9993..e8ddd7f8a 100644
--- a/dir.c
+++ b/dir.c
@@ -1353,6 +1353,15 @@ static int simplify_away(const char *path, int pathlen,
 {
 	int i;
 
+	if (pathspec)
+		guard_pathspec(pathspec,
+			       pathspec_fromtop |
+			       pathspec_maxdepth |
+			       pathspec_literal |
+			       pathspec_glob |
+			       pathspec_icase |
+			       pathspec_exclude);
+
 	if (!pathspec || !pathspec->nr)
 		return 0;
 
@@ -1385,6 +1394,15 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 {
 	int i;
 
+	if (pathspec)
+		guard_pathspec(pathspec,
+			       pathspec_fromtop |
+			       pathspec_maxdepth |
+			       pathspec_literal |
+			       pathspec_glob |
+			       pathspec_icase |
+			       pathspec_exclude);
+
 	if (!pathspec || !pathspec->nr)
 		return 0;
 
@@ -1996,15 +2014,6 @@ int read_directory(struct dir_struct *dir, const char *path,
 {
 	struct untracked_cache_dir *untracked;
 
-	if (pathspec)
-		guard_pathspec(pathspec,
-			       pathspec_fromtop |
-			       pathspec_maxdepth |
-			       pathspec_literal |
-			       pathspec_glob |
-			       pathspec_icase |
-			       pathspec_exclude);
-
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;

diff --git a/pathspec.c b/pathspec.c
index d4efcf666..bcf3ba039 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -414,10 +414,11 @@ static void NORETURN unsupported_magic(const char *pattern,
 		if (!(magic & m->bit))
 			continue;
 		if (sb.len)
-			strbuf_addch(&sb, ' ');
+			strbuf_addstr(&sb, ", ");
 
 		if (m->mnemonic)
-			strbuf_addf(&sb, "'(%c)%s'", m->mnemonic, m->name);
+			strbuf_addf(&sb, "'%s' (mnemonic: '%c')",
+				    m->name, m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
 	}
@@ -544,4 +545,5 @@ void clear_pathspec(struct pathspec *pathspec)
 	}
 	free(pathspec->items);
 	pathspec->items = NULL;
+	pathspec->nr = 0;
 }

-- 
2.11.0.390.gc69c2f50cf-goog


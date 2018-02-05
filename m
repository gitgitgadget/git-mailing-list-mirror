Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764831F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBFAEU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:04:20 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40037 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBFAER (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:04:17 -0500
Received: by mail-pl0-f68.google.com with SMTP id g18so98745plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxm94x96bppuvYBffsu+6G6p9hYgRhhXldO/Xv3UZzU=;
        b=BvRy+/SZxUJo+1q7xrYVadgNxuS1st6zLVSacu9gvyq1WJc+OF51GbGiUEkHSm0QnG
         nqidy1I791ph2Hni2+T+jSdOuROIKFp0SB/rYR7jiXGzc+ef6UD6mVO2DxCEdpiq9f1a
         pJoJ5C+Z7frsNW2s2RzfhxpXza5FzZDO224AvLFEnpao6B7n1HQL3zHRXlk2tBg94ZXt
         /d5x42n0H8vSpEHRijXyVCxP2MNhzVKP4ROgs3Wf8oH02ULv73iXi3TV9FGj2hbXaAvK
         ab4KSN9WXkZYokSPQAQDKhcYqRck++YlLXnFyUX94fvl6Ljv40GpAoirvTHEkkOmoZ1k
         UV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxm94x96bppuvYBffsu+6G6p9hYgRhhXldO/Xv3UZzU=;
        b=cpbWGgeglmzxbWu65Gjja6THbvRbVLGFpq2085uTUSst8ia4zEEaaotRdlxw1Ckyu1
         URJZJnVGcuJliaqIOhcq0uBiR8C0tPoveExOqo/ur7GEeQpu4dBHEkPk/u4AHODEvBI6
         TP8FUrwjEJnvwtSzNvXGUfrWRPnK3sgz0UaFmL845Y3K5RdeuLUH4SevYO6g1RyBy0KS
         92MCvTRumSgcY5h9WasNnuuDFrD0im+BDMR33pslG+vn7hT8fWZi7/wR9v+iYT7+cqwV
         ysfJb3f9kNlCuFWPKJdlNQgrGr6bsXV5pj0ArTx1iGMH7DYeDxWc526ygFKN5wp2ETyW
         gAnA==
X-Gm-Message-State: APf1xPCV3suMZSwZvhGTLlrabAh3u9ZlTX7Zn0UZMWnmtvZL0tlhj1m7
        L3cfhJ/aUWi905GZzEgxp/GFHGhje7w=
X-Google-Smtp-Source: AH8x2263v7k5cCo4CWo7EKwaXqXnZPEYTOvNuOP9z5PFCVNES93yLMApbZ16lxmkVL+viwTfljm1Rw==
X-Received: by 2002:a17:902:14cb:: with SMTP id y11-v6mr516655plg.294.1517875455934;
        Mon, 05 Feb 2018 16:04:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i187sm19198850pfc.99.2018.02.05.16.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:04:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 050/194] replace-object: check_replace_refs is safe in multi repo environment
Date:   Mon,  5 Feb 2018 15:55:11 -0800
Message-Id: <20180205235735.216710-30-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e1111cef23 (inline lookup_replace_object() calls, 2011-05-15) a shortcut
for checking the object replacement was added by setting check_replace_refs
to 0 once the replacements were evaluated to not exist. This works fine in
with the assumption of only one repository in existence.

The assumption won't hold true any more when we work on multiple instances
of a repository structs (e.g. one struct per submodule), as the first
repository to be inspected may have no replacements and would set the
global variable. Other repositories would then completely omit their
evaluation of replacements.

This reverts back the meaning of the flag `check_replace_refs` of
"Do we need to check with the lookup table?" to "Do we need read the
replacement definition?", adding the bypassing logic to
lookup_replace_object after the replacement definition was read.
As with the original patch, delay the renaming of the global variable

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 environment.c    | 2 +-
 replace-object.c | 2 --
 replace-object.h | 4 +++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index 63ac38a46f..249516cf6b 100644
--- a/environment.c
+++ b/environment.c
@@ -46,7 +46,7 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int check_replace_refs = 1;
+int check_replace_refs = 1; /* NEEDSWORK: rename to read_replace_refs */
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
diff --git a/replace-object.c b/replace-object.c
index c865eff0ba..91fedd9447 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -78,8 +78,6 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	the_repository->objects.replacements.prepared = 1;
-	if (!the_repository->objects.replacements.nr)
-		check_replace_refs = 0;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
diff --git a/replace-object.h b/replace-object.h
index 702020a3a0..8af730f5e3 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -24,7 +24,9 @@ extern const unsigned char *do_lookup_replace_object_the_repository(const unsign
  */
 static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
 {
-	if (!check_replace_refs)
+	if (!check_replace_refs ||
+	    (the_repository->objects.replacements.prepared &&
+	     the_repository->objects.replacements.nr == 0))
 		return sha1;
 	return do_lookup_replace_object(the_repository, sha1);
 }
-- 
2.15.1.433.g936d1b9894.dirty


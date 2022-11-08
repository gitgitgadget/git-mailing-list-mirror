Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D65C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiKHSSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbiKHSSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB65FE9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:17:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so40818674ejc.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzZK6eI4KSN2g1gei/czj0iAUC4rbQUDKDUs/W7AM48=;
        b=B6YYW6hN0hLJmpxQXDDLwZcHPaMsQ0CVHXYhfLarGaUBEyJLeHV28NuWuHI29HGVtk
         pnBE/TCDJ6thHPbBttAgVHDEij0Q7QY41oqYwmSqsafu94ZyF0uzbENeSMXcHxgBlfyI
         evsLtPefKNJbYlNoj/si0jAfddHWEmhPL6tT5WOg66Pn2oUDezV9fO80V2J2Wx4/8nTy
         JIj1Wi+jAkDdRglmVXlGcCODoOogMmTy1QU3AQjLu9PnQmxhoxZjXMvP5yHu9jFsgJZF
         u5BBo4ZyA/JFs+8Uto0NM1m2H20P5Ofgeii1LCT+PLE232tdsx8QvDWP/0i4247rTi2X
         8Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzZK6eI4KSN2g1gei/czj0iAUC4rbQUDKDUs/W7AM48=;
        b=43j44N7UJnBLlTRQw1eo1B0rPJtg4hOqXc1QZOk0RSYOXT23QacJ50k+MmVdHGeiZy
         fpG5Z7+sCOCw6WSuew2JjEQwpUp/bS1aA0L/E3id3ZLrI5R2aGOUfmUZcokkh+SI7iZ5
         ty3bVo+zsjnpmcD4jr92WEuN4OQOgOXsko/Q53O8L56T5Zdug5SJHPLo1vY/SrRlPKCz
         iz/PG+Lln4rt3tAcEUsehuTCaYFiUJThACNQMDRBR7BuwMkT3mU2MN1DWksZ7+vfFnKk
         obPS3SZ6JcS1w30qjrOSsiRzPabNlxDgJJN1+bGgRiHERZFzg1J+XlAlvAenDP+m4LEd
         gRhQ==
X-Gm-Message-State: ACrzQf3WkP9Y7yCEruMw0eJgQRNQrMc+bO1bkqeZthNjvmRJHJHNvpLi
        prhBWoEqSem9fiIEOhnlzQ1EkRtXvaEJ+Q==
X-Google-Smtp-Source: AMsMyM46gJVUr924dX9Nvb8W7Kh+qKaYmuyS4TB7QD2XUmECL7b9cPBmzTNa68gXpwZdnQHDgEn7Sg==
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id xf9-20020a17090731c900b00740ef932ffdmr53352969ejb.584.1667931477440;
        Tue, 08 Nov 2022 10:17:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/15] dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
Date:   Tue,  8 Nov 2022 19:17:41 +0100
Message-Id: <patch-v2-05.15-f4fc08a9bc8-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "ident" member of the structure was added in
1e8fef609e7 (untracked cache: guard and disable on system changes,
2015-03-08) this function wasn't updated to free it. Let's do so.

Let's also free the "exclude_per_dir" memory we've been leaking
since[1], while making sure not to free() the constant ".gitignore"
string we add by default[2].

As we now have three struct members we're freeing let's change
free_untracked_cache() to return early if "uc" isn't defined. We won't
hand it to free() now, but that was just for convenience, once we're
dealing with >=2 struct members this pattern is more convenient.

1. f9e6c649589 (untracked cache: load from UNTR index extension,
   2015-03-08)
2. 039bc64e886 (core.excludesfile clean-up, 2007-11-14)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 dir.c | 10 +++++++---
 dir.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d604d1bab98..fbdb24fc819 100644
--- a/dir.c
+++ b/dir.c
@@ -3581,8 +3581,12 @@ static void free_untracked(struct untracked_cache_dir *ucd)
 
 void free_untracked_cache(struct untracked_cache *uc)
 {
-	if (uc)
-		free_untracked(uc->root);
+	if (!uc)
+		return;
+
+	free(uc->exclude_per_dir_to_free);
+	strbuf_release(&uc->ident);
+	free_untracked(uc->root);
 	free(uc);
 }
 
@@ -3739,7 +3743,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 		      next + offset + hashsz);
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
 	exclude_per_dir = (const char *)next + exclude_per_dir_offset;
-	uc->exclude_per_dir = xstrdup(exclude_per_dir);
+	uc->exclude_per_dir = uc->exclude_per_dir_to_free = xstrdup(exclude_per_dir);
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
 	next += exclude_per_dir_offset + strlen(exclude_per_dir) + 1;
 	if (next >= end)
diff --git a/dir.h b/dir.h
index 674747d93af..8acfc044181 100644
--- a/dir.h
+++ b/dir.h
@@ -188,6 +188,7 @@ struct untracked_cache {
 	struct oid_stat ss_info_exclude;
 	struct oid_stat ss_excludes_file;
 	const char *exclude_per_dir;
+	char *exclude_per_dir_to_free;
 	struct strbuf ident;
 	/*
 	 * dir_struct#flags must match dir_flags or the untracked
-- 
2.38.0.1467.g709fbdff1a9


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2ACC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCQPgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjCQPgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6CD34C1D
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so21970052edb.6
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpWYcmFyQNT+DRQ3LlOJZ3oLBf+PGDsXp1WxZOLIVVw=;
        b=f9cfstfiMHvknwkj2PQfHMa6pXvi3cufpz6xefwcIWs8GwaROHvFOsEyIpnyHSdhFS
         ifHrqdFb7+VvCSYgt9Xg2DqSlU+zeLaZ0ZsZM/BHUFczTOLJv/EPZQGtLesyMXxt2lnK
         +Bu4iHXEL5J/51a2/+Oa72WSAaSKsz0jxc8XzQ75Kw9bR8Cle2T6VWNpxuk3KzobPdRl
         5e40y09yZNBhpyCu5mNoeOYktvp8kVP9ITu3LG8VEvFif8JA1TgReHgm+vTy+4qDsR+U
         qAHBcigGlXgxipb6EmPTwjE+NmJ8TtopYQB/simhnsOneV6P+eKLidsWayTA+mxMafNG
         XX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpWYcmFyQNT+DRQ3LlOJZ3oLBf+PGDsXp1WxZOLIVVw=;
        b=6K4ah5MgZwJeQoyjJaiC+lKpfcLyZWpzbN6+/+cRxJSsyErWVYOi7zYjDDL6/UtF/q
         jerWynRhq7BnGEifqB7AGRJ+PoxnSQ5geKMPOWIUO2AFhaxfVuiKoj7s5uVG4MnDp3aY
         SHzK3oEBAjXA5d3HFAK5L6MR+EZM2J7EJAToVa3R0L0Z5byJv40eFxwj8Rla1jLcHpI4
         PqNRRVSnvOtLGWTYK3b2CMBDGpsXdD7ha25A51o4lomuHFtWAeMv223PJ8s+H7/JK78w
         vYIa15YzRqX+HSA7Rv4fVoM3/0WeK0wuDw2hxn25zFBUyvAxVj2mtaAMOye30+1i0TR8
         ypUA==
X-Gm-Message-State: AO0yUKUHDPLIt3teAXe2SAto+QLShDm28NJHQwzOuHskTh3u6Gh5EWoV
        ruXf/1EjYeaMf5Sc8vmXRuWzSdgdjUgDXw==
X-Google-Smtp-Source: AK7set/2sKNUTv0BHb0OMYs3aUz3eqUSodWC3sqwIF3IJzPKr6ATIV9NhdGHvREPCXUQG1o3X+8kUw==
X-Received: by 2002:a17:906:f211:b0:932:20a5:5b with SMTP id gt17-20020a170906f21100b0093220a5005bmr2294654ejb.23.1679067338174;
        Fri, 17 Mar 2023 08:35:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/17] cocci: apply the "rerere.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:18 +0100
Message-Id: <patch-14.17-fb281b1ecdd-20230317T152725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"rerere.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c                                 | 2 +-
 contrib/coccinelle/the_repository.cocci         | 4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 4 ----
 rerere.h                                        | 3 ---
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 364273f1012..2017c278df2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -601,7 +601,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		ret = error(_("could not write index"));
 
 	if (ret) {
-		rerere(0);
+		repo_rerere(the_repository, 0);
 
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index b20a3e70845..1d1ac7d4fc5 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -109,6 +109,10 @@
 |
 - dwim_ref
 + repo_dwim_ref
+// rerere.h
+|
+- rerere
++ repo_rerere
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 8bf30798a04..1190a3312bd 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// rerere.h
-- rerere
-+ repo_rerere
 // revision.h
-|
 - init_revisions
 + repo_init_revisions
 )
diff --git a/rerere.h b/rerere.h
index c32d79c3bd8..876c316321e 100644
--- a/rerere.h
+++ b/rerere.h
@@ -24,9 +24,6 @@ struct rerere_id {
 };
 
 int setup_rerere(struct repository *,struct string_list *, int);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define rerere(flags) repo_rerere(the_repository, flags)
-#endif
 int repo_rerere(struct repository *, int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
-- 
2.40.0.rc1.1034.g5867a1b10c5


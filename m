Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1099C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D034F2072F
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNYON9M/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFKG7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFKG7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 02:59:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC6C08C5C2
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l26so3912981wme.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AafMz9R4E5k5OaVWLq2859BJWipKHSLAeJiS2GAQ5i4=;
        b=pNYON9M/gGAl0njERx3KlXIiEMhLiZ6vJuDbS7Mg6ChtmYk1reCIRtwzkXhn94TtAW
         EAKxrh+r+jQiaAzgw57XnYeCuDyoqbNwb7GVh0f/CqiVgePunz9Rce9568rRWrTYGzSj
         ICySjh5db25TC50+ziAn9CEqawP7NATqyscP9099wXohoVZj5aPRvXjL+vjybNSaFVkd
         eEL4JYx0yJJHkpXSfr8h4c83zzL0kz0G5kK0BHwy8dUBoG9NpL4AxVBM3D4bN9p+48nm
         EUxFLodv1gbRkEIQ8mHONd8/FT1D/BkAL9WJogFnYBLdJJtFGQ96zM/W7Vmws+hIVbMp
         +BcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AafMz9R4E5k5OaVWLq2859BJWipKHSLAeJiS2GAQ5i4=;
        b=dKNx/udzYWc8WtoZzH5fSmxOa7pUNSfNUnPNOfGlr+Kn6EfQPv6oY0EfaipbhCTh1Q
         s0PH03ebqLI3LoLsojT1RfoMtPH2oB6pyYE9feQWlUZO6RZI4jlhUYyE0XW47oG0T7BH
         /w3z4wLOAmv5hhdWFQ6xZQUznIqVKmnbxgSyT53bv/wPRkvVp0x9ZdvYCO9ZMijQhIoH
         B0DCUJEBZTVZT4u5xershF/80j3d2uqZtG7KVAHEdpBIAv/m6JS+eb7qPLhEpj+FQWJT
         VTCz3EkNYY6rMnk3r9RHwrh3HidPCz1EZiR9WmfT19DEsx5YV4ypjBtx8309gjiOPJPK
         8FmQ==
X-Gm-Message-State: AOAM532VeSSeOayyf2uVCuZ6z89IGVtlzrTJS5sDcReyI8LAQqZEg6W3
        RF1K4wauSCFoU1KzHbznVgy11zUU
X-Google-Smtp-Source: ABdhPJzkyusSvvRkqUn1r+wxLIckq4BGuOCNQ95R9QXiRSQI181wWVW2gcFw3mQVIHY6M9AaYQigiA==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr6485971wmb.3.1591858776422;
        Wed, 10 Jun 2020 23:59:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s132sm2901784wmf.12.2020.06.10.23.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 23:59:36 -0700 (PDT)
Message-Id: <d8e050701bde53084a337ec0bde40af8ff392ae5.1591858774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
References: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 06:59:30 +0000
Subject: [PATCH 1/4] dir: fix a few confusing comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     bmalehorn@gmail.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index d97e9558489..6fb2f8ecdd7 100644
--- a/dir.c
+++ b/dir.c
@@ -1820,7 +1820,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 * to recurse into untracked/ignored directories if either of the
 	 * following bits is set:
 	 *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
-	 *                           there are ignored directories below)
+	 *                           there are ignored entries below)
 	 *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
 	 *                                 the directory is empty)
 	 */
@@ -1838,10 +1838,11 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_excluded;
 
 	/*
-	 * If we have we don't want to know the all the paths under an
-	 * untracked or ignored directory, we still need to go into the
-	 * directory to determine if it is empty (because an empty directory
-	 * should be path_none instead of path_excluded or path_untracked).
+	 * Even if we don't want to know all the paths under an untracked or
+	 * ignored directory, we may still need to go into the directory to
+	 * determine if it is empty (because with DIR_HIDE_EMPTY_DIRECTORIES,
+	 * an empty directory should be path_none instead of path_excluded or
+	 * path_untracked).
 	 */
 	check_only = ((dir->flags & DIR_HIDE_EMPTY_DIRECTORIES) &&
 		      !(dir->flags & DIR_SHOW_IGNORED_TOO));
-- 
gitgitgadget


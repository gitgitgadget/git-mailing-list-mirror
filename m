Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5817AC433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C87621D7A
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbhAACfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbhAACfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:35:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39175C061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d26so21234131wrb.12
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XboQcxj2dqSpR9FRXI4YOMvdaQvvhKUQX9cakZLr9jY=;
        b=EW4fJHqg3/azJwFBn9fVXxKDZUDTaIo1280oPHB3HKB1gBz6AMst4qvF07nXBIMZiA
         MgPSTW0eVcKtoIkiRIexjuSS5OiIxBx/OR5/igJkV74KMDsas2e/IMS7PZceA4UrfKq6
         dD11Dkg8FmpoS8eSy6lBuzVdVvgQzM7A8Wg9iIMo/zmK2rdmwPRsktpGBw5oXYu+wUbV
         2XP0xA040G4ej71DSXu/Sm9/qkBlglEhUPOvTB7ebbqctqHj8OUOoTipF5QvOQFmavto
         SEafrfvwIu4+GHbQ1ddRKxX01l3EWd2D/d2/38fCStP6FuZCb+YT5hyba2aGzgEJnvlz
         nEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XboQcxj2dqSpR9FRXI4YOMvdaQvvhKUQX9cakZLr9jY=;
        b=R4soZTLGnKhZh0z4pkZ1quoEU69QDjgqjNtMaaGyT4qVIls745ooImtkSfB73ZUQuj
         GtrMhzz938paow/iOJDFbfsb+hQReXV2L2ZefrnquUBvlYIJn0ixFAEGgWWRY18e3xuH
         pjyqMN41Y2/D6+N5mE9prRBC4lQzggasGxwsUPvuA4X4TC3jMPPskk++Oi0Za7zCE6ir
         uffOuW+9gsCt8SolSxD9tZcwRnI+2To/1LOJm+eRiYOXzXfpADntLKiECSHKky3LVDxe
         Ebf1p4NxwTCxOBahxgsuxJDtmWHGBJ52RwcsEkDCDRx0H/F2kp/ydqChImD4G3U7C3JY
         dd7w==
X-Gm-Message-State: AOAM533vJWYadi/KNlyATwJIMp9+q0Jk3PySPWTCK6vo1ZWBind5F9hw
        xwSyt6SLyi+1pUglXOay/mzFOkadTwE=
X-Google-Smtp-Source: ABdhPJy3ip6GegeOtab4BhF/W434EIM0q/M8C3DP+KcKujdGQ0srZblyyPefP0Lzi7/I2veqBTB+9g==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr66077848wru.214.1609468490738;
        Thu, 31 Dec 2020 18:34:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z63sm16549391wme.8.2020.12.31.18.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:50 -0800 (PST)
Message-Id: <1869e497482a8ee7e1027d81dd900abf5f8be085.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:39 +0000
Subject: [PATCH v2 01/10] merge-ort: handle D/F conflict where directory
 disappears due to merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When one side has a directory at a given path and the other side of
history has a file at the path, but the merge resolves the directory
away (e.g. because no path within that directory was modified and the
other side deleted it, or because renaming moved all the files
elsewhere), then we don't actually have a conflict anymore.  We just
need to clear away any information related to the relevant directory,
and then the subsequent process_entry() handling can handle the given
path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 414e7b7eeac..dd90987ae3d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -976,7 +976,28 @@ static void process_entry(struct merge_options *opt,
 		assert(ci->df_conflict);
 	}
 
-	if (ci->df_conflict) {
+	if (ci->df_conflict && ci->merged.result.mode == 0) {
+		int i;
+
+		/*
+		 * directory no longer in the way, but we do have a file we
+		 * need to place here so we need to clean away the "directory
+		 * merges to nothing" result.
+		 */
+		ci->df_conflict = 0;
+		assert(ci->filemask != 0);
+		ci->merged.clean = 0;
+		ci->merged.is_null = 0;
+		/* and we want to zero out any directory-related entries */
+		ci->match_mask = (ci->match_mask & ~ci->dirmask);
+		ci->dirmask = 0;
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			if (ci->filemask & (1 << i))
+				continue;
+			ci->stages[i].mode = 0;
+			oidcpy(&ci->stages[i].oid, &null_oid);
+		}
+	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
 		die("Not yet implemented.");
 	}
 
-- 
gitgitgadget


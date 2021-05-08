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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD522C43461
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC376145D
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhEHAJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhEHAJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:09:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D88C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 17:08:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x5so10819119wrv.13
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ThQwWIUnfUmXZXm3iHsPscyieySk2PI+0bWDitXriE=;
        b=nbtFsgyrqwSuMNOrrX2DQMWiAYP94DmyCygTkfYnMrCMbOAVQNPSpZ5X/igUoZVrgU
         31dvNDcy4vm5sxfJ9ZRqE31KKJHEm7vKUK770dr4zQKPNlsvJK3xyenaIKlkbSu0vwKV
         SORXDZ6uftRGFdQfxOLtf/NyuEvfX0nNUX3byu0KMpWPhv6nX2U+HPkcfISqzkVKvlSS
         H7LCv2R7LBvyyiQyvEi3M9Ihyfyp4wzvnMHYIWZJgMUm7uEX9O9xeLD5LyqeNAtAu8C/
         9HAAho21xUA6sls9Zo54hQtnB7wEPtVeokt8jMhmGP0wyObUSnunisKXcYiSd6NX3IsD
         qIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ThQwWIUnfUmXZXm3iHsPscyieySk2PI+0bWDitXriE=;
        b=PEvoiL1spXxNrTB0x4M9kf2zQ+yO+vrvbI6hwnpvyw9Y0cSKrpReRMcihNSlXky5qu
         zl9aiPBBTDgH5p3pb5WHOukLLoVR2G4IMez8oQfz6c+h5Nf6pIxHhXdjkz8pouBysNST
         DgA6LdXolGXmk2/YvKI1RgntApeoGO3PbBJsGfn2ZyhjJjqLlNU/3yvGvgwrl/eEn1oE
         3Cp2nYaW1M1sgYOq38GSaLxy7HII9yAG8aQkolFfn4yzW9FNwsaIG/iup2GSWypGRpyg
         7uRABHItelLAYRHYUWlAUmBrRPsGsEIEieWIkxSlcOjn73a6U+FOL/Fm1jxgRkjyvauw
         FD3A==
X-Gm-Message-State: AOAM530nK5vDelDICgIJxCybXeI4nFvVyA7c+Tz0kAq+qRuHHEHofsuI
        5qVUWn3h2tgVGoNgE34+k/w2V0G5ErU=
X-Google-Smtp-Source: ABdhPJyuRoKmtTXvyZqCiCJ9kpffA9XXplPoMJrq+id3CiJ6vtRIChY64n9hC9A1wmThlsBhpBQIUA==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr15247692wri.27.1620432505233;
        Fri, 07 May 2021 17:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm10315884wrx.96.2021.05.07.17.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 17:08:24 -0700 (PDT)
Message-Id: <1d825dfdc70b8c658c4b6317310706bb6386f468.1620432501.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
        <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 00:08:18 +0000
Subject: [PATCH v2 6/8] dir: update stale description of treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

The documentation comment for treat_directory() was originally written
in 095952 (Teach directory traversal about subprojects, 2007-04-11)
which was before the 'struct dir_struct' split its bitfield of named
options into a 'flags' enum in 7c4c97c0 (Turn the flags in struct
dir_struct into a single variable, 2009-02-16). When those flags
changed, the comment became stale, since members like
'show_other_directories' transitioned into flags like
DIR_SHOW_OTHER_DIRECTORIES.

Update the comments for treat_directory() to use these flag names rather
than the old member names.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 3beb8e17a839..0a0138bc1aa6 100644
--- a/dir.c
+++ b/dir.c
@@ -1749,13 +1749,13 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
  * Case 3: if we didn't have it in the index previously, we
  * have a few sub-cases:
  *
- *  (a) if "show_other_directories" is true, we show it as
- *      just a directory, unless "hide_empty_directories" is
+ *  (a) if DIR_SHOW_OTHER_DIRECTORIES flag is set, we show it as
+ *      just a directory, unless DIR_HIDE_EMPTY_DIRECTORIES is
  *      also true, in which case we need to check if it contains any
  *      untracked and / or ignored files.
- *  (b) if it looks like a git directory, and we don't have
- *      'no_gitlinks' set we treat it as a gitlink, and show it
- *      as a directory.
+ *  (b) if it looks like a git directory and we don't have the
+ *      DIR_NO_GITLINKS flag, then we treat it as a gitlink, and
+ *      show it as a directory.
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
@@ -1843,7 +1843,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_recurse;
 	}
 
-	/* This is the "show_other_directories" case */
 	assert(dir->flags & DIR_SHOW_OTHER_DIRECTORIES);
 
 	/*
@@ -1858,7 +1857,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	/* Special cases for where this directory is excluded/ignored */
 	if (excluded) {
 		/*
-		 * In the show_other_directories case, if we're not
+		 * If DIR_SHOW_OTHER_DIRECTORIES is set and we're not
 		 * hiding empty directories, there is no need to
 		 * recurse into an ignored directory.
 		 */
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C0C43460
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B936191D
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhEKSf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhEKSfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:35:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCCCC06175F
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so1655690wrs.4
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IE8SjTUl16Ijhet7Y6rmh5P+LTw/2tHjkI++3IHg7vg=;
        b=PrPgx68ozNOmOblHWW2w0zhCDw+N8N0eAQMoF61glB4OxPuf0RlvSOMxRjWipbJTmV
         LUC6CKlfDlzPdluHoMwtV3xge620BJT1BwC4MdXGskumxNaJySaghsF0ech01kCTRcYU
         N1jGo5ANRGgBpPXon8s0ZemcMq9Si733nQ0FvIhHg46GNViaSv4MVqNwEE3EXvhHSq6R
         AMUOmelm5cmKuCcQop+4mP9zI1/+4Q5CDSy78YFyEHuFQ4yud0W/nz/bI1i1en5BmMGv
         /ccVWvOxBtIqC0rJHqR5Ejk/jIUhLvSAEa+p6AkUD3D18R4UJ5nm28LvUt8uAh4bhfoK
         vObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IE8SjTUl16Ijhet7Y6rmh5P+LTw/2tHjkI++3IHg7vg=;
        b=cNk9K/3D0WrrJwW+8RXRLwnZMf+gaXwXxNlANyQEE5EZFHbo+LbcTynq3QddGGsquz
         z0E0iDg+WqZrnCBbP/JF8mi3eqkTWcX0JDVjpytBU/avUlUPkOM+1y3bz3jlcuG+oKsV
         eaJQNSk0bMuDt3A6hbOQtABGMgwt8Fjn9/HAv8MJRu8MavmVrQp0Rg7+XtnADrYyUg5p
         cIMUN9cU4hWs8VU67gERhjluflkRiyhSn0XsDkD9dZn7ctQCbdon1n+EYBg2U1onmP2/
         PNw6zVq7QWhSz8Zubv0bmi/noKnVcSUEe+cUj7JF2JyHt8WutdDIOoeUIl1141wG7pCV
         TnzQ==
X-Gm-Message-State: AOAM532HiKIbtTbFUUeXD/dxeMzmotwFXHRoQa55+GA2vcmmRrGNAkLv
        SqsvzJGZOwYcuzc7qIJzHX1Cii05JMw=
X-Google-Smtp-Source: ABdhPJzb6eEcaVvFHb4pWh3X39ARDYRjwiP0hECgSL0KrqUvONT1pOrk0UM1In001GpSTfyVeWxobQ==
X-Received: by 2002:a05:6000:1290:: with SMTP id f16mr39505107wrx.52.1620758056632;
        Tue, 11 May 2021 11:34:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm29420049wrx.15.2021.05.11.11.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:34:16 -0700 (PDT)
Message-Id: <2945e749f5e398ead58a1e97c653145c2cf7cca5.1620758049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 18:34:08 +0000
Subject: [PATCH v4 8/8] dir: update stale description of treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
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
index deeff1a58319..993a12145f9d 100644
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

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCAC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7866128C
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhEHUAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhEHUAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24987C06175F
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so12562317wrm.4
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nagqnB6eYBu5uVDk1TnIam/B3bRjk8hGD85T5qbXJ/Q=;
        b=sMVD6an6Q7SSsUUiK/+8SUfTZ10XV693kFWs5DM2fMk0utKMeBiOFWcynATeQ1hwOi
         Lg/Jq/FesYGdKpmva4Gq6hPNywQ2cmZKrErI40mryy+QoSfmImBB8CddV3JwA4ulfonq
         /ZcRBrVXgT70IqFymPsM6lA7h853/H2EO2bCUgttQ6dPX4tMJhweafaXjJkv4HiNEtZQ
         WaWd1Nnghdnkc0AXnr8Chvs8a0u12PS9U2UbGQvV4rviRTITB+gqILaQv06bTg2hqPXT
         Krmzlw2kX3BaRA1DGyxAp69CAhHdF+q4Pcm+YisYNcJ/kS4K/QuUsm+g41uG3F+Rqb53
         Bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nagqnB6eYBu5uVDk1TnIam/B3bRjk8hGD85T5qbXJ/Q=;
        b=qtLlLkPxN87ewpGc2XCKOMAVod6U5yTSYigovIjT8zmKHha6JEdqad+xkqcpRld7Nj
         PdnypQtC79DQ9SrLFk14UTZTN6UWvngGNjFXNlZK78FkMHh8SC0nis+xhZtc0cYb9mrm
         0xzxEEoQStbWqN54PtBUMBAHFS5Zxn+DzKeAxKs0bXpj2BXrCT7qzD7mg+35xLjCzRIW
         pt8IagUpXGAG8j2oykzypxJSNXQzASnR4IaDCFlnyeh82R21rvsWmT1sUmRcJY37CrOL
         Ki1ksAkh+GesMTDUDqwAdtoq1+pAkyKMYx1BX+xTukRX5M91CG0xsEq3StqoXN4oToFf
         aPKQ==
X-Gm-Message-State: AOAM530HD16YJ36V8Fy+zjhY0+6iyaxPsOh1Ao3ds0i0iaUx3XAHVZdw
        Uwt151EBqxLsqnUVi94aAHyZQke8LjQ=
X-Google-Smtp-Source: ABdhPJxPP60vKdsbjlHC4dQD91P7+jSR6tuwejzwGhvaKa/TUXwwysGqSBb15bXRuXprzqojYUi6Vw==
X-Received: by 2002:adf:f74d:: with SMTP id z13mr20768505wrp.147.1620503952936;
        Sat, 08 May 2021 12:59:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c62sm704613wme.5.2021.05.08.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:12 -0700 (PDT)
Message-Id: <57135c35777416a91c0ae6bac7f0a57293815ced.1620503946.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:59:04 +0000
Subject: [PATCH v3 8/8] dir: update stale description of treat_directory()
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
index f5d9732d9e68..896a9a62b2c7 100644
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

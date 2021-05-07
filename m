Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60299C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3446260698
	for <git@archiver.kernel.org>; Fri,  7 May 2021 16:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhEGQXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbhEGQXw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 12:23:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E24C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 09:22:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a22so8429968qkl.10
        for <git@vger.kernel.org>; Fri, 07 May 2021 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kfyE/36ejJMgmj28q9XP3B4LF0SVTe/wiJd/IE94CeI=;
        b=OYzyfOBUnYo6GKTC5driSIMqjQm0Hj1FhGFOj8kwdKPWE/bFrPI7gc71Vdnz2UAOm/
         IE8rDzu6d+arcTFuaxQNOUEJsavcTP5n/EhhGBkgO5me8lNC5QyAf31x4NiCbA79g4No
         BAmDAuO36/lK/BbeD0Ra2jDD+X6NwzuvnX6lDbTMkMz9qVS6w+5LhoN4yU0Y8/m0rwxV
         waH7W+IDulKVElDVtC+kJjEXwuQJSF8kC0fZfv03OpYPu5su/nDGE4WjzIEpyjopAlgq
         43P4ZkkRh90v9KD9B/F6pv1CJrzOI9DmS9Y67AhSyO0XA7x8WHhqqlqtiH2Ajj9qjbb+
         iMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfyE/36ejJMgmj28q9XP3B4LF0SVTe/wiJd/IE94CeI=;
        b=mgvTdRa+LUjgHZErMuAE9P1qsFno62aC10pMAjBpzXg+LeVNzKufo3yu3/BCHynCBC
         fAyF6kDxTr6FNVbG8l+LtNATQqjlFAcUhA0ULF53O938pQnXj9xO3fanxY3hE0k2aA4d
         LaoZFniWbMwylN7pRaYpoiv0oVhoibjWR6KjJzbs91E0HLcnLZwy+uR3qGTwSwexmL0V
         e1lAT5PY2WWn6uAiQVONTwx5RlkXS5VCEP8Z12So1OSfipTfsbjTSY01UHt7krfUBZIO
         7PG2OWM0a0qRsY3DMa551rF+g0oP4o1fe35a1gLN1H2Fe7TJR6YfaA19vZ33OqQKjmhY
         xAGQ==
X-Gm-Message-State: AOAM5324C42uVukNxFt3fYHL6JzAoSTCdu73tKpVirozv/KmMLNYVLZf
        ifQUPODVL6VrRqu0ezMgEE0=
X-Google-Smtp-Source: ABdhPJywZy1+v6rFRBG8fw/ovTME+hbgYz2t/s7hWThbr17QIvp5EsNR8PRfNrEncHxfbblMjMjaFg==
X-Received: by 2002:a37:910:: with SMTP id 16mr6409010qkj.497.1620404571671;
        Fri, 07 May 2021 09:22:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:10d2:8815:444d:57fb? ([2600:1700:e72:80a0:10d2:8815:444d:57fb])
        by smtp.gmail.com with ESMTPSA id s24sm5006950qtx.94.2021.05.07.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 09:22:51 -0700 (PDT)
Subject: [PATCH 6/5] dir: update stale description of treat_directory()
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3343338e-9262-dfd1-90ef-36908c91dad4@gmail.com>
Date:   Fri, 7 May 2021 12:22:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/7/2021 12:04 AM, Elijah Newren via GitGitGadget wrote:
> This patchset fixes a few directory traversal issues, where fill_directory()
> would traverse into directories that it shouldn't and not traverse into
> directories that it should. One of these issues was reported recently on
> this list[1], another was found at $DAYJOB.
> 
> The fifth patch might have backward compatibility implications, but is easy
> to review. Even if the logic in dir.c makes your eyes glaze over, at least
> take a look at the fifth patch.

My eyes were glazing over, so I went to read the whole treat_directory()
method and its related documentation comment. I found it to be a bit
confusing that it was referencing names that were deprecated 12 years ago.

Here is a patch that you could add to this series to improve these
comments.

Thanks,
-Stolee

-- >8 --

From 587a94ac396c969b6e7734ee46afeac20e87ccb9 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 7 May 2021 12:14:13 -0400
Subject: [PATCH] dir: update stale description of treat_directory()

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
---
 dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 3beb8e17a83..0a0138bc1aa 100644
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
2.31.1.vfs.0.0.80.gb082c853c0e



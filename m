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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A17C432C3
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3E0235FF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbhAGVhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D8C0612FF
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q18so7062562wrn.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OkMBD9Rttf0qJ4vQ0leKiHKLBZbrHW77od2y0g+9RaA=;
        b=c6YP5wjXVFa6fRe/J1o0Cf6zM5g8HmBlNTk7zY5YNZ16SAnkwGVRFvx6FqBPb69Kfn
         JoRdkuwSwrTmTJmdet90rjnWThdflugkx3CSgQYgsabC+HEwHvpJ+kSfgKltfrIO+FlR
         3RAgHaORjsHtjIoQElHvMiFDcJoY4C26kqXvAC71JpdMTfmnj4gTFdDCa3bj28o/y+4f
         rssDFhrhy4LcfDh0hYh4DwUku1+Kl2dwG4/Z8whdRhV6R2Pe4tT5OpytNtj5Tp9ZWafq
         0ORJiUB4dF/c5t/fw7hKhxSRhZWoTjec+sEMRrr9qLyUfQG/3RTjbQkXymnAY5VGSD/K
         IW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OkMBD9Rttf0qJ4vQ0leKiHKLBZbrHW77od2y0g+9RaA=;
        b=TIM1X6uvpMn9X8jR1XRVIfqHCkIvsu0/OYH6XKTU3oSxMRm7enpom3oZikOCAXw9sZ
         js+4iApEvrZ24oexzwSuCCbVlcJ6icINxOGqYRyVjJXB4aS8ZWz1HLYc7dcNCWIyQOaR
         onQyNDq2ai310QXdSel8z6Mft+h6TBzbQMBDyhRSRPTKuDm0A16i3AaW61+HWLYc/4Vm
         XJYiTOtryltMzZQwLmjYQ1vFOJPUiUmUEUx9Dhlj+1bC3YTZKdlhzEEO2GX8PkZD9IZx
         CTVolOsTouXfdrO8WiuWHbhazmEAsAWHMwqHlWFF6rugtXtw8Zyj/IAyrtY8xXLsfdMw
         wGHQ==
X-Gm-Message-State: AOAM530Uz3HtrwJ2P9BlmOwAEage/cmwgWG9aECB5qJTcv9YZl+ShwSS
        nekqO+tBU93d30BbS+8rXifzQpqng+w=
X-Google-Smtp-Source: ABdhPJwvK/oX2xq8Y5RhVhtMU2WOIbQ0m1sgeQgdFzJlRD7gOtwYhKle+2SJ835T9mSfZvKUwST4ZQ==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr546226wre.408.1610055374364;
        Thu, 07 Jan 2021 13:36:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm10120932wrt.25.2021.01.07.13.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:13 -0800 (PST)
Message-Id: <4e79a96ba1cd5635e5f4cd6e57f5d6055ff37804.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:54 +0000
Subject: [PATCH v2 06/17] merge-ort: copy get_renamed_dir_portion() from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 73d3ff97f52..7e0cc597055 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,6 +721,110 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
+MAYBE_UNUSED
+static void get_renamed_dir_portion(const char *old_path, const char *new_path,
+				    char **old_dir, char **new_dir)
+{
+	char *end_of_old, *end_of_new;
+
+	/* Default return values: NULL, meaning no rename */
+	*old_dir = NULL;
+	*new_dir = NULL;
+
+	/*
+	 * For
+	 *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
+	 * the "e/foo.c" part is the same, we just want to know that
+	 *    "a/b/c/d" was renamed to "a/b/some/thing/else"
+	 * so, for this example, this function returns "a/b/c/d" in
+	 * *old_dir and "a/b/some/thing/else" in *new_dir.
+	 */
+
+	/*
+	 * If the basename of the file changed, we don't care.  We want
+	 * to know which portion of the directory, if any, changed.
+	 */
+	end_of_old = strrchr(old_path, '/');
+	end_of_new = strrchr(new_path, '/');
+
+	/*
+	 * If end_of_old is NULL, old_path wasn't in a directory, so there
+	 * could not be a directory rename (our rule elsewhere that a
+	 * directory which still exists is not considered to have been
+	 * renamed means the root directory can never be renamed -- because
+	 * the root directory always exists).
+	 */
+	if (end_of_old == NULL)
+		return; /* Note: *old_dir and *new_dir are still NULL */
+
+	/*
+	 * If new_path contains no directory (end_of_new is NULL), then we
+	 * have a rename of old_path's directory to the root directory.
+	 */
+	if (end_of_new == NULL) {
+		*old_dir = xstrndup(old_path, end_of_old - old_path);
+		*new_dir = xstrdup("");
+		return;
+	}
+
+	/* Find the first non-matching character traversing backwards */
+	while (*--end_of_new == *--end_of_old &&
+	       end_of_old != old_path &&
+	       end_of_new != new_path)
+		; /* Do nothing; all in the while loop */
+
+	/*
+	 * If both got back to the beginning of their strings, then the
+	 * directory didn't change at all, only the basename did.
+	 */
+	if (end_of_old == old_path && end_of_new == new_path &&
+	    *end_of_old == *end_of_new)
+		return; /* Note: *old_dir and *new_dir are still NULL */
+
+	/*
+	 * If end_of_new got back to the beginning of its string, and
+	 * end_of_old got back to the beginning of some subdirectory, then
+	 * we have a rename/merge of a subdirectory into the root, which
+	 * needs slightly special handling.
+	 *
+	 * Note: There is no need to consider the opposite case, with a
+	 * rename/merge of the root directory into some subdirectory
+	 * because as noted above the root directory always exists so it
+	 * cannot be considered to be renamed.
+	 */
+	if (end_of_new == new_path &&
+	    end_of_old != old_path && end_of_old[-1] == '/') {
+		*old_dir = xstrndup(old_path, --end_of_old - old_path);
+		*new_dir = xstrdup("");
+		return;
+	}
+
+	/*
+	 * We've found the first non-matching character in the directory
+	 * paths.  That means the current characters we were looking at
+	 * were part of the first non-matching subdir name going back from
+	 * the end of the strings.  Get the whole name by advancing both
+	 * end_of_old and end_of_new to the NEXT '/' character.  That will
+	 * represent the entire directory rename.
+	 *
+	 * The reason for the increment is cases like
+	 *    a/b/star/foo/whatever.c -> a/b/tar/foo/random.c
+	 * After dropping the basename and going back to the first
+	 * non-matching character, we're now comparing:
+	 *    a/b/s          and         a/b/
+	 * and we want to be comparing:
+	 *    a/b/star/      and         a/b/tar/
+	 * but without the pre-increment, the one on the right would stay
+	 * a/b/.
+	 */
+	end_of_old = strchr(++end_of_old, '/');
+	end_of_new = strchr(++end_of_new, '/');
+
+	/* Copy the old and new directories into *old_dir and *new_dir. */
+	*old_dir = xstrndup(old_path, end_of_old - old_path);
+	*new_dir = xstrndup(new_path, end_of_new - new_path);
+}
+
 static void compute_rename_counts(struct diff_queue_struct *pairs,
 				  struct strmap *dir_rename_count,
 				  struct strset *dirs_removed)
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB3C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 06:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiF3G5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiF3G5K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 02:57:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E733E99
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f190so10417973wma.5
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qOS+kMP6cipZCG+xmol8gINUINuUdHM//TOd5Z6Td3I=;
        b=myXx070RjGtP3QN8R/DwF4JsXSqC1w4GITmNpjv/1/PggaDTUPpnmSrvXc61PbXRSv
         p1a00CLLzHNzDj1+S/OYuXGmNiV8+su0F8t95Ghz8r2wW0x4qYj4mZ+093jUqo08dMsm
         6ErgiJ1tzwFUsb3sbKGF7DuzNbdMffPwwYflW9o5hcDzdwNUUZub3O1LbHs0YA5dJibR
         y/LqOHjzUS3xFzlHWnjnJG0ZcLxwwA6pE4f4D+UPrJHSIsnJANbQUA2gegZ1t2Xj2xo1
         VkZRdYC33mlVPyCtnFFdKFMFbn7z/E1CtUD4vjCZiDuBezmfZ6hgTVgHySCSBgxbk5WV
         pgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qOS+kMP6cipZCG+xmol8gINUINuUdHM//TOd5Z6Td3I=;
        b=q8atvZaZgA32wVZPqXJrpoN6CvUWI7YfvGB/rOUtCwg4zM3wxhMj+mCAXGb9P2+GMl
         OsQExIf0/JUJqJSLhY93cxfvcCYxo5OY8yPVC/4utlQUUSYfoAt6Qep6B+x11lao4g70
         YSWChBihhX95WWYnBbm/YNEVxz44OiXb8NLs5VN9tpGbXTQki8lqt2GMLsqSuuRH7nlg
         Rom5TI66wrNciFJmItIyyMoqK49963xO52ag/y//Nz+tehpI3GYpbnn9tWEW7SR7J1xp
         AmcZPSeIzQqzg9u1cFWtQTvLXUBQ+vxgsUe51guWeBB0AxVpqIQTfXap8ODdzQBzY0H6
         HCEw==
X-Gm-Message-State: AJIora/RGZxegFUw0RyLprtEmJJXJs9UDY3lQfl6y7tb57fzaGfv1nnw
        /L6UPe1ZwUxVsjzLUjVeoG54dNNGb14CAw==
X-Google-Smtp-Source: AGRyM1vqpjt3f89AoijgGv48/uM0URvkuE+WuVo9LLyxtLpxLFA/bgHe02KBBpw+ox8nRcdV+GkCEg==
X-Received: by 2002:a05:600c:4ece:b0:3a1:7816:31a7 with SMTP id g14-20020a05600c4ece00b003a1781631a7mr4638165wmq.76.1656572227525;
        Wed, 29 Jun 2022 23:57:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a1c7315000000b003a02cbf862esm5483716wmb.13.2022.06.29.23.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 23:57:06 -0700 (PDT)
Message-Id: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 06:57:02 +0000
Subject: [PATCH v2 0/3] Fix dual rename into each other plus conflicting adds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds some testcases based on the tensorflow repository issue
reported by Glen Choo at [1], demonstrating bugs in both the ort and
recursive strategies. It also provides a fix for the ort strategy.

Changes since v1:

 * Fixed some wording issues in comments, and added a bit more details to
   one of the commit messages

[1]
https://lore.kernel.org/git/kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com/

Elijah Newren (3):
  t6423: add tests of dual directory rename plus add/add conflict
  merge-ort: shuffle the computation and cleanup of potential collisions
  merge-ort: fix issue with dual rename and add/add conflict

 merge-ort.c                         |  63 +++++++++++------
 t/t6423-merge-rename-directories.sh | 102 ++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 20 deletions(-)


base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1268%2Fnewren%2Ffix-dual-rename-into-each-other-plus-conflicting-adds-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1268/newren/fix-dual-rename-into-each-other-plus-conflicting-adds-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1268

Range-diff vs v1:

 1:  69d62041843 ! 1:  bf4c03d01d5 t6423: add tests of dual directory rename plus add/add conflict
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
       '
       
      +# Testcase 12l, Both sides rename a directory into the other side, both add
     -+#   a file with after directory renames are the same filename
     ++#   a file which after directory renames are the same filename
      +#   Commit O: sub1/file,                 sub2/other
      +#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
      +#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '12k: Directory rename
      +#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
      +#
      +#   Expected: sub3/{file, newfile, sub2/other}
     -+#             CONFLICT (add/add): sub3/sub2/new_add_add_file
     ++#             CONFLICT (add/add): sub1/sub2/new_add_add_file
      +
      +test_setup_12l () {
      +	test_create_repo 12l_$1 &&
 2:  d8c13e56209 = 2:  cfa38f01481 merge-ort: shuffle the computation and cleanup of potential collisions
 3:  bb2badccb71 ! 3:  da3ae38e390 merge-ort: fix issue with dual rename and add/add conflict
     @@ Commit message
          with it.  So, let's just turn off directory rename detection in this
          case as well.
      
     +    Another way to look at this is that if the source name involved in a
     +    directory rename on one side is the target name of a directory rename
     +    operation for a file from the other side, then we avoid the doubly
     +    transitive rename.  (More concretely, if a directory rename on side D
     +    wants to rename a file on side E from OLD_NAME -> NEW_NAME, and side D
     +    already had a file named NEW_NAME, and a directory rename on side E
     +    wants to rename side D's NEW_NAME -> NEWER_NAME, then we turn off the
     +    directory rename detection for NEW_NAME to prevent the
     +    NEW_NAME -> NEWER_NAME rename, and instead end up with an add/add
     +    conflict on NEW_NAME.)
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     @@ merge-ort.c: static char *check_for_directory_rename(struct merge_options *opt,
       	const char *new_dir;
      +	int other_side = 3 - side_index;
       
     -+	/* Cases where there is no new path, so we return NULL */
     ++	/*
     ++	 * Cases where we don't have or don't want a directory rename for
     ++	 * this path, so we return NULL.
     ++	 */
       	if (strmap_empty(dir_renames))
       		return new_path;
      +	if (strmap_get(&collisions[other_side], path))

-- 
gitgitgadget

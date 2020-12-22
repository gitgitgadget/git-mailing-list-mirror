Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D1C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 03:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A543522CB1
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 03:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLVD7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 22:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgLVD7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 22:59:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5EC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 19:58:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id x22so717116wmc.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 19:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FTDnwG6VLFu7p2CDQa9hoKvYiyAHjiRfIXjujteKQGY=;
        b=f5ku2fGVCI24cZyltG2erTKFBJ+RAHP6DTmB4bc/NmiaF4877ZweZUaJxRlfzpgbrS
         uyEqLkXPD034Wg7BVZANIdeYrt7KQ1iB2rqr28hmN9PqOLT7EaBlg7WMN+zJ3EKqXvp5
         ox4MeWs8ty/8yipacJeUGkhIXAv3IKLblv6YkpedzGjYgO+TrJY1zB9R3I5ezRsMxvtL
         xcbXm7jgzwDPy8xlJPi7pavbX1cgBmw+8uKf281B94teJB2JfAFcxBCe67Q6iPm9raOQ
         bSgY2yAKB6tihTzWKBQ7mmfCxHOi/W1BijbkGumu+G+vfcZDShHEl0dFHHZY4KNLBbFk
         0YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FTDnwG6VLFu7p2CDQa9hoKvYiyAHjiRfIXjujteKQGY=;
        b=b7cp3iiZVIwPQa69XUXtXXJKrpqCqdROCiVlb9RMFgq9JvGqWRM6J+CSdYsM4d+cN/
         5LYcVAyeSVr+cwL+N2D1xrl4iPqgucnhYBYUIl2nzdqEiGS8exqj0pksFEbSEroCIten
         QgziZM4P8bqX+4CZWV/WIWhx3fSYfHcto4/N3RwC71HXqXaGHQ/rftitY6bNKU3/kUwe
         2KNkitMkT7LxPVYYbpjFsrZfzAKjIr1YvddnHpgvhf389HQt5v8o8jPDqkTY7So2lhfv
         /ViKJLSeNDnK0CZYEYvcxelwTITdg9G/Bt1cMPgr+hNrLpUlkjnca6VHSxYc2t8xD8LU
         LA3Q==
X-Gm-Message-State: AOAM531fbWKA+MK+f8F0UsA4Yw8yM/yMuBidbV5ymIOBmYLxcjko5VOf
        AF2iQi29iVsQkMkBz7uNAUvCm71AQlA=
X-Google-Smtp-Source: ABdhPJxhyndashpglGQZibgQaxX6vC9OTjwXtHO9IcGXxYk6z6+l4Du/8OjFKdU0dnX6jY8wtKu9Hw==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr19922078wmc.187.1608609499424;
        Mon, 21 Dec 2020 19:58:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm30473452wrp.56.2020.12.21.19.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 19:58:18 -0800 (PST)
Message-Id: <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 03:58:15 +0000
Subject: [PATCH v5 0/2] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If remote.origin.push was set to ":", git segfaults during a push operation,
due to bad parsing logic in query_matches_negative_refspec. Per bisect, the
bug was introduced in: c0192df630 (refspec: add support for negative
refspecs, 2020-09-30)

We found this issue when rolling out git 2.29 at Dropbox - as several folks
had "push = :" in their configuration. I based my diff off the master
branch, but also confirmed that it patches cleanly onto maint - if the
maintainers would like to also fix the segfault on 2.29

Update since Patch series V1:

 * Handled matching refspec explicitly
 * Added testing for "+:" case
 * Added comment explaining how the two loops work together

Update since Patch series V2

 * style suggestion in remote.c
 * Use test_config
 * Add test for a case with a matching refspec + negative refspec
 * Fix test_config to work with --add
 * Updated commit message to describe what git is told to do instead of
   segfaulting

Update since Patch series V3

 * Removed commit modifying test_config
 * Remove segfault-related comments in test
 * Consolidate the three tests to two tests (1st and 3rd test overlapped in
   functionality)
 * Base the patch series on the maint branch - since the bug affects 2.29.2

Update since Patch series V4

 * Squashed in Junio's patch to handle non-master named branches
 * Explicitly use test_unconfig

Appreciate the reviews from Junio and Eric! Happy Holidays!

Nipunn Koorapati (2):
  negative-refspec: fix segfault on : refspec
  negative-refspec: improve comment on query_matches_negative_refspec

 remote.c                          | 16 ++++++++--
 t/t5582-fetch-negative-refspec.sh | 51 +++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)


base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-820%2Fnipunn1313%2Fnk%2Fpush-refspec-segfault-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-820/nipunn1313/nk/push-refspec-segfault-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/820

Range-diff vs v4:

 1:  e59ff29bdef ! 1:  48c79dc3d84 negative-refspec: fix segfault on : refspec
     @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "fetch --prune with negat
       '
       
      +test_expect_success "push with matching : and negative refspec" '
     -+	test_config -C two remote.one.push : &&
     -+	# Fails to push master w/ tip behind counterpart
     ++	# Manually handle cleanup, since test_config is not
     ++	# prepared to take arbitrary options like --add
     ++	test_when_finished "test_unconfig -C two remote.one.push" &&
     ++
     ++	# For convenience, we use "master" to refer to the name of
     ++	# the branch created by default in the following.
     ++	#
     ++	# Repositories two and one have branches other than "master"
     ++	# but they have no overlap---"master" is the only one that
     ++	# is shared between them.  And the master branch at two is
     ++	# behind the master branch at one by one commit.
     ++	git -C two config --add remote.one.push : &&
     ++
     ++	# A matching push tries to update master, fails due to non-ff
      +	test_must_fail git -C two push one &&
      +
     ++	# "master" may actually not be "master"---find it out.
     ++	current=$(git symbolic-ref HEAD) &&
     ++
      +	# If master is in negative refspec, then the command will not attempt
      +	# to push and succeed.
     -+	# We do not need test_config here as we are updating remote.one.push
     -+	# again. The teardown of the first test_config will do --unset-all
     -+	git -C two config --add remote.one.push ^refs/heads/master &&
     -+	git -C two push one
     ++	git -C two config --add remote.one.push "^$current" &&
     ++
     ++	# With "master" excluded, this push is a no-op.  Nothing gets
     ++	# pushed and it succeeds.
     ++	git -C two push -v one
      +'
      +
      +test_expect_success "push with matching +: and negative refspec" '
     -+	test_config -C two remote.one.push +: &&
     -+	# Fails to push master w/ tip behind counterpart
     ++	test_when_finished "test_unconfig -C two remote.one.push" &&
     ++
     ++	# The same set-up as above, whose side-effect was a no-op.
     ++	git -C two config --add remote.one.push +: &&
     ++
     ++	# The push refuses to update the "master" branch that is checked
     ++	# out in the "one" repository, even when it is forced with +:
      +	test_must_fail git -C two push one &&
      +
     ++	# "master" may actually not be "master"---find it out.
     ++	current=$(git symbolic-ref HEAD) &&
     ++
      +	# If master is in negative refspec, then the command will not attempt
      +	# to push and succeed
     -+	git -C two config --add remote.one.push ^refs/heads/master &&
     -+	git -C two push one
     ++	git -C two config --add remote.one.push "^$current" &&
     ++
     ++	# With "master" excluded, this push is a no-op.  Nothing gets
     ++	# pushed and it succeeds.
     ++	git -C two push -v one
      +'
      +
       test_done
 2:  20575407cc0 = 2:  1f9af0e991c negative-refspec: improve comment on query_matches_negative_refspec

-- 
gitgitgadget

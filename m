Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F079AC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF18610A1
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhFNMoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhFNMoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 08:44:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08ABC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:41:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so12705783wmg.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WuxsjGwebURu7B2ejJ+m8uUmXvv9JplZ8PM/8aVjvzM=;
        b=MErPsorhjSVWlZ29p0gG1UAL3QlpA04IBNkGb5aKKBCUILAZLhx8heNDEQoEZYpxKE
         k9k2awbJSIB5Bw5NT93+n039cOihdGAeI1c52LTssFM1R+XbAqO7dv8MpwMPnOFbgKJU
         evFcLBXGch0ORrVIkakBBOgN2L2+edB+VFc4orJuHUh5mWHsA+LZW102kkCNRSMURMFB
         +jjK8IB0DjJ+EIeXgXfQZFS+WmA+EP55QbdWrwU3JFFgZyrxGI232D53UPe1WasvnsTw
         JcSXEEzJlwpPtH3IaK4OlamOZOHNZObAsv9cr1tvPVqfJ6UEi8Ro2UZAqLyEioA0hR4o
         Kolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WuxsjGwebURu7B2ejJ+m8uUmXvv9JplZ8PM/8aVjvzM=;
        b=YqNbXA/nNnfDDWOX1J4rPEvivXqA0sSlx9finYQ9ldPcucr65rtuz/hWKPaEkBw5nG
         fSL/IRYs5O7Ce95t3dL5dvUVEfGvHpZQpKIBuBNhtm5K2p/Ed7PwHS+xg3vh+qz8jGz3
         0LQ1aaMy8hfOkCrX9MOuhvhffisQ2gNisQ8nyCw/BA5JppsqygxYkoXMD6CrZXheX2EU
         c0FrRmcKU3o1oX0RpxvJHpmTC0q+6BMK/wEtohhxeY8WijyP2UokqE9lcuRYAXIXn+9V
         GYuSEfXx1TieWqJNLbG05dQoap6w+sVIaK1fjPC30XH1MHfBM3TEl314TZ0BbXIEItMQ
         NSNA==
X-Gm-Message-State: AOAM5311rn/5liJ0ywPFywsA1ED/RcBx4HCnKDqgS/p8YyYkXDsC0TyL
        F7wQyfQJgzrY5I3Ehqy1s+SiKAtWNs8=
X-Google-Smtp-Source: ABdhPJxy6CDJp4qkNX9JQWUjOcfviKol2DLHeTYrtI5PscUU0QisDM9nE+wi4MKkQrh4zWugHriVpA==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr16442637wmh.186.1623674515350;
        Mon, 14 Jun 2021 05:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l31sm12900383wms.31.2021.06.14.05.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 05:41:54 -0700 (PDT)
Message-Id: <pull.978.v2.git.1623674513.gitgitgadget@gmail.com>
In-Reply-To: <pull.978.git.1623316412.gitgitgadget@gmail.com>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 12:41:51 +0000
Subject: [PATCH v2 0/2] Fix git subtree on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the topic branch ls/subtree, we saw a lot of improvements of the git
subtree command, and some cleaning up, too. For example, 22d550749361
(subtree: don't fuss with PATH, 2021-04-27) carefully laid out a history of
changes intended to work around issues where the git-subtree script was not
in the intended location, and removed a statement modifying PATH in favor of
a conditional warning (contingent on the PATH being in an unexpected shape).

This particular condition, however, was never tested on Windows, and it
broke git subtree in Git for Windows v2.32.0, as reported here
[https://github.com/git-for-windows/git/issues/3260]. Now, every invocation
of git subtree, with or without command-line arguments, results in output
like this:

It looks like either your git installation or your
git-subtree installation is broken.

Tips:
 - If `git --exec-path` does not print the correct path to
   your git install directory, then set the GIT_EXEC_PATH
   environment variable to the correct directory.
 - Make sure that your `git-core\git-subtree` file is either in your
   PATH or in your git exec path (`C:/Users/harry/Downloads/PortableGit/mingw64/libexec/git-core`).
 - You should run git-subtree as `git core\git-subtree`,
   not as `git-core\git-subtree`.


This patch series provides a fix for that symptom, and is based on
ls/subtree.

Changes since v1:

 * Instead of using the Windows-specific cygpath construct, we now instead
   fall back to verify that GIT_EXEC_PATH and the first component of PATH
   refer to the same entity (via the -ef operator, which compares inodes).
   Since the bug affects only Windows, as far as we know, the
   non-portability of the -ef operator does not matter because Git for
   Windows' Bash does have support for it.

Johannes Schindelin (2):
  subtree: fix the GIT_EXEC_PATH sanity check to work on Windows
  subtree: fix assumption about the directory separator

 contrib/subtree/git-subtree.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)


base-commit: 9a3e3ca2ba869f9fef9f8be390ed45457565ccd1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-978%2Fdscho%2Ffix-subtree-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-978/dscho/fix-subtree-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/978

Range-diff vs v1:

 1:  a91ac6c18938 ! 1:  5f2d9434b4eb subtree: fix the GIT_EXEC_PATH sanity check to work on Windows
     @@ Commit message
          `GIT_EXEC_PATH` is a Windows-style path, while `PATH` is a Unix-style
          path list.
      
     -    Let's keep the original spirit, and hack together something that
     -    unbreaks the logic on Windows.
     +    Let's make extra certain that `$GIT_EXEC_PATH` and the first component
     +    of `$PATH` refer to different entities before erroring out.
      
     -    A more thorough fix would look at the inode of `$GIT_EXEC_PATH` and of
     -    the first component of `$PATH`, to make sure that they are identical,
     -    but that is even trickier to do in a portable way.
     +    We do that by using the `test <path1> -ef <path2>` command that verifies
     +    that the inode of `<path1>` and of `<path2>` is the same.
     +
     +    Sadly, this construct is non-portable, according to
     +    https://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html.
     +    However, it does not matter in practice because we still first look
     +    whether `$GIT_EXEC_PREFIX` is string-identical to the first component of
     +    `$PATH`. This will give us the expected result everywhere but in Git for
     +    Windows, and Git for Windows' own Bash _does_ handle the `-ef` operator.
     +
     +    Just in case that we _do_ need to show the error message _and_ are
     +    running in a shell that lacks support for `-ef`, we simply suppress the
     +    error output for that part.
      
          This fixes https://github.com/git-for-windows/git/issues/3260
      
     @@ contrib/subtree/git-subtree.sh
       #
       
      -if test -z "$GIT_EXEC_PATH" || test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
     -+if test -z "$GIT_EXEC_PATH" || {
     -+	test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" && {
     -+		# On Windows, PATH might be Unix-style, GIT_EXEC_PATH not
     -+		! type -p cygpath >/dev/null 2>&1 ||
     -+		test "${PATH#$(cygpath -au "$GIT_EXEC_PATH"):}" = "$PATH"
     -+	}
     -+} || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
     ++if test -z "$GIT_EXEC_PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup" || {
     ++	test "${PATH#"${GIT_EXEC_PATH}:"}" = "$PATH" &&
     ++	test ! "$GIT_EXEC_PATH" -ef "${PATH%%:*}" 2>/dev/null
     ++}
       then
       	echo >&2 'It looks like either your git installation or your'
       	echo >&2 'git-subtree installation is broken.'
 2:  4e1a569c9fa4 ! 2:  a6f7aa40485f subtree: fix assumption about the directory separator
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/subtree/git-subtree.sh ##
     -@@ contrib/subtree/git-subtree.sh: if test -z "$GIT_EXEC_PATH" || {
     - 	}
     - } || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
     +@@ contrib/subtree/git-subtree.sh: if test -z "$GIT_EXEC_PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup" || {
     + 	test ! "$GIT_EXEC_PATH" -ef "${PATH%%:*}" 2>/dev/null
     + }
       then
     -+	base=${0##*/}
     -+	base=${base##*\\}
     ++	basename=${0##*[/\\]}
       	echo >&2 'It looks like either your git installation or your'
       	echo >&2 'git-subtree installation is broken.'
       	echo >&2
     @@ contrib/subtree/git-subtree.sh: then
       	echo >&2 "   your git install directory, then set the GIT_EXEC_PATH"
       	echo >&2 "   environment variable to the correct directory."
      -	echo >&2 " - Make sure that your \`${0##*/}\` file is either in your"
     -+	echo >&2 " - Make sure that your \`$base\` file is either in your"
     ++	echo >&2 " - Make sure that your \`$basename\` file is either in your"
       	echo >&2 "   PATH or in your git exec path (\`$(git --exec-path)\`)."
      -	echo >&2 " - You should run git-subtree as \`git ${0##*/git-}\`,"
      -	echo >&2 "   not as \`${0##*/}\`." >&2
     -+	echo >&2 " - You should run git-subtree as \`git ${base#git-}\`,"
     -+	echo >&2 "   not as \`$base\`." >&2
     ++	echo >&2 " - You should run git-subtree as \`git ${basename#git-}\`,"
     ++	echo >&2 "   not as \`$basename\`." >&2
       	exit 126
       fi
       

-- 
gitgitgadget

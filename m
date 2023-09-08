Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88786EE57EC
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 10:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjIHKG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIHKG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 06:06:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1177211F
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 03:05:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4018af1038cso20237075e9.0
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694167541; x=1694772341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RfqSDVpr90qK3jJ5e08muZvkGSRSFuM9/9jk0a4kxbg=;
        b=nT1N6PrsxbyJg/ibl9lfTsXx/xLsRCjyOwi3ozxxDoX98fcASVfM8Uq7b3080fINOo
         kjyITAm2PDqJ+gVyCOb9IKL3Puv57pHP5AOTAjDPfwv5DAOekx8P6T3IHncn61Y/Uy8L
         PWCSkM131xyPxMcckHNCuJvBsRQ/8NKhXKjpiEMyz6z1NGLPbZTlpJOtUZymZO2mr4wg
         jTD30hhMZ9tKidZ5jnJMUfksgNiLdD4dpqu+r+RI9me2MVTnEIx6HtICE336kgLJfW3P
         nOi7IhgNYjACEyiKedSfr3kRm36FvhtfG1zzi4O+wPFA9lKqciLokZck60jrt9K745zY
         SVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694167541; x=1694772341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfqSDVpr90qK3jJ5e08muZvkGSRSFuM9/9jk0a4kxbg=;
        b=OxuefTwKiAM0PMA2858+WDc35KU++Om3ZV4rvUGq7zBSSCw6/Kl+e6zVJyhuaAKaSZ
         PEBR7siyhtmW8VlOYWKgmHWRlpzUuOKU+zLoKoL0TExcw46Cbb4OamvzyrcfSJpvn1zl
         jaoQiD+3dNBNwpABr53q1k1J8wNe+9X9+qVrbAVnBPzYKUkXvM4kZGoZqKAEUTmedo+f
         r0KTXaPwNs6qvPeMlg0RseffKGt0Ah1AvZthiwpjAFud2JLYfs6abk60rtk6Nv9AqHYf
         yVBpALjfwtuU6AI54cuIdXl6T64vM1KVioGAsdK69nL89t0PdsVp4mJYXiqUGdTb1Qwi
         m83A==
X-Gm-Message-State: AOJu0Yy9XQ6MKdMKFSgGK4DxqikEudKAExzDYodAlccm05h7k6BWjUrw
        9XOW3xTQWcLxPuA7rb9NlAWVwMuPTOQ=
X-Google-Smtp-Source: AGHT+IEQqEcWcrm4u3iSlYRe7ciyq70HOJZP8xRyHJ3nfXKggZnq7QKnd7c6xT43XabsIWPHAkropw==
X-Received: by 2002:a05:600c:2119:b0:3fc:92:73d6 with SMTP id u25-20020a05600c211900b003fc009273d6mr1741718wml.11.1694167541412;
        Fri, 08 Sep 2023 03:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b003feea62440bsm1557762wme.43.2023.09.08.03.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:05:41 -0700 (PDT)
Message-ID: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Sep 2023 10:05:40 +0000
Subject: [PATCH] start_command: reset disposition of all signals in child
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In order to avoid invoking a signal handler in the child process between
fork() and exec(), start_command() blocks all signals before calling
fork and then in the child resets the disposition of all signals that
are not ignored to SIG_DFL before unblocking them. The exception for
ignored signals seems to been inspired by ruby's process handling[1]
based on the misconception that execve() will reset them to
SIG_DFL. Unfortunately this is not the case [2] and any signals that are
ignored in the parent will default to being ignored by the program
executed by start_command().

When git ignores SIGPIPE before forking a child process it is to stop
git from being killed if the child exits while git is writing to the
child's stdin. We do not want to ignore SIGPIPE in the child. When git
ignores SIGINT and SIGQUIT before forking a child process it is to stop
git from being killed if the user interrupts the child with Ctrl-C or
Ctrl-\ we do not want the child to ignore those signals [3].
Fortunately the fix is easy - reset the disposition of all signals
regardless of their previous disposition.

[1] https://lore.kernel.org/git/20170413211428.GA5961@whir/

[2] The man page for execve(2) states:

        POSIX.1 specifies that the dispositions of any signals that are
	ignored or set to the default are left unchanged.  POSIX.1
	specifies one exception: if SIGCHLD is being ignored, then an
	implementation may leave the disposition unchanged or reset it
	to the default; Linux does the former.

    Page 579 of "The Linux Programming Interface" notes:

        SUSv3 recommends that signals should not be blokced or ignored
	across an exec() of an arbitrary program. Here, "arbitrary"
	means a program that we did not write.

[3] This is really a work-around for not moving the child into its own
    process group and changing the foreground process group of the
    controlling terminal.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    start_command: reset disposition of all signals in child
    
    As an aside I wonder if we ought to add an option to ignore SIGPIPE when
    stdin is redirected and possibly turn it on by default.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1582%2Fphillipwood%2Fstart-command-dont-ignore-signals-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1582/phillipwood/start-command-dont-ignore-signals-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1582

 run-command.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index a558042c876..765775a1f42 100644
--- a/run-command.c
+++ b/run-command.c
@@ -823,11 +823,8 @@ fail_pipe:
 		 * restore default signal handlers here, in case
 		 * we catch a signal right before execve below
 		 */
-		for (sig = 1; sig < NSIG; sig++) {
-			/* ignored signals get reset to SIG_DFL on execve */
-			if (signal(sig, SIG_DFL) == SIG_IGN)
-				signal(sig, SIG_IGN);
-		}
+		for (sig = 1; sig < NSIG; sig++)
+			signal(sig, SIG_DFL);
 
 		if (sigprocmask(SIG_SETMASK, &as.old, NULL) != 0)
 			child_die(CHILD_ERR_SIGPROCMASK);

base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
-- 
gitgitgadget

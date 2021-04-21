Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E045C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43747610CC
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbhDUXXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhDUXXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:23:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F6C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 16:22:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso2086623wmq.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4fzDd9ESlCmvhq/R6cXEZFdGXpIk3qtBfgTHD9mYaAY=;
        b=FQ2j+qNOSxcyxQ4AA7Aub3CkyzAHEgPqAAU1QzuLlgVq3WQEWm7YdrN0LbYumqZDcA
         neEEFoHO1keJ5XbPWsbzD+pQRvPB52l2jQwwr3WyXKz9TWOyUaZRNlsPmOwJOnEm5vZV
         PjeFzkdZOn0dQv0oZVegIYdAr0HVfZxHB9Q0QvyLSGWhcLKb1V4Bd4u9jafvOef/lBG4
         DZnEP+majfttNBJ+PYvbkNtYin18gVHBgP7uTMfIOUpN1oNBSCFdxbQkm8Jlp8PvBChn
         OYWqBLaqu/E2moiHAFtISZ9NYxHwu4LqpoPWIWTSg5vMJjlx7StIRX6OQjt1Lk9H2AOL
         5gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4fzDd9ESlCmvhq/R6cXEZFdGXpIk3qtBfgTHD9mYaAY=;
        b=W0/KNCKxQXC+se9FcHkRWGu4TADDmGsZLjS7Go23R6s6HNhkMapBp/tPhzDJS9jmqX
         0Bs4LfPRWmnx4eRaGocooMWCxUri5y82f37HOgibbLpGEMm/ZuUjMYTCOZ8Yn4Yg47br
         6N6Z8b1032AdL6MnmR43v2zEldwdI3Snr424Mom8moJq/1OBwRxKgUWdJ0wfI2Eukklx
         eTTEgwQKqiQvAEnej5faUq6/2AQo+QfedeVTTIQj4ETRPNDFYlb3yADJc6KTUdMO4b29
         ArWll/8tpAMNbc5V9wJwgmK4N/mIYoSajdcYjPLINMFQpofSyA9kDMjjLF4MNQbouUfS
         GG7Q==
X-Gm-Message-State: AOAM5308XHuswbJ6xJiAwHosblB+tvyAQ/wAjXbWitI2PMdEndt0sq7b
        hu3HO9cFK/KpqWPi2CJ2+CmTGkFg8vU=
X-Google-Smtp-Source: ABdhPJzNnF1ld4G7sblG2xRgTtJJZ4RbaB5hK0nAC3ciRofdyJ5lUF2X691QFjThp+pzHAiGRpHw7g==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr528603wmc.31.1619047348846;
        Wed, 21 Apr 2021 16:22:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm847345wrr.61.2021.04.21.16.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 16:22:28 -0700 (PDT)
Message-Id: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
In-Reply-To: <pull.934.git.1618770806366.gitgitgadget@gmail.com>
References: <pull.934.git.1618770806366.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 23:22:26 +0000
Subject: [PATCH v2] git-merge: move primary point before parenthetical
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

Usually, it is easier to read a message if it makes its primary
point first, before giving a parenthetical note.

Before:
` (nothing to squash)Already up to date.
`

After:
`Already up to date (nothing to squash).
`

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
    git-merge: move space to between strings
    
    GitHub Actions show things like:
    
     * branch                  master     -> FETCH_HEAD
     (nothing to squash)Already up to date.
    
    
    Usually, it is easier to read a message if it makes its primary point
    first, before giving a parenthetical note.
    
    The expected results are:
    
     * branch                  master     -> FETCH_HEAD
    Already up to date (nothing to squash).
    
    
    This commit should change that. Other than breaking all the
    localizations, and anyone who actively parses the output, this shouldn't
    have much impact.
    
    Changes since v1:
    
     * finish_up_to_date now takes a message with a %s for the parenthetical
       and a trailing \n to address feedback from Junio C Hamano

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-934%2Fjsoref%2Fnothing-to-squash-already-up-to-date-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-934/jsoref/nothing-to-squash-already-up-to-date-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/934

Range-diff vs v1:

 1:  1b9d685d611f ! 1:  4f60e08195ea git-merge: move space to between strings
     @@ Metadata
      Author: Josh Soref <jsoref@gmail.com>
      
       ## Commit message ##
     -    git-merge: move space to between strings
     +    git-merge: move primary point before parenthetical
     +
     +    Usually, it is easier to read a message if it makes its primary
     +    point first, before giving a parenthetical note.
     +
     +    Before:
     +    ` (nothing to squash)Already up to date.
     +    `
     +
     +    After:
     +    `Already up to date (nothing to squash).
     +    `
      
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
     @@ builtin/merge.c: static void restore_state(const struct object_id *head,
       {
       	if (verbosity >= 0)
      -		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
     -+		printf("%s%s\n", squash ? _("(nothing to squash) ") : "", msg);
     ++		printf(msg, squash ? _(" (nothing to squash)") : "");
       	remove_merge_branch_state(the_repository);
       }
       
     +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     + 		 * If head can reach all the merge then we are up to date.
     + 		 * but first the most common case of merging one remote.
     + 		 */
     +-		finish_up_to_date(_("Already up to date."));
     ++		finish_up_to_date(_("Already up to date%s.\n"));
     + 		goto done;
     + 	} else if (fast_forward != FF_NO && !remoteheads->next &&
     + 			!common->next &&
     +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     + 			}
     + 		}
     + 		if (up_to_date) {
     +-			finish_up_to_date(_("Already up to date. Yeeah!"));
     ++			finish_up_to_date(_("Already up to date%s. Yeeah!\n"));
     + 			goto done;
     + 		}
     + 	}


 builtin/merge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 062e91144125..aad180010670 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -383,7 +383,7 @@ static void restore_state(const struct object_id *head,
 static void finish_up_to_date(const char *msg)
 {
 	if (verbosity >= 0)
-		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
+		printf(msg, squash ? _(" (nothing to squash)") : "");
 	remove_merge_branch_state(the_repository);
 }
 
@@ -1482,7 +1482,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
-		finish_up_to_date(_("Already up to date."));
+		finish_up_to_date(_("Already up to date%s.\n"));
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
@@ -1566,7 +1566,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
-			finish_up_to_date(_("Already up to date. Yeeah!"));
+			finish_up_to_date(_("Already up to date%s. Yeeah!\n"));
 			goto done;
 		}
 	}

base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
-- 
gitgitgadget

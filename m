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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E365DC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA8460FE5
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhDVAzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 20:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhDVAzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 20:55:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C0C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 17:55:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so2158256wmi.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8jtk/J556zulD+R5IVJzbeDJhpSfhKrTI4eR9G+3sJU=;
        b=UFPodq5IUEy1Qb7xCe9qQtyWvCQ2jcNhOS8Kew4EWBu5XOLNYKMkrPm7/WL3hj6hHM
         rlynS/mRMyMXgXRASIhYEycGO5KpHCRmZhyyBt6bn90uKbc/L98n+93FuhF2lLpm2Zb0
         TVmtcU4TGD+ZwatLys2I8EpvXgtVXRagZaXGQYX9DvfxQ1dhGgfr5Zmd63WoEz3+qKN+
         jcRIpFBbJPpgF4OdB09oEISAPNEPM0+Q2JfsVQUXagXUfirJHH3/CCMQs9+Gb+Yr7M27
         m8BI+KQX9Tjy55ydvQ1hACtVUhoUczWSY+7QxH6x17LVpFSd9HkcFA/i8ckokIEkbmp+
         UZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8jtk/J556zulD+R5IVJzbeDJhpSfhKrTI4eR9G+3sJU=;
        b=tVJlhnruU6xUM4kFT9o9Z1pA/Jnp+UlT9E2/feVW2GSSSbk3N9G/tghijAhgxpmwCH
         6RGBGznCdwkQEAMsswWkvpYY7Ag/4Q8QAo6MXWRH1aUUZHjdhwrSsckOg5Ui/ghUVlXW
         pNxtYtj3Z9t9OM4XYeZ232loSMaFWbVMPSeU7yHX6p7+eORYMa/A9Hak9/l39a9Un8kz
         +iVGE9uScrkFfUaP3F3Fw1d4+Ty3tiqCUzZ5aDc70Lr+RS91pnpHN+ehVvo8YZjoDted
         toXK9Cp2jPtaM9F3NHj0CIz/Rcxu99/+rLTgGuf5wGpNaYGgHSck2qxko1v2gnxz7uTU
         JagQ==
X-Gm-Message-State: AOAM530EhjBlTo+36ZXc0JFfjiZY8iySm4LO2djwpqZVGa2LWuCx0EZD
        QL+LBUcfuPStrkzw0+kc+x9+rJjA+uU=
X-Google-Smtp-Source: ABdhPJy7osV4pR5ABIcuxh0WKUhYyns+4IdcFT+oAZlEofMWsYG1PK+ZaUyjROkz13T2XrJpH495Cg==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr817606wmj.185.1619052907727;
        Wed, 21 Apr 2021 17:55:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm1044406wrf.75.2021.04.21.17.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 17:55:07 -0700 (PDT)
Message-Id: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
In-Reply-To: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Apr 2021 00:55:06 +0000
Subject: [PATCH v3] git-merge: rewrite already up to date message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

Usually, it is easier to read a message if it makes its primary
point first, before giving a parenthetical note.

Possible messages before include:
` (nothing to squash)Already up to date.
`
and
`Already up to date. Yeeah!
`

After:
`Already up to date (nothing to squash).
`
and
`Already up to date.
`

Localizations now have two easy to understand translatable strings.
(All localizations of the previous strings are broken.)

Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Josh Soref <jsoref@gmail.com>
---
    git-merge: rewrite already up to date message
    
    GitHub Actions show things like:
    
     * branch                  master     -> FETCH_HEAD
     (nothing to squash)Already up to date.
    
    
    There was a code path where it would say:
    
    Already up to date. Yeeah!
    
    
    It is believed that other than being troublesome for localizers, this
    message added no value, so it's being removed.
    
    Usually, it is easier to read a message if it makes its primary point
    first, before giving a parenthetical note.
    
    The expected results are:
    
     * branch                  master     -> FETCH_HEAD
    Already up to date (nothing to squash).
    
    
    As well as an easier chance for localizers to actually translate the now
    two messages. (As they don't have to fight string pasting. Which is a
    localization sin.): Already up to date. Already up to date (nothing to
    squash).
    
    This commit should change that. Other than breaking anyone who actively
    parses the output and all the localizations (and giving localizers a
    real chance at localizing these messages), this shouldn't have much
    impact.
    
    Changes since v2:
    
     * finish_up_to_date now figures out the answer on its own to address
       feedback from Eric Sunshine
    
    -- Yes, I'm well aware of localization rules. But as Eric Sunshine
    noted, the code was already making a mess of things. I didn't want to
    make invasive changes. I actually wrote roughly what Eric proposed as an
    earlier implementation, but the various complexities, including trying
    to figure out what the yeah was for and who cared about it, made me
    really wary of proposing such a significant change.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-934%2Fjsoref%2Fnothing-to-squash-already-up-to-date-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-934/jsoref/nothing-to-squash-already-up-to-date-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/934

Range-diff vs v2:

 1:  4f60e08195ea ! 1:  a6c703603cda git-merge: move primary point before parenthetical
     @@ Metadata
      Author: Josh Soref <jsoref@gmail.com>
      
       ## Commit message ##
     -    git-merge: move primary point before parenthetical
     +    git-merge: rewrite already up to date message
      
          Usually, it is easier to read a message if it makes its primary
          point first, before giving a parenthetical note.
      
     -    Before:
     +    Possible messages before include:
          ` (nothing to squash)Already up to date.
          `
     +    and
     +    `Already up to date. Yeeah!
     +    `
      
          After:
          `Already up to date (nothing to squash).
          `
     +    and
     +    `Already up to date.
     +    `
     +
     +    Localizations now have two easy to understand translatable strings.
     +    (All localizations of the previous strings are broken.)
      
     +    Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Josh Soref <jsoref@gmail.com>
      
       ## builtin/merge.c ##
      @@ builtin/merge.c: static void restore_state(const struct object_id *head,
     - static void finish_up_to_date(const char *msg)
     + }
     + 
     + /* This is called when no merge was necessary. */
     +-static void finish_up_to_date(const char *msg)
     ++static void finish_up_to_date(void)
       {
     - 	if (verbosity >= 0)
     +-	if (verbosity >= 0)
      -		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
     -+		printf(msg, squash ? _(" (nothing to squash)") : "");
     ++	if (verbosity >= 0) {
     ++		if (squash)
     ++			puts(_("Already up to date (nothing to squash)."));
     ++		else
     ++			puts(_("Already up to date."));
     ++	}
       	remove_merge_branch_state(the_repository);
       }
       
     @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
       		 * but first the most common case of merging one remote.
       		 */
      -		finish_up_to_date(_("Already up to date."));
     -+		finish_up_to_date(_("Already up to date%s.\n"));
     ++		finish_up_to_date();
       		goto done;
       	} else if (fast_forward != FF_NO && !remoteheads->next &&
       			!common->next &&
     @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
       		}
       		if (up_to_date) {
      -			finish_up_to_date(_("Already up to date. Yeeah!"));
     -+			finish_up_to_date(_("Already up to date%s. Yeeah!\n"));
     ++			finish_up_to_date();
       			goto done;
       		}
       	}


 builtin/merge.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 062e91144125..f8c3d0687eaf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -380,10 +380,14 @@ static void restore_state(const struct object_id *head,
 }
 
 /* This is called when no merge was necessary. */
-static void finish_up_to_date(const char *msg)
+static void finish_up_to_date(void)
 {
-	if (verbosity >= 0)
-		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
+	if (verbosity >= 0) {
+		if (squash)
+			puts(_("Already up to date (nothing to squash)."));
+		else
+			puts(_("Already up to date."));
+	}
 	remove_merge_branch_state(the_repository);
 }
 
@@ -1482,7 +1486,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
-		finish_up_to_date(_("Already up to date."));
+		finish_up_to_date();
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
@@ -1566,7 +1570,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
-			finish_up_to_date(_("Already up to date. Yeeah!"));
+			finish_up_to_date();
 			goto done;
 		}
 	}

base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
-- 
gitgitgadget

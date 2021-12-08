Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21404C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 02:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhLHCPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHCPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 21:15:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93536C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 18:12:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so1376520wrn.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 18:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X0zx9FDzpzSb8oSOHhENqSjkylUeYDaprl25lgchGME=;
        b=I2pqRo6Nn1Ohy/L6Kty+nvghLSV0u0YDwsglDKTMOsLEK1Tw9REBO+ionzdAWVA9sg
         0IWACD79fQObeEqVE+hYP/hyvbHRtHhXhcXJMk5sqsFCbWSEHzfQuL52ztR/E4B1b2rI
         ZDQOQZ94CJPndhN7fOVfbn11Uz6b7y/TaVIO2/NLoVf7lZ8cDmlLvckUmEp6zO4s1fUm
         8m2Nb19ubMq7BAGk8XMI65ZuwU1g/d3kycT1HYJZJazSs+cXvWkmuauiFjC46IOPgSXg
         1hX7r4Nh25JC8gbnFRvpeO5H+h9UhlPRTCApNQZJq7VIO3LF4MErefSNUmos0kqxDCuZ
         CwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X0zx9FDzpzSb8oSOHhENqSjkylUeYDaprl25lgchGME=;
        b=pREMV9wVk3dP3PLKrORW+PQB+ZtCEGzixaTnMeyNoGoKO8jhTdcT4ZxyuxXSZXWKNC
         Jv5WQWf44bSgo4jRAmwVpvKAwPCNC3iAosR5Ju5+yoeBVrzfHiiKfsxtYFllxMfjJK0M
         LQ7gLePkV7dgF5DQ84SGVg0pKyKaBUs3OnyLHQJjfyEPoZCs/cvzWaEu+gFDdc1+wcsy
         /3QAW13n80WWi8/gyumh+1agurIXzx0d0ZRtFYpszMQNDPanstA4HIsEx7hnPuVm5VVG
         saEtgMpXiu/HCoH2kTChZslWzostR5rnHanI0EUQGRtSOJ9ku03lOcYTp7ocutH5bSCL
         aulg==
X-Gm-Message-State: AOAM532SAkfrKIkNwRQ9FSCzNREnf5k/v2URClBzRR6NmhdrUSpcjVrp
        UYgf3QddghkYKP/maw1mOfRpPYjWmtI=
X-Google-Smtp-Source: ABdhPJy0CJhoxkcfAkDisRrJBLjIFkYfigf1WCoYWGDNunI8daKXfzJL6bA9kp2QWbUshNSp+JcSvA==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr58303874wru.363.1638929519968;
        Tue, 07 Dec 2021 18:11:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm1812013wri.50.2021.12.07.18.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 18:11:59 -0800 (PST)
Message-Id: <pull.1086.v4.git.1638929518657.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com>
References: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com>
From:   "James Limbouris via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 02:11:58 +0000
Subject: [PATCH v4] subtree: fix argument handling in check_parents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        James Limbouris <james@digitalmatter.com>,
        James Limbouris <james@digitalmatter.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: James Limbouris <james@digitalmatter.com>

315a84f9aa0 (subtree: use commits before rejoins for splits, 2018-09-28)
changed the signature of check_parents from 'check_parents [REV...]'
to 'check_parents PARENTS_EXPR INDENT'. In other words the variable list
of parent revisions became a list embedded in a string. However it
neglected to unpack the list again before sending it to cache_miss,
leading to incorrect calls whenever more than one parent was present.
This is the case whenever a merge commit is processed, with the end
result being a loss of performance from unecessary rechecks.

The indent parameter was subsequently removed in e9525a8a029 (subtree:
have $indent actually affect indentation, 2021-04-27), but the argument
handling bug remained.

For consistency, take multiple arguments in check_parents,
and pass all of them to cache_miss separately.

Signed-off-by: James Limbouris <james@digitalmatter.com>
---
    subtree: fix argument handling in check_parents
    
    > I saw that you sent a v3, but did not see any of this information
    > (which took a good while to assemble, as you might have guessed) in
    > the commit message. However, I think that message would make for the
    > best home for this information.
    
    Sorry Dscho - it wasn't 100% clear to me which details were required.
    I've rerolled and tried again. Also sorry if I'm not replying to the
    mail correctly - I'm not actually subscribed to the list, and this seems
    like the only easy way to get text onto it through gitgitgadget without
    fighting Outlook.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1086%2Fjamesl-dm%2Fmaint-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1086/jamesl-dm/maint-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1086

Range-diff vs v3:

 1:  f734ca9d276 ! 1:  cdc5295a7ac subtree: fix argument handling in check_parents
     @@ Metadata
       ## Commit message ##
          subtree: fix argument handling in check_parents
      
     -    check_parents was taking all of its arguments as a single string,
     -    and erroneously passing them to cache_miss as a single string. For
     -    commits with a single parent this would succeed, but whenever a merge
     -    commit was processed, cache_miss would be passed "parent1 parent2"
     -    instead of "parent1" "parent2" and fail, leading to unecessary rechecks
     -    of the parent commits.
     +    315a84f9aa0 (subtree: use commits before rejoins for splits, 2018-09-28)
     +    changed the signature of check_parents from 'check_parents [REV...]'
     +    to 'check_parents PARENTS_EXPR INDENT'. In other words the variable list
     +    of parent revisions became a list embedded in a string. However it
     +    neglected to unpack the list again before sending it to cache_miss,
     +    leading to incorrect calls whenever more than one parent was present.
     +    This is the case whenever a merge commit is processed, with the end
     +    result being a loss of performance from unecessary rechecks.
     +
     +    The indent parameter was subsequently removed in e9525a8a029 (subtree:
     +    have $indent actually affect indentation, 2021-04-27), but the argument
     +    handling bug remained.
      
          For consistency, take multiple arguments in check_parents,
          and pass all of them to cache_miss separately.


 contrib/subtree/git-subtree.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7f767b5c38f..71f1fd94bde 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -296,10 +296,9 @@ cache_miss () {
 	done
 }
 
-# Usage: check_parents PARENTS_EXPR
+# Usage: check_parents [REVS...]
 check_parents () {
-	assert test $# = 1
-	missed=$(cache_miss "$1") || exit $?
+	missed=$(cache_miss "$@") || exit $?
 	local indent=$(($indent + 1))
 	for miss in $missed
 	do
@@ -753,7 +752,7 @@ process_split_commit () {
 	fi
 	createcount=$(($createcount + 1))
 	debug "parents: $parents"
-	check_parents "$parents"
+	check_parents $parents
 	newparents=$(cache_get $parents) || exit $?
 	debug "newparents: $newparents"
 

base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
-- 
gitgitgadget

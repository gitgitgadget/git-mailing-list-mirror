Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C5EC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 02:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhLFCtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbhLFCtN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 21:49:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0B3C061354
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 18:45:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i5so19372570wrb.2
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 18:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cENW2RdcQYx/np7UTy8gEVQVJU47Pn+14ajOrALawWU=;
        b=m4zACP6ph0V1zSfDu14tCse99q3ZsqHMvcpPVAhGEtTlnL2eFdKkKTJiMeJkWwSacm
         tWFt0RG77Gi9PgrXh0+fi5Alw415HZZUvjUsix7MrnllSHaVRZMjONysSDaCnVrGm2gK
         WxbI0jX2GiuHpnkkkPlZEAdBph3QWuQqZvVwDEC3s1pEpl+3qS0BeNLhsBO0evCbR9RH
         yO1sm0pQyGAJxEUswsTmQvejoDZbrDxo1jSNcjaDMuNjcdbPLsFQHayi+Wx9FlVVuYpf
         plXDuL81qJx3g3DbJxPeJlGfAvojpUa6OkxlbV4FKOXyOOOeK6mqfzhKJ48FMeL7ODD1
         X8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cENW2RdcQYx/np7UTy8gEVQVJU47Pn+14ajOrALawWU=;
        b=PovNt71cypzxboE8WKY5ysPRrelAv47nuIE4+j9Agqrvd8J/5Mlj3vjWvdZbm3gqC9
         co6wUG5Pn1+dAy/z1DJhTbpqVkJy7x3EyV/zwmoAPw/X6NgtxYD87LeTmGLU2R6+j0zs
         JCAVpukr+nj9buoMqOaeSaXWy6CA1b+PH87tyCe3Gr+cUW3bvQB6dYU3OwVNydhNg5j4
         YOQk9+U52daFfYXukyGp5sIIQn/jDqnWv/60uIJ/T4NQET6T6Ah2Fn3b/d8gmE8MZsl0
         wto1ot8RpXP9HrodAzqZ9E9xT2fPfzrusPmnAlwL21lweFXGPtIBXeCBnOzB4TeYTy/d
         Bs2w==
X-Gm-Message-State: AOAM530v78ocfS8EnqaXyHNujvteicLRVZiF0NTKi2NbKnJKbNmiCr8h
        1LJcTlFVtjM6zeIZDYJ6v1xuvUS0k5M=
X-Google-Smtp-Source: ABdhPJyq6/5W/QQnQ0CBMxQlDPt9Gs91BpBxM0JfBQ3b5Yim8saDk1rzAawJDuOR+xfJBx7T/uX7mA==
X-Received: by 2002:adf:c146:: with SMTP id w6mr41099188wre.541.1638758744365;
        Sun, 05 Dec 2021 18:45:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm12262277wmi.36.2021.12.05.18.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 18:45:43 -0800 (PST)
Message-Id: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.v2.git.1638424290015.gitgitgadget@gmail.com>
References: <pull.1086.v2.git.1638424290015.gitgitgadget@gmail.com>
From:   "James Limbouris via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 02:45:42 +0000
Subject: [PATCH v3] subtree: fix argument handling in check_parents
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

check_parents was taking all of its arguments as a single string,
and erroneously passing them to cache_miss as a single string. For
commits with a single parent this would succeed, but whenever a merge
commit was processed, cache_miss would be passed "parent1 parent2"
instead of "parent1" "parent2" and fail, leading to unecessary rechecks
of the parent commits.

For consistency, take multiple arguments in check_parents,
and pass all of them to cache_miss separately.

Signed-off-by: James Limbouris <james@digitalmatter.com>
---
    subtree: fix argument handling in check_parents
    
    > I agree with this. I'll mark the topic as "Expecting a reroll" in the
    > next "What's cooking" report, so that we do not forget that we are
    > waiting for such an improved description in the log message.
    
    Thanks for the feedback - log message has been amended.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1086%2Fjamesl-dm%2Fmaint-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1086/jamesl-dm/maint-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1086

Range-diff vs v2:

 1:  1198a84995b ! 1:  f734ca9d276 subtree: fix argument handling in check_parents
     @@ Commit message
          subtree: fix argument handling in check_parents
      
          check_parents was taking all of its arguments as a single string,
     -    and erroneously passing them to cache_miss as a single string.
     -    cache_miss would then fail, and the spurious cache misses it produced
     -    would hurt performance.
     +    and erroneously passing them to cache_miss as a single string. For
     +    commits with a single parent this would succeed, but whenever a merge
     +    commit was processed, cache_miss would be passed "parent1 parent2"
     +    instead of "parent1" "parent2" and fail, leading to unecessary rechecks
     +    of the parent commits.
      
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

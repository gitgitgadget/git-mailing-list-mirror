Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA8C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 05:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhLBFzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 00:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhLBFy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 00:54:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19040C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 21:51:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so57291750wrn.6
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 21:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FdMUJPjKMMXEnM3YqDJ0g4uHFUAqvqXoH7DL+rBlN6s=;
        b=WKenbnBwj58E1DHxeagJeb94n5toy0J6e4PvllaxiTJRhmnanOWy6MIrs7ju61zTSD
         QzqBP7UIhe6hKe7kKREypWMBYyzaujWU5EtkML5hB5v7G6tlJSybvV9HL/iazvsp19fX
         UHszE9XqUNqASyxk+xV9wlav6FoEQbu3LtgOyzEb1UmGUbAZS/DyjqGBE83dIXaejyHT
         Q6ABgRXpP4sWK11KN1xKWY5M5LZwuVC5s2a+QKb3Z1nljyxgwQ1KXV9RGNZ2ykZs57fr
         4r1a2Mj1zdNDmJIngsFewznxiPbTZG6Ru/AaNUIC7Ib1IWQcVurN4II/UdkLHGM2ToXp
         NWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FdMUJPjKMMXEnM3YqDJ0g4uHFUAqvqXoH7DL+rBlN6s=;
        b=z/mOhMSp4cdHgMGUJ3bgKySQVNYKkjFJfaDeeZTy1kzy5wplSOALpKpjh30KJokzjo
         g+cG5Nt44ztIOyI+ERD6N93jKf6UKDh7Ej8S4VtQyuM73Bi49GE5FzrvkGHlbVOzjoEW
         R/3XrBTG8H2mpnlmtp+RnBK2sIXfgM07wWIElc6QTcjbWZNaFjm4YTXWgIIMXvT22iOd
         V6XumnOa2F+aSOYtrb1Up3t44Gn5SP7ajMkF2wywqIBy6t/Aec4Dm93sfMMZ5DP0HfSv
         VkXsCz/psH+FqXo1Ou2ywsGdMZkIUKcbWThBoGp23H2D/RdSpWEaOBrkg/+mRu5dPtCi
         sBSA==
X-Gm-Message-State: AOAM530fjuyWyn47ruaomOlHMcsjM5k4f8KvpfuKS1h2kiZp0yVzSnLQ
        +A6fdQjbZclOjZZIrccMaFV7whQO0Ao=
X-Google-Smtp-Source: ABdhPJzQ9Tl+phuS7TqnH71b+Evf2WkPs5Sm8RwhM7MTm8nsyFv1qgV+mSuPVsi2L5RTKqm8UGcxjQ==
X-Received: by 2002:a05:6000:1541:: with SMTP id 1mr12007332wry.347.1638424291729;
        Wed, 01 Dec 2021 21:51:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m34sm1139735wms.25.2021.12.01.21.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 21:51:30 -0800 (PST)
Message-Id: <pull.1086.v2.git.1638424290015.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.git.1638324413653.gitgitgadget@gmail.com>
References: <pull.1086.git.1638324413653.gitgitgadget@gmail.com>
From:   "James Limbouris via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 05:51:29 +0000
Subject: [PATCH v2] subtree: fix argument handling in check_parents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     James Limbouris <james@digitalmatter.com>,
        James Limbouris <james@digitalmatter.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: James Limbouris <james@digitalmatter.com>

check_parents was taking all of its arguments as a single string,
and erroneously passing them to cache_miss as a single string.
cache_miss would then fail, and the spurious cache misses it produced
would hurt performance.

For consistency, take multiple arguments in check_parents,
and pass all of them to cache_miss separately.

Signed-off-by: James Limbouris <james@digitalmatter.com>
---
    subtree: fix argument handling in check_parents
    
    > It seems that 315a84f9 (subtree: use commits before rejoins for
    > splits, 2018-09-28) is what broke the logic, but it does not look like
    > a coding style clean-up to me.
    
    Sorry - you're right. I thought it was 6ae6a2 (subtree: adjust style to
    match CodingGuidelines) that broke it, but it was actually the addition
    of quotes in the check_parents and cache_miss calls of 315a84f9.
    
    > so writing "$@" is much more preferrable over $*
    
    Yes agreed - thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1086%2Fjamesl-dm%2Fmaint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1086/jamesl-dm/maint-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1086

Range-diff vs v1:

 1:  11b65a7b3a5 ! 1:  1198a84995b subtree: fix argument handling in check_parents
     @@ contrib/subtree/git-subtree.sh: cache_miss () {
       check_parents () {
      -	assert test $# = 1
      -	missed=$(cache_miss "$1") || exit $?
     -+	missed=$(cache_miss $*) || exit $?
     ++	missed=$(cache_miss "$@") || exit $?
       	local indent=$(($indent + 1))
       	for miss in $missed
       	do


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

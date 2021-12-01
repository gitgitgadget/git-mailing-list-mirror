Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BBCC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 02:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbhLACKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 21:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhLACKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 21:10:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC0C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 18:06:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so16118304wms.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 18:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=d+mwGkv5jfYw/s7pc+R8ZH+31l91kQoryzD9vzJ+PHA=;
        b=m7lvw8e+j2wvPFFOM5Tk8utF5v0nh29QtDScQkq1R8FiCOWZMiJl3Y2/mtJbk40X4b
         aWIhwRmyJnfd+FkiNhnajSBWOs0IMRbm9gPspmItkHpzZxlnCGVDk9JGvCj6uteIoS1X
         bIlg9i+WH6sda+fpGlaHy4QyYRHi6iVVMGaDtHpBQx9ES9Hg0/DnYmJ+SDI8RlrcFAQm
         N5umWTUFe6QSeG2f5++zsE5ScKLL30L+KVBaQZlRpXR5omsg3BGpHgDbvoaadQAG6qyV
         URx3gC9VFBC8yjEv+Exs8lISmeXPKNOkIJWNkcotPOba4KInaRzSubv/gHMWdpw0ie1Q
         HSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d+mwGkv5jfYw/s7pc+R8ZH+31l91kQoryzD9vzJ+PHA=;
        b=pfPP0HERNYi1PAYEtp++4/EdwumCXUVsERWG5DDlgDVg3hE/RCo8nCNUL1eGgIL0iR
         eDKl1O0b8Cfa5/t2TTiYGZMrENQVo1Fl3UBcko1fEFQwp6LQBknGEi3xRQDE28p9CvID
         W+F52MJQYJIgigMyF48OZCT1/EyLhNidAYiCpMu/CcZb/jnQZh1THBTPp8uudBIl3EQa
         DJtK4KjJvNYhHAil0R20BrzH88slthp0sqYzs/agoebKgroanePSbrSCglIZGpsv/cM9
         OGfmabvOpJFc6I5dVnw3FKS2lSQEPmfFbUFrKnOc2WhOFrBrrnVQpXxUq84aEc7ukTP3
         yAxw==
X-Gm-Message-State: AOAM531kJ7sOXSiU3eJscDXu8Ln4DfQBMfXzxHGHk3nqHBXxPEQ1lgQw
        WxPNVPbZxjW0ZOIHY3IwWE1RMPmE+Ak=
X-Google-Smtp-Source: ABdhPJxeDxQ+rJATGtG/si2mn2b2ly2UM4az5ElH7+Vk4dsDK+072Jgxi8Hoaz2Iwb36AQpVGSoCFQ==
X-Received: by 2002:a1c:43c1:: with SMTP id q184mr3121859wma.153.1638324414481;
        Tue, 30 Nov 2021 18:06:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm1262890wmb.24.2021.11.30.18.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 18:06:54 -0800 (PST)
Message-Id: <pull.1086.git.1638324413653.gitgitgadget@gmail.com>
From:   "James Limbouris via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 02:06:53 +0000
Subject: [PATCH] subtree: fix argument handling in check_parents
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
    
    Hello git developers. Please consider this small patch that fixes a bug
    introduced during a coding style cleanup of the subtree command. Changes
    to the argument handling were causing check_parents to fail when more
    than one parent was supplied, which led to a small loss of performance.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1086%2Fjamesl-dm%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1086/jamesl-dm/maint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1086

 contrib/subtree/git-subtree.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7f767b5c38f..56f24000c2c 100755
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
+	missed=$(cache_miss $*) || exit $?
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

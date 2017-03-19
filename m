Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C9420323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbdCSUYI (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:24:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34995 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbdCSUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 16:24:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id u108so15714028wrb.2
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/AisuhQz6qfAMAsNvAp7j0ko6CZHKf92+0N8AWwCazM=;
        b=ZbsuBBUw3pWS9HIpvLpdnTCyQ/1QFberkDJWCKldZpPrjZ6KIINRM2vKBZPC00oq/B
         gGyURa+DlU4Vf4h7T4nEVBBxSTPkr83myGQL7MzOCsFW2/VZaCVNOIdr7HNPUda8xM2V
         2n9/c5gcAz0ezh2JbaqMmhfEoeaevwDW4bFU2i+UC2qeJ1KxTsRIlov20AAhusj20LRW
         2l34WEldr5E+vacSkGG+knNay5gE66sWRDPcQ/qX+O5l8HJwW/z+SE6hEvrzWNOWBP/e
         hgNtTo6MSxNLSp+WDguVbEA1LNjrPYWEZGWKe0+RMlMFb2KBKG3ltR/vfzLk3rzKqHYo
         pCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/AisuhQz6qfAMAsNvAp7j0ko6CZHKf92+0N8AWwCazM=;
        b=lQSC03+JqY4Yw8cWBL5ILGqSg6wwBuVOqPliQDCAMSFap84eNpbagfVHI1LBPDcf2I
         0MC5O4mDjmyGyHptHZApVXiZ3zbHyvsgeHLnuNCyAXYXBsZUb2QzZije7FncwcxVtomA
         dHrv1rtxqn1tqy6mFMFG4J3Iy9Z1MyShP5mw/XLSU01De8renJmM9tjeLPltpyvKuBuT
         9u4NWEbn5g8nE9ZVQYR8qF/UKGt0h7UEmfB9468VhahHHJJ8Q40yo8leQSct+UKzzkic
         6VsABaZgpwTdPbeRnFaLBI4LHeys7levZP4YkGb6EofPuFfEGLybEBzt2CR8COcmM7Vp
         GfQw==
X-Gm-Message-State: AFeK/H251T+csgdgCQU8mWJQIKOSYpddDlDE7SI5cGQ6vxoo1ix91TE0sdkPwIIaZ0nQ/w==
X-Received: by 10.223.180.68 with SMTP id v4mr21069876wrd.37.1489955019580;
        Sun, 19 Mar 2017 13:23:39 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id o15sm18149945wra.61.2017.03.19.13.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Mar 2017 13:23:39 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC 1/3] stash: show less information for stash push -- <pathspec>
Date:   Sun, 19 Mar 2017 20:23:49 +0000
Message-Id: <20170319202351.8825-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.483.gad4152297
In-Reply-To: <20170319202351.8825-1-t.gummerer@gmail.com>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git stash push -- <pathspec> in the following sequence:

       git init -q repo
       cd repo

       for i in one two; do
               echo content >$i
               git add $i
       done
       git commit -qm base

       for i in one two; do
               echo change >$i
       done
       git stash -- one

it shows:

   Saved working directory and index state WIP on master: 20cfadf base
   Unstaged changes after reset:
    M   one
    M   two

Even though "one" no longer has unstaged changes.

It really is enough for the user to know that the stash is created,
without bothering them with the internal details of what's happening.
Always pass the -q flag to git clean and git reset in the pathspec case,
to avoid unnecessary and potentially confusing output.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9c70662cc8..59f055e27b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -299,10 +299,10 @@ push_stash () {
 	then
 		if test $# != 0
 		then
-			git reset ${GIT_QUIET:+-q} -- "$@"
+			git reset -q -- "$@"
 			git ls-files -z --modified -- "$@" |
 			git checkout-index -z --force --stdin
-			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
+			git clean --force -q -d -- "$@"
 		else
 			git reset --hard ${GIT_QUIET:+-q}
 		fi
-- 
2.12.0.483.gad4152297

